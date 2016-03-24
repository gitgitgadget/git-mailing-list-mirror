From: Motroni Igor <motroniii@gmail.com>
Subject: [PATCH 2/2] Just a minor commit to trigger Travis Ci build
Date: Thu, 24 Mar 2016 22:41:09 +0300
Message-ID: <1458848469-12663-3-git-send-email-motroniii@gmail.com>
References: <1458848469-12663-1-git-send-email-motroniii@gmail.com>
Cc: Pontifik <motroniii@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 20:41:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajB8K-0005RF-Rk
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 20:41:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbcCXTlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 15:41:21 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36217 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbcCXTlS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 15:41:18 -0400
Received: by mail-lf0-f67.google.com with SMTP id r8so4630086lfe.3
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 12:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MVxDEQ92S6EAypY2Yk6xmHm/N8f/TD2Bo1k3D+2o2E4=;
        b=bV3iDsDtjpBjTmwtyQ/5ANVh+yQwkBtH6G++WdFuBWelosq++Y6tDw+kn+UJF0AN0P
         QlDeGq5dmtvlP/RU2i8cvFEettInHKh+m7rartsKVQvW2HC48c4QYzg73rEjixaexWzm
         sHA+jfa8MVHAB1F0ZH2xuqa0jk47pcLNu6ioyo8UDYQVo9rJ6l/sOgW2iYB/zK7FjsFk
         +2t2x5IbpKD1tFzCszx8QEDty6DO+bjo7jTbQKNFfLzz9U0zc8xLn0Y5uPjvX8+y9Bxr
         kKg0ul1BhSueLYpDN0LT52HW7uEPdR7TWDVPXxQVkhiStKIn/C53uFHT9pbTqzqUmxlL
         pPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MVxDEQ92S6EAypY2Yk6xmHm/N8f/TD2Bo1k3D+2o2E4=;
        b=gdaVUT/IdB++SaEGhmpwD3hqSnYyvDLJMTQV4ee93rp0XZhQ0yiCZ58yJi0ffO0jKX
         tfbJ5BpMherb9Z23nULNNunl90br9ucPFaletaFflB9vVLYhJdh4VsReRRuQy7XQWJsR
         d3FK1kNkyv12lboAq8hHsNxnHKNvYfQDfRTtsvMABdAo9bzdqpAbPa+2jjveiybSuEsb
         e6P0KThqibcM3jRWRqkkwS+2y79VSJevVGZugN17gJ1DR73nVWGjdUEkG4lhoxbyCKPi
         MD30mIUyS3HdcyIXRuiXZWHp3AS7VgJe1+kMCUW3NwOB+KQv1BxIm3E2KwAgkMVNymwN
         bNTQ==
X-Gm-Message-State: AD7BkJLDy2n06r1dtrGdAmxBo3kgD4LpuFA+ESMv57if1MXDj01DdA1mAGD035XRzUJkSQ==
X-Received: by 10.25.40.210 with SMTP id o201mr3453122lfo.44.1458848476900;
        Thu, 24 Mar 2016 12:41:16 -0700 (PDT)
Received: from localhost.localdomain (ppp91-76-147-218.pppoe.mtu-net.ru. [91.76.147.218])
        by smtp.gmail.com with ESMTPSA id i8sm1390220lbj.30.2016.03.24.12.41.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Mar 2016 12:41:16 -0700 (PDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1458848469-12663-1-git-send-email-motroniii@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289786>

From: Pontifik <motroniii@gmail.com>

Signed-off-by: Pontifik <motroniii@gmail.com>
---
 notes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/notes.c b/notes.c
index 88cf474..6d7da1e 100644
--- a/notes.c
+++ b/notes.c
@@ -539,8 +539,8 @@ static unsigned char determine_fanout(struct int_node *tree, unsigned char n,
 	return fanout + 1;
 }
 
-/* hex SHA1 + 19 * '/' + NUL */
-#define FANOUT_PATH_MAX 40 + 19 + 1
+/* hex SHA1 + 19 * '/' + NUL = 60 */
+#define FANOUT_PATH_MAX 60
 
 static void construct_path_with_fanout(const unsigned char *sha1,
 		unsigned char fanout, char *path)
-- 
2.5.0
