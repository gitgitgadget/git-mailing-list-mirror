From: dborowitz@google.com
Subject: [PATCH] Documentation/Makefile: Allow custom XMLTO binary
Date: Wed, 19 Sep 2012 10:06:37 -0700
Message-ID: <1348074397-29978-1-git-send-email-dborowitz@google.com>
Cc: Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Sep 19 19:07:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TENjv-0005WH-Kc
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 19:07:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756264Ab2ISRG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 13:06:58 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37178 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754475Ab2ISRG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 13:06:57 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so2934376pbb.19
        for <git@vger.kernel.org>; Wed, 19 Sep 2012 10:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=SYWNuJgya5s69byfMJnXKk3daEKX3Glm3XtxPjNkxyY=;
        b=DwiRm21d3GwVyd1OPPbwz8+2lAklliTd3EzxNzTDLNdfCfI7vAW9VV7Dl6+E9FNYhQ
         YpHHvYoiT2ShIXg2Q8skr3XexphWI9wIFT7AyuEklKqZcfrJhD6uhEkMkPppbTnQv8Z9
         z3Mz42RLi/oWVV3guP0CInkqlIpp3kLt2mKp3k3td/tAkNKhL1nEMfbgTLB7pUTe1A8t
         ZyRyLle8eryaQTdYsMid328Cg4f4Y/92e11PFp3mh//so8YAscgLE6sUTdLZR1dQUA+S
         V8vHDdAoFTxXWyFwQx58LRHrNPPBOWaqAG99wvi27xwGQLIDUUYlgwTIpzYy0KLRwJrP
         DirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=SYWNuJgya5s69byfMJnXKk3daEKX3Glm3XtxPjNkxyY=;
        b=J7I+afvS6RlxLesgFIxjEx8f0W0TmxEx6pkINlM7k1sf3IVIImy23tZD0PfosGmn0J
         yeF8mq0RbEnD5X2doS39//0CLvRhgheJhxRGX+jaz//GVl8gZ9e2e9UN/X3bxx91dPgh
         cqp66P4BtI/crEuEwEXx0zlpeII4VSNN09NDQAszlx3ZSaTvuKb+PNI4iUYftYH7k2qD
         bIaWSj37c+b6AoZs8svw+sWwsYKoh64pgiawqB++EpQ6PEmeOMTD6XU1vhOYBnDCEV+b
         7IfBqxKhZUQqS4hQWjAPseor0AL+WqpCfwq4TtKkfAzX6/NfQqswNLu03skqZaxoJ7BZ
         ioYg==
Received: by 10.66.73.166 with SMTP id m6mr8476477pav.1.1348074416999;
        Wed, 19 Sep 2012 10:06:56 -0700 (PDT)
Received: by 10.66.73.166 with SMTP id m6mr8476448pav.1.1348074416796;
        Wed, 19 Sep 2012 10:06:56 -0700 (PDT)
Received: from serval.mtv.corp.google.com (serval.mtv.corp.google.com [172.27.69.27])
        by mx.google.com with ESMTPS id te6sm2129666pbc.29.2012.09.19.10.06.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 19 Sep 2012 10:06:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.1
X-Gm-Message-State: ALoCoQk+YT/Qra2ceP8CnBSlW0H3h+kKwQC4XO+N8F6WVTEaQ9eGho2k7Uqg5UQjAvqHF67XswOfbcKWdKPu87TbSqqW/xkK9s4+On7U2bhBXdQdiovFgqEUSQwhxvigQpWR3Zb9mudtJWqcN/xJVfXG99Nrw9yE8UvjHPrXoebsQPxzPZADEF6+g+QZZD6Q7Pq9YqKgiafwM6e6Fu9j5hI2WmUO2pmBp7eMdMYMi35m+rvsUmWRTrU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205946>

From: Dave Borowitz <dborowitz@google.com>

Signed-off-by: Dave Borowitz <dborowitz@google.com>
---
 Documentation/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index cf5916f..b045628 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -47,6 +47,7 @@ man7dir=$(mandir)/man7
 ASCIIDOC=asciidoc
 ASCIIDOC_EXTRA =
 MANPAGE_XSL = manpage-normal.xsl
+XMLTO=xmlto
 XMLTO_EXTRA =
 INSTALL?=install
 RM ?= rm -f
@@ -245,7 +246,7 @@ manpage-base-url.xsl: manpage-base-url.xsl.in
 
 %.1 %.5 %.7 : %.xml manpage-base-url.xsl
 	$(QUIET_XMLTO)$(RM) $@ && \
-	xmlto -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
+	$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
 
 %.xml : %.txt
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-- 
1.7.12.1
