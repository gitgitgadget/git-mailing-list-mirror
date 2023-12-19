Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2A612E73
	for <git@vger.kernel.org>; Tue, 19 Dec 2023 08:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivHYkXGs"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40c39e936b4so48884575e9.1
        for <git@vger.kernel.org>; Tue, 19 Dec 2023 00:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702975326; x=1703580126; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEk8w6zLthh6eU9WJj7lAhdI382V9ytLfLho6ibFBNY=;
        b=ivHYkXGshNqPZcCM8NnWpefkb+T8VXXfmk92IF7fcy7INJSt7pc83uhxQBj/ows7+h
         blS81dJFta4k10jjBwj6qDISlc1fTcsLA7LV2USrv8hvCQ/tYknHF9Z44dBKDQvTyLmx
         BoI/Wwe+YOAg6F1U0Km3NUkTyF2P6j5z+FjQmSJ5m2VB/4SWJvY0lDP/e15XIeOT6Gjr
         daQQoMh/iIoOC9o7eF6dm/cCo5dxakxjlSFym+FvPdj3V3q6COjKptol2/W16QlhDPH6
         AU47ASnxyCOn07qiI5NCBDImpS59x7fbRG+SHcIzIfzgolFf8LmBsCHDKLUo7jiuty5p
         Cz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702975326; x=1703580126;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EEk8w6zLthh6eU9WJj7lAhdI382V9ytLfLho6ibFBNY=;
        b=cU1LDlmoxs+F2y4fswqoCLyoIrGpUBxpWXkL5eAW4+GgsvJk5Q/AdLHnZKTUatiFhh
         eMv6FOcJ91z+gtFlhoobXBwUbgf4ivFGIPHHimNdAKm6xoGcYZDsDKipBqY/y5t/3hH4
         5i6VxqfmnNHK06Zv3MY+NpNKOYKSSdbbJCLZngGo9LiQKOwgP3GyRUnLhmqKq92k4biA
         90wGuNk7CDjlqgvrCIfBBseP4c30GGQwIB15fHaZAmNM2BREO3gysr68GZODJ8Yo64gh
         nvmgN/NVwPbsnEF3G5f9snrIPE/E9m+OQ12UBv6B0EuPe6UyyR1Q8q4zaXi2mTIRCKhz
         PdpQ==
X-Gm-Message-State: AOJu0YyXNzoJ76DTjjXDqLoEHLHNm77ZsRqOVmCpkYCEqg0ntph3GeTP
	0PbW0bjhVE8HRUCVxQ+Dn4Q6Qt4URSE=
X-Google-Smtp-Source: AGHT+IH4QcgqA5ComtUB2X/5KHm11JelDX54Aj+D0nPwQXwAyg+ZzS2TWx+vRPQPLmg9ObV2XiQxDw==
X-Received: by 2002:a7b:c40d:0:b0:40c:31f1:144c with SMTP id k13-20020a7bc40d000000b0040c31f1144cmr4425366wmi.87.1702975326536;
        Tue, 19 Dec 2023 00:42:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c354700b0040d2805d158sm1260537wmq.48.2023.12.19.00.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 00:42:06 -0800 (PST)
Message-ID: <043d2a24202d39c5564e4a4369c86ae4648dd721.1702975320.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
From: "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 19 Dec 2023 08:41:57 +0000
Subject: [PATCH 6/8] SubmittingPatches: clarify GitHub visual
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
    Josh Soref <jsoref@gmail.com>,
    Josh Soref <jsoref@gmail.com>

From: Josh Soref <jsoref@gmail.com>

Some people would expect a cross to be upright, and potentially have
unequal lengths...

GitHub uses a white x overlaying a solid red circle to indicate failure.

Signed-off-by: Josh Soref <jsoref@gmail.com>
---
 Documentation/SubmittingPatches | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index d7a84f59478..8e19c7f82e4 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -604,7 +604,7 @@ to your fork of Git on GitHub.  You can monitor the test state of all your
 branches here: `https://github.com/<Your GitHub handle>/git/actions/workflows/main.yml`
 
 If a branch did not pass all test cases then it is marked with a red
-cross. In that case you can click on the failing job and navigate to
++x+. In that case you can click on the failing job and navigate to
 "ci/run-build-and-tests.sh" and/or "ci/print-test-failures.sh". You
 can also download "Artifacts" which are tarred (or zipped) archives
 with test data relevant for debugging.
-- 
gitgitgadget

