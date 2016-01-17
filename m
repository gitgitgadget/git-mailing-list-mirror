From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 1/4] ls-remote: document --quiet option
Date: Sun, 17 Jan 2016 12:03:59 +0100
Message-ID: <1453028643-13978-2-git-send-email-t.gummerer@gmail.com>
References: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
Cc: bturner@atlassian.com, gitster@pobox.com, pedrorijo91@gmail.com,
	git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>
To: peff@peff.net
X-From: git-owner@vger.kernel.org Sun Jan 17 12:03:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKl7j-00054T-5L
	for gcvg-git-2@plane.gmane.org; Sun, 17 Jan 2016 12:03:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbcAQLDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2016 06:03:49 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35970 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbcAQLDs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2016 06:03:48 -0500
Received: by mail-wm0-f67.google.com with SMTP id l65so11107404wmf.3
        for <git@vger.kernel.org>; Sun, 17 Jan 2016 03:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zhJ3EAhXIS0vBXcvB8eVLcJVb1+A5b6iRRVdbeeIDZk=;
        b=b6QxsDx5AnW19h+ZOKFQktS8vC457iWDTF/7ARxq0/CUWjwhihIbNBIYMjT80eQ19B
         F6XgsGzKa4lUsQC7/ms+uQRAVMmuqBjSu+rk0M4vNic3wBMWyl1314pyb+Z1ILQfTTvs
         niZFrRXJD/X8LaDPhp0WyIjJ/ISeTYM2y0DPzZY3jQ1O1IMv17m90j0uY29QIN785H0+
         zND8shDYlQ1ptbFNO0+NEF/3rnkxNiMU75mI7/9hi8zjJ9J2OSJWIMk+Dl62xCYxQiLx
         D+pxnUMDR3nNMNGTjsI7DdF9bez1KDDndXDUISjiNfZuzjyLWFaFZIzAXiTG0btKdM2j
         vjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zhJ3EAhXIS0vBXcvB8eVLcJVb1+A5b6iRRVdbeeIDZk=;
        b=FzzC4bmJZ2peJq8Y+T/w/adAMu1UpBlwCCEPSwOMhKGhqWs2LrdLGgi14sQNpofdd3
         Xvf2kHtKPcSkWZ2ioIV3+3PYQ6/BgOh3uFtihdnKigy4o5GJTTSZwvo4q5sCOQGviczx
         aKviz7BnHQh1/USQGmeQqMvmL3wLqXoYpxwh/GXXTuC4aGgEPg38bGKgwTY9P0MTZ6vq
         jkoeTMtRpExxGuYpk8LVIAcHZqn1v056U0/dRJ1PFs2b8Bm5QyvGyS7RlXccYG56Vx/v
         8whf8T1f3xMnOUilV5SFwIrZEAfZ5ZMPHIzwhshDH3zfUPFYr+eQ5UDLewME1cUAgfOX
         bXDw==
X-Gm-Message-State: ALoCoQn9idHbbhprpqN2HCtiwGW85JIv35jlj6ADbIsd+cfXsIQczqYsUMvc28yMlnqD9g5gaOOH0FtUu/wKDaQP+q4zwqeIOw==
X-Received: by 10.194.19.100 with SMTP id d4mr19012048wje.18.1453028626854;
        Sun, 17 Jan 2016 03:03:46 -0800 (PST)
Received: from localhost ([95.233.44.41])
        by smtp.gmail.com with ESMTPSA id w1sm10698426wmd.2.2016.01.17.03.03.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2016 03:03:45 -0800 (PST)
X-Mailer: git-send-email 2.7.0.14.g2b6d3d6
In-Reply-To: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284251>

cefb2a5e3 ("ls-remote: print URL when no repo is specified") added a
quiet option to ls-remote, but didn't add it to the documentation.  Add
it.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-ls-remote.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index d510c05..27380de 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git ls-remote' [--heads] [--tags]  [--upload-pack=<exec>]
-	      [--exit-code] <repository> [<refs>...]
+	      [-q | --quiet] [--exit-code] <repository> [<refs>...]
 
 DESCRIPTION
 -----------
@@ -29,6 +29,10 @@ OPTIONS
 	both, references stored in refs/heads and refs/tags are
 	displayed.
 
+-q::
+--quiet::
+	Do not print remote URL to stderr.
+
 --upload-pack=<exec>::
 	Specify the full path of 'git-upload-pack' on the remote
 	host. This allows listing references from repositories accessed via
-- 
2.7.0.14.g2b6d3d6
