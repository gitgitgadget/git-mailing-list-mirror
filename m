From: Junio C Hamano <junkio@cox.net>
Subject: Re: Storing state in $GIT_DIR
Date: Thu, 25 Aug 2005 22:49:06 -0700
Message-ID: <7virxti6y5.fsf@assigned-by-dhcp.cox.net>
References: <46a038f905082420323b025e3b@mail.gmail.com>
	<Pine.LNX.4.58.0508251053000.3317@g5.osdl.org>
	<46a038f905082518306e9d7d2a@mail.gmail.com>
	<Pine.LNX.4.58.0508252051400.3317@g5.osdl.org>
	<46a038f90508252115415acc04@mail.gmail.com>
	<7v3boxl3o1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0508260101390.23242@iabervon.org>
	<Pine.LNX.4.58.0508252219520.3317@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 26 08:51:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8X5v-0001IN-Us
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 07:49:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbVHZFtL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 01:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbVHZFtL
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 01:49:11 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:59537 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932308AbVHZFtK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2005 01:49:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050826054908.GCHK16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 26 Aug 2005 01:49:08 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508252219520.3317@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 25 Aug 2005 22:31:35 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7794>

Linus Torvalds <torvalds@osdl.org> writes:

> That kind of extension shouldn't be too hard, and might make tags much 
> more generally usable (ie you could say "I sign these <n> official 
> releases" or something).

Well, I admit that once I advocated changing "tag" to "bag", but
one problem is how you would dereference something like that.

"v0.99.5^0" means "look at the named object v0.99.5, dereference
it repeatedly until you get a non-tag, and take the result,
which had better be a commit".  If a tag can contain more than
one pointers, I do not know what it means.
