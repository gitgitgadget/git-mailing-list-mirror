Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3993F4DA
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 23:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOiYiGNJ"
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA7BD49
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 16:16:12 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-41cc7379b23so9945301cf.3
        for <git@vger.kernel.org>; Thu, 26 Oct 2023 16:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698362171; x=1698966971; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oSJ4AnqGGLU7aUUGUC3lJm/lpp+yIKsd7le7Po4eT+g=;
        b=QOiYiGNJHRDTCgbxlpp1cPzf/KtPPFFXzmrDgxFMKbRgLYIKQpwxLi6HEC3Vuzui43
         /weehecsxFSJPddSRwB7ih/+OiS50s53LZFDCJMAU/gz/sxqyxMvTGrUmrAzrF0+uubu
         RInKWwBuklCu1NQTohu04u9MKbxVKy0P3BFDyoP2M7tUqGIVHr/zojLoH3eaOBwiHClh
         BrHYlDe5RLZtjpSBiKx9QmvK+mqhsOBmVL1/xs+NbKd445mO/I0fwEJO5fmLTklLaOz9
         15p7FWDdM/j9h0+y9d++eydb1gP1qX3rvVV9KRCpDXpa12ARzOqhjdfMOlxtSYzGkh5f
         Bz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698362171; x=1698966971;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSJ4AnqGGLU7aUUGUC3lJm/lpp+yIKsd7le7Po4eT+g=;
        b=rzsos9LVOfKrMM50ElYGSzCP6oFuZfPFP+Vj688/EredzxZq46JBjwQI61zTNcfGPd
         2Ke0t0a20naJMMoX15jRdyhEpCVA1ywggFrjz3XiebkJUeaEfGdQ3K8QfAeyHemuZT0H
         8pgapFC3xj5Il9ivet76fxm3ftacJ2zLeTk/At1W8L05PKDYWY2bl0ELoLcAc1M8uNRT
         qHyASsdVLWKMhVKoOseOLIANVcUJprP/sEOOOaT0O42Q3qrrPRCiBpTaCzPJTA1WWKyL
         C/MvAlH8CH9+CjF4Jw6i3guiarnY1PHi8yG0LHFP8wgICTlkiBjHjJkKUuCINVwO4Qq+
         ke9w==
X-Gm-Message-State: AOJu0YywlYaHNqHXLQh0Ta0p09MMc9YPCD9HP5CXihPoQrSKtXGO50wa
	v5Ya4FoGpUBkTRxF5/pFXDBszy8lqj8=
X-Google-Smtp-Source: AGHT+IHLsCK50sbkc3+I6VFpOxPrLiNDQfxZHj0MYaKJdnKK145rw6JHbbeYQZvxuGBIAuqjUTujtA==
X-Received: by 2002:ac8:7f15:0:b0:41c:dd22:e7c0 with SMTP id f21-20020ac87f15000000b0041cdd22e7c0mr1173161qtk.29.1698362170744;
        Thu, 26 Oct 2023 16:16:10 -0700 (PDT)
Received: from [192.168.0.16] (modemcable063.135-226-192.mc.videotron.ca. [192.226.135.63])
        by smtp.gmail.com with ESMTPSA id do10-20020a05622a478a00b004181b41e793sm132459qtb.50.2023.10.26.16.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 16:16:09 -0700 (PDT)
From: Liam Beguin <liambeguin@gmail.com>
Date: Thu, 26 Oct 2023 19:16:04 -0400
Subject: [PATCH 1/2] doc: pretty-formats: add missing word
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231026-pretty-email-domain-v1-1-5d6bfa6615c0@gmail.com>
References: <20231026-pretty-email-domain-v1-0-5d6bfa6615c0@gmail.com>
In-Reply-To: <20231026-pretty-email-domain-v1-0-5d6bfa6615c0@gmail.com>
To: git@vger.kernel.org
Cc: Liam Beguin <liambeguin@gmail.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698362168; l=1442;
 i=liambeguin@gmail.com; s=20230824; h=from:subject:message-id;
 bh=DoVIocbe5T4bT2zJEY/EfX8lolv9lpoJDdhHxsOYd+s=;
 b=W2EOmwYcokjPESMZrwX8r+rVTsihyFAJHCSV6JDAO7961zuuTwt5toLb6DAMfs0mdAHteslln
 9H9Wg17glh3BBeyNj//E8q9Qz1e/yG1ccjMXHN6V7RMy4O3XjTAKJCD
X-Developer-Key: i=liambeguin@gmail.com; a=ed25519;
 pk=x+XyGOzOACLmUQ7jTEZhMy+lL3K5nhtUH6Oxt+tHkUQ=

Follow %al and %cl and make sure to mention it's the 'email' local-part.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 Documentation/pretty-formats.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index d38b4ab5666c..a22f6fceecdd 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -193,7 +193,7 @@ The placeholders are:
 '%aE':: author email (respecting .mailmap, see linkgit:git-shortlog[1]
 	or linkgit:git-blame[1])
 '%al':: author email local-part (the part before the '@' sign)
-'%aL':: author local-part (see '%al') respecting .mailmap, see
+'%aL':: author email local-part (see '%al') respecting .mailmap, see
 	linkgit:git-shortlog[1] or linkgit:git-blame[1])
 '%ad':: author date (format respects --date= option)
 '%aD':: author date, RFC2822 style
@@ -211,7 +211,7 @@ The placeholders are:
 '%cE':: committer email (respecting .mailmap, see
 	linkgit:git-shortlog[1] or linkgit:git-blame[1])
 '%cl':: committer email local-part (the part before the '@' sign)
-'%cL':: committer local-part (see '%cl') respecting .mailmap, see
+'%cL':: committer email local-part (see '%cl') respecting .mailmap, see
 	linkgit:git-shortlog[1] or linkgit:git-blame[1])
 '%cd':: committer date (format respects --date= option)
 '%cD':: committer date, RFC2822 style

-- 
2.39.0

