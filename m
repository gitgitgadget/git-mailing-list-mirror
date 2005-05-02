From: Junio C Hamano <junkio@cox.net>
Subject: Re: Complete http-pull; where should it go?
Date: Sun, 01 May 2005 17:09:49 -0700
Message-ID: <7vsm16qyia.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.21.0505011656270.30848-100000@iabervon.org>
	<Pine.LNX.4.58.0505011616230.22864@ppc970.osdl.org>
	<Pine.LNX.4.58.0505011638370.22864@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Mon May 02 02:05:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSOQZ-00082S-1A
	for gcvg-git@gmane.org; Mon, 02 May 2005 02:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVEBAKI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 20:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbVEBAKI
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 20:10:08 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:43703 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261522AbVEBAJz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2005 20:09:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050502000949.WWLH7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 1 May 2005 20:09:49 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505011638370.22864@ppc970.osdl.org> (Linus
 Torvalds's message of "Sun, 1 May 2005 16:48:04 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> I didn't do the ".p1" for parent thing. It would be easy to add, I just 
LT> haven't decided on a nice syntax for it (I'd like something that is nice 
LT> and doesn't need quoting, but the ".p1" seems a bit _too_ ugly).

Shameless plug but could you take a look at how my JIT does it,
at <http://members.cox.net/junkio/JITNotes.txt>, especially
scroll down to near the bottom "Syntax to naming a snapshot or a
commit" section?

I still think this kind of thing belongs to Porcelain not
Plumbing, though.

