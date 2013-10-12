From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 17/20] diff: trivial style fix
Date: Sat, 12 Oct 2013 02:07:06 -0500
Message-ID: <1381561636-20717-11-git-send-email-felipe.contreras@gmail.com>
References: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:14:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtOz-00066M-MY
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702Ab3JLHNo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:13:44 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:43150 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754696Ab3JLHNm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:13:42 -0400
Received: by mail-oa0-f51.google.com with SMTP id h16so3076610oag.24
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XI4mGMTXFPClR2qQ4IvHzQZN16zUwOR46/kUPxT6gtI=;
        b=n3tfWuGCvzWUidSSBSYO05GbWYpu50/vxaOUWbR6p5YU2Y1nVzYvsvxhDzXysURJkQ
         pwH62lrMshYilqTXIcTw6tupsc4FWMUESZD6MQHmGVVnHSdtjG0xpgUMnVxZCFl1kIfp
         KBcWA+DjLYHKI6LmQziMZTVbG+E8yHOMoobCKAZsbit2t2cCRjQTpsMhoiUYQ2/wxTV3
         tmqgfdwNEsS0PrZXgiL43zFPLBo3OPfuzyZB2i08BC9+lUwg15k2yVrAZH1JOjnp4n2B
         W5IJGak/aYbB6nySRA25FyYk58bcGVz7m8ne1rcOdclr5y/w6AYVfwka5llts6Q5j9xm
         AuGQ==
X-Received: by 10.182.181.34 with SMTP id dt2mr17469650obc.30.1381562022507;
        Sat, 12 Oct 2013 00:13:42 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id r6sm28674602obi.14.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:13:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236027>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index 2fb8c5d..adb93a9 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -169,7 +169,7 @@ static int builtin_diff_tree(struct rev_info *revs,
 	if (ent1->item->flags & UNINTERESTING)
 		swap = 1;
 	sha1[swap] = ent0->item->sha1;
-	sha1[1-swap] = ent1->item->sha1;
+	sha1[1 - swap] = ent1->item->sha1;
 	diff_tree_sha1(sha1[0], sha1[1], "", &revs->diffopt);
 	log_tree_diff_flush(revs);
 	return 0;
-- 
1.8.4-fc
