From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 07/20] shortlog: add missing declaration
Date: Sat, 12 Oct 2013 02:07:08 -0500
Message-ID: <1381561636-20717-13-git-send-email-felipe.contreras@gmail.com>
References: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:13:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtOZ-0005ob-FK
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754757Ab3JLHNs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:13:48 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:58790 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630Ab3JLHNr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:13:47 -0400
Received: by mail-oa0-f46.google.com with SMTP id k14so3107893oag.5
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hhA/ev6blxh6e+/ff6vYKdXUfeBLWALwVy6DGmwPB2w=;
        b=ev2vLKnh7hR9wyQCUEmErDKwgTOHUExJ89ix9Vra62AGTOgtIlcN6FEUSCYccg6f/M
         Ghyn6Rw31O9cuCZw/E6NBcIOF0LBXGa5vmwHySWhNKiQqpRFfs3Za9UTAgiLWcl25+bp
         0E7X5aO4eCORAqU65VJGxQX2wk3o/tQUfeRigzzJNGPlluBwPzAsXii/dYgvO/mttcJz
         MWyYpFE7MVlfCa6/xeYkWgxM/u9ksZBWr0VA2BNPp2CcOK/F3IfUhY3F9p50a4lISJFn
         iIw2gSBZKCUodx4Cq2HOaFr7ZUJDlem/ZBCiRYI9ZND7DgA4gpbf41CGWxhwPSAQDllD
         uHpA==
X-Received: by 10.60.174.75 with SMTP id bq11mr17797731oec.17.1381562027332;
        Sat, 12 Oct 2013 00:13:47 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id bq4sm28641412obb.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:13:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236020>

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
