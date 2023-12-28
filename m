Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AA16131
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 04:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3NVYj61"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40d5b159497so18441525e9.1
        for <git@vger.kernel.org>; Wed, 27 Dec 2023 20:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703739333; x=1704344133; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBn14IT4/vIp0ajBOo2jBfCf7O7dESwOExxMEXpgvo4=;
        b=g3NVYj61+kpcjH7XygffdNkEyJisDSpriIQlDgb5mwunG5H5TEGvHrIa0DQfBa7tFZ
         0TmpPHS7pGsnpzvCZziDFayXzlNpJ6IR2cbVp9qiLe5HFcoybynBVPgP0DdhmS4s6f54
         fXf3lsIScVKm5fbTsiy+YoUUT3zCLxWeCwJCQ3D8b3XnS2FJutIPjAgZrhUmWgVikM8u
         peSUY9opWjRZ15jtq0ZUZ+8HO3RBcP0LdP4pDmNHi5yKEJeFT42K7sbzvzXeW9MTIzgg
         MNTMk1VqKRx2vzinik4QDDGWAgRnANeOZq8ahDbvbYqI8NhgPBpILgQfY/YdA0Lhf6WZ
         IB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703739333; x=1704344133;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBn14IT4/vIp0ajBOo2jBfCf7O7dESwOExxMEXpgvo4=;
        b=X9k20Wcqpotb/rtb7SUnTTODIdAOl6fSpDYCAFv96fy7EZJWY7lxSbKHUNJTZ8ETWz
         v6gZ/v2LfLq+jvs+Quirnhi6wPDsX7ROYmuq3bRgXQkbpDClm22KJs/Ysg596h9ZOOtr
         +9dYwreyEWxOeeMUjeyyv07JkjXD1n6J4EbVlGFTZxPMEkeXQUfhdBHfHj28phhGlNuz
         sVJE6gOWgXgsc6kiXF37bzc5Sm+HLrNW7tpgxHYYgNAiGhhmTIP0E52Z/J4rZVNBMHBN
         Ae2MzTLwHCaYetELr8PDS9xhLT3Ej+hQAdVHZCUvtCcfg72r/Pq3t5m7bnL4atKmZaz5
         Vd6A==
X-Gm-Message-State: AOJu0YwKhM4cqadioRkxP0gZlwp6NjiFpz3o/ZXZLQHqKSBS2oJOxzXa
	lH8FY/IJPyKXfAcwjGwtox1WXBp8vg4=
X-Google-Smtp-Source: AGHT+IEOeeGJ+Wd6R33jLraZbfbVsQT67auD35OiBwX1NBGZz/GKPidGmE7QDQa+apDibt+XIadKvg==
X-Received: by 2002:a05:600c:1819:b0:40d:190c:160f with SMTP id n25-20020a05600c181900b0040d190c160fmr3260790wmp.110.1703739333010;
        Wed, 27 Dec 2023 20:55:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n42-20020a05600c502a00b0040b3d8907fesm26226384wmr.29.2023.12.27.20.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 20:55:32 -0800 (PST)
Message-ID: <49cef6f7c20d79ef217b345364ce9f7143bf7b7d.1703739324.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1623.v3.git.1703739324.gitgitgadget@gmail.com>
References: <pull.1623.v2.git.1703176865.gitgitgadget@gmail.com>
	<pull.1623.v3.git.1703739324.gitgitgadget@gmail.com>
From: "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 Dec 2023 04:55:22 +0000
Subject: [PATCH v3 7/9] SubmittingPatches: clarify GitHub visual
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

GitHub has two general forms for its states, sometimes they're a simple
colored object (e.g. green check or red x), and sometimes there's also a
colored container (e.g. green box or red circle) which contains that
object (e.g. check or x).

That's a lot of words to try to describe things, but in general, the key
for a failure is that it's recognized as an `x` and that it's associated
with the color red -- the color of course is problematic for people who
are red-green color-blind, but that's why they are paired with distinct
shapes.

Signed-off-by: Josh Soref <jsoref@gmail.com>
---
 Documentation/SubmittingPatches | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 94c874ab5e6..0665f89f38c 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -602,11 +602,11 @@ After the initial setup, CI will run whenever you push new changes
 to your fork of Git on GitHub.  You can monitor the test state of all your
 branches here: `https://github.com/<Your GitHub handle>/git/actions/workflows/main.yml`
 
-If a branch did not pass all test cases then it is marked with a red
-cross. In that case you can click on the failing job and navigate to
-"ci/run-build-and-tests.sh" and/or "ci/print-test-failures.sh". You
-can also download "Artifacts" which are tarred (or zipped) archives
-with test data relevant for debugging.
+If a branch does not pass all test cases then it will be marked with a
+red +x+, instead of a green check. In that case, you can click on the
+failing job and navigate to "ci/run-build-and-tests.sh" and/or
+"ci/print-test-failures.sh". You can also download "Artifacts" which
+are tarred (or zipped) archives with test data relevant for debugging.
 
 Then fix the problem and push your fix to your GitHub fork. This will
 trigger a new CI build to ensure all tests pass.
-- 
gitgitgadget

