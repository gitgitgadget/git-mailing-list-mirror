From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] change ent to tree in git-diff documentation
Date: Sun, 09 Jul 2006 03:24:11 -0700
Message-ID: <7v1wsvnkj8.fsf@assigned-by-dhcp.cox.net>
References: <E1FzW4h-00058M-3u@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 09 12:24:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzWSh-0007EY-LG
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 12:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbWGIKYY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 06:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030394AbWGIKYY
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 06:24:24 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:31675 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1030231AbWGIKYY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jul 2006 06:24:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060709102423.DLYJ27857.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 9 Jul 2006 06:24:23 -0400
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1FzW4h-00058M-3u@moooo.ath.cx> (Matthias Lederhofer's message
	of "Sun, 9 Jul 2006 11:59:39 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23543>

Matthias Lederhofer <matled@gmx.net> writes:

> This is quite confusing for someone new to git who is not familiar
> with the vocabulary used with git. I don't think a man page is the
> right place for riddles :)
> Additionaly I changed two times 'is' to 'are', I hope this is correct.

I am not attached to <ent> at all, but I do not know if this is
worth it.  I suspect there are many other places you need to fix
to make things consistent, and I think the first thing that
should be touched is glossary.txt.

... goes "git grep -w ent", gets quite surprised and comes back ...

Oops.  I think you are right and I was wrong saying the above
four lines.  It is only git-diff.txt and glossay entry that
talks about <ent>.

Whoever coined <ent> (I do not remember anymore) do you mind
this in addition to Matthias's patch?

-- >8 --
Eradicate <ent>

Technical documentation is not a place for riddles.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
diff --git a/Documentation/glossary.txt b/Documentation/glossary.txt
index 116ddb7..14449ca 100644
--- a/Documentation/glossary.txt
+++ b/Documentation/glossary.txt
@@ -86,7 +86,7 @@ directory::
 ent::
 	Favorite synonym to "tree-ish" by some total geeks. See
 	`http://en.wikipedia.org/wiki/Ent_(Middle-earth)` for an in-depth
-	explanation.
+	explanation.  Avoid this term, not to confuse people.
 
 fast forward::
 	A fast-forward is a special type of merge where you have
