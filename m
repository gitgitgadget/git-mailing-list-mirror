From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v3 3/3] rev-parse: update documentation of --flags and --no-flags options
Date: Sat, 25 Sep 2010 21:22:43 +1000
Message-ID: <1285413763-25082-4-git-send-email-jon.seymour@gmail.com>
References: <1285413763-25082-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org, robbat2@gentoo.org, casey@nrlssc.navy.mil,
	avarab@gmail.com
X-From: git-owner@vger.kernel.org Sat Sep 25 13:20:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzSni-0002GO-My
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 13:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756554Ab0IYLUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 07:20:09 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53866 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756531Ab0IYLUI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 07:20:08 -0400
Received: by pwj6 with SMTP id 6so829886pwj.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 04:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Xd28nbVlpb5k7nT2x1LYvGKgbPpRtno8Moi2raltIOc=;
        b=m2cFE1lMyhDzeL39RkvGnCttL4NgSdyLKLM6gTyqwiumSynoH5SmXM0mK8ahYL1/2o
         5g0wynuClpXyUmrV95B5tJG5sI1TQSONzUeSYYW/dwX1wg2QWvlwFd2fQ4hDC6vsxXgF
         qgG1fKZQtBY8GEp7sfyfwWB6Mu53LhXmKWFEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=j51k174bfiTm8BTvJ3KEJlTXsrLUmFq3jRXAUa5H1vY9Ow+sOtnN+E963Xlklpc3i/
         525dylsp1lGL+DKY8BSLbyU+bUFdnx0Ws10lCHWnAd1GFILVsthTY6WLVRBjDJjr8e1N
         Op13jIKIui70QcBIXlhScTe0kWmFOY0Iymvss=
Received: by 10.142.207.15 with SMTP id e15mr3905363wfg.277.1285413608049;
        Sat, 25 Sep 2010 04:20:08 -0700 (PDT)
Received: from localhost.localdomain ([120.16.63.67])
        by mx.google.com with ESMTPS id o16sm3755003wfh.7.2010.09.25.04.20.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 04:20:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.2.g216ca.dirty
In-Reply-To: <1285413763-25082-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157147>

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
1.7.3.2.g216ca.dirty
