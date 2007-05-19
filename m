From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Documentation (mainly user-manual) patches
Date: Sat, 19 May 2007 00:32:34 -0400
Message-ID: <20070519043234.GE3141@spearce.org>
References: <20070518033746.GB30144@fieldses.org> <20070518045634.GU4489@pasky.or.cz> <20070518134316.GA21925@fieldses.org> <20070519040212.GC3141@spearce.org> <20070519041357.GA2679@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sat May 19 06:32:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpGcg-0000ev-8b
	for gcvg-git@gmane.org; Sat, 19 May 2007 06:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755143AbXESEcs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 00:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755440AbXESEcs
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 00:32:48 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57887 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755143AbXESEcr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 00:32:47 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HpGcW-0003d7-JH; Sat, 19 May 2007 00:32:44 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2A6C820FBAE; Sat, 19 May 2007 00:32:35 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070519041357.GA2679@fieldses.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47712>

"J. Bruce Fields" <bfields@fieldses.org> wrote:
> But, actually, I tried it just now and it only gave the url:
> 
> 	The following changes since commit 164b19893ab5bc66b531a26480149a0dff082969:
> 	  Michael Hendricks (1):
> 		Document core.excludesfile for git-add
> 
> 	are found in the git repository at:
> 
> 		git://linux-nfs.org/~bfields/git.git
> 
> How's it supposed to figure out the branch name?

It connects to the remote URL, lists the refs found there, and
finds any that has the commit you passed in as the 3rd argument
(defaults to HEAD).  If none match it prints ..BRANCH.NOT.VERIFIED..
as the branch name, to signal no branch points at the given commit,
which means it cannot be (easily) pulled.

Not getting that means you have too old of a Git to have my branch
improvements.  It was in ff06c743dc, which is in master and hence
should be in 1.5.2 final.

> (And I'm not sure
> about that "change since commit..." stuff--that seems like slight
> overkill.)

Yea, it can be a little overkill sometimes.  But the maintainer
knows where you started from.  If that commit is horribly old he
might wonder what is going on.  ;-)

-- 
Shawn.
