From: Brian Gesiak <modocache@gmail.com>
Subject: [PATCH 2/2] api-strbuf.txt: Add docs for _trim and _ltrim
Date: Wed, 30 Apr 2014 17:58:07 +0900
Message-ID: <1398848287-77109-2-git-send-email-modocache@gmail.com>
References: <1398848287-77109-1-git-send-email-modocache@gmail.com>
Cc: Brian Gesiak <modocache@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 30 10:59:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfQMf-0000c0-Fd
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 10:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758561AbaD3I7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 04:59:34 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:56188 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756568AbaD3I7d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 04:59:33 -0400
Received: by mail-pd0-f182.google.com with SMTP id v10so1395425pde.13
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 01:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MdcLWAlXfmth7o0n0FehjOwtRDpG9CKIJUhMNWRjm+Q=;
        b=kop4O5qKHwVvJPAeoAU9wDlq2OKqummUUzgfKpc/2IHZW8wdLrWEonpvZJtQNZW1Xn
         qDep3BGI9bfq6cw7YSWG8cAS58Lez4oqph55BadbCve3Nku9oqb66Mf/QoL4RlWLENiE
         VGtijE0QYeN+9SKBYjzUSxSdWie8ZnT7eyZ1ImRE/IeTU+w4U06Q9zj0DGuD5tmkKdnV
         Ta5IVHaULFB3tbmLe8QBrtlidstwXUsJOdoSw//QwOmDMLQERME59w07uZ5UEowYsozt
         NGszEnUhkDGqcnMGFUH8bavvp9SrM3PkZi6Unhg6x98D+sMUwcXZz+M+BGEUr5Be/iAA
         pdtQ==
X-Received: by 10.66.147.130 with SMTP id tk2mr6166020pab.125.1398848370362;
        Wed, 30 Apr 2014 01:59:30 -0700 (PDT)
Received: from localhost.localdomain (p1157-ipbf5204marunouchi.tokyo.ocn.ne.jp. [118.8.132.157])
        by mx.google.com with ESMTPSA id g6sm130770710pat.2.2014.04.30.01.59.28
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 30 Apr 2014 01:59:29 -0700 (PDT)
X-Mailer: git-send-email 1.9.2.507.g779792a
In-Reply-To: <1398848287-77109-1-git-send-email-modocache@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247686>

API documentation for strbuf does not document strbuf_trim or
strbuf_ltrim. Add documentation for these two functions.

Signed-off-by: Brian Gesiak <modocache@gmail.com>
---
 Documentation/technical/api-strbuf.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
index 3350d97..4396be9 100644
--- a/Documentation/technical/api-strbuf.txt
+++ b/Documentation/technical/api-strbuf.txt
@@ -121,10 +121,19 @@ Functions
 
 * Related to the contents of the buffer
 
+`strbuf_trim`::
+
+	Strip whitespace from the beginning and end of a string.
+	Equivalent to performing `strbuf_rtrim()` followed by `strbuf_ltrim()`.
+
 `strbuf_rtrim`::
 
 	Strip whitespace from the end of a string.
 
+`strbuf_ltrim`::
+
+	Strip whitespace from the beginning of a string.
+
 `strbuf_cmp`::
 
 	Compare two buffers. Returns an integer less than, equal to, or greater
-- 
1.9.2.507.g779792a
