Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05B511F454
	for <e@80x24.org>; Wed,  6 Nov 2019 23:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfKFXtu (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 18:49:50 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34228 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfKFXtu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 18:49:50 -0500
Received: by mail-wr1-f65.google.com with SMTP id e6so808484wrw.1
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 15:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=niemier-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Y7JbxZ9cunUUsvqIIE8vQFUXgW3JKfd6BA5/PNbAXM=;
        b=JgUlu4vqacyCMAkA0JLqDZPRkqnpzg1AzWZxaZKf0qeqwDKEcYDujUakeUpfn7SXll
         O8Bp/wSL6ete3MLENXz6ozpX7AGyPRo95PvimtQ5BxEhHbGGQbWbwNOl9/izsvLFlcAf
         RlNJsQBo5jcItcm1rFen+SqIYs3KH+mSRGKNUz2zWWwPMUXxCfGXscraAaNi7ebL56pa
         gIiOcbYQw+r8xyBFR5hY2PLEQo+O+X7ITDp+mQHGjj0SSNfW2u+Y1uiiL/i6Ci7MN2l7
         kLLjvj5kq99wuBnVU19UF3CSwXWiklMw1wRDIAoW0KDGzHg51brGcb3hT9DbHVzbqqvJ
         ksnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Y7JbxZ9cunUUsvqIIE8vQFUXgW3JKfd6BA5/PNbAXM=;
        b=mHZhzEWVj7ou7j4DYvbN4OJCnO6yTLZ3X2Ge9B7kWc4H98F5Hq6ASuPbxDssSp9Oti
         7IAqZgdcb/1K5wEkjSeJ2G0C3oQJU7EEnNS0GA4dv0wpBUVZtLIiji9+JObAztfwO+yC
         veg0q8MvgyP/FSpabNVA+shllS6xJs+/RwcQXB23BB9yMytYCeQQ3o1qitfyllO4rwJY
         tr5nxJrvOLmMHuBqx1itdZNIb6UVTBwkIQMwyNYgIFZWnRwl7+/HsCJJchmcIaOf2LAU
         XOei0vPkOywOl1rm0pzKj6xams2ImOX1iUaSMEN3H6idLj7KHIK7igAwwymQdJyp8/mS
         EhiQ==
X-Gm-Message-State: APjAAAWoOyrtPd1y45qukiLPWuZP78wl0wQPsKdnHxB1FO4pO4jMpBhA
        DxvMp/qZFykBWrT4CxPu/QZ7uAejOf0qeQ==
X-Google-Smtp-Source: APXvYqzIpmjjnaPNThDhhisCT/l9gxw+nrKfhXlzJdtxnECuSYEwSobSpE1KiZ3GIWyW4v7e6PsQwQ==
X-Received: by 2002:adf:ed4e:: with SMTP id u14mr181729wro.132.1573084185421;
        Wed, 06 Nov 2019 15:49:45 -0800 (PST)
Received: from localhost.localdomain (83.25.107.61.ipv4.supernova.orange.pl. [83.25.107.61])
        by smtp.gmail.com with ESMTPSA id r19sm368163wrr.47.2019.11.06.15.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 15:49:44 -0800 (PST)
From:   =?UTF-8?q?=C5=81ukasz=20Niemier?= <lukasz@niemier.pl>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C5=81ukasz=20Niemier?= <lukasz@niemier.pl>
Subject: [PATCH v3] userdiff: add Elixir to supported userdiff languages
Date:   Thu,  7 Nov 2019 00:49:41 +0100
Message-Id: <20191106234941.48926-1-lukasz@niemier.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adds support for xfuncref in Elixir[1] language which is Ruby-like
language that runs on Erlang[3] Virtual Machine (BEAM).

[1]: https://elixir-lang.org
[2]: https://www.erlang.org

Signed-off-by: Łukasz Niemier <lukasz@niemier.pl>
---
 t/t4018-diff-funcname.sh               |  1 +
 t/t4018/elixir-do-not-pick-end         |  5 +++++
 t/t4018/elixir-ex-unit-test            |  6 ++++++
 t/t4018/elixir-function                |  5 +++++
 t/t4018/elixir-macro                   |  5 +++++
 t/t4018/elixir-module                  |  9 +++++++++
 t/t4018/elixir-module-func             |  8 ++++++++
 t/t4018/elixir-nested-module           |  9 +++++++++
 t/t4018/elixir-private-function        |  5 +++++
 t/t4018/elixir-protocol                |  6 ++++++
 t/t4018/elixir-protocol-implementation |  5 +++++
 userdiff.c                             | 12 ++++++++++++
 12 files changed, 76 insertions(+)
 create mode 100644 t/t4018/elixir-do-not-pick-end
 create mode 100644 t/t4018/elixir-ex-unit-test
 create mode 100644 t/t4018/elixir-function
 create mode 100644 t/t4018/elixir-macro
 create mode 100644 t/t4018/elixir-module
 create mode 100644 t/t4018/elixir-module-func
 create mode 100644 t/t4018/elixir-nested-module
 create mode 100644 t/t4018/elixir-private-function
 create mode 100644 t/t4018/elixir-protocol
 create mode 100644 t/t4018/elixir-protocol-implementation

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 6f5ef0035e..c0f4839543 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -32,6 +32,7 @@ diffpatterns="
 	csharp
 	css
 	dts
+	elixir
 	fortran
 	fountain
 	golang
diff --git a/t/t4018/elixir-do-not-pick-end b/t/t4018/elixir-do-not-pick-end
new file mode 100644
index 0000000000..fae08ba7e8
--- /dev/null
+++ b/t/t4018/elixir-do-not-pick-end
@@ -0,0 +1,5 @@
+defmodule RIGHT do
+end
+#
+#
+# ChangeMe; do not pick up 'end' line
diff --git a/t/t4018/elixir-ex-unit-test b/t/t4018/elixir-ex-unit-test
new file mode 100644
index 0000000000..0560a2b697
--- /dev/null
+++ b/t/t4018/elixir-ex-unit-test
@@ -0,0 +1,6 @@
+defmodule Test do
+  test "RIGHT" do
+    assert true == true
+    assert ChangeMe
+  end
+end
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
diff --git a/t/t4018/elixir-macro b/t/t4018/elixir-macro
new file mode 100644
index 0000000000..4f925e9ad4
--- /dev/null
+++ b/t/t4018/elixir-macro
@@ -0,0 +1,5 @@
+defmacro foo(RIGHT) do
+  # Code
+  # Code
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
diff --git a/t/t4018/elixir-module-func b/t/t4018/elixir-module-func
new file mode 100644
index 0000000000..c9910d0675
--- /dev/null
+++ b/t/t4018/elixir-module-func
@@ -0,0 +1,8 @@
+defmodule Foo do
+  def fun(RIGHT) do
+     # Code
+     # Code
+     # Code
+     ChangeMe
+  end
+end
diff --git a/t/t4018/elixir-nested-module b/t/t4018/elixir-nested-module
new file mode 100644
index 0000000000..771ebc5c42
--- /dev/null
+++ b/t/t4018/elixir-nested-module
@@ -0,0 +1,9 @@
+defmodule MyApp.RIGHT do
+  @moduledoc """
+  Foo bar
+  """
+
+  def ChangeMe(a) where is_map(a) do
+    a
+  end
+end
diff --git a/t/t4018/elixir-private-function b/t/t4018/elixir-private-function
new file mode 100644
index 0000000000..1aabe33b7a
--- /dev/null
+++ b/t/t4018/elixir-private-function
@@ -0,0 +1,5 @@
+defp function(RIGHT, arg) do
+  # comment
+  # comment
+  ChangeMe
+end
diff --git a/t/t4018/elixir-protocol b/t/t4018/elixir-protocol
new file mode 100644
index 0000000000..7d9173691e
--- /dev/null
+++ b/t/t4018/elixir-protocol
@@ -0,0 +1,6 @@
+defprotocol RIGHT do
+  @doc """
+  Calculates the size (and not the length!) of a data structure
+  """
+  def size(data, ChangeMe)
+end
diff --git a/t/t4018/elixir-protocol-implementation b/t/t4018/elixir-protocol-implementation
new file mode 100644
index 0000000000..f9234bbfc4
--- /dev/null
+++ b/t/t4018/elixir-protocol-implementation
@@ -0,0 +1,5 @@
+defimpl RIGHT do
+  # Docs
+  # Docs
+  def foo(ChangeMe), do: :ok
+end
diff --git a/userdiff.c b/userdiff.c
index e187d356f6..577053c10a 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -32,6 +32,18 @@ PATTERNS("dts",
 	 /* Property names and math operators */
 	 "[a-zA-Z0-9,._+?#-]+"
 	 "|[-+*/%&^|!~]|>>|<<|&&|\\|\\|"),
+PATTERNS("elixir",
+	 "^[ \t]*((def(macro|module|impl|protocol|p)?|test)[ \t].*)$",
+	 /* Atoms, names, and module attributes */
+	 "|[@:]?[a-zA-Z0-9@_?!]+"
+	 /* Numbers with specific base */
+	 "|[-+]?0[xob][0-9a-fA-F]+"
+	 /* Numbers */
+	 "|[-+]?[0-9][0-9_.]*([eE][-+]?[0-9_]+)?"
+	 /* Operators and atoms that represent them */
+	 "|:?(\\+\\+|--|\\.\\.|~~~|<>|\\^\\^\\^|<?\\|>|<<<?|>?>>|<<?~|~>?>|<~>|<=|>=|===?|!==?|=~|&&&?|\\|\\|\\|?|=>|<-|\\\\\\\\|->)"
+	 /* Not real operators, but should be grouped */
+	 "|:?%[A-Za-z0-9_.]\\{\\}?"),
 IPATTERN("fortran",
 	 "!^([C*]|[ \t]*!)\n"
 	 "!^[ \t]*MODULE[ \t]+PROCEDURE[ \t]\n"
-- 
2.23.0

