From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 06/10] shortlog: add missing declaration
Date: Sat, 28 Sep 2013 16:51:42 -0500
Message-ID: <1380405106-29430-7-git-send-email-felipe.contreras@gmail.com>
References: <1380405106-29430-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 28 23:58:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2WU-0002LM-GS
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 23:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755318Ab3I1V5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 17:57:53 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:45588 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755143Ab3I1V5v (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 17:57:51 -0400
Received: by mail-ob0-f174.google.com with SMTP id uz6so4150624obc.33
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 14:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hhA/ev6blxh6e+/ff6vYKdXUfeBLWALwVy6DGmwPB2w=;
        b=HIxx8MnpKeyrLIEBAhKVaSDwxb2b+2NrWVXPbj4mrRN23az6GCLUFf01aS4cP4NV3m
         oPeHWxB3ZRQp2uFSQdhenVD3LlDdt8gN+HU1zDtU0L2BV7aaj1yScRYByQg8qmMx6QPI
         j+Wm0f9Sv7HlzyoHobBFy1q4QozdN6BVlRbbMHCSnd9mIAF7fkhKmPSm/xhPOB5efSkk
         RElhN3cdWdEEUhhxD6SUZ373jehvtibWDkM3ziL5tcV239eIhomgqq5ZI/SpXFmViTxR
         gT2g6fzPWRMuIQW9SnwXFhfNDvDYMSZdtXSfoWlwsOu2z0CAvI95M0lm8t/8ChaTRddS
         ttXA==
X-Received: by 10.60.63.68 with SMTP id e4mr12303709oes.23.1380405470728;
        Sat, 28 Sep 2013 14:57:50 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id j9sm25346692oef.8.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 14:57:50 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405106-29430-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235516>

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
