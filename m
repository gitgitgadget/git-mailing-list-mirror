Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A179468A
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 04:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4lensw4"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40d4103aed7so70105965e9.3
        for <git@vger.kernel.org>; Wed, 27 Dec 2023 20:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703739331; x=1704344131; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZJmQEl1AJu+X+/7ItiH2PLw1DdEwsjNopB/9zc4/nk=;
        b=I4lensw4/W1s2/2Ef86YMb7+7MtEs0v2B7HYmLnVOaal64XWKD6dyXkxqO7DzV8uVN
         ex5rej3p4Gv3XIJsWEp+9yjDDBEzOhBKH2gW9FUGHA30sFUywfUV5kKUguYvz53FfjmI
         dOpWMBcb25U1w4Rw6xEJb3u4Bc28jND4+vbLDs4svOKI/jqO1JLwWLDIn3nTbsOg8rnT
         TTlmaaXjQaTt7oujfiXA+DzjCJZADyBmxrKnbkoHF+nbNVwfRNAuXylzxeJ8NpoeV/6y
         xFtwn2Tfcz2pOzD9OCr6zb7o58HRNaJNWA9vm+NW6HLhnimMNS5kVrsZC42YaQPf0QZi
         uoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703739331; x=1704344131;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZJmQEl1AJu+X+/7ItiH2PLw1DdEwsjNopB/9zc4/nk=;
        b=X0HI3jUhcWg0gaSfVR+MhbdY+GR5r+uYB8XAFTiYQC7HCx9jlMQMD0E5M3q1l6szn6
         7IJe97L8V/ni5YTMG83zeSh1+OnxmdMNXHjC6ceg5cKJF72lznai+Fm3kdNwPt7Tc/Hp
         Gvci2+9LTUAI41MthidM7Du3hcTHqQiQvUGyrha4tLc0P3/MyMLYTjiq43x6ajOKZ4vL
         JBIlk4RyufVyH2qNQLvWBHdjZXgzbwEUx0UlyAucXNyBFq/Ud6w+eSpk7NrcYXW/8z0l
         nGYKqu3CfHhtro0yt1gzZXRHy3VBR9FWcmalni279+YxUUNEdGonGmsFpDzPhf9ZmWYO
         As0Q==
X-Gm-Message-State: AOJu0YwPpFM3ysmJLXnGvCvVNlJ63mbgS5K1Od9lO9WiKuJLmtgXAatu
	g0IfcXki/fz7mRV7cupQoq51rI1/4gs=
X-Google-Smtp-Source: AGHT+IEBmI7JRftSjvDsaq5ZFefhYVC5B0nPyh5FUuLO/VXGHMk/zrxvZD+V+4dtM+n3fGacpaJe8Q==
X-Received: by 2002:a05:600c:314c:b0:40d:5f35:5294 with SMTP id h12-20020a05600c314c00b0040d5f355294mr1076523wmo.26.1703739330634;
        Wed, 27 Dec 2023 20:55:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s23-20020adf9797000000b00336813bb588sm16310509wrb.111.2023.12.27.20.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 20:55:30 -0800 (PST)
Message-ID: <8848572fe2c7432ede85e042bc2558fd8b3e8b1d.1703739324.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1623.v3.git.1703739324.gitgitgadget@gmail.com>
References: <pull.1623.v2.git.1703176865.gitgitgadget@gmail.com>
	<pull.1623.v3.git.1703739324.gitgitgadget@gmail.com>
From: "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 Dec 2023 04:55:20 +0000
Subject: [PATCH v3 5/9] SubmittingPatches: update extra tags list
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
    =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Josh Soref <jsoref@gmail.com>,
    Dragan Simic <dsimic@manjaro.org>,
    Josh Soref <jsoref@gmail.com>,
    Josh Soref <jsoref@gmail.com>

From: Josh Soref <jsoref@gmail.com>

Add items with at least 100 uses in the past three years:
- Co-authored-by
- Helped-by
- Mentored-by
- Suggested-by

git log --since=3.years|
  perl -ne 'next unless /^\s+[A-Z][a-z]+-\S+:/;s/^\s+//;s/:.*/:/;print'|
  sort|uniq -c|sort -n|grep '[0-9][0-9] '
  14 Based-on-patch-by:
  14 Original-patch-by:
  17 Tested-by:
 100 Suggested-by:
 121 Co-authored-by:
 163 Mentored-by:
 274 Reported-by:
 290 Acked-by:
 450 Helped-by:
 602 Reviewed-by:
14111 Signed-off-by:

Signed-off-by: Josh Soref <jsoref@gmail.com>
---
 Documentation/SubmittingPatches | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 58dfe405049..31878cb70b7 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -355,6 +355,14 @@ If you like, you can put extra tags at the end:
   patch after a detailed analysis.
 . `Tested-by:` is used to indicate that the person applied the patch
   and found it to have the desired effect.
+. `Co-authored-by:` is used to indicate that people exchanged drafts
+   of a patch before submitting it.
+. `Helped-by:` is used to credit someone who suggested ideas for
+  changes without providing the precise changes in patch form.
+. `Mentored-by:` is used to credit someone with helping develop a
+  patch as part of a mentorship program (e.g., GSoC or Outreachy).
+. `Suggested-by:` is used to credit someone with suggesting the idea
+  for a patch.
 
 While you can also create your own trailer if the situation warrants it, we
 encourage you to instead use one of the common trailers in this project
-- 
gitgitgadget

