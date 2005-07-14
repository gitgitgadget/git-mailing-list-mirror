From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] cat-file: be consistent in usage string and documentation.
Date: Wed, 13 Jul 2005 20:23:40 -0700
Message-ID: <7vvf3ekr43.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 05:24:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsuKA-0007jh-SF
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 05:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbVGNDXn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 23:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262877AbVGNDXn
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 23:23:43 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:28904 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S262874AbVGNDXm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2005 23:23:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050714032340.HBCP12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 13 Jul 2005 23:23:40 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Now that we have something called tag object, and a notion of
"tags" stored in .git/refs/tags/ directory, the word "tagname"
has become misleading in the usage string.  The documentation
already calls that <type>.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 cat-file.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

61a4ebfb09cee6955f80a863b9651204ba17117a
diff --git a/cat-file.c b/cat-file.c
--- a/cat-file.c
+++ b/cat-file.c
@@ -13,7 +13,7 @@ int main(int argc, char **argv)
 	unsigned long size;
 
 	if (argc != 3 || get_sha1(argv[2], sha1))
-		usage("git-cat-file [-t | -s | tagname] <sha1>");
+		usage("git-cat-file [-t | -s | <type>] <sha1>");
 
 	if (!strcmp("-t", argv[1]) || !strcmp("-s", argv[1])) {
 		if (!sha1_object_info(sha1, type,
