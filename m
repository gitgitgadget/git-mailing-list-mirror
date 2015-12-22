From: "Stephen P. Smith" <ischis2@cox.net>
Subject: [PATCH 1/2] Define the term shallow clone.
Date: Mon, 21 Dec 2015 19:09:38 -0700
Message-ID: <1450750180-1811-1-git-send-email-ischis2@cox.net>
Cc: "Stephen P. Smith" <ischis2@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 22 03:10:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBCOr-0001Wj-Km
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 03:10:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025AbbLVCKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 21:10:00 -0500
Received: from fed1rmfepo103.cox.net ([68.230.241.145]:44205 "EHLO
	fed1rmfepo103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbbLVCJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 21:09:59 -0500
Received: from fed1rmimpo306 ([68.230.241.174]) by fed1rmfepo103.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20151222020958.NEHY11111.fed1rmfepo103.cox.net@fed1rmimpo306>
          for <git@vger.kernel.org>; Mon, 21 Dec 2015 21:09:58 -0500
Received: from thunderbird ([68.231.74.134])
	by fed1rmimpo306 with cox
	id wS9y1r0072tqoqC01S9yR4; Mon, 21 Dec 2015 21:09:58 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020206.5678B0F6.0106,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=LKq4tuq9 c=1 sm=1
 a=/Rt4pg3TtX3KzfzhvVoEow==:17 a=kviXuzpPAAAA:8 a=wUQvQvOEmiQA:10
 a=3OWYAzbGzU0cImQrX4sA:9 a=/Rt4pg3TtX3KzfzhvVoEow==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.smith.home (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id E3C1A13F6E8;
	Mon, 21 Dec 2015 19:10:41 -0700 (MST)
X-Mailer: git-send-email 2.6.3.368.gf34be46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282828>

There are several places in the documentation that
the term shallow clone is used. Defining the term
enables its use elsewhere with a known definition.

Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---
 Documentation/glossary-content.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index e225974..d384aed 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -531,6 +531,10 @@ The most notable example is `HEAD`.
 	"Secure Hash Algorithm 1"; a cryptographic hash function.
 	In the context of Git used as a synonym for <<def_object_name,object name>>.
 
+[[def_shallow_clone]]shallow clone::
+	A clone of a <<def_repository,repository>> which creates a
+    <<def_shallow_repository,shallow_repository>>.
+
 [[def_shallow_repository]]shallow repository::
 	A shallow <<def_repository,repository>> has an incomplete
 	history some of whose <<def_commit,commits>> have <<def_parent,parents>> cauterized away (in other
-- 
2.6.3.368.gf34be46
