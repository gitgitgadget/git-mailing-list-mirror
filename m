From: "Michael G. Schwern" <schwern@pobox.com>
Subject: [PATCH 8/8] Fix indents to match style.
Date: Thu, 26 Jul 2012 17:26:07 -0700
Message-ID: <1343348767-86446-9-git-send-email-schwern@pobox.com>
References: <1343348767-86446-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, jrnieder@gmail.com, schwern@pobox.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 27 02:27:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuYOb-0004ZF-3u
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 02:27:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853Ab2G0A0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 20:26:49 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41590 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752814Ab2G0A0s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 20:26:48 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so4044857pbb.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 17:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=QxTbH39cT6PXBUt/k3ipNWilIVAVZplPnrV6kaD8e78=;
        b=ddiu90mQeifpXpVIv8WmbIvUBFtMupHhswbwpfZELctDnXf4HgaMGxjgYG1Nuz/hdz
         nRotEvMC9DvZsRxy3RSN7mgcXT1Cgdw6MZx8zEodlVhVi97x8I8sfjqimGQjzX3PjC6M
         eyBUdrYpuuNMYPE2dsoWENasVQZOLMndYwdl+pe/FYI/xnkoyDAjFNFp8EUXhBN0bGpr
         sADLY+wfX9vuNU6Kvop7u6VL9SZJfH69gFgRHSruytsW+6wN3t2rRTlEZAPimvXo8kvo
         nY7eYs2r3Ue5ws4BFy/kOhyWB/M5Vm9sXiRrnrWqvuICzq5R4h+CetrXqcpa8AnQIF9b
         MFJw==
Received: by 10.68.234.6 with SMTP id ua6mr9043943pbc.117.1343348807976;
        Thu, 26 Jul 2012 17:26:47 -0700 (PDT)
Received: from localhost.localdomain (c-76-105-239-160.hsd1.or.comcast.net. [76.105.239.160])
        by mx.google.com with ESMTPS id jz4sm692556pbc.17.2012.07.26.17.26.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 17:26:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1
In-Reply-To: <1343348767-86446-1-git-send-email-schwern@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202326>

From: "Michael G. Schwern" <schwern@pobox.com>

---
 git-svn.perl | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 584e93a..4d173d4 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -31,14 +31,14 @@ use Git::SVN::Migration;
 
 use Git::SVN::Utils qw(fatal can_compress);
 use Git qw(
-    git_cmd_try
-    command
-    command_oneline
-    command_noisy
-    command_output_pipe
-    command_close_pipe
-    command_bidi_pipe
-    command_close_bidi_pipe
+	git_cmd_try
+	command
+	command_oneline
+	command_noisy
+	command_output_pipe
+	command_close_pipe
+	command_bidi_pipe
+	command_close_bidi_pipe
 );
 
 BEGIN {
-- 
1.7.11.1
