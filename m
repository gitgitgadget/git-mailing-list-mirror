Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17296FA6
	for <git@vger.kernel.org>; Sun, 15 Oct 2023 14:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PI5O7dwP"
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58B0C1
	for <git@vger.kernel.org>; Sun, 15 Oct 2023 07:08:51 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4060b623e64so22569485e9.0
        for <git@vger.kernel.org>; Sun, 15 Oct 2023 07:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697378930; x=1697983730; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZDE43Prm5ICylZKVQBbRhA0M+EruasqvtuQYPhU4nA=;
        b=PI5O7dwPTyXl/vYab11vvJcFTHedse9OmRzWKilmbW1wxEVq+4wwOvJWI0QkiDrQfA
         8ys7m7qvjHSZmP4WMbDgMF6pOgVa8mt/d5IngCB8g5L7+ZSQN63qTOWWvBD8rrANZd2X
         OLwFViQq1GjbgDWzPdYqXg5G3bgT3tTdYH+5w9fnNCt9TmDAr/oGetIUr0EeuFvM0Twr
         TvjS65kWkiUbWUKcPHKYAXjliKG1VsNoqgsgjECny3r4mBrVTv3PqlFeu3Cc2nFi8PbE
         ZgVSmW/DgIC6rs022Jm+bscqeyPk6ZJZa6L0jAaZS0rhFo1enV7vs5jibF5boFQhRxZB
         ruDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697378930; x=1697983730;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ZDE43Prm5ICylZKVQBbRhA0M+EruasqvtuQYPhU4nA=;
        b=Oa7DbGFcr/SLY6smvdf+/PNQW/1mKZq2U8LdPJTMMvq4WxdiyYtlV5p+RawCIxyeFv
         jPEFL74279dZbRjf2wFoI0GbvNQn97i75k3w0pwZHnan9ZYmUaoEUXNifcvfduV2H/Tk
         EY5wrTRnS7rrEYu68EpfpdYk+UEsVayWPOqEpDPNrrMhLt41iOvAikfk//TApNPHYEQ2
         9DbJ1JaHSiALn3BXgQjMrLG6cd/pzvnSwPQlQr3nY/FLcYQnJAIefpB2VTEa03JWCU4U
         /KGQV/IDn0wtnm24KPIy5Gr+dx3i4qsfnNS5iFCL7POOhygYWJ7P1OOwJXHVX9YJVuG6
         P2EQ==
X-Gm-Message-State: AOJu0Yyu+GvCUtuhNamomnGwVFUxDU2q47WRpz2s0eiHLW3fYzSKcycF
	yCZ977bJTWIfti495XtVYtPNVXu4WHs=
X-Google-Smtp-Source: AGHT+IEdy/xskDEj0wH3NvxIiXWrWNI9XRkbDbvNRT5N2TOyMi452rbFIBKYwo9f6I6KHeVzPWxaBg==
X-Received: by 2002:a05:600c:1e0a:b0:406:45c1:4dd with SMTP id ay10-20020a05600c1e0a00b0040645c104ddmr3827458wmb.14.1697378929769;
        Sun, 15 Oct 2023 07:08:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f18-20020a05600c4e9200b004064288597bsm4611470wmq.30.2023.10.15.07.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 07:08:49 -0700 (PDT)
Message-ID: <pull.1592.git.git.1697378928693.gitgitgadget@gmail.com>
From: "Wangchangxin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 15 Oct 2023 14:08:48 +0000
Subject: [PATCH] typo: fix the typo 'neeed' into 'needed' in the comment under
 merge-ort.c
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
Cc: Wangchangxin <1571825323@qq.com>,
    foril <1571825323@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: foril <1571825323@qq.com>

Signed-off-by: 王常新 (Wang Changxin) <foril@foril.space>
---
    typo: fix the typo 'neeed' into 'needed' in the comment under merge-o…
    
    the comments on line 2039 under merge-ort.c should be :
    this is needed if we have content merges of content merges rather than
    this is neeed if we have content merges of content merges
    
    fix the typo

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1592%2FforiLLL%2Fcomment_patch-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1592/foriLLL/comment_patch-v1
Pull-Request: https://github.com/git/git/pull/1592

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
