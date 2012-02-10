From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 6/8] gitweb: Highlight interesting parts of diff
Date: Fri, 10 Feb 2012 13:56:11 -0800 (PST)
Message-ID: <m3y5satksm.fsf@localhost.localdomain>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1328865494-24415-7-git-send-email-michal.kiedrowicz@gmail.com>
	<20120210202008.GA5874@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-2?q?Micha=B3_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 10 22:56:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvyS3-0003Pv-HD
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 22:56:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753947Ab2BJV4O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 16:56:14 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39496 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181Ab2BJV4O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2012 16:56:14 -0500
Received: by eaah12 with SMTP id h12so1066906eaa.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 13:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=o++LATgEDOT5e2JB+7+5gDzMP5+sHuKifqp8yRYW4iA=;
        b=DavdFM1i3Q50N7tIzr5ARlPT1sBhXRfm8tkrut+MrTKLsONKmy0uRBjOBc3VDBlvOb
         Sp7SrggpVuLbcro6dDfN/65Wjx5vjBu/CGt7i/UePhihA7JGS7fsWvL8FjAMN5anOWs5
         EjQDlmy9u7jd1Dz2FKYBtpiawoIzrKfLg7i8U=
Received: by 10.14.194.136 with SMTP id m8mr2471105een.97.1328910972561;
        Fri, 10 Feb 2012 13:56:12 -0800 (PST)
Received: from localhost.localdomain (abwh187.neoplus.adsl.tpnet.pl. [83.8.231.187])
        by mx.google.com with ESMTPS id v51sm26981763eef.2.2012.02.10.13.56.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 13:56:11 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q1ALuBr6000766;
	Fri, 10 Feb 2012 22:56:11 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q1ALuAE3000757;
	Fri, 10 Feb 2012 22:56:10 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20120210202008.GA5874@sigill.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190465>

Jeff King <peff@peff.net> writes:

> (I was hoping not to need to get a running gitweb installation in
> order to see the output).

Well, there is always git-instaweb ;-)

--=20
Jakub Nar=EAbski
