From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: [PATCH] Really *do* nothing in while loop
Date: Sun, 8 May 2005 11:34:40 +0200
Message-ID: <20050508093440.GA9873@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 08 11:28:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUi4f-0005sZ-2Q
	for gcvg-git@gmane.org; Sun, 08 May 2005 11:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262828AbVEHJeo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 05:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262833AbVEHJeo
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 05:34:44 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:1705 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262828AbVEHJel (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2005 05:34:41 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j489YeS8012392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 8 May 2005 09:34:40 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j489YenC012391;
	Sun, 8 May 2005 11:34:40 +0200 (CEST)
To: LKML <linux-kernel@vger.kernel.org>, GIT <git@vger.kernel.org>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>,
	GIT <git@vger.kernel.org>
Content-Disposition: inline
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[PATCH] Really *do* nothing in while loop

Signed-Off-by: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>

--- a/sha1_file.c
+++ b/sha1_file.c
@@ -335,7 +335,7 @@
 	stream.next_in = hdr;
 	stream.avail_in = hdrlen;
 	while (deflate(&stream, 0) == Z_OK)
-		/* nothing */
+		/* nothing */;
 
 	/* Then the data itself.. */
 	stream.next_in = buf;
