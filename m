From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 08/16] sha1-name: trivial style cleanup
Date: Thu, 31 Oct 2013 03:25:39 -0600
Message-ID: <1383211547-9145-9-git-send-email-felipe.contreras@gmail.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 31 10:33:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vboch-0008Ez-HS
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 10:33:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753704Ab3JaJct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 05:32:49 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:44311 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753648Ab3JaJcs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 05:32:48 -0400
Received: by mail-ob0-f182.google.com with SMTP id wn1so2780480obc.13
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 02:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tN6mxYxNDXLK7/8AEcdfzRG08e4sJ28231UO1AXezuo=;
        b=EfZ0P3fe2LMM2C/uaUOrvQSJODwMEORhjw5Wq2MaB/3v1XKMAKJt76QoV8PBhkjVi+
         ITAWDTUHS3E5fgO0GZZSrb+wBX0UNaLy44BA3LYflkG5IFVaAAbxe7hAuFi+Ii54fXge
         1yubVE1SkHBjaDMRl5oz4C56d4tRHT4MfDlw2GP16Z9Z+3BSpb2seEITVbl9KSQsu2k4
         oHs2u8xORK8JpGYvuAIM+Y3Q1SBo9Wg7E1U4MjpIeNLJzK8hUkmC85EldFeN7pYpDvCI
         03DcqAo5S/ne0OQFytb3U3RRYdB623l3AgnUCyrmTvOe6B0efSeOnK73qOcfnweoa1zQ
         v7WQ==
X-Received: by 10.60.73.137 with SMTP id l9mr1890962oev.32.1383211968150;
        Thu, 31 Oct 2013 02:32:48 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id r3sm5419993oep.2.2013.10.31.02.32.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2013 02:32:47 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237092>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sha1_name.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sha1_name.c b/sha1_name.c
index 0e5fe7f..e9c2999 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -343,7 +343,6 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 	return status;
 }
 
-
 int for_each_abbrev(const char *prefix, each_abbrev_fn fn, void *cb_data)
 {
 	char hex_pfx[40];
-- 
1.8.4.2+fc1
