From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Rename git-core rpm to just git and rename the meta-pacakge to git-all.
Date: Fri, 15 Feb 2008 11:36:50 -0800 (PST)
Message-ID: <m3tzkaau75.fsf@localhost.localdomain>
References: <1203100163-17509-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-15?q?Kristian_H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Fri Feb 15 20:38:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ6Nk-0006wd-Hv
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 20:38:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbYBOTg6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Feb 2008 14:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbYBOTg6
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 14:36:58 -0500
Received: from fk-out-0910.google.com ([209.85.128.188]:5364 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbYBOTg5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Feb 2008 14:36:57 -0500
Received: by fk-out-0910.google.com with SMTP id z23so849150fkz.5
        for <git@vger.kernel.org>; Fri, 15 Feb 2008 11:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:date;
        bh=CzHm7Uu0++k2SIT2IDsUqCwepwYXK0qKx2nuf8GfEB8=;
        b=hrrR2u9OPdfw4wCQSq3itlZXZSUa7xG6nZHKT2sS6vjEJfXryrAVTT72RmBbA95yvwq2yd0zrRY6zOcD+Mx1AxKuTBKSogIm6cVaeq5MoKTIV1g/Ncv9qDQK6RHpYFM447rlL3JZARehrI49TnVsqH4YKJflGvbKrSk94G0wMLA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:date;
        b=suGCtBTlNPkbCYooZrN8wqhMSbGSEoTgiXqvq/tKWBORn61hBKecxi9YzhKYLerCmd/qnjbCTK4Jdest4Ng31my2dtcpMeHWs34vPFJBp2lyvzeSow1r0fP3Bis1tWmD0LAqfeoomdbw6bHt7AHz2SaqRSksNwgU1MC6SH4uzjs=
Received: by 10.82.150.20 with SMTP id x20mr4003677bud.31.1203104212152;
        Fri, 15 Feb 2008 11:36:52 -0800 (PST)
Received: from localhost.localdomain ( [83.8.221.186])
        by mx.google.com with ESMTPS id b33sm7160395ika.5.2008.02.15.11.36.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Feb 2008 11:36:50 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1FJaFbV006461;
	Fri, 15 Feb 2008 20:36:25 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1FJZw69006457;
	Fri, 15 Feb 2008 20:35:58 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1203100163-17509-1-git-send-email-krh@redhat.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73978>

Kristian H=F8gsberg <krh@redhat.com> writes:

> So here's change to fix my favorite annoyance with the git rpm
> packaging: don't pull in tla when I say yum install git!  The decisio=
n
> to make 'git' a metapackage is to say the least unconventional and
> continues to surprise people (here's today discussion:
> http://marc.info/?t=3D120309228600004&r=3D1&w=3D2).
>=20
> I know it's late and most people who use the git rpms are used to ins=
talling
> git-core by now, but myself and most of my Red Hat co-workers (who sh=
ould
> know a thing or two about rpm packaging) have been fooled by the 'git=
'
> rpm that pulls in everything.  There's really no precendence for this=
, quite
> the opposite: you wouldn't expect yum install gcc to pull in fortran,=
 right?

I think I'd rather have git RPM as metapackage, but not such wide
one. I'd like for git RPM to install git-core, git-email, git, git-gui
and perl-Git; I agree that bits about interaction with other SCMs
should be not included in git (meta)package, as this requires to
actually have all those SCMs...

Just my 2 eurocents

--=20
Jakub Narebski
Poland
ShadeHawk on #git
