From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] Documentation/git-add.txt: add `add.ginore-errors` configuration variable
Date: Mon, 26 Jan 2015 22:55:25 +0600
Message-ID: <1422291325-4332-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 17:55:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFmwu-0000KJ-AI
	for gcvg-git-2@plane.gmane.org; Mon, 26 Jan 2015 17:55:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756117AbbAZQzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2015 11:55:37 -0500
Received: from mail-la0-f51.google.com ([209.85.215.51]:55848 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753317AbbAZQzf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2015 11:55:35 -0500
Received: by mail-la0-f51.google.com with SMTP id ge10so8737698lab.10
        for <git@vger.kernel.org>; Mon, 26 Jan 2015 08:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Gc7iTng4BP3b6I9es1efVifYUvvWsfksJRg+cHR/ikc=;
        b=LLnSMi/i705UlB7dneVlFAnwEFE0sWGNvMZeeJKR00MJFgr5RBJiOUZiKDL9JBMbOv
         eApmOblq4HU7QK0aMkdeNlo+9gmrOMDsTUChFYJFRBGqEElmBpptFC5zPAEX4eGZCEDH
         rYXzJcbCvfisNgtLOMWFdNPzeugwyjNzegAcEj6gLQqO8X3eJSOPdwwUZfNrES1FsLcj
         +Sh/ANY/HaKIWbpEryMg1UfBuRq5nBJ7SwYsv6XUT8R0NZpHjHxK7Yfn7Aj1Rki74NBJ
         UcFbkeudKq5rwoM8VYnX3N0coNMgqXvQ8UWeM1YKA3EkJm2yNSJ6umr+Ooid+rdz7L3v
         b++w==
X-Received: by 10.152.4.233 with SMTP id n9mr22403980lan.61.1422291333908;
        Mon, 26 Jan 2015 08:55:33 -0800 (PST)
Received: from localhost.localdomain ([178.89.29.232])
        by mx.google.com with ESMTPSA id r7sm1170261lbs.37.2015.01.26.08.55.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Jan 2015 08:55:33 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc1.275.g028c360
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263036>

'git add' supports not only `add.ignoreErrors`, but also `add.ignore-errors`
configuration variable.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 Documentation/git-add.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 1c74907..f68c2a2 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -155,8 +155,8 @@ for "git add --no-all <pathspec>...", i.e. ignored removed files.
 	If some files could not be added because of errors indexing
 	them, do not abort the operation, but continue adding the
 	others. The command shall still exit with non-zero status.
-	The configuration variable `add.ignoreErrors` can be set to
-	true to make this the default behaviour.
+	The configuration variable `add.ignoreErrors` or `add.ignore-errors`
+	can be set to true to make this the default behaviour.
 
 --ignore-missing::
 	This option can only be used together with --dry-run. By using
-- 
2.3.0.rc1.275.g028c360
