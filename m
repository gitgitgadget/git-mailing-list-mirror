Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8F5FC0E
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 13:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAR41DLn"
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD7CE6
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 06:40:32 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32d81864e3fso3566649f8f.2
        for <git@vger.kernel.org>; Tue, 31 Oct 2023 06:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698759630; x=1699364430; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhbCMbk4OYV1pDq4SOz5L1zbEJa1k4da4AgGhIPZw/k=;
        b=IAR41DLnL4fUOteT3Vnl7K60gC8REM9d5K9zlrCxMYGiUULBV26BTCEcMjrB3D1EAk
         jzdVBxXbURwYMXwQDtbiQFX1kOvtL/n6fwEIMCcPF1fLeI1JxC8/9xxz7nWijoRyG4zR
         0cM0C13u1cY8Vmmxb6cOBc0RR8k80Ji/COqWraYzFYe+d4znD+Yo+dODKDeVxwu95MZf
         bRcUcNP5ex7lsOgckK7f6/gE/1uTFBL2oIpRat8qO04a5sIgbhr8/7Nq0U4T/68gjDJn
         9rjzetCcWaizd5yfUGwn66tCx/c7o7sQHU9MAsnqODwX/nFfmUdx+yDHguwBB/sAywnv
         JKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698759630; x=1699364430;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhbCMbk4OYV1pDq4SOz5L1zbEJa1k4da4AgGhIPZw/k=;
        b=wZWNuFqI0pMeHfJaQd9zo3DXl4NzRQCrP+cVRc/CtUni6M+DO+EVhpiC/vP9soA04L
         jbXsShP2kbLCJhm3WfK5ooMqbtMlmF8aYxs/yKLro0GXYG+hYjsWT4kqYDQeiIcMhKo/
         ecBI6QFVxOyAsa3WKDrqmUM73/+fr4WcwFY7C6Wuzl3zuivVCYAt4RH4ov9CIBHCbZDU
         g0fT5RQ1sNdNuzxIM3rpGsnxf9wxooqnVUIo618Zt5FETZRzSRtFzE+yl/710g9oAF/K
         73buhL4uvi9b9oArSMpX4HywtAceGVwyswJ55b2nOn5FXqwBFinzSJu8a1gKa+ooOJdE
         ie5w==
X-Gm-Message-State: AOJu0YyFYW8L60NRbVKEIm+rbylvljlcttYFTHFZ+DZTGGNcgSGCbAnj
	GivLbfin0cRryd35tjyis1FGbUz0klA=
X-Google-Smtp-Source: AGHT+IE4Hg+S2oQQy5h0ONG+qp28Ha7krcg8cuWwwfdDUMHjxx5m25hOx5+H/b+YSzkzFi0bI6uoqw==
X-Received: by 2002:adf:e7c2:0:b0:32d:ae31:458f with SMTP id e2-20020adfe7c2000000b0032dae31458fmr8955183wrn.30.1698759630110;
        Tue, 31 Oct 2023 06:40:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h12-20020a5d688c000000b00323287186aasm1539140wru.32.2023.10.31.06.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 06:40:29 -0700 (PDT)
Message-ID: <pull.1602.v2.git.git.1698759629166.gitgitgadget@gmail.com>
In-Reply-To: <pull.1602.git.git.1698610987926.gitgitgadget@gmail.com>
References: <pull.1602.git.git.1698610987926.gitgitgadget@gmail.com>
From: "Aditya Neelamraju via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 31 Oct 2023 13:40:28 +0000
Subject: [PATCH v2] clang-format: fix typo in comment
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
    clang-format: fix typo in comment for formatting binary operations.
    
    cc: Taylor Blau me@ttaylorr.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1602%2Faneelamr%2Fclang-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1602/aneelamr/clang-v2
Pull-Request: https://github.com/git/git/pull/1602

Range-diff vs v1:

 1:  e3ff8aa76fe ! 1:  dfb442ea338 chore: fix typo in .clang-format comment
     @@ Metadata
      Author: Aditya Neelamraju <adityanv97@gmail.com>
      
       ## Commit message ##
     -    chore: fix typo in .clang-format comment
     +    clang-format: fix typo in comment
      
          Signed-off-by: Aditya Neelamraju <adityanv97@gmail.com>
      


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
