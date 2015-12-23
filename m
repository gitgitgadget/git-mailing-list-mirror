From: "Stephen P. Smith" <ischis2@cox.net>
Subject: [PATCH V4 2/2] user-manual: add section documenting shallow clones
Date: Wed, 23 Dec 2015 13:36:01 -0700
Message-ID: <1450902961-1528-1-git-send-email-ischis2@cox.net>
References: <CAPig+cRMdpJ-k9L33jE01ubfK6MOWNGwuoUULuQqOv8C0we+DQ@mail.gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	"Stephen P. Smith" <ischis2@cox.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 23 21:35:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBq8O-0005P7-Vj
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 21:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965366AbbLWUfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2015 15:35:41 -0500
Received: from fed1rmfepo102.cox.net ([68.230.241.144]:51664 "EHLO
	fed1rmfepo102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965352AbbLWUfk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2015 15:35:40 -0500
Received: from fed1rmimpo110 ([68.230.241.159]) by fed1rmfepo102.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20151223203539.SQM7752.fed1rmfepo102.cox.net@fed1rmimpo110>
          for <git@vger.kernel.org>; Wed, 23 Dec 2015 15:35:39 -0500
Received: from thunderbird ([68.231.74.134])
	by fed1rmimpo110 with cox
	id x8be1r00Z2tqoqC018becs; Wed, 23 Dec 2015 15:35:39 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020201.567B059B.0066,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=B55nJpRM c=1 sm=1
 a=/Rt4pg3TtX3KzfzhvVoEow==:17 a=kviXuzpPAAAA:8 a=wUQvQvOEmiQA:10
 a=TSbVqHtbAAAA:8 a=a-mmkxGj_Wl2OYgx35IA:9 a=/Rt4pg3TtX3KzfzhvVoEow==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.smith.home (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id BC43213F63A;
	Wed, 23 Dec 2015 13:36:32 -0700 (MST)
X-Mailer: git-send-email 2.6.3.368.gf34be46
In-Reply-To: <CAPig+cRMdpJ-k9L33jE01ubfK6MOWNGwuoUULuQqOv8C0we+DQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282953>

Rather than merely pointing readers at the 1.5 release notes to
learn about shallow clones, document them formally.

Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---

 I replaced the paragraphs that I wrote with Eric Shunshine's since it
 was cleaner.

 I like the idea of linking to the preceeding effort, but gmane.org is
 currently undergoing maintance and therefore giving me errors when I
 attempt to access it.

 Documentation/user-manual.txt | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 1c790ac..5c13683 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2128,6 +2128,20 @@ The gitweb cgi script provides users an easy way to browse your
 project's files and history without having to install Git; see the file
 gitweb/INSTALL in the Git source tree for instructions on setting it up.
 
+[[how-to-get-a-git-repository-with-minimal-history]]
+How to get a Git repository with minimal history
+------------------------------------------------
+
+A <<def_shallow_clone,shallow clone>>, with its truncated
+history, is useful when one is interested only in recent history
+of a project and getting full history from the upstream is
+expensive.
+
+A <<def_shallow_clone,shallow clone>> is created by specifying
+the linkgit:git-clone[1] `--depth` switch. The depth can later be
+changed with the linkgit:git-fetch[1] `--depth` switch, or full
+history restored with `--unshallow`.
+
 [[sharing-development-examples]]
 Examples
 --------
@@ -4645,9 +4659,6 @@ standard end-of-chapter section?
 
 Include cross-references to the glossary, where appropriate.
 
-Document shallow clones?  See draft 1.5.0 release notes for some
-documentation.
-
 Add a section on working with other version control systems, including
 CVS, Subversion, and just imports of series of release tarballs.
 
-- 
2.6.3.368.gf34be46
