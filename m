From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 03/10] pretty: trivial style fix
Date: Sat, 28 Sep 2013 16:51:39 -0500
Message-ID: <1380405106-29430-4-git-send-email-felipe.contreras@gmail.com>
References: <1380405106-29430-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 28 23:57:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2WJ-0002Dl-GS
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 23:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755193Ab3I1V5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 17:57:44 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:59344 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755140Ab3I1V5m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 17:57:42 -0400
Received: by mail-ob0-f181.google.com with SMTP id gq1so4054149obb.26
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 14:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hCpTLCkamuLDYa3KSt/M2tFgRhaGMWyXLS316DNtrRg=;
        b=aw3Dva26COyzfK0fW17dInJW7j1MEXngwlasHhNP8ewYqLcFbkbHaLRniKjNHoZhU1
         vdjfFm+BE2jPOSxG+MxRYjAoFX9b0hWybppFS19ZRC9DMDGVUuKodoSCERiGJ4Nobd0Y
         fX8cT1czHhTbd+c5qQrVR0Cz0FpMbKbfMa8ui8XUfzuOqYVtrptzltoTd1TpZv6x0feA
         y2WUGh8OLVVq1qcI6E5KMYWs+CPv6xbS8JFFxO4QPf7QGikwHC0METyeidhUPpYJLGc/
         +9M2q28VebPEGQVNVQ4jwdm8QC3rkMfOtZYHTqLIP+iln8WBpI6zkZNhg0mCOBl/NWLJ
         Y35Q==
X-Received: by 10.60.60.105 with SMTP id g9mr12342528oer.8.1380405462402;
        Sat, 28 Sep 2013 14:57:42 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s14sm25398615oeo.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 14:57:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405106-29430-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235512>

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
