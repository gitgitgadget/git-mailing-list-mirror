Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 569731F454
	for <e@80x24.org>; Wed,  6 Nov 2019 17:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732246AbfKFRsv (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 12:48:51 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36354 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729007AbfKFRsv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 12:48:51 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so221369wrx.3
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 09:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=niemier-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ye4AwGnOuI7ov3vZHZVimsZn5hd7YEhOaWmUnBmWDXw=;
        b=eq3w5wQf3BaVNt78ezomLfD5oPLofE9aA9GK2SU7w3qO/goxTlyqM0vMxnfU7LNNCv
         MHajXLDVly0ge02kgQ/YMXdHq1tww/idwf7hKPgXOu529qQUIABNdDpEu2gjg40bn+z7
         vEQ7GhN51Oga60wAvyJhHtEQSrv2B9Xr7m0KmrprEZ8/kny2bPg1Jsu6eGbTuCny/6QY
         pdMnq4LIkTTuUZ6O5CEeRymPPdC0hhihmVpWn+h9xjoB3/wbJb+IkO9ZbOYAXZlmna9p
         bC66kPWljSpiqf/ZLgG843gFiss0/PEukWvXnmNQ1NPZFWe4C/qNluGePcaMJLrct+86
         Kqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ye4AwGnOuI7ov3vZHZVimsZn5hd7YEhOaWmUnBmWDXw=;
        b=SEJgtN5gxWkMUhM6mZrRuVtsuN2Lc7vxAv6rFC13rP5M+TMFWM1vpG4g2BGG/LE/2Y
         4RF/t6sS33Vofyd51hQdLlIqChF4P/hVWKq/bpSRcvwcYiUmNlCY3uDBziTo3s+Peuir
         oy3vYggx7TvKp++DPKuTJXnwR6A4M0TNLDk0+7LHY+iUk0Cql1wG94Qw327CGyJRI1Nz
         bhzuj9a4XMqDxjtDry/xJOsj6F+oeTamenk6tsZRJGdMjV7cg62tbC+1bOY+CmELWnr2
         /z5fZe3tFPcrFbMDIhtMu/hWiUWaou5XnBdHt6iozNsynGyQQv4BVjn8YriiCnt1lSgY
         g88Q==
X-Gm-Message-State: APjAAAX8W7jauXOT8W9kHsfyz07/IClsmYKLSr1YjcT7n5Pop6NtGIOc
        YKfW2qE/rVCYuxCkpzICvT3lMeRjl7BJwA==
X-Google-Smtp-Source: APXvYqyn5Fpjk7Nru7ty/ERrQi14EkJhQ+dx+u4XB5sFwffgv+WZU5JDKu47PnuJ0hzyf7hm4owfUQ==
X-Received: by 2002:adf:fd4b:: with SMTP id h11mr3700878wrs.191.1573062528857;
        Wed, 06 Nov 2019 09:48:48 -0800 (PST)
Received: from localhost.localdomain (83.25.107.61.ipv4.supernova.orange.pl. [83.25.107.61])
        by smtp.gmail.com with ESMTPSA id g4sm17273944wru.75.2019.11.06.09.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 09:48:48 -0800 (PST)
From:   =?UTF-8?q?=C5=81ukasz=20Niemier?= <lukasz@niemier.pl>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C5=81ukasz=20Niemier?= <lukasz@niemier.pl>
Subject: [PATCH v2] feat: add Elixir to supported userdiff languages
Date:   Wed,  6 Nov 2019 18:48:44 +0100
Message-Id: <20191106174844.23482-1-lukasz@niemier.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
Remove file that landed accidentally in the commit
 t/t4018-diff-funcname.sh | 1 +
 t/t4018/elixir-function  | 5 +++++
 t/t4018/elixir-module    | 9 +++++++++
 userdiff.c               | 7 +++++++
 4 files changed, 22 insertions(+)
 create mode 100644 t/t4018/elixir-function
 create mode 100644 t/t4018/elixir-module

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 6f5ef0035e..194310377e 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -31,6 +31,7 @@ diffpatterns="
 	cpp
 	csharp
 	css
+	elixir
 	dts
 	fortran
 	fountain
diff --git a/t/t4018/elixir-function b/t/t4018/elixir-function
new file mode 100644
index 0000000000..d452f495a7
--- /dev/null
+++ b/t/t4018/elixir-function
@@ -0,0 +1,5 @@
+def function(RIGHT, arg) do
+  # comment
+  # comment
+  ChangeMe
+end
diff --git a/t/t4018/elixir-module b/t/t4018/elixir-module
new file mode 100644
index 0000000000..91a4e7aa20
--- /dev/null
+++ b/t/t4018/elixir-module
@@ -0,0 +1,9 @@
+defmodule RIGHT do
+  @moduledoc """
+  Foo bar
+  """
+
+  def ChangeMe(a) where is_map(a) do
+    a
+  end
+end
diff --git a/userdiff.c b/userdiff.c
index e187d356f6..31fff34e1e 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -32,6 +32,13 @@ PATTERNS("dts",
 	 /* Property names and math operators */
 	 "[a-zA-Z0-9,._+?#-]+"
 	 "|[-+*/%&^|!~]|>>|<<|&&|\\|\\|"),
+PATTERNS("elixir",
+	 "^[ \t]*((def(macro|module|impl|guard|protocol)?p?|test)[ \t].*)$",
+	 "[a-zA-Z0-9_.]+"
+	 "|:[a-zA-Z0-9@_]+"
+	 "|:'a-zA-Z0-9@_]+'"
+	 "|:\"[a-zA-Z0-9@_]+\""
+	 "|@[a-zA-Z0-9_]+"),
 IPATTERN("fortran",
 	 "!^([C*]|[ \t]*!)\n"
 	 "!^[ \t]*MODULE[ \t]+PROCEDURE[ \t]\n"
-- 
2.23.0

