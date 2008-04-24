From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Different Versions
Date: Thu, 24 Apr 2008 21:50:41 +0200
Message-ID: <20080424195041.GA5905@steel.home>
References: <899199.2868131209043100219.JavaMail.servlet@kundenserver>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: rjtaylor@havocinspired.co.uk
X-From: git-owner@vger.kernel.org Thu Apr 24 21:52:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jp7Ti-0007qw-AK
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 21:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763660AbYDXTuq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Apr 2008 15:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763661AbYDXTup
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Apr 2008 15:50:45 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:53257 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763659AbYDXTuo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2008 15:50:44 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarO+CMY=
Received: from tigra.home (Fab05.f.strato-dslnet.de [195.4.171.5])
	by post.webmailer.de (klopstock mo29) (RZmta 16.27)
	with ESMTP id u06764k3OGxwlt ; Thu, 24 Apr 2008 21:50:41 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 66190277BD;
	Thu, 24 Apr 2008 21:50:41 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id C2B6456D28; Thu, 24 Apr 2008 21:50:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <899199.2868131209043100219.JavaMail.servlet@kundenserver>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80314>

rjtaylor@havocinspired.co.uk, Thu, Apr 24, 2008 15:18:20 +0200:
> I=E2=80=99m in a fairly restricted situation were I have a Live Web S=
erver
> and a Dev Web Server. Now the Live box is running Ubuntu 7.04, and
> installs git version 1.4.* through apt-get. On the Dev box I=E2=80=99=
ve got
> Ubuntu 7.10, and this installs git version 1.5.*.
>=20
> Each seem to use slightly different commands, e.g. to initialise a
> repository.=20
>=20
> My question is am I ok to use git versions 1.4.* and 1.5.* together,
> or am I going to have problems?

apart from the different commands - no.

> Should I down great my Dev box to Ubuntu 7.04 to get git version
> 1.4* so they are the same?

no, no need to downgrade anything

> Any advice would be appreciated.

get the git source, checkout the 1.4.x version you have on your Live
Web Server, compile and install it in your $HOME on developnment
machine and try things out before doing them on production system.

But it is actually quite simple to uninstall the old git on both
systems, compile the newest git, and just install it everywhere.
