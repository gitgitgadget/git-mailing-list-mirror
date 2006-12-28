From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 1/2] Teach git-reset to let others override its reflog entry.
Date: Thu, 28 Dec 2006 01:22:34 -0500
Message-ID: <20061228062233.GA17304@spearce.org>
References: <20061228014336.GA16790@spearce.org> <7vslf0zgwp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 07:22:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzofI-0002pH-9I
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 07:22:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbWL1GWk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 01:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbWL1GWk
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 01:22:40 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:44260 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964943AbWL1GWj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 01:22:39 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GzoeZ-0005fC-Bu; Thu, 28 Dec 2006 01:22:11 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EBFFF20FB65; Thu, 28 Dec 2006 01:22:34 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vslf0zgwp.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35521>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > The new --reflog-action for git-reset behaves like the same option
> > to git-merge; it can be used by the caller to override the message
> > entry in the reflog and is intended to be used only when git-reset
> > is acting as plumbing, not porcelain.
> 
> Honestly, I hate these --reflog-action options everywhere.

Me too.  Yet I submit patches to add them.  ;-)
 
> Then calls to "git-update-ref -m" could use the value of
> "$GIT_REFLOG_ACTION", without explicit --reflog-action=
> parameters and $rloga variables.

I agree.  Your suggestion is way more elegant.

I have some more git-am/git-merge/git-pull/git-rebase patches
brewing; I'm finishing the commit message for the last in the
sequence.  I'll update it to include your suggestion and try to
start cleaning up this --reflog-action mess, then ship the series
out to the list, including this mini 2 patch series you are
rejecting for good reason.

-- 
Shawn.
