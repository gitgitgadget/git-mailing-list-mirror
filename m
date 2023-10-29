Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0AB11C99
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 20:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuNDtK8L"
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26533C0
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 13:23:11 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32f7c44f6a7so809398f8f.1
        for <git@vger.kernel.org>; Sun, 29 Oct 2023 13:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698610989; x=1699215789; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HNdsCo+vMheZ6VmPMr0gKwMOp+OninhIfK7w4fFsKHg=;
        b=UuNDtK8LOPZUCiviZBvxUGelbQlpdEq0ApAMisRHUYKhbpQjkp/aFGFhKX+CvbGW7R
         qLDjj8ebJP9YwIcZKiOBH7822/WWEsyAWdghhqY9RMjGYTHINxlmDxOSE3W7+QCsUV6f
         za4Jny0ltV86YcGtCDBr9pSp/lo9CRlb4QJ/YM9eq+4du0Uz5CyUUbRU/qb+U/jtPw7N
         MiaIqmBXoY/7wATT2S5n4fFzCftwWrojNZZVWfa1/iBPmJmiPDKr0i0vyMAzJzhrLidA
         SFI7fc8rCWSX21wro//hhUFw6DPvyKCqvssV48BuUI4RAmLmeO4H61KxtYgB1mKfRxuK
         VHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698610989; x=1699215789;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HNdsCo+vMheZ6VmPMr0gKwMOp+OninhIfK7w4fFsKHg=;
        b=fhpmI6uisA5j8UMfksqeiXAjl7HHsYGmFz3q8JlfFcxSkvMJG0kYyL7AH3xZqkfSOz
         f1mnQR/l2M5zLthmI0KX8eTjqIypAZ+fOECxWUV+BJDaWgTWJdOTLYb06NDfFccl0lNJ
         ZPVskSBSWX4dHtXcngYvdbqn++cxXeHvfpBoX9BdLXQ4q52w0f+v7lDa8gI2FmzdW0l5
         vXaD5lTD7JEHNirGwQhZ8DHFCL4eqRO/Tfb0V0mAiEHnocVrncN6nEJZid6giXEzLJpU
         hUBiJ2sOyl0lTK364ijbvAv6hb51tDZmsAhrDMSG9P4oIXTj7QVnBZyGUUA8LPiFwmfW
         mm0Q==
X-Gm-Message-State: AOJu0YzthUk4Rfo0TjD5TuDbLSHg+zlosTcqhwA68UyfZN+vYwCS7DOi
	Of+4ZQ51jJI1EqOEx4TtznQb6bx4Pcs=
X-Google-Smtp-Source: AGHT+IFQyqpbABS1pvWVlM5kP4Bb1FLpd6kbGXovwg8M5+duu7/cflR+PUxxQjChe+Lhw/JAk9EaDA==
X-Received: by 2002:a05:6000:186c:b0:32f:7c4a:4f28 with SMTP id d12-20020a056000186c00b0032f7c4a4f28mr3670176wri.65.1698610989074;
        Sun, 29 Oct 2023 13:23:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z9-20020a5d44c9000000b00327b5ca093dsm6666513wrr.117.2023.10.29.13.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Oct 2023 13:23:08 -0700 (PDT)
Message-ID: <pull.1602.git.git.1698610987926.gitgitgadget@gmail.com>
From: "Aditya Neelamraju via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 29 Oct 2023 20:23:07 +0000
Subject: [PATCH] chore: fix typo in .clang-format comment
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
Cc: Aditya Neelamraju <adityanv97@gmail.com>,
    Aditya Neelamraju <adityanv97@gmail.com>

From: Aditya Neelamraju <adityanv97@gmail.com>

Signed-off-by: Aditya Neelamraju <adityanv97@gmail.com>
---
    chore: fix typo in .clang-format comment

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1602%2Faneelamr%2Fclang-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1602/aneelamr/clang-v1
Pull-Request: https://github.com/git/git/pull/1602

 .clang-format | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/.clang-format b/.clang-format
index c592dda681f..3ed4fac753a 100644
--- a/.clang-format
+++ b/.clang-format
@@ -83,9 +83,9 @@ BinPackParameters: true
 BreakBeforeBraces: Linux
 
 # Break after operators
-# int valuve = aaaaaaaaaaaaa +
-#              bbbbbb -
-#              ccccccccccc;
+# int value = aaaaaaaaaaaaa +
+#             bbbbbb -
+#             ccccccccccc;
 BreakBeforeBinaryOperators: None
 BreakBeforeTernaryOperators: false
 

base-commit: 2e8e77cbac8ac17f94eee2087187fa1718e38b14
-- 
gitgitgadget
