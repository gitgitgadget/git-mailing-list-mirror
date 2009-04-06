From: Jason Merrill <jason@redhat.com>
Subject: [PATCH] Documentation: clarify .gitattributes search
Date: Sun, 05 Apr 2009 22:43:47 -0400
Message-ID: <49D96C63.9070200@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080700080503020302040605"
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 06 04:46:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqepy-0005CC-Sw
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 04:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754003AbZDFCny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 22:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753718AbZDFCny
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 22:43:54 -0400
Received: from mx2.redhat.com ([66.187.237.31]:57029 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753324AbZDFCny (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 22:43:54 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n362hnTW015380;
	Sun, 5 Apr 2009 22:43:49 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n362ho5u021032;
	Sun, 5 Apr 2009 22:43:51 -0400
Received: from [127.0.0.1] (sebastian-int.corp.redhat.com [172.16.52.221])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n362hnoA009956;
	Sun, 5 Apr 2009 22:43:49 -0400
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115754>

This is a multi-part message in MIME format.
--------------080700080503020302040605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------080700080503020302040605
Content-Type: text/x-patch;
 name="0001-Documentation-clarify-.gitattributes-search.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-Documentation-clarify-.gitattributes-search.patch"

>From 04b504dc0c174d697cc1b75829fe2f7473f193ce Mon Sep 17 00:00:00 2001
From: Jason Merrill <jason@redhat.com>
Date: Sun, 5 Apr 2009 21:54:37 -0400
Subject: [PATCH] Documentation: clarify .gitattributes search


Signed-off-by: Jason Merrill <jason@redhat.com>
---
As discussed on IRC today; I was wondering if my home directory qualified
as a parent directory, but apparently not.

 Documentation/gitattributes.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 55668e3..0338385 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -60,9 +60,9 @@ same as in `.gitignore` files; see linkgit:gitignore[5].
 When deciding what attributes are assigned to a path, git
 consults `$GIT_DIR/info/attributes` file (which has the highest
 precedence), `.gitattributes` file in the same directory as the
-path in question, and its parent directories (the further the
-directory that contains `.gitattributes` is from the path in
-question, the lower its precedence).
+path in question, and its parent directories within the git repository
+(the further the directory that contains `.gitattributes` is from the
+path in question, the lower its precedence).
 
 If you wish to affect only a single repository (i.e., to assign
 attributes to files that are particular to one user's workflow), then
-- 
1.6.2.2


--------------080700080503020302040605--
