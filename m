From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 5/5] README.md: move down historical explanation about the name
Date: Tue, 23 Feb 2016 18:40:29 +0100
Message-ID: <1456249229-30454-6-git-send-email-Matthieu.Moy@imag.fr>
References: <1456249229-30454-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: emma.westby@gmail.com, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 18:41:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYGxn-0006DG-5q
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 18:41:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754765AbcBWRl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 12:41:26 -0500
Received: from mx1.imag.fr ([129.88.30.5]:37003 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754739AbcBWRlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 12:41:09 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u1NHf3g7004346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 23 Feb 2016 18:41:03 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1NHf0l9012837;
	Tue, 23 Feb 2016 18:41:04 +0100
X-Mailer: git-send-email 2.7.2.334.g35ed2ae.dirty
In-Reply-To: <1456249229-30454-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 23 Feb 2016 18:41:03 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1NHf3g7004346
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1456854063.31799@x4/BURL+3j9ot48Bb59WbQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287089>

The explanations about why the name was chosen are secondary compared to
the description and link to the documentation.

Some consider these explanations as good computer scientists joke, but
other see it as needlessly offensive vocabulary.

This patch preserves the historical joke, but gives it less importance
by moving it to the end of the README, and makes it clear that it is a
historical explanation, that does not necessarily reflect the state of
mind of current developers.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 README.md | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/README.md b/README.md
index c11c3e2..40de78e 100644
--- a/README.md
+++ b/README.md
@@ -1,16 +1,5 @@
 # Git - fast, scalable, distributed revision control system
 
-"git" can mean anything, depending on your mood.
-
- - random three-letter combination that is pronounceable, and not
-   actually used by any common UNIX command.  The fact that it is a
-   mispronunciation of "get" may or may not be relevant.
- - stupid. contemptible and despicable. simple. Take your pick from the
-   dictionary of slang.
- - "global information tracker": you're in a good mood, and it actually
-   works for you. Angels sing, and a light suddenly fills the room.
- - "goddamn idiotic truckload of sh*t": when it breaks
-
 Git is a fast, scalable, distributed revision control system with an
 unusually rich command set that provides both high-level operations
 and full access to internals.
@@ -51,6 +40,18 @@ list the current status of various development topics to the mailing
 list.  The discussion following them give a good reference for
 project status, development direction and remaining tasks.
 
+The name "git" was given by Linus Torvalds when he wrote the very
+first version. He described it as (depending on your mood):
+
+ - random three-letter combination that is pronounceable, and not
+   actually used by any common UNIX command.  The fact that it is a
+   mispronunciation of "get" may or may not be relevant.
+ - stupid. contemptible and despicable. simple. Take your pick from the
+   dictionary of slang.
+ - "global information tracker": you're in a good mood, and it actually
+   works for you. Angels sing, and a light suddenly fills the room.
+ - "goddamn idiotic truckload of sh*t": when it breaks
+
 [INSTALL]: INSTALL
 [Documentation/gittutorial.txt]: Documentation/gittutorial.txt
 [Documentation/giteveryday.txt]: Documentation/giteveryday.txt
-- 
2.7.2.334.g35ed2ae.dirty
