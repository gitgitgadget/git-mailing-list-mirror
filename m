From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 15/20] pretty: trivial style fix
Date: Sat, 12 Oct 2013 02:07:01 -0500
Message-ID: <1381561636-20717-6-git-send-email-felipe.contreras@gmail.com>
References: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:14:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtPK-0006KL-CB
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752827Ab3JLHOe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:14:34 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:32906 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754563Ab3JLHNa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:13:30 -0400
Received: by mail-oa0-f52.google.com with SMTP id n2so3057978oag.25
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hCpTLCkamuLDYa3KSt/M2tFgRhaGMWyXLS316DNtrRg=;
        b=QjYdNK1sNiTtLupBYCusDOLQJ/qksOcaB8ftc3dm520spzLi3EyJFB5Xm/fnCV4OjA
         lD4iXaT3vtkxkoPAp891v/pDviag+DHwdjCtyOq3x0b2Z8pwVCt6dRjHrzqL+XqxlJZb
         WlfNihmf+WBj3ZhT7bCrePoL3WXUT3igI1pb0oL9ZvgmZAhqMLrdkLS4cGcvincuAo2+
         1XPp+3QsfWksababdFdaRJYkSToKevf/hWLfFqXGZY4kKgIAR8ynlmu/+iR3rNLRrtie
         7X7LWEd9r6l7tfm/iLzFqEwgCa6LCPZ2nARtgXAN47tebrMZoF4c2MR6Y3OWSnHxIiIr
         gKmA==
X-Received: by 10.182.227.136 with SMTP id sa8mr985358obc.39.1381562009643;
        Sat, 12 Oct 2013 00:13:29 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id it7sm28653917obb.11.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:13:28 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236032>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 pretty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pretty.c b/pretty.c
index b4e32b7..962e82b 100644
--- a/pretty.c
+++ b/pretty.c
@@ -497,7 +497,7 @@ void pp_user_info(struct pretty_print_context *pp,
 static int is_empty_line(const char *line, int *len_p)
 {
 	int len = *len_p;
-	while (len && isspace(line[len-1]))
+	while (len && isspace(line[len - 1]))
 		len--;
 	*len_p = len;
 	return !len;
-- 
1.8.4-fc
