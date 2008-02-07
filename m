From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH (repost)] Improve bash prompt to detect merge / rebase in progress
Date: Thu, 7 Feb 2008 01:34:12 -0500
Message-ID: <20080207063412.GQ24004@spearce.org>
References: <9b3e2dc20802061152q63bc61acuaecf3f33d4df8b19@mail.gmail.com> <200802062314.39440.robin.rosenberg.lists@dewire.com> <7vodatu37m.fsf@gitster.siamese.dyndns.org> <200802070123.43109.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Stephen Sinclair <radarsat1@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 07:35:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN0Ln-0003b9-CV
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 07:35:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752503AbYBGGei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 01:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752092AbYBGGei
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 01:34:38 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:51485 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503AbYBGGeg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 01:34:36 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JN0Ks-0002YV-BI; Thu, 07 Feb 2008 01:34:14 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D0DE220FBAE; Thu,  7 Feb 2008 01:34:12 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <200802070123.43109.robin.rosenberg.lists@dewire.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72899>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> I sent a patch and Shawn modified it somewhat and posted the full modified
> patch. Here is the same patch again (to make sure you get the right one). It
> has a better comment than the one I sent recently.
> 
> -- robin
> 
> From 82a5b8d5b043ffc7c1950b391ec7ae69d575640b Mon Sep 17 00:00:00 2001
> From: Robin Rosenberg <robin.rosenberg@dewire.com>
> Date: Sun, 30 Sep 2007 02:20:45 +0200
> Subject: [PATCH] Improve bash prompt to detect various states like an unfinished merge
> 
> This patch makes the git prompt (when enabled) show if a merge or a
> rebase is unfinished. It also detects if a bisect is being done as
> well as detached checkouts.
> 
> An uncompleted git-am cannot be distinguised from a rebase (the
> non-interactive version). Instead of having an even longer prompt
> we simply ignore that and hope the power users that use git-am knows
> the difference.
> 
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>

For what it's worth:

Acked-by: Shawn O. Pearce <spearce@spearce.org>

-- 
Shawn.
