From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: [PATCH 1/3] test-lib: Document short options in t/README
Date: Thu, 27 Mar 2014 03:32:48 -0700
Message-ID: <1395916370-1404-2-git-send-email-ilya.bobyr@gmail.com>
References: <1395650987-5960-1-git-send-email-ilya.bobyr@gmail.com>
 <1395916370-1404-1-git-send-email-ilya.bobyr@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Ilya Bobyr <ilya.bobyr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 27 11:33:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WT7dB-00055E-PJ
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 11:33:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754969AbaC0Kdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 06:33:50 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:33125 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754643AbaC0Kdt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 06:33:49 -0400
Received: by mail-pd0-f178.google.com with SMTP id x10so3182868pdj.37
        for <git@vger.kernel.org>; Thu, 27 Mar 2014 03:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c/ZkX+zFINtg5X+Q6rvs0sOhRo4Z34pE58NsA+OV9bA=;
        b=Eq1Ay4NlKjLpS5DaLMmJKwlIogQM6NdZ7KSgmUePsr5dqqziwYOzHPxsU+yQ5+jn2M
         uSGtzTYeCEzH3UYeeXLMTKj8qAQv5iT9gIJ5RxkG+AFrgdMcFHGKfbHPcbR99FOX9qIG
         Saw3Etv6CPWgDV/f3qWovHf5CrPOCcytNl5wIeT1I+DC31Uivgc+/WPxhZ2dKJT8qYIc
         aGm1/44uuFewL7x0/03pW+BhxsDNrsXSAMq1Yt+IqLFm/zEosOaBQVA3CldnX8h7OHMC
         v2wpTLXTkCwpY1IcSJNrWC0AxK2kc8IN/ZryrnIcTMeU5KwBI+yWKhLdB5oDhaxxs9+H
         9AZA==
X-Received: by 10.68.240.36 with SMTP id vx4mr1011279pbc.140.1395916428610;
        Thu, 27 Mar 2014 03:33:48 -0700 (PDT)
Received: from localhost.localdomain (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id hc4sm7104861pbc.29.2014.03.27.03.33.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Mar 2014 03:33:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1395916370-1404-1-git-send-email-ilya.bobyr@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245272>

Most arguments that could be provided to a test have short forms.
Unless documented, the only way to learn them is to read the code.

Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>
---
 Minor changes according to comments in

    http://www.mail-archive.com/git@vger.kernel.org/msg46423.html
    Ramsay Jones

 and

    http://www.mail-archive.com/git@vger.kernel.org/msg46512.html
    Eric Sunshine

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
