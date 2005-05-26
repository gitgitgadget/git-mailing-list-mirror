From: Junio C Hamano <junkio@cox.net>
Subject: Re: Summary of core GIT while you are away.
Date: Thu, 26 May 2005 15:25:17 -0700
Message-ID: <7vy8a18w1e.fsf@assigned-by-dhcp.cox.net>
References: <7vzmuy13od.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505160837080.28162@ppc970.osdl.org>
	<20050526004411.GA12360@vrfy.org>
	<Pine.LNX.4.58.0505251826460.2307@ppc970.osdl.org>
	<20050526202712.GA6024@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, pasky@ucw.cz,
	braddr@puremagic.com, nico@cam.org, david@dgreaves.com,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 00:29:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbQm2-0008SE-FG
	for gcvg-git@gmane.org; Fri, 27 May 2005 00:24:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbVEZWZx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 18:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbVEZWZx
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 18:25:53 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:6024 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261835AbVEZWZY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2005 18:25:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050526222519.PUMC26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 26 May 2005 18:25:19 -0400
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20050526202712.GA6024@vrfy.org> (Kay Sievers's message of
 "Thu, 26 May 2005 22:27:12 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "KS" == Kay Sievers <kay.sievers@vrfy.org> writes:

KS> Nice, thanks. Here is a very first try. It searches the commit messages
KS> and uses pickaxe to search in the file content:
KS>   http://ehlo.org/~kay/gitweb.cgi?p=git/git.git;a=search;s=symlink

Nice, thanks for using pickaxe ;-).  One request, knowing well
that what you have on ehlo is your first cut.

The pickaxe really shines when you can paste a couple of lines
of code in the version you are having trouble with (or just you
are curious about) in order to see where they came from.  For
example, I did an equivalent of the following command back to
figure out which patch and author to give credit to when I stole
the tagged output format for git-ls-files from Cogito branch:

git-rev-list pasky |
git-diff-tree -v -p --stdin \
-S'static const char *tag_cached = "";
static const char *tag_unmerged = "";
static const char *tag_removed = "";'

Since this is primarily about program code, forbidding '*' is
rather nasty, and not being able to do multiple lines makes it
quite less useful than it could be.


