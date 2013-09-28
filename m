From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 33/44] shortlog: add missing declaration
Date: Sat, 28 Sep 2013 17:03:58 -0500
Message-ID: <1380405849-13000-34-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:11:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2jp-0003vk-D4
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755359Ab3I1WLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:11:43 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:49055 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755279Ab3I1WLj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:11:39 -0400
Received: by mail-ob0-f176.google.com with SMTP id uy5so4131468obc.21
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hhA/ev6blxh6e+/ff6vYKdXUfeBLWALwVy6DGmwPB2w=;
        b=OZ0voVQRm72soLn3vSVJLkBG02BoEyY6hbSR2xRx85VxQknEf8ijfvIvXyZo2DPQrk
         ldGm9VIMlK2G8zJhCDn97jo245EtoJ8y+uA5zEIgaB3+guQ7qVZhTEr4gpVLaQnmwOyI
         9EOgMDUB//gNN8AjRWpH20yCuWVc1FSCeUnbt4JQ18Q9srWOcdR8PMi3FFNAs5KHYKUm
         MEtFzKShXfppeckKGJKhxTeixHmeeXvfn3sLU8zqXsZ3OfjK4/lv7smkA2vQ3OwqDxeG
         N89QHQb9b37RvcwLWqwsRjf8bSDDe0IZINbcemOqAhVruGN5JArfqjifAeT1J+sDwC/b
         CbsQ==
X-Received: by 10.60.63.68 with SMTP id e4mr12348952oes.23.1380406299336;
        Sat, 28 Sep 2013 15:11:39 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id it7sm19488481obb.11.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:11:38 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235553>

Otherwise we would have to include commit.h.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 shortlog.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/shortlog.h b/shortlog.h
index de4f86f..54bc07c 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -19,6 +19,8 @@ struct shortlog {
 	struct string_list mailmap;
 };
 
+struct commit;
+
 void shortlog_init(struct shortlog *log);
 
 void shortlog_add_commit(struct shortlog *log, struct commit *commit);
-- 
1.8.4-fc
