From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 00/12] Extensions in core needed by PackWriter
Date: Sat, 7 Jun 2008 03:16:13 -0400
Message-ID: <20080607071613.GA12896@spearce.org>
References: <1212441883-12990-1-git-send-email-marek.zawirski@gmail.com> <200806061524.04140.robin.rosenberg@dewire.com> <4849D115.5030602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 09:17:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4sfl-000797-Tb
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 09:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753939AbYFGHQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 03:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753832AbYFGHQR
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 03:16:17 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38595 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127AbYFGHQR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 03:16:17 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1K4ser-0007TQ-1R; Sat, 07 Jun 2008 03:16:13 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 25B1A20FBAE; Sat,  7 Jun 2008 03:16:13 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4849D115.5030602@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84180>

Marek Zawirski <marek.zawirski@gmail.com> wrote:
> On Fri, Jun 6, 2008 at 3:24 PM, Robin Rosenberg 
> > 
> > I'm somewhat reluctant to reformatting patches though. 
> 
> Well, so should I remove these reformatting patches from series? (oouch!)
> 
> Actually, when I ran into formatting problem, Shawn suggested that I may 
> format PackFile as he was also touching this file - I much appreciated 
> this idea. PackIndex* formatting is however my own invention.

I'm in favor of reformatting, at least these two classes.
Editing them without the formatting fixes is insanely annoying.
But bulk reformatting all 118 files at once is nuts.

I'd rather do it one file at a time, when we touch it, and especially
if it is fairly stable and isn't being actively hacked on by others.

> Isn't it somewhat annoying that formatting is inconsistent through
> project (especially line width in some places)? And that I almost have
> to block formatting shortcut to stop my pre-save/pre-commit habit?;)

Yes.  Yes it is.

-- 
Shawn.
