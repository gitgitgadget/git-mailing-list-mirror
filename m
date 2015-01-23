From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT 3/5] doc: don't use guilt-foo invocations in examples.
Date: Fri, 23 Jan 2015 14:24:57 +0100
Message-ID: <1422019499-2012-4-git-send-email-cederp@opera.com>
References: <1422019499-2012-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri Jan 23 14:26:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEeFx-0004TD-2O
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 14:26:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755328AbbAWN0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 08:26:30 -0500
Received: from mail-wi0-f179.google.com ([209.85.212.179]:45489 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754436AbbAWN00 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 08:26:26 -0500
Received: by mail-wi0-f179.google.com with SMTP id l15so2790289wiw.0
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 05:26:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f8GhZXuINz8DIwkk8FKrnFK3Ho0Yn9UtmGiwNqqjR4w=;
        b=G1Iz34RtAgp3+p+4hJpebJYeTnRPELj/bsoPmTym+Xo282/SjpXlzsriEb2qXvzHl2
         nofgLBDLPy1ebYkUIed9HCf0nVbNBglqli7iltjphmoM6DLgViYsmTbVvUWH4sUM+32u
         8nQthz67iiLfSINFgyKdF2ZUDs20v6PgFC5Am6wgWIahDvcojosjHCdu4w5Pkpo9rlyp
         thLw3rCQWg2vg5AVEWxH3Z+lTikllKvBjl/XL9nb75Fb16CkEmQ2cdBPNxA4ACm0kplP
         V1b5hO+6I3z+7QQN9/kp8c2WtKDS3lVewGV3wQdpgXw1D/bBeqseNqKIyodsb8q7KsTj
         AFUA==
X-Gm-Message-State: ALoCoQl5X8N9gw49DwSRGcGCEUqks/TUuYuQSvkuQfI4fseTxMt+JMl0xRWTZDN03YRnUqoGwFz1
X-Received: by 10.180.95.97 with SMTP id dj1mr3681512wib.43.1422019585432;
        Fri, 23 Jan 2015 05:26:25 -0800 (PST)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id fi10sm1841950wib.13.2015.01.23.05.26.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Jan 2015 05:26:24 -0800 (PST)
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1422019499-2012-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262924>

Note: there is one place where I replace guilt-repair with "guilt
repair" instead of "+guilt repair+".  At least the version of docbook
I'm using mishandles the "+" signs in that particular spot (even
though it works properly for "+guilt select+" in another file.  I know
too little docbook to be able to find the cause.

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 Documentation/guilt-add.txt    | 2 +-
 Documentation/guilt-delete.txt | 2 +-
 Documentation/guilt-diff.txt   | 2 +-
 Documentation/guilt-help.txt   | 4 ++--
 Documentation/guilt-new.txt    | 6 +++---
 Documentation/guilt-repair.txt | 2 +-
 Documentation/guilt-select.txt | 4 ++--
 7 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/guilt-add.txt b/Documentation/guilt-add.txt
index 6d2785a..a276f09 100644
--- a/Documentation/guilt-add.txt
+++ b/Documentation/guilt-add.txt
@@ -24,7 +24,7 @@ EXAMPLES
 Create and add a new file example.c
 
 	$ touch example.c
-	$ guilt-add example.c
+	$ guilt add example.c
 
 Author
 ------
diff --git a/Documentation/guilt-delete.txt b/Documentation/guilt-delete.txt
index ef57dc6..4e8c28c 100644
--- a/Documentation/guilt-delete.txt
+++ b/Documentation/guilt-delete.txt
@@ -25,7 +25,7 @@ EXAMPLES
 --------
 Delete a patch called 'foobar':
 
-	$ guilt-delete foobar
+	$ guilt delete foobar
 
 Author
 ------
diff --git a/Documentation/guilt-diff.txt b/Documentation/guilt-diff.txt
index 986ceca..0ee062c 100644
--- a/Documentation/guilt-diff.txt
+++ b/Documentation/guilt-diff.txt
@@ -18,7 +18,7 @@ OPTIONS
 -------
 -z::
 	Output a interdiff against the top-most applied patch. This should
-	produce the same diff as "+guilt-new -f foo+".
+	produce the same diff as "+guilt new -f foo+".
 
 <path>...::
 	Restrict diff output to a given set of files.
diff --git a/Documentation/guilt-help.txt b/Documentation/guilt-help.txt
index ed6a5cf..df0e0fb 100644
--- a/Documentation/guilt-help.txt
+++ b/Documentation/guilt-help.txt
@@ -18,11 +18,11 @@ EXAMPLES
 
 Open the guilt-status man page 
 
-	$ guilt-help status
+	$ guilt help status
 
 Open the guilt man page 
 
-	$ guilt-help
+	$ guilt help
 
 Author
 ------
diff --git a/Documentation/guilt-new.txt b/Documentation/guilt-new.txt
index a2c8a4c..698dcb7 100644
--- a/Documentation/guilt-new.txt
+++ b/Documentation/guilt-new.txt
@@ -42,16 +42,16 @@ EXAMPLES
 
 Create a new patch called 'foobar':
 
-	$ guilt-new foobar
+	$ guilt new foobar
 
 Create a patch called 'foo' and supply a patch description interactively:
 
-	$ guilt-new -e foo
+	$ guilt new -e foo
 
 Create a patch called 'bar' with a provided patch description and sign off
 on the patch:
 
-	$ guilt-new -s -m patch-fu bar
+	$ guilt new -s -m patch-fu bar
 
 Author
 ------
diff --git a/Documentation/guilt-repair.txt b/Documentation/guilt-repair.txt
index 4aa472b..4faf113 100644
--- a/Documentation/guilt-repair.txt
+++ b/Documentation/guilt-repair.txt
@@ -22,7 +22,7 @@ Perform various repository repairs. You must specify one mode of repair:
 	WARNING: Running this command may result in commits and working
 	directory changes being lost. You may want to create a new reference
 	(e.g., branch, or reflog) to the original HEAD before using
-	guilt-repair.
+	"guilt repair".
 
 --status::
 	Upgrade the status file from old format to new.
diff --git a/Documentation/guilt-select.txt b/Documentation/guilt-select.txt
index f7fb5f7..dd5833e 100644
--- a/Documentation/guilt-select.txt
+++ b/Documentation/guilt-select.txt
@@ -19,10 +19,10 @@ the following way:
 * An unguarded patch is always applied.
 
 * A patch with a positive guard is applied *only* if the guard is
-selected with guilt-select.
+selected with "+guilt select+".
 
 * A patch with a negative guard is applied *unless* the guard is
-selected with guilt-select.
+selected with "+guilt select+".
 
 OPTIONS
 -------
-- 
2.1.0
