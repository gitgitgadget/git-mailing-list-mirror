From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 6/7] git-log.txt: rewrite note on why "--" may be required
Date: Sun, 21 Apr 2013 14:20:51 +0530
Message-ID: <1366534252-12099-7-git-send-email-artagnon@gmail.com>
References: <1366534252-12099-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 21 10:51:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTpzb-0008Nr-6N
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 10:51:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712Ab3DUIvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 04:51:16 -0400
Received: from mail-da0-f41.google.com ([209.85.210.41]:53545 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752195Ab3DUIvM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 04:51:12 -0400
Received: by mail-da0-f41.google.com with SMTP id p8so2473201dan.28
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 01:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=E8w6HEBhZQLxm5G7dCyqEDLm2ubZ1ZXLciPdI3P39bw=;
        b=TH0FkgVLpmHrcsNW3jpJF63MbFPUTtXYoXHKB+2oJknLjY7aMxggtIExK9Gh+FTBr4
         q20Kxzuc8BsLl40+ZZu319rY60UJv3QtlCqrGx4UfTzzoY0hN/VhySx3ORvUK0xLv68x
         NjHl8WqHeSZTie0ga0vQEfc922DsBWHkGjGh5k63lrHBmb0WpL1EQJP4SP2t3uAtRcVF
         qEqjtlA5V/A4nF465NOgfIxs/VKvYAkGoeXT4NNU+K0lSaI0rfXybSn6YcBIyzIpPbDx
         Ni0UL2ll7RQj9O/0XqX9BvVtD8B7j7atXlIokBeeB5auvbeb5LPXlCRzVedMbwE0zWE3
         NEFw==
X-Received: by 10.66.121.36 with SMTP id lh4mr6509817pab.208.1366534271935;
        Sun, 21 Apr 2013 01:51:11 -0700 (PDT)
Received: from localhost.localdomain ([122.174.41.136])
        by mx.google.com with ESMTPS id mm9sm20241909pbc.43.2013.04.21.01.51.09
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 01:51:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.501.gd2949c7
In-Reply-To: <1366534252-12099-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221933>

In its current form, the note talks about separating options from
"branch names" and "refnames" in the same sentence.  This is entirely
inaccurate, as <revision range> need not be a set of branch names or
ref names.  Rewrite it to use the word "revision range", to be
consistent with the SYNOPSIS.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-log.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index c238475..7ae21ff 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -77,8 +77,8 @@ produced by --stat etc.
 	Simplification" below for details and other simplification
 	modes.
 +
-To prevent confusion with options and branch names, paths may need to
-be prefixed with "\-- " to separate them from options or refnames.
+Paths may need to be prefixed with "\-- " to separate them from
+options or the revision range, when confusion arises.
 
 include::rev-list-options.txt[]
 
-- 
1.8.2.1.501.gd2949c7
