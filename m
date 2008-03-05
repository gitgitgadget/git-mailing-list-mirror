From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to force explicit user info
Date: Wed, 05 Mar 2008 06:38:43 -0800 (PST)
Message-ID: <m3r6epgrqt.fsf@localhost.localdomain>
References: <8aa486160803050539p4c443302nc322241d59fe9374@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: =?iso-8859-15?q?Santi_B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 15:40:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWumF-0000ax-4D
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 15:39:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001AbYCEOiu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Mar 2008 09:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbYCEOiu
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 09:38:50 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:18996 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbYCEOit convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2008 09:38:49 -0500
Received: by ug-out-1314.google.com with SMTP id z38so3303317ugc.16
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 06:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:date;
        bh=VAm5pgzcQL4Q7mbUjitYv3cxzXLvHPgUaj5cPSNyfyg=;
        b=G0HIbzQHII/wCZ5cQa1/VxccO9v0s6Ze6ObJ7cEI/b93/BsbCH//JRcpU4w5hxcxRpGE1y7ZLaHoS4KEHtlJ3Z9B8/xR9b2VoHgJ33dm98/gGRof3SuZFV/ali+rc2Cr4DKa3LT1QZwbzewPfIVpvsxpVfA4/od5aFEdtA+Dcn4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:date;
        b=UferXGE4M6NCbR2MobLzEplYdfcqPL1sJy1g6KOqMowqpFx6a9JX+vVmMe/1Jb13FwTwbdPzjySJICbU1fx7QGazb6gA2Vb+9ledeIvFiv1+eI21VXkTRlsIXXcRPal1dP7FXAno09PATTdLE9iNC3hQOZ55asXSousMp64PySs=
Received: by 10.66.251.3 with SMTP id y3mr6439324ugh.88.1204727925844;
        Wed, 05 Mar 2008 06:38:45 -0800 (PST)
Received: from localhost.localdomain ( [83.8.248.32])
        by mx.google.com with ESMTPS id n34sm3831262ugc.64.2008.03.05.06.38.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Mar 2008 06:38:43 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m25Ed7Zh023295;
	Wed, 5 Mar 2008 15:39:07 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m25Ed7nK023292;
	Wed, 5 Mar 2008 15:39:07 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <8aa486160803050539p4c443302nc322241d59fe9374@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76221>

"Santi B=E9jar" <sbejar@gmail.com> writes:

>   How can I forbid the gecos info and always force git to ask for an
> explicit user.name and user.email?
>=20
>   I use a different email for personal projects and for work projects=
,
> using the same machine. So I set user.email locally in each
> repository. But when I forget setting this I get
> userid@hostname.(none) as the email. Is there a way to just die and
> ask for this info (maybe user.AlwaysExplicit or something like that)?

I don't think there is a way to get exactly what you want... unless
you would "scratch that itch"... :-)

You can set default user.name and user.email in the ~/.gitconfig
global (user) git configuration, and in /etc/gitconfig for system-wide
git config, though. HTH.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
