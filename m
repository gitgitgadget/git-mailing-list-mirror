From: Junio C Hamano <junkio@cox.net>
Subject: Re: Storing state in $GIT_DIR
Date: Thu, 25 Aug 2005 22:52:41 -0700
Message-ID: <7v8xypi6s6.fsf@assigned-by-dhcp.cox.net>
References: <46a038f905082420323b025e3b@mail.gmail.com>
	<Pine.LNX.4.58.0508251053000.3317@g5.osdl.org>
	<46a038f905082518306e9d7d2a@mail.gmail.com>
	<Pine.LNX.4.58.0508252051400.3317@g5.osdl.org>
	<46a038f90508252115415acc04@mail.gmail.com>
	<7v3boxl3o1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0508260101390.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>, GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 26 09:47:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8X9H-0001Xr-G6
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 07:53:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbVHZFwo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 01:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbVHZFwo
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 01:52:44 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:33488 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932352AbVHZFwn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2005 01:52:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050826055241.BKYO19627.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 26 Aug 2005 01:52:41 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0508260101390.23242@iabervon.org> (Daniel
	Barkalow's message of "Fri, 26 Aug 2005 01:08:14 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7771>

Daniel Barkalow <barkalow@iabervon.org> writes:

> I don't think this buys you anything, because then the tag needs to be
> accessible from something, which is the same problem you were trying to
> solve for the commit.

Actually not.  My suggestion was a qualified one: "If all you
need is a textual information plus a single pointer to a commit
object", and Martin did not say different generations of arch
metainfo needs to be strung together, so you could keep updating
the tag object in "refs/tags/arch-meta-info", which has such a
pointer and textual arch meta info and nothing else.
