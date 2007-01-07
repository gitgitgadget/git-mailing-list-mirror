From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [DRAFT] Branching and merging with git
Date: Sun, 7 Jan 2007 18:44:11 -0500
Message-ID: <20070107234411.GD18009@fieldses.org>
References: <20061116221701.4499.qmail@science.horizon.com> <20070103170411.GB5491@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux@horizon.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 08 00:44:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3hgj-0006e3-Fr
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 00:44:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965254AbXAGXoQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 18:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965256AbXAGXoQ
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 18:44:16 -0500
Received: from mail.fieldses.org ([66.93.2.214]:34546 "EHLO
	pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965254AbXAGXoO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 18:44:14 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1H3hgR-0004GZ-Gr; Sun, 07 Jan 2007 18:44:11 -0500
To: Theodore Tso <tytso@mit.edu>
Content-Disposition: inline
In-Reply-To: <20070103170411.GB5491@thunk.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36205>

On Wed, Jan 03, 2007 at 12:04:11PM -0500, Theodore Tso wrote:
> What ever happened to this document?  There was some talk of getting
> this integrated into the git tree as Docmentation/tutorial-3.txt.

Just to throw more fuel on the fire....

I have a draft attempt at a complete "git user's manual" at

	http://www.fieldses.org/~bfields/

The goals are:

	- Readable from beginning to end in order without having read
	  any other git documentation beforehand.
	- Helpful section names and cross-references, so it's not too
	  hard to skip around some if you need to.
	- Organized to allow it to grow much larger (unlike the
	  tutorials)

It's more liesurely than tutorial.txt, but tries to stay focused on
practical how-to stuff.  It adds a discussion of how to resolve merge
conflicts, and partial instructions on setting up and dealing with a
public repository.

I've lifted a little bit from "branching and merging" (e.g., some of the
discussion of history diagrams), and could probably steal more if that's
OK.  (Similarly anyone should of course feel free to reuse bits of this
if any parts seem more useful than the whole.)

There's a lot of detail on managing branches and using git-fetch, just
because those are essential even to people needing read-only access
(e.g., kernel testers).  I think those sections will be much shorter
once the new "git remote" command and the disconnected checkouts are
taken into account.

I do feel bad about adding yet another piece of documentation, but I we
need something that goes through all the basics in a logical order, and
I wasn't seeing how to grow the tutorials into that.

Opinions?

--b.
