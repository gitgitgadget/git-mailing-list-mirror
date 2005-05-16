From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/4] Tweak diff output further to make it a bit less
 distracting.
Date: Mon, 16 May 2005 16:44:00 -0700
Message-ID: <7vsm0mlosf.fsf@assigned-by-dhcp.cox.net>
References: <7vvf5kqj9l.fsf@assigned-by-dhcp.cox.net>
	<20050516220559.GC8609@pasky.ji.cz>
	<7vsm0mn5s1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505161556260.18337@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 01:44:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXpFQ-00068g-6z
	for gcvg-git@gmane.org; Tue, 17 May 2005 01:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbVEPXoG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 May 2005 19:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbVEPXoF
	(ORCPT <rfc822;git-outgoing>); Mon, 16 May 2005 19:44:05 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:53393 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261977AbVEPXoC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2005 19:44:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050516234400.HWWR22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 16 May 2005 19:44:00 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505161556260.18337@ppc970.osdl.org> (Linus
 Torvalds's message of "Mon, 16 May 2005 16:28:31 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> I have to say, I muct prefer the first over the second.

Likewise.

LT> ... (whether you want the "mode"
LT> for the deleted file case or not is up to you - it could be an added
LT> sanity check that the diff actually matches, but on the other hand there's
LT> really nothing you could do anyway except warn if the mode didn't match,
LT> so..)

Applying patch in reverse comes to mind...

I'd agree what you said about "diff -git" in the rest of your
message makes the most sense.

