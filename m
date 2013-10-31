From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 05/16] revision: add missing include
Date: Thu, 31 Oct 2013 03:25:36 -0600
Message-ID: <1383211547-9145-6-git-send-email-felipe.contreras@gmail.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 31 10:32:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbocQ-00087Y-V9
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 10:32:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753615Ab3JaJcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 05:32:43 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:63783 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490Ab3JaJcl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 05:32:41 -0400
Received: by mail-oa0-f44.google.com with SMTP id l20so2801445oag.3
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 02:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XcHZ/WOL2uEBdNVXKVCBJa+Tkz1GMIh/JYMPJ4MkdFA=;
        b=NAdDM9YCoREzLtphz6bHflCngW1FDoCt0Muis6PitrlZBuH76/CZNB7fcFBn2YC0Pq
         SaCU7iASOT9bBBfYe8yfoxdeZ6qaR+scQK6tjDE8r6r6jVpJ00a1k5v4kA3nQpr8GUSH
         kNfX5+KLVRLHUGK4sMkf9J7e05TcqN/iMMqMSYvDkO6mmsaFYu64n0j9hkfktOQSIQHR
         qAiEQnppsXtjKdyg4fMLZMyak3zWNjL/X91xbII6qjKwlkF038hqBVBjBW//IMHQV2kS
         q0xMwk2vFsBHEK6oStPR9xDy/W1YFmT5rBu8XqZV9sLcRdvohM5xrYM28qWjfNnoxB/I
         UM4A==
X-Received: by 10.182.215.202 with SMTP id ok10mr1887917obc.62.1383211961363;
        Thu, 31 Oct 2013 02:32:41 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s14sm5425472oeo.1.2013.10.31.02.32.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2013 02:32:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237089>

Otherwise we might not have 'struct diff_options'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 revision.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/revision.h b/revision.h
index e7f1d21..89132df 100644
--- a/revision.h
+++ b/revision.h
@@ -5,6 +5,7 @@
 #include "grep.h"
 #include "notes.h"
 #include "commit.h"
+#include "diff.h"
 
 #define SEEN		(1u<<0)
 #define UNINTERESTING   (1u<<1)
-- 
1.8.4.2+fc1
