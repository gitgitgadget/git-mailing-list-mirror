From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff-cache path restriction fix.
Date: Tue, 24 May 2005 18:49:20 -0700
Message-ID: <7v3bscqdlr.fsf@assigned-by-dhcp.cox.net>
References: <7vu0ksrv1v.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505241757280.2307@ppc970.osdl.org>
	<7vekbwru6x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505241814220.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 03:48:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dakzv-0001WS-AK
	for gcvg-git@gmane.org; Wed, 25 May 2005 03:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbVEYBt3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 21:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbVEYBt3
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 21:49:29 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:65515 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S262235AbVEYBtW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 21:49:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050525014920.UAVA7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 24 May 2005 21:49:20 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505241814220.2307@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 24 May 2005 18:24:58 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> I checked in the fixed arg parsing already ;)

Thanks.

LT> Hmm. According to that logic, ">" and ">=" is superfluous.

Yes, I was trained by Paul Eggert (me says that proudly).

Practically speaking, the only time I deliberately used > and >=
was when I was doing some dialect of SQL that always wanted
literal on fixed side and column on the other; I do not remember
which was which and whose SQL anymore.

Of course I sometimes end up using them when I am trying to
match the style of existing code.  However, for that particular
comparison in diff-cache, there weren't any other around there
to match, other than the "if (argc < 2 || ...)" after the loop,
which was what I myself wrote so it does not count.

LT> Also, what language do you actually speak?

Japanese.

I have not thought about that kind of relationship between the
natural language and if() expression at all, and I am certainly
not claiming comparing it the logic way is natural in Japanese.
I think it probably isn't.

LT> ... Usually google is a good way to get a feel for how
LT> common some phrase is, but not on things like this.

If you feel strongly about this, just write it in coding-style
document and I'll follow whatever you tell me while I am coding
for this project.  Honestly, I do not particularly care how
common that is in the wider world outside.


