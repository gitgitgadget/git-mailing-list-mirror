Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9146F5823D
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 16:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlmOprKD"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33621d443a7so978050f8f.3
        for <git@vger.kernel.org>; Thu, 21 Dec 2023 08:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703176871; x=1703781671; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZJmQEl1AJu+X+/7ItiH2PLw1DdEwsjNopB/9zc4/nk=;
        b=YlmOprKDl5KoEeLipOV9Qo5pyjMTPbHk8YlEMiADXg/+ocY1++pM5LBziQO95cNoPy
         plp4TKVaYRkSeBb/IONRp9yX8Yp0Qhxj3Flov0q4kD7f8xl1DR4jH2MjeGH0EZmDOTyx
         /nriQ9axUeVjj4wyaUen/uDG/yIJHoPBSkSy8lxLRXYailm7RKLAsOOy9tSiylUI4qIc
         Yjvd2Us5e2FkmvIiEwauXsgB4YpWKWk172OVH09BbfFiPPhRpuYjSsE/5ghFj8e/tAeL
         u3/VxPlMQ0Id46MrQ2EoT5F6qnerD6SshHxWPCt5QdUUVYvqsorxYK/kX4rOHj4QgVYb
         ZdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703176871; x=1703781671;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZJmQEl1AJu+X+/7ItiH2PLw1DdEwsjNopB/9zc4/nk=;
        b=jRuEKl+gLowxSo6RuTfCMe9zgxbxMqze6RyWmDOlAGkd0K1PtZjMOvFvXA1ty/8pSR
         l/jWNQkCArq59hg7JSoXdfNjDcM7IG6WTDWH1KfegJWyHyu1TuZu+N5oEgEcyzSAOiG4
         /8wWclIuFmdS8qwGEILa7mCGVHuY3fgXWoDL76PiOIckJWT2NxW8QM5et4s3m+PUMLL+
         Fm/Trekx4dcHZpXKtonOurkoglauDNSSRJKCKFb3bh+oM5cjquerMoL9nFPCtcJCoRNs
         zY6Hh7/P8cpr9Tbse/S/NinSsTTArNnC9FcLQoc+RvEI/Pd76lAIeLNGEealUHcrcIi6
         Q99Q==
X-Gm-Message-State: AOJu0YzRm1QN4bIRrr9g9BHqsXDb+ttAIzqAvGevDz9Fg6ap21VwcHnP
	xK+4sVmO9TF26FeNpWZKmGLVxcmIG2E=
X-Google-Smtp-Source: AGHT+IEF264J8FAeLtN9BhbJsMV/OmnIal4zXZyc7psLZ6ss5VDojkEw3hc+vVA/5F/41BUC08nAeg==
X-Received: by 2002:a05:600c:519b:b0:40d:41bd:3dad with SMTP id fa27-20020a05600c519b00b0040d41bd3dadmr446wmb.80.1703176871537;
        Thu, 21 Dec 2023 08:41:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a3-20020a056000100300b003368d2e729bsm710306wrx.43.2023.12.21.08.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 08:41:10 -0800 (PST)
Message-ID: <8848572fe2c7432ede85e042bc2558fd8b3e8b1d.1703176866.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1623.v2.git.1703176865.gitgitgadget@gmail.com>
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
	<pull.1623.v2.git.1703176865.gitgitgadget@gmail.com>
From: "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 21 Dec 2023 16:41:01 +0000
Subject: [PATCH v2 5/9] SubmittingPatches: update extra tags list
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

