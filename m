From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-grep: add --color to highlight matches
Date: Sat, 24 May 2008 01:28:13 -0700 (PDT)
Message-ID: <m3ve142jkc.fsf@localhost.localdomain>
References: <20080524043118.GA23118@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?b?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?utf-8?b?YyBEdXk=?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 24 10:29:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jzp7m-0005qu-WB
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 10:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753846AbYEXI2S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 May 2008 04:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753697AbYEXI2S
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 04:28:18 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:3148 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327AbYEXI2R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 May 2008 04:28:17 -0400
Received: by nf-out-0910.google.com with SMTP id d3so499095nfc.21
        for <git@vger.kernel.org>; Sat, 24 May 2008 01:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:date;
        bh=vhEYBJycA51Lva+rTc4JAsbCkNHhwKB19Ssc/Orfmxg=;
        b=Quyxy1i5ISbO2ONPY3FYDTCq9X/plSkj3Me3nzcjv+8dm7DXzW/JHo6Xzx5k5c6veFyJSF0+GTs0vkxdeZl1R4pFPr9LM152iLyWdIk1mFzp1cAMQMo48pDOdFfrgEkJUbl/kPrp2Xq9CdiFqGzI5Mw9fEdGRf7XBu9xPZI0Zk8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:date;
        b=slUkTvY3wofqHmpDFPtBsuyHUdZiJs/l6xMUAWnEgGGdrP/zaKCoQtItJs/nRxZz8v4Gtvok4riRZCxcvC7XemFjMU5H/GP/GApVReBLuGAa/v/XhgxzjxsT+fC2Z9S4lylkFIWrqjEIbfDs/Y41uCQ5HNd0On+T+CqcuMti8mo=
Received: by 10.210.65.2 with SMTP id n2mr1847156eba.145.1211617695297;
        Sat, 24 May 2008 01:28:15 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.211.36])
        by mx.google.com with ESMTPS id c22sm6959311ika.1.2008.05.24.01.28.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 May 2008 01:28:13 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m4O8Rir8002426;
	Sat, 24 May 2008 10:27:55 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m4O8RWxI002422;
	Sat, 24 May 2008 10:27:32 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080524043118.GA23118@laptop>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82803>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> +--color::
> +	Show colored matches.
> +

Why not borrow from GNU grep manpage?

   --colour[=3DWHEN], --color[=3DWHEN]
      Surround  the  matching  string  with  the marker find in GREP_CO=
LOR
      environment variable. WHEN may be 'never', 'always', or 'auto'

We probably would also want it configurable (via config variables),
as `color.grep' I guess.

I think compatibility with grep (using GREP_COLOR) would be good idea,
and easily implemented.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
