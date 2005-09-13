From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH 2/5] Don't output 'Automatic merge failed, ...'
Date: Tue, 13 Sep 2005 23:40:23 +0200
Message-ID: <20050913214023.GC10953@c165.ib.student.liu.se>
References: <20050913213730.GA10953@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Sep 13 23:42:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFIW3-0006Ms-VR
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 23:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbVIMVk0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 17:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbVIMVk0
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 17:40:26 -0400
Received: from [85.8.31.11] ([85.8.31.11]:14471 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1750898AbVIMVkY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Sep 2005 17:40:24 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 66D47411B; Tue, 13 Sep 2005 23:45:28 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EFIVr-0002uG-00; Tue, 13 Sep 2005 23:40:23 +0200
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050913213730.GA10953@c165.ib.student.liu.se>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8493>

git-merge.sh does this for us.

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 git-merge-recursive.py |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

e0e1a108a224b6bf202beb59c1514325205d3638
diff --git a/git-merge-recursive.py b/git-merge-recursive.py
--- a/git-merge-recursive.py
+++ b/git-merge-recursive.py
@@ -423,5 +423,4 @@ except:
 if clean:
     sys.exit(0)
 else:
-    print 'Automatic merge failed, fix up by hand'
     sys.exit(1)
