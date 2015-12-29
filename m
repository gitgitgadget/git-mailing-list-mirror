From: "Stephen P. Smith" <ischis2@cox.net>
Subject: [PATCH V4 1/2] glossary: define the term shallow clone
Date: Tue, 29 Dec 2015 11:54:35 -0700
Message-ID: <1451415275-3900-1-git-send-email-ischis2@cox.net>
References: <xmqqfuymji50.fsf@gitster.mtv.corp.google.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	"Stephen P. Smith" <ischis2@cox.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 29 19:54:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDzQ5-0002Of-Gk
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 19:54:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753686AbbL2Syu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 13:54:50 -0500
Received: from fed1rmfepo203.cox.net ([68.230.241.148]:58412 "EHLO
	fed1rmfepo203.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753600AbbL2Sys (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 13:54:48 -0500
Received: from fed1rmimpo305 ([68.230.241.173]) by fed1rmfepo203.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20151229185448.GTDU26406.fed1rmfepo203.cox.net@fed1rmimpo305>
          for <git@vger.kernel.org>; Tue, 29 Dec 2015 13:54:48 -0500
Received: from thunderbird ([68.231.74.134])
	by fed1rmimpo305 with cox
	id zWun1r00V2tqoqC01Wun4C; Tue, 29 Dec 2015 13:54:47 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020203.5682D6F7.0238,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=f8aW8pOM c=1 sm=1
 a=/Rt4pg3TtX3KzfzhvVoEow==:17 a=kviXuzpPAAAA:8 a=wUQvQvOEmiQA:10
 a=TSbVqHtbAAAA:8 a=3OWYAzbGzU0cImQrX4sA:9 a=/Rt4pg3TtX3KzfzhvVoEow==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.smith.home (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id 8211013F6E8;
	Tue, 29 Dec 2015 11:54:47 -0700 (MST)
X-Mailer: git-send-email 2.7.0-rc2
In-Reply-To: <xmqqfuymji50.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283142>

There are several places in the documentation that
the term shallow clone is used. Defining the term
enables its use elsewhere with a known definition.

Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---

Notes:
    The review comments for the user guide update[1] suggested a change
    in the definition of a shallow clone to:
       - note differences between a shallow clone and a shallow repository and
       - define it as a noun (which is the way the user guide update
         patch uses the term)
    
    [1] http://article.gmane.org/gmane.comp.version-control.git/283052

 Documentation/glossary-content.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index e225974..cafc284 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -531,6 +531,11 @@ The most notable example is `HEAD`.
 	"Secure Hash Algorithm 1"; a cryptographic hash function.
 	In the context of Git used as a synonym for <<def_object_name,object name>>.
 
+[[def_shallow_clone]]shallow clone::
+	Mostly a synonym to <<def_shallow_repository,shallow repository>>
+	but the phrase makes it more explicit that it was created by
+	running `git clone --depth=...` command.
+
 [[def_shallow_repository]]shallow repository::
 	A shallow <<def_repository,repository>> has an incomplete
 	history some of whose <<def_commit,commits>> have <<def_parent,parents>> cauterized away (in other
-- 
2.7.0-rc2
