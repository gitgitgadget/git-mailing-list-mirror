From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/4] sha1_file: trivial style cleanup
Date: Thu, 30 May 2013 08:56:21 -0500
Message-ID: <1369922181-31016-5-git-send-email-felipe.contreras@gmail.com>
References: <1369922181-31016-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 15:58:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui3N3-0007EF-V0
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 15:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405Ab3E3N6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 09:58:22 -0400
Received: from mail-yh0-f53.google.com ([209.85.213.53]:54736 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932262Ab3E3N6T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 09:58:19 -0400
Received: by mail-yh0-f53.google.com with SMTP id f64so58909yha.40
        for <git@vger.kernel.org>; Thu, 30 May 2013 06:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=39UfoG7Awa6aX3ua5WrmBp8NA8MYOVvg43XgJ8Ikk7Q=;
        b=y59CAeNk1akP7xWDKaYJugx+Y2Rd5ZS+cjeq5fpkLQFSHFwJbKI/agCiNpstqQ2yPO
         sLEz7OQFLNVyu46a84LJVqzSmlD5eU7uhEfarZF0XHpQcDe8lNJ7wcK8QeS0wdaWmG47
         AI1Ri2yWRD1hT55MzNlVBmF+iPHQNlVCpaC4Rz0pWqTJ8kt9vzyTcrN7fV2wm3n1t5Ef
         F36t51SlEcKCmSwbbhzq8j4jhQlgHVptF4RWAK3ohF5GPq39nVOPNCLAH75MbWCEgoBy
         ckFoZHIHMV42BSic33Cjy8bMOAmwMxCH6UUpNLvOVdRrZrJYugsIMFZDKYPetdd2ppkw
         e6UA==
X-Received: by 10.236.27.106 with SMTP id d70mr3726277yha.34.1369922298673;
        Thu, 30 May 2013 06:58:18 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id z67sm5187730yhb.5.2013.05.30.06.58.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 30 May 2013 06:58:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369922181-31016-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226000>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sha1_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index 67e815b..b114cc9 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2138,7 +2138,7 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 		if (!data)
 			die("failed to apply delta");
 
-		free (delta_data);
+		free(delta_data);
 	}
 
 	*final_type = type;
-- 
1.8.3.rc3.312.g47657de
