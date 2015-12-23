From: "Stephen P. Smith" <ischis2@cox.net>
Subject: [PATCH V3 1/2] glossary: define the term shallow clone
Date: Tue, 22 Dec 2015 20:53:24 -0700
Message-ID: <1450842804-14069-1-git-send-email-ischis2@cox.net>
References: <CAPig+cR5_ybQ_gODu6iusXxib2ZEOfjYJ2RCe3qwh6LCF5Yw3A@mail.gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	"Stephen P. Smith" <ischis2@cox.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 23 04:53:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBaU8-0000yt-Iv
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 04:53:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754971AbbLWDwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 22:52:46 -0500
Received: from fed1rmfepo101.cox.net ([68.230.241.143]:46554 "EHLO
	fed1rmfepo101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227AbbLWDwo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 22:52:44 -0500
Received: from fed1rmimpo209 ([68.230.241.160]) by fed1rmfepo101.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20151223035243.QBBR331.fed1rmfepo101.cox.net@fed1rmimpo209>
          for <git@vger.kernel.org>; Tue, 22 Dec 2015 22:52:43 -0500
Received: from thunderbird ([68.231.74.134])
	by fed1rmimpo209 with cox
	id wrsj1r0012tqoqC01rsj13; Tue, 22 Dec 2015 22:52:43 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020202.567A1A8B.0063,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=RNFt6fe+ c=1 sm=1
 a=/Rt4pg3TtX3KzfzhvVoEow==:17 a=kviXuzpPAAAA:8 a=wUQvQvOEmiQA:10
 a=3OWYAzbGzU0cImQrX4sA:9 a=/Rt4pg3TtX3KzfzhvVoEow==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.smith.home (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id 06C7A13F63A;
	Tue, 22 Dec 2015 20:53:33 -0700 (MST)
X-Mailer: git-send-email 2.6.3.368.gf34be46
In-Reply-To: <CAPig+cR5_ybQ_gODu6iusXxib2ZEOfjYJ2RCe3qwh6LCF5Yw3A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282920>

There are several places in the documentation that
the term shallow clone is used. Defining the term
enables its use elsewhere with a known definition.

Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---
 Documentation/glossary-content.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index e225974..cecc83d 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -531,6 +531,10 @@ The most notable example is `HEAD`.
 	"Secure Hash Algorithm 1"; a cryptographic hash function.
 	In the context of Git used as a synonym for <<def_object_name,object name>>.
 
+[[def_shallow_clone]]shallow clone::
+	A clone of a <<def_repository,repository>> which creates a
+	<<def_shallow_repository,shallow_repository>>.
+
 [[def_shallow_repository]]shallow repository::
 	A shallow <<def_repository,repository>> has an incomplete
 	history some of whose <<def_commit,commits>> have <<def_parent,parents>> cauterized away (in other
-- 
2.6.3.368.gf34be46
