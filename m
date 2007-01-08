From: Theodore Tso <tytso@mit.edu>
Subject: Re: [DRAFT] Branching and merging with git
Date: Mon, 8 Jan 2007 09:03:05 -0500
Message-ID: <20070108140305.GE32756@thunk.org>
References: <20061116221701.4499.qmail@science.horizon.com> <20070103170411.GB5491@thunk.org> <20070107234411.GD18009@fieldses.org> <7vzm8uz7pz.fsf@assigned-by-dhcp.cox.net> <20070108023511.GI18009@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, linux@horizon.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 08 15:03:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3v6D-0004eT-MH
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 15:03:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbXAHODi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 09:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161305AbXAHODi
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 09:03:38 -0500
Received: from thunk.org ([69.25.196.29]:38334 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751549AbXAHODi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 09:03:38 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1H3vA8-0003oU-SR; Mon, 08 Jan 2007 09:07:45 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1H3v5d-00049q-Me; Mon, 08 Jan 2007 09:03:05 -0500
To: "J. Bruce Fields" <bfields@fieldses.org>
Content-Disposition: inline
In-Reply-To: <20070108023511.GI18009@fieldses.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36262>

On Sun, Jan 07, 2007 at 09:35:11PM -0500, J. Bruce Fields wrote:
> chapters 1 and 2: "Read-only" operations:
> 
> 	clone, fetch, the commit DAG, etc.; material that could be
> 	useful to a linux kernel tester, for example.  This also
> 	includes lots of stuff about branch manipulation and fetching,
> 	just because that's necessary to keep a repo up to date and
> 	check out random commits.  Once we have "git remote" and
> 	disconnected checkouts most of this could be postponed till
> 	later.

I would add a QuickStart Chapter before you start going into the
"read-only" oeperations.  It would show how to create a completely
empty repository, and add a few commits.  It would also demonstrate
how to clone an example repository (with a fixed set of contents,
stored at git://git.kernel.org/pub/scm/git/example and add a commit
using "git commit -a".

The basic idea is to show the user that git really isn't that hard,
*before* you start diving into a lot of details.  If you don't tell a
user how to make a commit until Chapter 3, he/she will assume it's
because it's Really Hard, and you may end up losing them before that.

> Chapter 3: "Read-write" operations:
> 
> 	Read-write stuff: creating commits (basic mention of index),
> 	handling merges, git-gc, ending with distributed stuff:
> 	importing and exporting patches, pull and push, etc.

At least some discussions of branches needs to happen here; it's
really important to talk about different workflows, and how you use
branches as part of your read-write operations.  Some folks might or
might not use topic branches, but the concept of using temporary
branches to try things out is critical.

> Chapter 4 (unwritten): interactions with other VCS's
> 
> 	cvs, subversion.  Also some of us use track projects with git
> 	even when all we've got is a sequence of release tarballs to
> 	track, and that might be worth documenting.
> 
> Chapter 6 (unwritten): git internals
> 
> 	I intend to just do a wholesale import of either tutorial-2.txt,
> 	core-tutorial.txt, or the README, or some combination thereof,
> 	but can't decide which.

You might want to consider putting these two chapters into appendices.

						- Ted
