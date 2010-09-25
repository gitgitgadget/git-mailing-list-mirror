From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v4 3/4] rev-parse: update documentation of --flags and --no-flags options
Date: Sat, 25 Sep 2010 23:33:52 +1000
Message-ID: <1285421633-22684-4-git-send-email-jon.seymour@gmail.com>
References: <1285421633-22684-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org, robbat2@gentoo.org, casey@nrlssc.navy.mil,
	avarab@gmail.com
X-From: git-owner@vger.kernel.org Sat Sep 25 15:31:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzUql-0002J2-VK
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 15:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755103Ab0IYNbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 09:31:19 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:39907 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754970Ab0IYNbT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 09:31:19 -0400
Received: by pvg2 with SMTP id 2so896365pvg.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 06:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=zs3cokWOWodiCCB8HigVvakBrLZCzVxHRTNOlpA/vGQ=;
        b=aMdSpOR+8U57by+ZzMVtpZbY3LfqsaXEyEjSIhp3alGx+HH4KmRTWvF7uH/PQT1HOu
         smOdygDTk6oAPZhMEHli+bES5RI34BZIakOnuzoBxQw3GTI9OGwr6cYAMVkNzuptEv6P
         u/rUe8zk3EGJzWeh7bmqZnY+7/gdsECrVzaE4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mRsRQ69tKBvIXaNfC/T1nM+pZW3NUEGHakDXkLQrmN+ZdxmIunw/MkyQhM7AXkh2i+
         ZzzCLW4oYQElE6Fq39b+AsjSmo8HQG0JR3adwg2pm9ZC55vZar7msHKkeimQjra7ujEc
         kK3MHUIhL9hwDmzV3ty8Amki4l/xJ2p3HDI48=
Received: by 10.143.17.12 with SMTP id u12mr4042889wfi.55.1285421478567;
        Sat, 25 Sep 2010 06:31:18 -0700 (PDT)
Received: from localhost.localdomain ([120.16.118.189])
        by mx.google.com with ESMTPS id l42sm3924235wfa.9.2010.09.25.06.31.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 06:31:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4.ge900b
In-Reply-To: <1285421633-22684-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157153>

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 Documentation/git-rev-parse.txt |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 341ca90..f5e6637 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -49,10 +49,20 @@ OPTIONS
 	'git rev-list' command.
 
 --flags::
-	Do not output non-flag parameters.
+	Do not output non-flag parameters which are not also revisions.
+	+
+	If specified, this option causes 'git rev-parse' to stop
+	interpreting remaining arguments as options for its own
+	consumption. As such, this option should be specified
+	after all other options that 'git rev-parse' is expected
+	to interpret.
 
 --no-flags::
 	Do not output flag parameters.
+	+
+	If both `--flags` and `--no-flags` are specified, the first
+	option specified wins and the other option is treated like
+	a non-option argument.
 
 --default <arg>::
 	If there is no parameter given by the user, use `<arg>`
-- 
1.7.3.3.gc4c52.dirty
