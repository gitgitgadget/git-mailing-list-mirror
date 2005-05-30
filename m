From: Junio C Hamano <junkio@cox.net>
Subject: Re: I want to release a "git-1.0"
Date: Mon, 30 May 2005 14:07:36 -0700
Message-ID: <7vbr6s1kyv.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 23:20:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dcrft-000071-2F
	for gcvg-git@gmane.org; Mon, 30 May 2005 23:19:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbVE3VVI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 17:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261758AbVE3VIj
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 17:08:39 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:25233 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261767AbVE3VHq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2005 17:07:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050530210736.EDDZ550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 30 May 2005 17:07:36 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org> (Linus
 Torvalds's message of "Mon, 30 May 2005 13:00:42 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> I was showing off raw git to Steve Chamberlain yesterday, and showing it
LT> to him made some things pretty obvious - one of them being that
LT> "git-init-db" really needed to set up the initial refs etc). So I wrote
LT> this silly "git-commit-script" to make it at least half-way palatable, but
LT> what else do people feel is "too hard"?

I think you need to clarify your intended audience first before
soliciting "list of things that would help CVS user to convert
to GIT".  Specifically, which variant of GIT you are talking
about.

I think you are talking about using the bare Plumbing.  I
suspect that some of the things you said "too hard" may be
coming from the fact that you did not use Cogito in the "showing
off" you did.  I imagine Cogito users do not experience the
trouble you felt with git-init-db, since I presume they would
rather use cg-init which IIUIC sets up the .git/refs structure
for its taste.

Having said that, I am in the same camp as you are in, in that
the (secondary) goal of my involvement in this project so far
has been to make the bare Plumbing confortable enough to use, to
make the choice of Porcelain more or less irrelevant.  As such,
I am all for such a tutorial to convert CVS people to Plumbing
GIT.

Not that I'd volunteer writing big part of such a document.  I
suck at documentation, not just math ;-).

