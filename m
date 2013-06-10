From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: [PATCH 3/6] templates: Fix spelling in pre-commit hook
Date: Mon, 10 Jun 2013 20:36:02 +0200
Message-ID: <1370889365-6239-4-git-send-email-richih.mailinglist@gmail.com>
References: <1370889365-6239-1-git-send-email-richih.mailinglist@gmail.com>
Cc: Richard Hartmann <richih.mailinglist@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 10 20:36:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um6x8-00059Y-TR
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 20:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173Ab3FJSgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 14:36:19 -0400
Received: from mail-ee0-f49.google.com ([74.125.83.49]:44692 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754098Ab3FJSgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 14:36:16 -0400
Received: by mail-ee0-f49.google.com with SMTP id b57so3187736eek.22
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 11:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=v41HMtrjrygm4FibI2n7Nhdu9kAUH3DVYrack4d0rmY=;
        b=LbXmBroft/+t6NBKfmo3G1GqEkBf0/ZAIUXCX45n4UpZu1plnGBqQ/LOTSN5AmhyWk
         Hkug0N33GEvPo5jSdmbiRxaSiPohl4oevPefvxDUZYasZ/9kFkt6FJe4/aKwR6FZ+9bd
         Z+EDnzVMGEqjG5rAVmzIC9XcX7KAgoyGxz4I73WOss+LfiY/DxXCcySgJksvMDZcefFp
         gnIFhfnlMdPv2Q8XCgeKltQDiU0iRA4kwCHcWKjT/1A8X5fbLW/ZSscKTP+CffnnLjc+
         OVUoj8QU158mBboLb4zBzFtH7+ezWEhVcWjHiK24DxE/YP49UoRUIKJNPdZJUvhZgbBH
         e9ug==
X-Received: by 10.14.172.194 with SMTP id t42mr2866753eel.78.1370889375749;
        Mon, 10 Jun 2013 11:36:15 -0700 (PDT)
Received: from rockhopper.fritz.box (p54998111.dip0.t-ipconnect.de. [84.153.129.17])
        by mx.google.com with ESMTPSA id ba7sm24960845eeb.0.2013.06.10.11.36.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 10 Jun 2013 11:36:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1370889365-6239-1-git-send-email-richih.mailinglist@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227349>

Signed-off-by: Richard Hartmann <richih.mailinglist@gmail.com>
---
 templates/hooks--pre-commit.sample |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
index 7676c6e..a982d99 100755
--- a/templates/hooks--pre-commit.sample
+++ b/templates/hooks--pre-commit.sample
@@ -15,13 +15,13 @@ else
 	against=4b825dc642cb6eb9a060e54bf8d69288fbee4904
 fi
 
-# If you want to allow non-ascii filenames set this variable to true.
+# If you want to allow non-ASCII filenames set this variable to true.
 allownonascii=$(git config hooks.allownonascii)
 
 # Redirect output to stderr.
 exec 1>&2
 
-# Cross platform projects tend to avoid non-ascii filenames; prevent
+# Cross platform projects tend to avoid non-ASCII filenames; prevent
 # them from being added to the repository. We exploit the fact that the
 # printable range starts at the space character and ends with tilde.
 if [ "$allownonascii" != "true" ] &&
@@ -31,7 +31,7 @@ if [ "$allownonascii" != "true" ] &&
 	test $(git diff --cached --name-only --diff-filter=A -z $against |
 	  LC_ALL=C tr -d '[ -~]\0' | wc -c) != 0
 then
-	echo 'Error: Attempt to add a non-ascii file name.
+	echo 'Error: Attempt to add a non-ASCII file name.
 
 This can cause problems if you want to work with people on other platforms.
 
-- 
1.7.10.4
