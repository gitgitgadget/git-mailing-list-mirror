From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: [PATCH] git: Mention the '-p' option in the usage help string if git-diff-tree.
Date: Thu, 5 May 2005 21:51:34 +0200
Message-ID: <20050505195134.GN20994@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu May 05 21:52:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTmNB-0005Xq-RI
	for gcvg-git@gmane.org; Thu, 05 May 2005 21:51:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbVEETyx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 15:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262199AbVEETxi
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 15:53:38 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:23970 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262222AbVEETvl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2005 15:51:41 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j45JpZS8022906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 5 May 2005 19:51:35 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j45JpZoD022905;
	Thu, 5 May 2005 21:51:35 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>, GIT <git@vger.kernel.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	GIT <git@vger.kernel.org>
Content-Disposition: inline
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Mention the '-p' option in the usage help string of git-diff-tree.

Signed-Off-by: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>

--- a/diff-tree.c
+++ b/diff-tree.c
@@ -250,7 +250,7 @@ static int diff_tree_sha1(const unsigned
 	return retval;
 }
 
-static char *diff_tree_usage = "diff-tree [-r] [-z] <tree sha1> <tree sha1>";
+static char *diff_tree_usage = "diff-tree [-p] [-r] [-z] <tree sha1> <tree sha1>";
 
 int main(int argc, char **argv)
 {
