From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH 1/4] grep doc: add --break / --heading / -W to synopsis
Date: Sun, 25 Mar 2012 22:41:42 -0400
Message-ID: <1332729705-9283-2-git-send-email-lodatom@gmail.com>
References: <1332729705-9283-1-git-send-email-lodatom@gmail.com>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 26 04:42:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBztG-0000YB-IV
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 04:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756477Ab2CZCmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Mar 2012 22:42:35 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:34124 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756020Ab2CZCl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2012 22:41:58 -0400
Received: by mail-qa0-f53.google.com with SMTP id c11so1895985qad.19
        for <git@vger.kernel.org>; Sun, 25 Mar 2012 19:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=RJ1jgxjbLMedEFeTTxZIMCYcHg6cR6boprh6F9zyOpo=;
        b=X85KbYLLBOc9im0RmfkYi36Kuh0sfq4YgkOOm0Tv2WtkOW5AKcCvCaiqyhPE6zVX4s
         2hnz41qeYNlLyty5PFtHtpN06gCrFbJMbgWz8epdP+F94G5u7KNTYDZyzYoRKcWPXM0g
         7q4drhU6kyrRim+Bkh4cGdajeOdrNFf/mMQaraSlPjymRwAYmguihJlWbXkP7RmYrPs2
         TdAolScab6QohrQ1TbHrKUV4t4pT9PvrlhpjOVd1JAFPvdlYCEdfxvd6oS9Z/1Y4cPAN
         /4bP87sLJF2j356ZM5M7AwZNMIUkfGdu3X3Ww89e3IFJG6y9dQPY+p9L9uUjcu/OSiil
         gzcA==
Received: by 10.229.78.227 with SMTP id m35mr7800090qck.0.1332729718645;
        Sun, 25 Mar 2012 19:41:58 -0700 (PDT)
Received: from mark.hsd1.dc.comcast.net. (c-76-21-213-235.hsd1.dc.comcast.net. [76.21.213.235])
        by mx.google.com with ESMTPS id fq1sm27711867qab.10.2012.03.25.19.41.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 25 Mar 2012 19:41:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.4
In-Reply-To: <1332729705-9283-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193892>

All of the other options were included in the synopsis, so it makes
sense to include these as well.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
 Documentation/git-grep.txt |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 6a8b1e3..343eadd 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -20,7 +20,9 @@ SYNOPSIS
 	   [-c | --count] [--all-match] [-q | --quiet]
 	   [--max-depth <depth>]
 	   [--color[=<when>] | --no-color]
+	   [--break] [--heading] [-p | --show-function]
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
+	   [-W | --function-context]
 	   [-f <file>] [-e] <pattern>
 	   [--and|--or|--not|(|)|-e <pattern>...]
 	   [ [--exclude-standard] [--cached | --no-index | --untracked] | <tree>...]
-- 
1.7.9.2
