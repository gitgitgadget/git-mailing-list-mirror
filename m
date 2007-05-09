From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] checkout: allow full refnames for local branches
Date: Wed, 9 May 2007 16:11:05 -0400
Message-ID: <20070509201105.GF3141@spearce.org>
References: <11787000032830-git-send-email-hjemli@gmail.com> <7v7iriwfeu.fsf@assigned-by-dhcp.cox.net> <8c5c35580705090207y2979aaa5u7ce9de5fa1dfe658@mail.gmail.com> <20070509185440.GB3141@spearce.org> <8c5c35580705091301s19dcd2e0q20a4c84e3dd23d82@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 09 22:11:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlsVF-0003et-TB
	for gcvg-git@gmane.org; Wed, 09 May 2007 22:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754240AbXEIULK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 16:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbXEIULK
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 16:11:10 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33323 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754240AbXEIULJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 16:11:09 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HlsV0-0000wd-7j; Wed, 09 May 2007 16:10:58 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5EE8620FBAE; Wed,  9 May 2007 16:11:05 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <8c5c35580705091301s19dcd2e0q20a4c84e3dd23d82@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46777>

Lars Hjemli <hjemli@gmail.com> wrote:
> On 5/9/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> >If you are building "porcelain" to sit over Git and offer up a pretty
> >view of things, I would encourage you to avoid the stock porcelain.
> >Don't use git-checkout, its stock porcelain.  Instead go right to
> >the plumbing.  The plumbing doesn't really change behavior as often
> >(if ever).
> 
> Thanks, I probably will (also to avoid the shell scripts, since my
> porcelain is aimed at my co-workers who are stuck on windows)

Are you building a strictly Win32 native GUI?  Or something else?
Can I ask what sort of features you are going after?  (And if
there's a git repository available, feel free to just point me at
it and ignore my questions.)

I'm just curious.  We seem to have a lot of user interface projects
going on at once right now (Eclipse plugin, git-gui, gitk, qgit, tig,
gitweb, blameview) and everyone's been learning from each other.
I think the competition is good, there's no clear right way to do
things here.  As the primary author of git-gui, I do want to try
and keep current with what the others are up to.  ;-)

-- 
Shawn.
