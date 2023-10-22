Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489F536D
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 02:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmCdCbLP"
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989E7DE
	for <git@vger.kernel.org>; Sat, 21 Oct 2023 19:46:11 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40842752c6eso17614795e9.1
        for <git@vger.kernel.org>; Sat, 21 Oct 2023 19:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697942770; x=1698547570; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TuAe/1D9girOuXDRwF8JygfzAwm35kUOboiBzvO6UNY=;
        b=EmCdCbLP4xNto+HcBejW0wKjBC/7Cq3GaRq5IMuPYUPoSDsftGHNJr+PDgM+e92obs
         81Ed8qr0ecPX0lzEC3o/O2oGq2r4MPGnGYFxAT29raLBQFjovp+5XiuJrxIASUnKauEl
         vD6VUSN0ETnPT/zigd33E9J+H3l60bowkJo0Ac+/jgpb6sJWMZgBUrP5Od75BD9RWKl0
         AZDqLshzPh+KLAhlfyEDhPvg8CLzpyiMepJ5u6NhOA1kdikWPUSpe1UxU02rhKZKpf0I
         0biGiyTSG3mgGW179uu0dZxT/XVQPGIVk7YwtTslkrEWuJTrqU0wW10knCDXtczQfIh/
         1i4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697942770; x=1698547570;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TuAe/1D9girOuXDRwF8JygfzAwm35kUOboiBzvO6UNY=;
        b=tVBfSvE/iEGR2u1rU8qJd8oTzw+B97IdhMRnzJhjx5YP92yWpuLKw7fAw3YlmFob8a
         mzbWyfjOzwItpgJ9Va7yBa7OnEEw2io1CLkOxbp0nWc/y87sEboE4SijSLkm/VeuG61L
         GHENzpnRpi10rYWcLR6jKmMXihoLqbB+ZXBnXMhRxexlhsQKZd4Q9uPj/gAeeSH5HD8E
         25qJAyc1fVed0xs1ozrIEIFicGBKP8jVYVRkG3Sy/KMt8SJ89+aZtsNaNIHk5iFFjRnO
         jxstqOvPTIKuhZ8QVuhlEOZuMebA/fQUChcxibtlAUZxYoqB9dOuEEK7Atw8dp8z96Pd
         3hCA==
X-Gm-Message-State: AOJu0YxanzFdLBxeiNCewys2VtLihyaTgGDr/+BxQt9MOU+9ArER9WXA
	+vSPt+W/uQjLLCZa9vcIc//lJ5ixiJM=
X-Google-Smtp-Source: AGHT+IF7kLSNvVBEqLr0XgaRUJPBcDPZDBGO5MPHw2RZ/NjqpX4xDTMU9Jd1XLhCq2Uz8pDBMZi77w==
X-Received: by 2002:a05:600c:1c21:b0:402:8c7e:ba5 with SMTP id j33-20020a05600c1c2100b004028c7e0ba5mr4652446wms.18.1697942769487;
        Sat, 21 Oct 2023 19:46:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j14-20020a05600c130e00b0040772934b12sm10499527wmf.7.2023.10.21.19.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 19:46:09 -0700 (PDT)
Message-ID: <pull.1592.v3.git.git.1697942768555.gitgitgadget@gmail.com>
In-Reply-To: <pull.1592.v2.git.git.1697719216137.gitgitgadget@gmail.com>
References: <pull.1592.v2.git.git.1697719216137.gitgitgadget@gmail.com>
From: "Wangchangxin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 22 Oct 2023 02:46:08 +0000
Subject: [PATCH v3] merge-ort.c: fix typo 'neeed' to 'needed'
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
    =?UTF-8?q?=E7=8E=8B=E5=B8=B8=E6=96=B0?= <wchangxin824@gmail.com>

From: =?UTF-8?q?=E7=8E=8B=E5=B8=B8=E6=96=B0?= <wchangxin824@gmail.com>

Signed-off-by: 王常新 (Wang Changxin) <wchangxin824@gmail.com>
---
    typo: fix the typo 'neeed' into 'needed' in the comment under merge-o…
    
    the comments on line 2039 under merge-ort.c should be :
    this is needed if we have content merges of content merges rather than
    this is neeed if we have content merges of content merges
    
    fix the typo

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1592%2FforiLLL%2Fcomment_patch-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1592/foriLLL/comment_patch-v3
Pull-Request: https://github.com/git/git/pull/1592

Range-diff vs v2:

 1:  3934ee6b684 ! 1:  9320154b91a merge-ort.c: fix typo 'neeed' to 'needed'
     @@
       ## Metadata ##
     -Author: foril <1571825323@qq.com>
     +Author: 王常新 <wchangxin824@gmail.com>
      
       ## Commit message ##
          merge-ort.c: fix typo 'neeed' to 'needed'
      
     -    Signed-off-by: 王常新 (Wang Changxin) <foril@foril.space>
     +    Signed-off-by: 王常新 (Wang Changxin) <wchangxin824@gmail.com>
      
       ## merge-ort.c ##
      @@ merge-ort.c: static int handle_content_merge(struct merge_options *opt,


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
