From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 14/14] remote: add comment about read_{branches,remotes}_file
Date: Sat, 22 Jun 2013 13:28:21 +0530
Message-ID: <1371887901-5659-15-git-send-email-artagnon@gmail.com>
References: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 22 10:02:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqIm4-0008Qb-Fw
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 10:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423779Ab3FVICP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 04:02:15 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:57141 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423731Ab3FVICL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 04:02:11 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp16so8825410pbb.14
        for <git@vger.kernel.org>; Sat, 22 Jun 2013 01:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jnL1NU6F0RThVLPamVz1d2mpqcz/WUZt26EyRZfJfys=;
        b=bKBU1v3yVXasL/RSQ53GDrPgiHYQ3fyZufWzjLPim7UOZ+Z3PX+AVxlKO/HzAN0ylx
         ziL4Sjd8aEkSTz/NVAsX1Nj9j+oR6RNpZnZR0atLVQ2f44eexpYjn6RQ1fD9Cj4hWNMt
         o172LcOv/feGKYHB6js4CI0gjOaFCA6MN9ikb3i9NKvIz077M4a1sojztZWNQmV2tY4V
         k/eCNfJkx3XzJWa+zd7RAnXzhiyxdZUeiFv9v+0o/k/usbjGJlaOYVCBjwUlv/vaoCk6
         a0VW/dZT4DiJWyU8+eeOkg24Ypd27r/DbhT6ZkFjzJ4M1Tk14csSP5Y1KzTD9RZFuxJh
         WnFA==
X-Received: by 10.69.2.228 with SMTP id br4mr15481245pbd.91.1371888130833;
        Sat, 22 Jun 2013 01:02:10 -0700 (PDT)
Received: from localhost.localdomain ([122.174.20.35])
        by mx.google.com with ESMTPSA id dc3sm8355333pbc.9.2013.06.22.01.02.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 22 Jun 2013 01:02:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.487.gd3dfebf
In-Reply-To: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228685>

Explain that they are fringe features.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 remote.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/remote.c b/remote.c
index 128b210..f980928 100644
--- a/remote.c
+++ b/remote.c
@@ -227,6 +227,10 @@ static void add_instead_of(struct rewrite *rewrite, const char *instead_of)
 	rewrite->instead_of_nr++;
 }
 
+/*
+ * Fringe feature.  Modern Git encourages the use of gitconfig instead
+ * of remotes-file.
+ */
 static void read_remotes_file(struct remote *remote)
 {
 	FILE *f = fopen(git_path("remotes/%s", remote->name), "r");
@@ -274,6 +278,10 @@ static void read_remotes_file(struct remote *remote)
 	fclose(f);
 }
 
+/*
+ * Fringe feature.  Modern Git encourages the use of gitconfig instead
+ * of branches-file.
+ */
 static void read_branches_file(struct remote *remote)
 {
 	char *frag;
-- 
1.8.3.1.498.gacf2885
