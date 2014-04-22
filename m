From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: [PATCH 1/3] test-lib: Document short options in t/README
Date: Tue, 22 Apr 2014 01:19:25 -0700
Message-ID: <1398154767-1276-2-git-send-email-ilya.bobyr@gmail.com>
References: <1398154767-1276-1-git-send-email-ilya.bobyr@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Ilya Bobyr <ilya.bobyr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 10:20:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcVwH-00024U-Kw
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 10:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754997AbaDVIUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 04:20:20 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:34392 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754902AbaDVIUH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 04:20:07 -0400
Received: by mail-pb0-f47.google.com with SMTP id up15so4687330pbc.34
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 01:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=86UztVn8ooIQBBnKJnpoWdlJBvDGmqIJok2gAY3R8kM=;
        b=BO7WdpX1SVgQWlx8jAIyUPOVe27FL1MGdeZcbxg4TsrUwnldclV0swhttqW8XxwCsH
         mPXsH6g/2ozDTWnvUI7uQpMYMS2zR5hwhjxI60NeNPvkehe7kA02vHIdQJakpc4VExNb
         m2zEVYbCYd/RvHuhfXk7+Foe0GFNDBRQh+6fB2boQY3ki0IWTyhVRRqDle7DBZiHSf5u
         JWer0nxxHua5dljBbI1LQL3NOlo7i6lYHgZZxxegnsObg+mpWk6mS1+wuTLCnyjBnDkq
         7O3hTHXMuxsky6vor8lX1WGODqrlj3zOWxZ5Kv+QSmo6k52rWlPSDLtvqKx0sKs6wdS2
         eg3Q==
X-Received: by 10.69.0.198 with SMTP id ba6mr43286056pbd.16.1398154807346;
        Tue, 22 Apr 2014 01:20:07 -0700 (PDT)
Received: from localhost.localdomain (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id om6sm83107950pbc.43.2014.04.22.01.20.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Apr 2014 01:20:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1398154767-1276-1-git-send-email-ilya.bobyr@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246715>

Most arguments that could be provided to a test have short forms.
Unless documented, the only way to learn them is to read the code.

Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>
---
 t/README |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/README b/t/README
index caeeb9d..6b93aca 100644
--- a/t/README
+++ b/t/README
@@ -71,7 +71,7 @@ You can pass --verbose (or -v), --debug (or -d), and --immediate
 (or -i) command line argument to the test, or by setting GIT_TEST_OPTS
 appropriately before running "make".
 
---verbose::
+-v,--verbose::
 	This makes the test more verbose.  Specifically, the
 	command being run and their output if any are also
 	output.
@@ -81,7 +81,7 @@ appropriately before running "make".
 	numbers matching <pattern>.  The number matched against is
 	simply the running count of the test within the file.
 
---debug::
+-d,--debug::
 	This may help the person who is developing a new test.
 	It causes the command defined with test_debug to run.
 	The "trash" directory (used to store all temporary data
@@ -89,14 +89,14 @@ appropriately before running "make".
 	failed tests so that you can inspect its contents after
 	the test finished.
 
---immediate::
+-i,--immediate::
 	This causes the test to immediately exit upon the first
 	failed test. Cleanup commands requested with
 	test_when_finished are not executed if the test failed,
 	in order to keep the state for inspection by the tester
 	to diagnose the bug.
 
---long-tests::
+-l,--long-tests::
 	This causes additional long-running tests to be run (where
 	available), for more exhaustive testing.
 
-- 
1.7.9
