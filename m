From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: [PATCH 1/3] test-lib: Document short options in t/README
Date: Wed, 30 Apr 2014 02:50:42 -0700
Message-ID: <1398851444-2492-2-git-send-email-ilya.bobyr@gmail.com>
References: <1398154767-1276-1-git-send-email-ilya.bobyr@gmail.com>
 <1398851444-2492-1-git-send-email-ilya.bobyr@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Ilya Bobyr <ilya.bobyr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 11:51:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfRAc-000361-3z
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 11:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754864AbaD3JvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 05:51:14 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:59569 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140AbaD3JvK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 05:51:10 -0400
Received: by mail-pd0-f182.google.com with SMTP id v10so1462233pde.41
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 02:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OmN3GWpZU0icygIYLXoueXyDWof91RwJDenQKzyHLwE=;
        b=zONQlJZQoitZtnr4Wanv6jI23n8qIuD92dc7sA2yV4tVYo25HJhaa7VyqBeFZ5y19v
         lVcXR8rO/QToXl8Gx8Ce+4a669fMZsGHBKn9Gi+qTLL6au64V/jJgr2yI3383KXccZkf
         jl9GedMELezlpKoFH5nUUavXApskOdyjo5uJpfTSN8IWpaUsMXrZIlk7SCYUUbtlaYCo
         qZ9KfDyPvpJY4ZwQA6ur4GP4yPkfdV3xclNePwTYw87A00koD+7uleeYwC3/MaJAXwNV
         ofnaGyPzCp2UHUmtafzNQcyYQYJ9T3cVtHazso6yGzZsYxMD2v//EFpwZrv/J3oLRPGv
         bgKw==
X-Received: by 10.66.240.130 with SMTP id wa2mr6663420pac.73.1398851467325;
        Wed, 30 Apr 2014 02:51:07 -0700 (PDT)
Received: from localhost.localdomain (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id ss2sm131761603pab.8.2014.04.30.02.51.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Apr 2014 02:51:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1398851444-2492-1-git-send-email-ilya.bobyr@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247693>

Most arguments that could be provided to a test have short forms.
Unless documented, the only way to learn them is to read the code.

Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>
---

Changed to use AsciiDoc format.

 t/README |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/t/README b/t/README
index caeeb9d..eaf6ecd 100644
--- a/t/README
+++ b/t/README
@@ -71,6 +71,7 @@ You can pass --verbose (or -v), --debug (or -d), and --immediate
 (or -i) command line argument to the test, or by setting GIT_TEST_OPTS
 appropriately before running "make".
 
+-v::
 --verbose::
 	This makes the test more verbose.  Specifically, the
 	command being run and their output if any are also
@@ -81,6 +82,7 @@ appropriately before running "make".
 	numbers matching <pattern>.  The number matched against is
 	simply the running count of the test within the file.
 
+-d::
 --debug::
 	This may help the person who is developing a new test.
 	It causes the command defined with test_debug to run.
@@ -89,6 +91,7 @@ appropriately before running "make".
 	failed tests so that you can inspect its contents after
 	the test finished.
 
+-i::
 --immediate::
 	This causes the test to immediately exit upon the first
 	failed test. Cleanup commands requested with
@@ -96,6 +99,7 @@ appropriately before running "make".
 	in order to keep the state for inspection by the tester
 	to diagnose the bug.
 
+-l::
 --long-tests::
 	This causes additional long-running tests to be run (where
 	available), for more exhaustive testing.
-- 
1.7.9
