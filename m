From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: [PATCH 1/3] test-lib: Document short options in t/README
Date: Mon, 24 Mar 2014 01:49:45 -0700
Message-ID: <1395650987-5960-2-git-send-email-ilya.bobyr@gmail.com>
References: <1395650987-5960-1-git-send-email-ilya.bobyr@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ilya Bobyr <ilya.bobyr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 24 09:50:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS0ao-0004N6-Oq
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 09:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122AbaCXIun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 04:50:43 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:50476 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753116AbaCXIui (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 04:50:38 -0400
Received: by mail-pb0-f43.google.com with SMTP id um1so5148507pbc.16
        for <git@vger.kernel.org>; Mon, 24 Mar 2014 01:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oFCPxN/Hx2lZT+rT4vMsyy8KAqq8ikfCkTME73GRUho=;
        b=m+UBfUh1gfV09ngeN1ju4HW01X4XPrrHwyiaEZdBiAbCteSAo01/soAOopBM5KiZ11
         WwFvpgj30+xZLqpbf67qnaPX10Ka+3nkpmAHxGxUDm2kTGAD0ojyv/j5X9fwuyOXadpV
         93m7ec0Wa30hsuRu0IqNBva+01i7I0vjZMxTgjpTpNeI5UsJ4/OEDoIdD7pRQ9Mok/F0
         NgpnujQdKXzCbCyeb6vxszk0Nj1MUlrZPQAI4WPpnyI0auyTVZ+NBnWb2/x9WpXep09s
         jQr/yHJoZ+FtSzzHIe5It0VdOT2bbgsVhMtagpv6opSt6DtHCnDnVM+H9UmrJLpFgWP0
         d9oQ==
X-Received: by 10.68.138.227 with SMTP id qt3mr15688907pbb.6.1395651038387;
        Mon, 24 Mar 2014 01:50:38 -0700 (PDT)
Received: from localhost.localdomain (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id vx10sm56423680pac.17.2014.03.24.01.50.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Mar 2014 01:50:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1395650987-5960-1-git-send-email-ilya.bobyr@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244813>

Most arguments that could be provided to a test have short forms.
Unless documented the only way to learn then is to read the code.

Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>
---
 t/README |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/README b/t/README
index caeeb9d..ccb5989 100644
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
@@ -89,18 +89,18 @@ appropriately before running "make".
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
 
---valgrind=<tool>::
+-v,--valgrind=<tool>::
 	Execute all Git binaries under valgrind tool <tool> and exit
 	with status 126 on errors (just like regular tests, this will
 	only stop the test script when running under -i).
-- 
1.7.9
