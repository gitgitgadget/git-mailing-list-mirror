From: Junio C Hamano <junkio@cox.net>
Subject: Re: I want to release a "git-1.0"
Date: Tue, 31 May 2005 23:28:55 -0700
Message-ID: <7vsm02pp3s.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
	<m1psv7bjb6.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0505312002160.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 01 08:26:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdMg9-0003Zb-DC
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 08:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVFAG3A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 02:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbVFAG3A
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 02:29:00 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:14312 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261295AbVFAG25 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2005 02:28:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050601062855.ZWBA20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Jun 2005 02:28:55 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505312002160.1876@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 31 May 2005 20:04:11 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Anyway, I wrote just a _very_ introductory thing in
LT> Documentation/tutorial.txt, I'll try to update and expand on it later. It
LT> basically has a really stupid example of "how to set up a new project".

Linus,

        I was following your "tutorial" and saw the last step
(git-whatchanged) showing the HEAD commit and diff _twice_.

You got me _WORRIED_!!!

I knew it uses your faviorite diff-tree command and I was the
most likely suspect who broke it.  And I remember you were
understandably unhappy last time I broke it (the "diff-tree -s"
problem).

It turns out that the example in the tutorial was bad.  Here is
a fix.  It is so obvious that I do not think it deserves a
sign-off nor credit.  Please just fold it into your edit next
time you update the tutorial.

---
cd /opt/packrat/playpen/public/in-place/git/git.junio/
jit-diff : Documentation
# - linus: git-apply --stat: limit lines to 79 characters
# + (working tree)
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -401,7 +401,7 @@ activity.
 To see the whole history of our pitiful little git-tutorial project, we
 can do
 
-	git-whatchanged -p --root HEAD
+	git-whatchanged -p --root
 
 (the "--root" flag is a flag to git-diff-tree to tell it to show the
 initial aka "root" commit as a diff too), and you will see exactly what

Compilation finished at Tue May 31 23:12:32


