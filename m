From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] Keep committer and committer dates
Date: Thu, 5 Jun 2008 16:11:31 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0806051600310.1798@tm8103-a.perex-int.cz>
References: <Pine.LNX.4.61.0806031647320.1798@tm8103-a.perex-int.cz>
 <alpine.DEB.1.00.0806032115340.13507@racer.site.net>
 <Pine.LNX.4.61.0806041113520.1798@tm8103-a.perex-int.cz>
 <20080604102906.GA2126@diana.vm.bytemark.co.uk> <m3ej7dzc7y.fsf@localhost.localdomain>
 <Pine.LNX.4.61.0806041424140.1798@tm8103-a.perex-int.cz>
 <alpine.DEB.1.00.0806041641150.13507@racer.site.net> <20080605010330.GB24466@leksak.fem-net>
 <alpine.DEB.1.00.0806050523120.21190@racer> <4847917A.2050700@viscovery.net>
 <Pine.LNX.4.61.0806051428390.1798@tm8103-a.perex-int.cz>
 <alpine.DEB.1.00.0806051408520.21190@racer> <Pine.LNX.4.61.0806051528220.1798@tm8103-a.perex-int.cz>
 <alpine.DEB.1.00.0806051452380.21190@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 05 16:12:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4GCi-0004Y0-EJ
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 16:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755032AbYFEOLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 10:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755103AbYFEOLi
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 10:11:38 -0400
Received: from mail1.perex.cz ([212.20.107.53]:55022 "EHLO mail1.perex.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755005AbYFEOLi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 10:11:38 -0400
Received: from server.perex.cz (server.perex.cz [172.16.0.20])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 3CD22149D98;
	Thu,  5 Jun 2008 16:11:34 +0200 (CEST)
Received: from tm8103.perex-int.cz (localhost [127.0.0.1])
	by server.perex.cz (Perex's E-mail Delivery System) with ESMTP id 955D384356;
	Thu,  5 Jun 2008 16:11:33 +0200 (CEST)
Received: by tm8103.perex-int.cz (Postfix, from userid 1000)
	id 4CB5757FEC; Thu,  5 Jun 2008 16:11:32 +0200 (CEST)
X-X-Sender: perex@tm8103-a.perex-int.cz
In-Reply-To: <alpine.DEB.1.00.0806051452380.21190@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83935>

On Thu, 5 Jun 2008, Johannes Schindelin wrote:

> > On Thu, 5 Jun 2008, Johannes Schindelin wrote:
> > 
> > > It would make a wonderfully helpful tool less helpful.
> > 
> > I don't agree. Tool is tool. Every tool can be used in a wrong way. A 
> > notice to documentation that some of functionality should be used very 
> > carefully should be enough.
> 
> In that case, could you please test this patch?

Could you please test to open emergency door in airplane (at best when 
the airplain is in air) without any good reason? The emergency door is 
also a tool, but it should be used in really specific situation.

> -- snip --
> [PATCH] git wrapper: --try-this

> > If I changed portion of unpublished tree, as maintainer I can combine 
> > any patches and it might make sense to keep at least my commit dates for 
> > my reference.
> 
> The problem is _NOT_ the unpublished tree, but that you, as a maintainer, 
> committed something, but said that somebody else did.  Possibly avoiding 
> blame, shifting it to others.

I meant I'm commiter for last patches. So I don't shift my blame to 
others. Also even if I'm not the commiter of patches and removing or 
touching totaly different area (like just README or some or other little 
changes) in repository, I don't see a reason to not to do so. Of course in 
99.9% cases it's better to do it with new commit, because with 
git-reset you split trees and users will have to force pull and 
will probably cry. But in some cases might be worth just to remove / 
modify a patch hardly.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
