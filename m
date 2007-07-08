From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Enable "git rerere" by the config variable rerere.enabled
Date: Sun, 8 Jul 2007 18:00:49 -0400
Message-ID: <20070708220049.GD4436@spearce.org>
References: <Pine.LNX.4.64.0707061303450.4093@racer.site> <7vejjkdaqe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 00:00:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7eoK-0007am-Gi
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 00:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757723AbXGHWAy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 18:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757544AbXGHWAx
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 18:00:53 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33381 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757323AbXGHWAx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 18:00:53 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I7eo5-0003NJ-9r; Sun, 08 Jul 2007 18:00:41 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 384A620FBAE; Sun,  8 Jul 2007 18:00:49 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vejjkdaqe.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51930>

Junio C Hamano <gitster@pobox.com> wrote:
> I'll exclude git-gui part and commit with a minor tweaks; having
> extra "does the directory exist" check in git-gui would not hurt
> people who are used to how rerere works in the short term, and I
> think I read somewhere that I should expect git-gui updates over
> the weekend anyway.

There is a slew of git-gui updates already made but not yet pulled
in by you, and a pile yet still coming.

I'm going to be hacking on git-gui pretty much the rest of today,
and probably a good deal tomorrow too.  I'm trying to simplify
the workflow for users in my 400+ branch production repository.
They are actively using git-gui now and really need the tool to
handle things for them.  Especially since all but 1 of the users
is _not_ command-line friendly.

So you can feel free to pull maint and master over if you want,
but you might just want to wait another day or two.

Are you thinking of doing a git 1.5.2.4?  I'd like to get the bug
fixes accumulating in git-gui's maint into 1.5.2.4 as gitgui-0.7.5.
If you are doing a 1.5.2.4 release that is...

-- 
Shawn.
