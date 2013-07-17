From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 6/6] blame-options.txt: explain that -L <start> and <end> are optional
Date: Wed, 17 Jul 2013 17:25:32 -0400
Message-ID: <1374096332-7891-7-git-send-email-sunshine@sunshineco.com>
References: <1374096332-7891-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 17 23:26:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzZF2-00041q-SA
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 23:26:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757427Ab3GQV0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 17:26:17 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36890 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757424Ab3GQV0P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 17:26:15 -0400
Received: by mail-ob0-f174.google.com with SMTP id wd20so2870817obb.5
        for <git@vger.kernel.org>; Wed, 17 Jul 2013 14:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=ZFX3e2pAH01finMlMw9rbiIGJNJ8xKuQ0PZHqhxSxU8=;
        b=veIbC0sCBQWu2Z/MmVuN5xbo2yeUk+ePv8IPx74CVF/rSOyE3Lo3tNHRFJiziIdX8q
         +OYkn1ZSwo89XIBQHdtaj5zGV9vWUDWp9yq89sS5pskC68ZkxexQ8DvyfdX4BVvPYTd2
         lxAQL6sYSnTmEjDmkxVElEu3lRKXnHf/ZvW/bmSfna+T15MNWbBX1BKCZx9+kanUz8Av
         TU1PEl/vQv88V8c6a1v0tO1kg4UVtHWwdbjA1W9kw6a2PsbDUTSyKKwDz+OfRxuCiZWf
         WM8i+SUgzsP3mNS+1kFNuWZ+E10PlkE6uQc6sUJ4L2jonZET60xi7VDPvAxGcmiKvMLu
         Wrkg==
X-Received: by 10.182.55.72 with SMTP id q8mr4607639obp.96.1374096375297;
        Wed, 17 Jul 2013 14:26:15 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id ps5sm10308187oeb.8.2013.07.17.14.26.13
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jul 2013 14:26:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.3.1016.g4f0baba
In-Reply-To: <1374096332-7891-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230657>

The ability to omit either end of the -L range is a handy but
undocumented shortcut, and is thus not easily discovered. Fix this
shortcoming.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/blame-options.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 624b353..4e55b15 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -11,8 +11,11 @@
 
 -L <start>,<end>::
 -L :<regex>::
-	Annotate only the given line range.  <start> and <end> can take
-	one of these forms:
+	Annotate only the given line range.  <start> and <end> are optional.
+	``-L <start>'' or ``-L <start>,'' spans from <start> to end of file.
+	``-L ,<end>'' spans from start of file to <end>.
++
+<start> and <end> can take one of these forms:
 
 include::line-range-format.txt[]
 
-- 
1.8.3.3.1016.g4f0baba
