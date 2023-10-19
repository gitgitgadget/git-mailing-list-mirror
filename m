Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8453C225B6
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 12:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxxztXCx"
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5ACBE
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 05:40:19 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c50d1b9f22so76062171fa.0
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 05:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697719217; x=1698324017; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Rou4hccZK8UzIkFbhFlPYVOErvLFP0pkFBDEY8V7lY=;
        b=YxxztXCxzPaL9U9H0O5QLq6ZQ3wfpyh0myodfN68sL2lHgKwQ4qqLhCinXUJUO/T+7
         XvJTpU9nx7hggkUj53NYdef1mBSywFdSJ/vYD6Lm3YlEfT/q6dGoJ7hD/9qTco8GaXHF
         jbqyGRy2Qa4M/9dBBH55Zf5QBSB8hbICFOEgAbqQHMdFRel0BHhs0Ne/nZ/TCAQ+MO0s
         //llr+xkrp3/AEDwGZj8bEDpiXgKNwtINepm/1IRZPqLoID4+7HTPFrrgLx38/cU3lsV
         AOyLnOhOEIiaBvabAW0QnY0KPA6OXrsm6eqpr7M8wnxBKj2QdDvPLArkYt5h86TACXFo
         kezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697719217; x=1698324017;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Rou4hccZK8UzIkFbhFlPYVOErvLFP0pkFBDEY8V7lY=;
        b=YA3ysCyikq2jBtFqykvuXQiCz/KCi0J03ugd6aR54B2FWCJLfnp4vWuHYlku4RRHex
         HzBiyaajplAkYpbaywEp3Y0OJMU72Tvxg3H4hLQpAwR6ehznYPelWjpcTGVktohslosA
         zksjl3I67qKfJJGsm+pZ/Faf7JKPmui/H5l68HlN+DfMMHu2sRwjdd63rGiC1Dorual+
         TN14m0hxKw+hF+Y4HyxuIPCtEZAIh9XnrWCZH677OZO90eudYuiGDDT+8PQb8pX0LzY3
         3UvsBb3vdblyrGp+z8u+AruOa0PELqMOIJdZBnpYRH94YR6nH+pgeivLpDEX/1KiAQj7
         oIWA==
X-Gm-Message-State: AOJu0YwlsxYGfFSdnRmT0sJsxP+1IeTQUwKLL64V9f2XJo7giKYiOUNu
	pcw08xTZuypm52T3TAdQTBSmIoz62QQ=
X-Google-Smtp-Source: AGHT+IFDmfCaMT0ozOWSj0XrDQhU2x7xxtp4sAbuJjWFKAdyH32aKspSQoYttgXH0SGUQCOZLiZxjg==
X-Received: by 2002:a2e:a4b0:0:b0:2c0:a0c:be7 with SMTP id g16-20020a2ea4b0000000b002c00a0c0be7mr1230061ljm.8.1697719217329;
        Thu, 19 Oct 2023 05:40:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c4e8700b00403b63e87f2sm4437050wmq.32.2023.10.19.05.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 05:40:16 -0700 (PDT)
Message-ID: <pull.1592.v2.git.git.1697719216137.gitgitgadget@gmail.com>
In-Reply-To: <pull.1592.git.git.1697378928693.gitgitgadget@gmail.com>
References: <pull.1592.git.git.1697378928693.gitgitgadget@gmail.com>
From: "Wangchangxin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 19 Oct 2023 12:40:15 +0000
Subject: [PATCH v2] merge-ort.c: fix typo 'neeed' to 'needed'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Wangchangxin <wchangxin824@163.com>,
    foril <1571825323@qq.com>

From: foril <1571825323@qq.com>

Signed-off-by: 王常新 (Wang Changxin) <foril@foril.space>
---
    typo: fix the typo 'neeed' into 'needed' in the comment under merge-o…
    
    the comments on line 2039 under merge-ort.c should be :
    this is needed if we have content merges of content merges rather than
    this is neeed if we have content merges of content merges
    
    fix the typo

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1592%2FforiLLL%2Fcomment_patch-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1592/foriLLL/comment_patch-v2
Pull-Request: https://github.com/git/git/pull/1592

Range-diff vs v1:

 1:  737eccd2811 ! 1:  3934ee6b684 typo: fix the typo 'neeed' into 'needed' in the comment under merge-ort.c
     @@ Metadata
      Author: foril <1571825323@qq.com>
      
       ## Commit message ##
     -    typo: fix the typo 'neeed' into 'needed' in the comment under merge-ort.c
     +    merge-ort.c: fix typo 'neeed' to 'needed'
      
          Signed-off-by: 王常新 (Wang Changxin) <foril@foril.space>
      


 merge-ort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 7857ce9fbd1..aee6f7d8173 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2036,7 +2036,7 @@ static int handle_content_merge(struct merge_options *opt,
 	 * the three blobs to merge on various sides of history.
 	 *
 	 * extra_marker_size is the amount to extend conflict markers in
-	 * ll_merge; this is neeed if we have content merges of content
+	 * ll_merge; this is needed if we have content merges of content
 	 * merges, which happens for example with rename/rename(2to1) and
 	 * rename/add conflicts.
 	 */

base-commit: a9ecda2788e229afc9b611acaa26d0d9d4da53ed
-- 
gitgitgadget
