From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] Keep committer and committer dates
Date: Thu, 5 Jun 2008 14:44:12 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0806051428390.1798@tm8103-a.perex-int.cz>
References: <Pine.LNX.4.61.0806031647320.1798@tm8103-a.perex-int.cz>
 <alpine.DEB.1.00.0806032115340.13507@racer.site.net>
 <Pine.LNX.4.61.0806041113520.1798@tm8103-a.perex-int.cz>
 <20080604102906.GA2126@diana.vm.bytemark.co.uk> <m3ej7dzc7y.fsf@localhost.localdomain>
 <Pine.LNX.4.61.0806041424140.1798@tm8103-a.perex-int.cz>
 <alpine.DEB.1.00.0806041641150.13507@racer.site.net> <20080605010330.GB24466@leksak.fem-net>
 <alpine.DEB.1.00.0806050523120.21190@racer> <4847917A.2050700@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jun 05 14:45:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4EqA-0004fG-IT
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 14:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758752AbYFEMoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 08:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758738AbYFEMoU
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 08:44:20 -0400
Received: from mail1.perex.cz ([212.20.107.53]:48084 "EHLO mail1.perex.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758669AbYFEMoS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 08:44:18 -0400
Received: from server.perex.cz (server.perex.cz [172.16.0.20])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 6E1B1149DAB;
	Thu,  5 Jun 2008 14:44:14 +0200 (CEST)
Received: from tm8103.perex-int.cz (localhost [127.0.0.1])
	by server.perex.cz (Perex's E-mail Delivery System) with ESMTP id 5C64F84355;
	Thu,  5 Jun 2008 14:44:14 +0200 (CEST)
Received: by tm8103.perex-int.cz (Postfix, from userid 1000)
	id 1E21957FEC; Thu,  5 Jun 2008 14:44:12 +0200 (CEST)
X-X-Sender: perex@tm8103-a.perex-int.cz
In-Reply-To: <4847917A.2050700@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83916>

On Thu, 5 Jun 2008, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > Hi,
> > 
> > On Thu, 5 Jun 2008, Stephan Beyer wrote:
> > 
> >>> - as has been pointed out several times now, you _are_ the committer, 
> >>>   and you seem to want to lie there.
> >> Lying is already possible with GIT_COMMITTER_{NAME,EMAIL,NAME} 
> >> environment variables.
> > 
> > Of course it is possible!  I even pointed to a method!
> > 
> > The _point_ was that we do not want to recommend it.  And giving prominent 
> > support for it, such as introducing a command line parameter, _would_ 
> > have the effect of recommending it.
> 
> Furthermore, if you mess with committer dates, you can screw up revision
> walking to some degree. committer dates aren't merely informational.

Of course, you can find many reasons to not use this function. I just used 
the proposed function when we migrated from HG to GIT to rebase with 
actual Linus's tree without touching commiters (because I've not changed 
patches itself).

Also, having a possibility to easy remove a changeset (hardly - not 
revert) without touching all other changesets on top is a function worth 
to include. With --committer parameter, it can be easily implemented using 
git-format-patch & git-am. And before you complain, yes, I know - it 
should be used only localy before the repository is published to others.

** I take GIT as a tool to manage repositories and it has already many 
low-level commands/parameters. My proposal was an extension to them. If 
there are not real technical reasons agains, it should go in. Users have 
to decide about useability for their cases. I saw only "political" 
comments that it's evil to do so in some (most of) cases. End of my 
opinion. **

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
