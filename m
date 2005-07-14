From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] clone-pack: Typofix in the error message.
Date: Wed, 13 Jul 2005 20:26:54 -0700
Message-ID: <7vbr56kqyp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=euc-jp
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 05:27:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsuNJ-00089C-Fd
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 05:27:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVGND05 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 13 Jul 2005 23:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbVGND05
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 23:26:57 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:65259 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261380AbVGND04 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2005 23:26:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050714032655.HCND12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 13 Jul 2005 23:26:55 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Cleans a small cut-and-paste mistake.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 clone-pack.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

c8db6ce8de9b9fc8a5eab939704eaa1535a0d3f0
diff --git a/clone-pack.c b/clone-pack.c
--- a/clone-pack.c
+++ b/clone-pack.c
@@ -30,7 +30,7 @@ static struct ref *get_remote_refs(int f
 		if (line[len-1] =3D=3D '\n')
 			line[--len] =3D 0;
 		if (len < 42 || get_sha1_hex(line, sha1))
-			die("git-fetch-pack: protocol error - expected ref descriptor, got =
'%s=8E=A4'", line);
+			die("git-clone-pack: protocol error - expected ref descriptor, got =
'%s=8E=A4'", line);
 		refname =3D line+41;
 		len =3D len-40;
 		if (nr_match && !path_match(refname, nr_match, match))
