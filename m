From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] t8005: use egrep when extended regular expressions are 
	required
Date: Thu, 7 May 2009 10:12:45 +1000
Message-ID: <fcaeb9bf0905061712y38c7b31bl97759fecdc8a9a5b@mail.gmail.com>
References: <oO0aWq8IlAMsKZ9ZA1BW41Q2yED3E3Gy0etERczi2cjwFaZDei2brNq_BxSt-DnUld4xgNrFZ64@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu May 07 02:13:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1rEl-00008A-6l
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 02:13:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755421AbZEGANK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 May 2009 20:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754666AbZEGANJ
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 20:13:09 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:22933 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754517AbZEGANG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 May 2009 20:13:06 -0400
Received: by an-out-0708.google.com with SMTP id d40so1177531and.1
        for <git@vger.kernel.org>; Wed, 06 May 2009 17:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=/cTZgGjqBqiTwv5x8k8dxDbuHKywQy2nN8LE9EImuIc=;
        b=YkBAqHI0l/PBLJ0HczvUlFcW295bsRZMuErScjXnWDgH1oHpm7c8YISkzyDIl0AO0M
         zu9CWeyctmX9+pGrCfBTn5xfGytDdN/h+IqUnnJGbehEKLg3aU1PgShEupVJhF6h9Bj4
         EHtuLSlniOeKuAt3Oy0aDltdeh1jYyRCJjpoE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=DopjbBIgnUgGiaZF6rDCu/9j3tc8+XpkTl6PGlJAzOy4VCKxEO/RvC9iUdfAYACgwJ
         Q3DpwDmfc8TMj9x5TbIYt/eEG87eZJsrt7PpQVxrztFB1SjakGapl+YSR8loo8PEznHQ
         Bj+MkOQ6JHVk5LFqd1oVwKklouTg7KwMLluPc=
Received: by 10.100.132.14 with SMTP id f14mr4053055and.79.1241655185236; Wed, 
	06 May 2009 17:13:05 -0700 (PDT)
In-Reply-To: <oO0aWq8IlAMsKZ9ZA1BW41Q2yED3E3Gy0etERczi2cjwFaZDei2brNq_BxSt-DnUld4xgNrFZ64@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118414>

On Thu, May 7, 2009 at 4:31 AM, Brandon Casey <casey@nrlssc.navy.mil> w=
rote:
> Not all versions of grep understand backslashed extended regular
> expressions. =C2=A0Possibly only gnu grep does.
>
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>

Works for me.
--=20
Duy
