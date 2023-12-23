Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E276614F85
	for <git@vger.kernel.org>; Sat, 23 Dec 2023 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDJ0jFsG"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-336897b6bd6so2514937f8f.2
        for <git@vger.kernel.org>; Sat, 23 Dec 2023 09:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703351711; x=1703956511; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNi9JTg7O8mXiHhbMn/8YgHPkgzDveZ7qNVf8534OA0=;
        b=HDJ0jFsGITJEsdnAnSOKmXni9Y+iQnhVwDX/Xt2ZRfAsmLLfi8KHTFdEMZNEKgePhb
         MRJidjlR2i8ROToRJAED4OKmIBjlzuljiBSdZZcBSvrcaPDKAKgWKEH8m3IvXJuJEQ7N
         Ok9grXKWztY3zyiWzD+w4x7gob/4lae4AcVsOrerwhg8/Dnx+J1DnjlUlaM3Dmk5KfxE
         RZj6G3mxZL3Fhq+yrJeI32BN2q/WU1BCleXqG+diTp006OD6nXw+gfgyzFj1Atg3Y2/p
         8euwaW41+JmHGPHchVgz8nv8AnENu2CM9RlPiv/J67yoaUB7/1ylVUiWJ5QnwqbkJumg
         A1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703351711; x=1703956511;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNi9JTg7O8mXiHhbMn/8YgHPkgzDveZ7qNVf8534OA0=;
        b=pWb12d3nNmSJQjbiwn7Ja7Ks1nfIn7tLqf7UZe5KuWcgo6s0T+0LbbW051gpN3Ul8k
         1cvcXlzCl72YmysEUwe9P/RvsCh+v6zenogX/i/P+qDXxDyuBZH5lVJ4aoFtmpZLdM8p
         qvssez2aXOiHHz8uK3PP8+5t52U0RrH5y6stjEgaUSjOmh4T3FNuVDed+vC5cjQ9t1fs
         Ab1DhwZFUDdZcphOCKjnBck2B5ZkDRGQTHHiUgrOdH1SNu7ga83ipPK9RnOlpVtGTI8V
         /+i1+YXLjkgpq4JgfXqb2gua5TLp3RbkWEwfRyNqXUG3lToYz+Kl6afeOBDMzoEtCRxk
         pSMg==
X-Gm-Message-State: AOJu0YyrErER43qIkRAy3o3+D14FGJa6d97vZMp3qcq3gNAGPLi0aBOK
	LNvAJvkGeTGJdALdwR3S6gubsXo55ZY=
X-Google-Smtp-Source: AGHT+IHn5YUuWX29HK0jaUstbu41XvLDiYNP//BupHrW5H+ibSqWfznDkYykLWkIyOe4reRo0qq/ew==
X-Received: by 2002:a5d:56c3:0:b0:332:ffaf:d215 with SMTP id m3-20020a5d56c3000000b00332ffafd215mr1953894wrw.22.1703351710746;
        Sat, 23 Dec 2023 09:15:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c14-20020adffb4e000000b0033687f3b9b5sm6237224wrs.93.2023.12.23.09.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 09:15:10 -0800 (PST)
Message-ID: <7270441cd64cd0c580bff3a4346855ae0e917b18.1703351701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1617.v2.git.1703351700.gitgitgadget@gmail.com>
References: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
	<pull.1617.v2.git.1703351700.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Dec 2023 17:14:55 +0000
Subject: [PATCH v2 07/12] line-log.h: remove unnecessary include
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

The unnecessary include in the header transitively pulled in some
other headers actually needed by source files, though.  Have those
source files explicitly include the headers they need.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 line-log.c | 1 +
 line-log.h | 2 --
 log-tree.c | 1 +
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/line-log.c b/line-log.c
index a878cb7810a..c276ccec549 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1,4 +1,5 @@
 #include "git-compat-util.h"
+#include "diffcore.h"
 #include "line-range.h"
 #include "hex.h"
 #include "tag.h"
diff --git a/line-log.h b/line-log.h
index 4291da8d792..e9dadbc1a58 100644
--- a/line-log.h
+++ b/line-log.h
@@ -1,8 +1,6 @@
 #ifndef LINE_LOG_H
 #define LINE_LOG_H
 
-#include "diffcore.h"
-
 struct rev_info;
 struct commit;
 struct string_list;
diff --git a/log-tree.c b/log-tree.c
index 504da6b519e..337b9334cdb 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -2,6 +2,7 @@
 #include "commit-reach.h"
 #include "config.h"
 #include "diff.h"
+#include "diffcore.h"
 #include "environment.h"
 #include "hex.h"
 #include "object-name.h"
-- 
gitgitgadget

