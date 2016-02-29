From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH] Documentation: talk about pager in api-trace.txt
Date: Mon, 29 Feb 2016 15:21:20 +0100
Message-ID: <1456755680-4335-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 29 15:23:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaOjo-0004QI-6B
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 15:23:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709AbcB2OXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 09:23:47 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37967 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbcB2OXq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 09:23:46 -0500
Received: by mail-wm0-f52.google.com with SMTP id l68so60683124wml.1
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 06:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=x0auPZ4IjEQryAsL9HkAHBZO/teG2uda+xjZTSAUoJE=;
        b=eQy7JMZzg1Il9MP7wtPvtibjRj1QDpGps4OXnYB0weXaApcHsdSfbFqU4cI4KY3bx5
         ZkqhGG6qv1EVwxOy2xjNJXC2RwB2P4Ll4PjylEokc56NBgu8laAL464Whc0cVH1/Lnv8
         GoMU9PNK3Zm2CFgALuRB6YbMLqnUSswmMdjae+3C5c+Mcox+RLCMtcJfeC6rPFqayD4a
         YMWERbZQEtTZADI/ogYZ50e7uo9H8WFXvEr3/q8r/rxT3NOySFLbI9SYs0ZuPXfgi+GZ
         XbcyGar7+f54Qfp+T6x1LHSQYrLDjod24yZsRyAmBafNS5xA/S6zDaJ5nKSVT9dpgMXc
         M7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x0auPZ4IjEQryAsL9HkAHBZO/teG2uda+xjZTSAUoJE=;
        b=H4R2fGhuncLIEz91VFmN6BctjPDYSMcO2+t1QnzEpTNKtiZRHQWEZZvtmDXgowo1KT
         N5OA/QkmI+YGaKwKYcwMP0IiaN9za8ZQyeisGp3rYvdyG+c9T9mPtfhCA0UFUKbRx3m5
         EvJRPgIjJs2N2dOncVFy4gr9wxfqKWscpIrqkdb1KPxq38ujTuekygOS4EFPnombgKKH
         pfaDb2nZo89Uno5mvTDeBevBTvTWLoruAj07NS11RADbBcp8ttwH96NzVOCnmEFIORPc
         5a+z1bbGmdZdfKRu2ywCcDfsMCTxuSDHH3hPjO1yUAzzhN2s6LRbif9GR6kc0X6VmHc1
         SgpQ==
X-Gm-Message-State: AD7BkJIvZfTsRh2HOXk6TR/+T8zX50Dk2J6B4oyyLJbwUcMYCOQzrDPnQXxfpZH6ajqv8g==
X-Received: by 10.195.13.16 with SMTP id eu16mr17019533wjd.140.1456755825045;
        Mon, 29 Feb 2016 06:23:45 -0800 (PST)
Received: from localhost.localdomain (AMontpellier-652-1-275-241.w90-57.abo.wanadoo.fr. [90.57.182.241])
        by smtp.gmail.com with ESMTPSA id l7sm26226757wjx.14.2016.02.29.06.23.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Feb 2016 06:23:44 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.1.289.gf4cc727
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287840>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/technical/api-trace.txt | 43 +++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/Documentation/technical/api-trace.txt b/Documentation/technical/api-trace.txt
index 097a651..a10b3a9 100644
--- a/Documentation/technical/api-trace.txt
+++ b/Documentation/technical/api-trace.txt
@@ -95,3 +95,46 @@ for (;;) {
 }
 trace_performance(t, "frotz");
 ------------
+
+Bugs & Caveats
+--------------
+
+Some git commands, like `git log`, are run by default using a
+pager. In this case, stdout and stderr are redirected to the pager and
+are closed when the pager exits.
+
+If a GIT_TRACE* environment variable has been set to "1" or "2" to
+print traces on stderr, no trace output will be printed after the
+pager has exited.
+
+This can be annoying, because GIT_TRACE_PERFORMANCE by default prints
+the performance stats for the whole command at atexit() time which
+happens after the pager has exited.
+
+So the following command will print no performance stat:
+
+------------
+GIT_TRACE_PERFORMANCE=2 git log -1
+------------
+
+To overcome this problem, you can use one of the following
+work-arounds:
+
+  - redirect to another file descriptor which is redirected to stderr,
+    like this:
+
+------------
+GIT_TRACE_PERFORMANCE=3 3>&2 git log -1
+------------
+
+  - redirect to a file specified by its absolute path, like this:
+
+------------
+GIT_TRACE_PERFORMANCE=/path/to/log/file git log -1
+------------
+
+  - use "--no-pager", like this:
+
+------------
+GIT_TRACE_PERFORMANCE=2 git --no-pager log -1
+------------
-- 
2.7.1.289.gf4cc727
