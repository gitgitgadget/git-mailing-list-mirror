From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2] Documentation: talk about pager in api-trace.txt
Date: Mon,  7 Mar 2016 11:38:53 +0100
Message-ID: <1457347133-31733-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 07 11:42:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acsbs-0001vu-Cc
	for gcvg-git-2@plane.gmane.org; Mon, 07 Mar 2016 11:41:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140AbcCGKlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2016 05:41:47 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35301 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbcCGKlp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2016 05:41:45 -0500
Received: by mail-wm0-f42.google.com with SMTP id l68so79425057wml.0
        for <git@vger.kernel.org>; Mon, 07 Mar 2016 02:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Zp9S2YTGGjp1WbAIX9rpwHQgHWn1fX3bQ96DVqz4KHI=;
        b=QwgMTJlSa6h8WAAskf2TEIQm+k2tjy7isPEDJo01m4wx96yXGmVbifoCPvv7vkNQuu
         1ZGpIGYBKPtvUbKoOBFo+ysRCKDdqeA7PwtylSgEwfkdAX5v8xYIIOPGD4sPeSQRTDLN
         QZWfl2kveiHMhGf2mQNGnE/dutkgswy/BPOwnpYZ5TlklaWp1tGmyujAZRq5/tRP91p+
         lZv8ZuohpM7nmE7MSfZMtlRWmagrL6368o/tE2UUGUx8WK/fDpvWR0sZGU0rJemyngf8
         7vpAo8plc1Ts+ro62i4YbVlRS7vKfwzAVWjK6t7C9pKoGdV3RWJuImt5eAlVnO4n1fy1
         FWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Zp9S2YTGGjp1WbAIX9rpwHQgHWn1fX3bQ96DVqz4KHI=;
        b=Df8MCp3NS42qA/CzWT83osx7r4JNAv2XSgwz5qcvXvDPURcaEvGC2AHLzHIZGrH4FT
         8tIKv/umkVA0ZRz+5uUfTnx7Mc8d0csVYS5zc23DJAWhN7lPQZyXgeQuKk9etIghhDGP
         6w/9GjHENgpRCUEQW2p+WWAUtizcqAmiraVBTD1x6LUi+s/nEw2CQ6fZXiUonQ+ozr7z
         qdmWFRj+pLQXqihZF9H7rwYFNe0jDqLg6JdV1q0dx4Qj08Wyi8nkiJlkhuD20pDzeS1M
         68WLqCL1ckLMo7z361ab9Uw+hCNKxA/vP0dvqutpoZVcztakUXzaYUEMaggx6dHpVoSN
         G0UA==
X-Gm-Message-State: AD7BkJJ+fOlbO/X7yBdVytSoKUma1bUVPhwG0h+SR3vEN2gUewL8RB/3jWLtvo6Py5Cp9w==
X-Received: by 10.28.105.136 with SMTP id z8mr12300787wmh.71.1457347304324;
        Mon, 07 Mar 2016 02:41:44 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id h128sm12939191wmf.23.2016.03.07.02.41.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Mar 2016 02:41:43 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc0.1.gd285ab0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288387>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/technical/api-trace.txt | 44 +++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/technical/api-trace.txt b/Documentation/technical/api-trace.txt
index 097a651..0e1af02 100644
--- a/Documentation/technical/api-trace.txt
+++ b/Documentation/technical/api-trace.txt
@@ -95,3 +95,47 @@ for (;;) {
 }
 trace_performance(t, "frotz");
 ------------
+
+Bugs & Caveats
+--------------
+
+GIT_TRACE_* environment variables can be used to tell Git to show
+trace output to its standard error stream. Git can often spawn a pager
+internally to run its subcommand and send its standard output and
+standard error to it.
+
+Because GIT_TRACE_PERFORMANCE trace is generated only at the very end
+of the program with atexit(), which happens after the pager exits, it
+would not work well if you send its log to the standard error output
+and let Git spawn the pager at the same time.
+
+As a work around, you can for example use '--no-pager', or set
+GIT_TRACE_PERFORMANCE to another file descriptor which is redirected
+to stderr, or set GIT_TRACE_PERFORMANCE to a file specified by its
+absolute path.
+
+For example instead of the following command which by default may not
+print any performance information:
+
+------------
+GIT_TRACE_PERFORMANCE=2 git log -1
+------------
+
+you may want to use:
+
+------------
+GIT_TRACE_PERFORMANCE=2 git --no-pager log -1
+------------
+
+or:
+
+------------
+GIT_TRACE_PERFORMANCE=3 3>&2 git log -1
+------------
+
+or:
+
+------------
+GIT_TRACE_PERFORMANCE=/path/to/log/file git log -1
+------------
+
-- 
2.8.0.rc0.1.gd285ab0
