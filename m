From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT 5/5] doc: git doesn't use git-foo invocations.
Date: Fri, 23 Jan 2015 14:24:59 +0100
Message-ID: <1422019499-2012-6-git-send-email-cederp@opera.com>
References: <1422019499-2012-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri Jan 23 14:28:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEeHd-0005kE-I7
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 14:28:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755345AbbAWN1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 08:27:21 -0500
Received: from mail-we0-f178.google.com ([74.125.82.178]:54078 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754334AbbAWN1U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 08:27:20 -0500
Received: by mail-we0-f178.google.com with SMTP id k48so7555965wev.9
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 05:27:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E+PUe3c1R10LOLhn6m4+3Ix5ebea1NEYGdAyGDBL7Dg=;
        b=EijbeFSLPZRpzaLYK193LAfK3Oe4XxtcZt5uElR6FOY0nqJv42MoE+IOxASCOF6ALR
         XsKy4G1ejN5UWiEr4VwZaluG1zzJ/Ioerov7PqEg8A+KitdzKoV8fQ/sesiW7lQVB5z2
         KLpx2MIeICMrvh0hnALdCmWoemVcqaLypl6hAXBHrgjKP78BslFm9AFKby9jJoldQdVM
         UCqhdtHbJcL7zeZjfxX8e6AuEQMQIliAxCjek2uMAqfpSPWD6RPNKYG8JF4oTRe0VHKt
         m0WhnJTHerjVuXngBqCMwpnWs+f3rZwVMg+BRZAom0qJcyEwTp63ebLZhgJs/lHS4EUv
         F6Ig==
X-Gm-Message-State: ALoCoQmNDrhlH7mp05PNdghUQ/VToTo5YB2ZRt0Xyj7w3hQHBYDFj7TQGnPoMjfvCqIDepaO6p2n
X-Received: by 10.194.59.234 with SMTP id c10mr14112947wjr.49.1422019639200;
        Fri, 23 Jan 2015 05:27:19 -0800 (PST)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id fi10sm1841950wib.13.2015.01.23.05.27.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Jan 2015 05:27:18 -0800 (PST)
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1422019499-2012-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262926>

Make them into reference to the man pages instead.

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 Documentation/guilt-add.txt     | 2 +-
 Documentation/guilt-refresh.txt | 2 +-
 Documentation/guilt-rm.txt      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/guilt-add.txt b/Documentation/guilt-add.txt
index a276f09..067b6ca 100644
--- a/Documentation/guilt-add.txt
+++ b/Documentation/guilt-add.txt
@@ -11,7 +11,7 @@ include::usage-guilt-add.txt[]
 
 DESCRIPTION
 -----------
-Adds the files specified to git using git-add making it available to guilt.
+Adds the files specified to git using git-add(1) making it available to guilt.
 
 OPTIONS
 -------
diff --git a/Documentation/guilt-refresh.txt b/Documentation/guilt-refresh.txt
index 7757bdc..98076e3 100644
--- a/Documentation/guilt-refresh.txt
+++ b/Documentation/guilt-refresh.txt
@@ -23,7 +23,7 @@ OPTIONS
 Include a diffstat output in the patch file. Useful for cases where
 patches will be submitted with other tools.
 +
-If the command line option is omitted, the corresponding git-config
+If the command line option is omitted, the corresponding git-config(1)
 option "guilt.diffstat" will be queried. So this would enable diffstat
 output by default:
 
diff --git a/Documentation/guilt-rm.txt b/Documentation/guilt-rm.txt
index 71b49fe..cfe471e 100644
--- a/Documentation/guilt-rm.txt
+++ b/Documentation/guilt-rm.txt
@@ -11,7 +11,7 @@ include::usage-guilt-rm.txt[]
 
 DESCRIPTION
 -----------
-Removes the files specified from git using git-rm
+Removes the files specified from git using git-rm(1).
 
 OPTIONS
 -------
-- 
2.1.0
