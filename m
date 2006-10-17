From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Tue, 17 Oct 2006 11:19:21 -0700
Message-ID: <7v64eikdp2.fsf@assigned-by-dhcp.cox.net>
References: <7vvemjmlo2.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610171005370.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 20:37:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZtoI-00065K-Mm
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 20:37:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWJQSWl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 14:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWJQSWl
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 14:22:41 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:9214 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751281AbWJQSWk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 14:22:40 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061017181922.YKKP6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Tue, 17 Oct 2006 14:19:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id bWK81V0051kojtg0000000
	Tue, 17 Oct 2006 14:19:08 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610171005370.3962@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 17 Oct 2006 10:16:21 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29099>

Linus Torvalds <torvalds@osdl.org> writes:

> There's two things to note about this:
>
>  - the libxdiff dependencies are broken, so it's likely that you need to 
>    do a "make clean; make" to actually see the result of this.

Eh, stupid-and-obvious like this perhaps.

---

diff --git a/Makefile b/Makefile
index 2c7c338..3fed480 100644
--- a/Makefile
+++ b/Makefile
@@ -237,6 +237,7 @@ PYMODULES = \
 
 LIB_FILE=libgit.a
 XDIFF_LIB=xdiff/lib.a
+$(XDIFF_LIB): $(wildcard xdiff/*.[ch])
 
 LIB_H = \
 	archive.h blob.h cache.h commit.h csum-file.h delta.h grep.h \
