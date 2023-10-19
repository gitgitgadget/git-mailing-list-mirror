Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BF717FD
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 12:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHnlZeOi"
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCE2A3
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 05:24:41 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c9c5a1b87bso57246295ad.3
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 05:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697718280; x=1698323080; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h79BHGmNPkbt3cR7vJ6fLBC1I2PWxkcWV6bq1poKfnM=;
        b=QHnlZeOiPYLf4o6h39h2WhVkAT5hc3N7EtAFz5RCgiFZskUVXSor7jIxjyvkwR/2EL
         6Zw20xn1KyPZDOIB2hek8CycP2h6/ILUiU9VVdCUegkvM7H1W++Mmx4VihZw11Jx7ECG
         3yTifpWVwGQhKxPNo6NyKAf1/j6XbwEuJ73FhmesXO0SPquVJomTGLqMeSnn5Vt8xc1T
         YpmfjLgbFXZlG1pZKq7CHjq3MrDTLg4dGPERMjfEuvZWRIEn+LA2iS0GpI82hscrwjZE
         ABqW0PC5DraeoBdQi0S93heS1AyZkOzKASBPqeqTO12PF6+9mfJUPPwLyUQ/EIBpkxSK
         q2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697718280; x=1698323080;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h79BHGmNPkbt3cR7vJ6fLBC1I2PWxkcWV6bq1poKfnM=;
        b=FrpYbX6KpBnqcMkzNG6AioGDrQEIRM1jSmfZyd6GXJqDPk7VEGphnLssjrjjTfy/OQ
         0GAX50l4EX7ww/f/YwzggwR2N3jnENfccnNgnZ2lEqDSKTK6sbPAN6Z5VT4uQ3tzlDw0
         /LnblSzeDDxDw4Ljpq5WKlznnAHADQEptK3lI14cu7CW8l01qJXC5BYV/EojLPRZMRWw
         1KEqpwrDWPQFQxOEquvs5Y9aPhur+x7BWfOHHjkXzhw2v+eDf+G4EUS5YtN2PRDvuhO+
         IK+Vd4F6/o4a+1zexg4KnMexDZqZuBjzxTRZyIZCQdlm8gUhSdGg4aQMasdki/9nwMk/
         uEQA==
X-Gm-Message-State: AOJu0YydjIxFwzm7a/K78OXxwWoYZJvITELpGOg7Oni8Dp7re2n8ScOz
	p8fTp79SmZOINojVUbsEJ3TNRopQhYWi+die
X-Google-Smtp-Source: AGHT+IGbgtAMqF8I36ZvtZLMs1Z7tGF7DCMSr20iHJ3B7Xv+VFIOAwcyo5GBzrsTy6b+8p+xofirUw==
X-Received: by 2002:a17:902:da92:b0:1c6:2d13:5b74 with SMTP id j18-20020a170902da9200b001c62d135b74mr2629988plx.55.1697718279947;
        Thu, 19 Oct 2023 05:24:39 -0700 (PDT)
Received: from smtpclient.apple (ec2-54-254-241-62.ap-southeast-1.compute.amazonaws.com. [54.254.241.62])
        by smtp.gmail.com with ESMTPSA id z4-20020a170902708400b001bb9f104328sm1815818plk.146.2023.10.19.05.24.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Oct 2023 05:24:39 -0700 (PDT)
From: =?utf-8?B?546L5bi45paw?= <wchangxin824@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: [PATCH] typo: fix the typo 'neeed' into 'needed' in the comment under
 merge-ort.c
Message-Id: <2DB9ED79-FE58-4072-91E0-B4C51A3F6C5B@gmail.com>
Date: Thu, 19 Oct 2023 20:24:24 +0800
Cc: Wangchangxin <1571825323@qq.com>,
 foril <1571825323@qq.com>
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3774.100.2.1.4)

From: foril <1571825323@qq.com>

Signed-off-by: =E7=8E=8B=E5=B8=B8=E6=96=B0 (Wang Changxin) =
<foril@foril.space>
---
   typo: fix the typo 'neeed' into 'needed' in the comment under =
merge-o=E2=80=A6

   the comments on line 2039 under merge-ort.c should be :
   this is needed if we have content merges of content merges rather =
than
   this is neeed if we have content merges of content merges

   fix the typo

Published-As: =
https://github.com/gitgitgadget/git/releases/tag/pr-git-1592%2FforiLLL%2Fc=
omment_patch-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git =
pr-git-1592/foriLLL/comment_patch-v1
Pull-Request: https://github.com/git/git/pull/1592

merge-ort.c | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 7857ce9fbd1..aee6f7d8173 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2036,7 +2036,7 @@ static int handle_content_merge(struct =
merge_options *opt,
	 * the three blobs to merge on various sides of history.
	 *
	 * extra_marker_size is the amount to extend conflict markers in
-	 * ll_merge; this is neeed if we have content merges of content
+	 * ll_merge; this is needed if we have content merges of content
	 * merges, which happens for example with rename/rename(2to1) =
and
	 * rename/add conflicts.
	 */

base-commit: a9ecda2788e229afc9b611acaa26d0d9d4da53ed
--=20
gitgitgadget

