Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBD459922
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsIsciB8"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40d3c4bfe45so10215625e9.1
        for <git@vger.kernel.org>; Thu, 21 Dec 2023 08:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703176873; x=1703781673; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUFYgtLxjJrim50uBF5bk4cAvvjSciytMUeR7FKkRp0=;
        b=gsIsciB8E+ZyKuLuKU5zB1WicYWOUjIiIdSyWyaNl51GDOKD/z3t2VY6rCzzb+9DQM
         LV2Y3hpklIzB60mTLQ8i96hbBaCZG4T7WUcq3tV9/SxHTiPASkIAeM7unMiKbLVvhIeC
         mZtAsipOQoFbpJSUMxPKbth0enerRktgUcPPU0o+FYjsDBIhDRdRKUUu8rsd6wLJBntA
         6LTYdgdsu1XkXCLxkDCRPkFfH5JDwqCPppRP3w8nASLCSk6mK+/RGYbrKGsRPgDpG4Yd
         rpclfewXfg9FkL9RRtEEqKB5VHBfDAVQXtb+MX2FBX9OKKn3G6w4gzVHVJ6z7N00Pw/L
         5Rug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703176873; x=1703781673;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eUFYgtLxjJrim50uBF5bk4cAvvjSciytMUeR7FKkRp0=;
        b=hMpJ3dtL79iIJQ0+CUNRm/lRXQD4lmki+Sy/o1wGzOocYLVvxAvXtXSS2N5Ay1+578
         meSkM8F57Hw5GD89nXGGKgld78GDGpSj5zRsRteZRIh23XalSoUC6SLVxPvWluKNCiu8
         10XgAt/bos6KISRaUBSV+Ury2r50ocd/6GRc/9pzrUEas43nsdWOisWITlSAYKQmbXpx
         ihcwZHBdl2ta6wwqW7Y5WrG54aTcDpcS4aK6iErTZQSziRaOK0WQ2bxod07tIDtOOsNl
         eDl5S6VnFJuRwAEWjN8F5etWOm24n6e+O3J/BS3z1e+UwPy+ZhbohJLI8O68HsA0ZkBn
         I84w==
X-Gm-Message-State: AOJu0Yz86RvImG77LylUxvtXwZqWbDj+6taJJmpHmxwkZg/5ZPbnF2m6
	GILj/dZ2Zt9q1fmpT2pAaIPCuI24A+w=
X-Google-Smtp-Source: AGHT+IGsYOJthjpl/WsANXnrsKBfqEcEHN0zpXfgciS1X06QS1XzcT1iRBaggKv2T5YS1mUK/strIg==
X-Received: by 2002:a05:600c:2a8f:b0:40d:37a8:3261 with SMTP id x15-20020a05600c2a8f00b0040d37a83261mr951wmd.134.1703176872834;
        Thu, 21 Dec 2023 08:41:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id je17-20020a05600c1f9100b0040d1450ca7esm11704513wmb.7.2023.12.21.08.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 08:41:12 -0800 (PST)
Message-ID: <cdb5fd0957fee7ce8c19720f588da96898cd3dc9.1703176866.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1623.v2.git.1703176865.gitgitgadget@gmail.com>
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
	<pull.1623.v2.git.1703176865.gitgitgadget@gmail.com>
From: "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 21 Dec 2023 16:41:03 +0000
Subject: [PATCH v2 7/9] SubmittingPatches: clarify GitHub visual
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

GitHub has two general forms for its states, sometimes they're a simple
colored object (e.g. green check or red x), and sometimes there's also a
colored container (e.g. green box or red circle) with containing that
object (e.g. check or x).

That's a lot of words to try to describe things, but in general, the key
for a failure is that it's recognized as an `x` and that it's associated
with the color red -- the color of course is problematic for people who
are red-green color-blind, but that's why they are paired with distinct
shapes.

Using the term `cross` doesn't really help.

Signed-off-by: Josh Soref <jsoref@gmail.com>
---
 Documentation/SubmittingPatches | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 4476b52a50f..8f79253c5cb 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -603,7 +603,7 @@ to your fork of Git on GitHub.  You can monitor the test state of all your
 branches here: `https://github.com/<Your GitHub handle>/git/actions/workflows/main.yml`
 
 If a branch did not pass all test cases then it is marked with a red
-cross. In that case you can click on the failing job and navigate to
++x+. In that case you can click on the failing job and navigate to
 "ci/run-build-and-tests.sh" and/or "ci/print-test-failures.sh". You
 can also download "Artifacts" which are tarred (or zipped) archives
 with test data relevant for debugging.
-- 
gitgitgadget

