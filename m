From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [DRAFT] Branching and merging with git
Date: Sun, 7 Jan 2007 21:35:11 -0500
Message-ID: <20070108023511.GI18009@fieldses.org>
References: <20061116221701.4499.qmail@science.horizon.com> <20070103170411.GB5491@thunk.org> <20070107234411.GD18009@fieldses.org> <7vzm8uz7pz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux@horizon.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 08 03:35:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3kM4-0000Ke-CQ
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 03:35:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030456AbXAHCfQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 21:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030453AbXAHCfQ
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 21:35:16 -0500
Received: from mail.fieldses.org ([66.93.2.214]:36045 "EHLO
	pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030458AbXAHCfP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 21:35:15 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1H3kLv-0007pd-UJ; Sun, 07 Jan 2007 21:35:11 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzm8uz7pz.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36226>

On Sun, Jan 07, 2007 at 04:24:08PM -0800, Junio C Hamano wrote:
> "J. Bruce Fields" <bfields@fieldses.org> writes:
> In other words, I think we have enough information in the
> tutorial documents, but the problem is not the lack of
> information -- the problem is the lack of organization.
> 
> I think this effort of yours is wonderful because it directly
> tackles that problem.

OK, thanks for the vote of confidence....  My tentative organization
(which I'm totally open to argument about) is:

chapters 1 and 2: "Read-only" operations:

	clone, fetch, the commit DAG, etc.; material that could be
	useful to a linux kernel tester, for example.  This also
	includes lots of stuff about branch manipulation and fetching,
	just because that's necessary to keep a repo up to date and
	check out random commits.  Once we have "git remote" and
	disconnected checkouts most of this could be postponed till
	later.

Chapter 3: "Read-write" operations:

	Read-write stuff: creating commits (basic mention of index),
	handling merges, git-gc, ending with distributed stuff:
	importing and exporting patches, pull and push, etc.

Chapter 4 (unwritten): interactions with other VCS's

	cvs, subversion.  Also some of us use track projects with git
	even when all we've got is a sequence of release tarballs to
	track, and that might be worth documenting.

Chapter 5 (unwritten): rewriting history

	rebasing, cherry-picking, managing patch series, etc.

Chapter 6 (unwritten): git internals

	I intend to just do a wholesale import of either tutorial-2.txt,
	core-tutorial.txt, or the README, or some combination thereof,
	but can't decide which.

--b.
