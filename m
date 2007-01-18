From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/2] Document the master@{n} reflog query syntax.
Date: Thu, 18 Jan 2007 10:48:45 -0500
Message-ID: <20070118154845.GD15428@spearce.org>
References: <20070118020804.GA23488@spearce.org> <Pine.LNX.4.64.0701171829240.27034@elephant.stardot-tech.com> <20070118025003.GC23124@spearce.org> <45AF4CDF.5010406@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jim Treadway <jim@stardot-tech.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 18 16:49:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7ZVd-0007qB-6N
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 16:49:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbXARPsv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 10:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752054AbXARPsv
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 10:48:51 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53261 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053AbXARPsu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 10:48:50 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H7ZVJ-0003Sj-J8; Thu, 18 Jan 2007 10:48:41 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1FA6820FBAE; Thu, 18 Jan 2007 10:48:45 -0500 (EST)
To: Andreas Ericsson <ae@op5.se>
Content-Disposition: inline
In-Reply-To: <45AF4CDF.5010406@op5.se>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37114>

Andreas Ericsson <ae@op5.se> wrote:
> Shawn O. Pearce wrote:
> >Jim Treadway <jim@stardot-tech.com> wrote:
> >>On Wed, 17 Jan 2007, Shawn O. Pearce wrote:
> >>>-  of the ref at a prior point in time.  This suffix may only be
> >>>+  of the ref at a prior point in time.This suffix may only be
> >>I'm guessing that the above was unintentional?
> >
> >Yes.  Danngit.  Junio, can you hand edit that patch?
> >
> 
> I'm starting to see --amend as an extremely useful thing to have, and 
> I'm sure Junio thinks the same. For fixes this small, it sure is easier 
> to just --amend the commit than to ask for a new patch to apply.

I still shouldn't have let that change sneak into the diff.  I know
how it happened, I wanted to copy part of that line so I wiggled
it around in vi, copied it, then hit undo.  I didn't undo back far
enough.  Then I didn't read the diff closely enough before sending.

> Out of curiousity, how many other SCM's allow you to --amend a commit?

None that I know of.

-- 
Shawn.
