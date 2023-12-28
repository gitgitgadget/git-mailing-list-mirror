Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B0F15A8
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 04:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzudUeb1"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40d5aef534eso16997745e9.0
        for <git@vger.kernel.org>; Wed, 27 Dec 2023 20:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703739327; x=1704344127; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcI2SqQQB4Jltt9lH8a1zFwnKso4M1EWV/+giKCyLKc=;
        b=OzudUeb1YmJ4NI5buRfoJMvuDPmh3bxwwHjw9vFMgINMjDrvdHb/jgaJVV/3uopfQU
         /OhE7m2ODcPDe6Yu9Aim71Qpkq03OIeCKRcOhi69dCN4h47spL/BVhpFVl/uT3tvONaF
         eJz0LeK38mAIo1RecRpQlQELe6IuTCBNNlxFXDvgKxQ/5e0nofqKWPDtVbaeh7+1Qx/F
         Bh+LV8b9WfgqA+msqFjd2oDtVVRnZSMbBRoN+RkJCZpE1ghxpJhd/FxCuweOZCxZLgYL
         W0eYEpGyuKt//nZlNlV401M3Y3VMUH03YM7L78hud+bXOPeHuEc6XCV2G5Cs19yhmc6g
         R1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703739327; x=1704344127;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AcI2SqQQB4Jltt9lH8a1zFwnKso4M1EWV/+giKCyLKc=;
        b=dvrPCkoBr7x84H7m0O8UoiX5AKUH64oZCVuS+w52gnU6YMshaTEunFlDCHuvfWsCHR
         9L45HTw9H8R3vnCoxQaHVD1OwCtn7oHW2TYIf/5fh6Fco80mZWg5DmMQdvfJa5Ej87Lh
         feCfaFVJQAzEteBJDZyMh/7bdLSHsN40UMGWxvHWTv57o9lPbNZXHRWSFwhlT2178bOd
         znwy8AZARkIj8a5YJHAXI6CtewpshPLEgGaz/FCpNIszb/qhelMpfg/x2z8lavqRi498
         Y6g0/Q5KM3mUNdXpN1/9/NR21tlLmzYDepSph/HTmcJFr9crWTy5o3nmDiRbPEG6rtZI
         Iu1w==
X-Gm-Message-State: AOJu0YzC1mKfk+MN7IMVzBAIG0UIUSrbEBdv3N+F7du+Ekpcs1A/YHxq
	FMDc1c4AUVToMtsQAPBVxS4/yVssdfM=
X-Google-Smtp-Source: AGHT+IG3CCc99Ac2N8oYuunecz38EEgHMHE5PmxcoWrBiLXnPxsdMVd/mXgcZ4ORgN8LVMRUQCtxgw==
X-Received: by 2002:a05:600c:a44:b0:40d:6c48:a1dc with SMTP id c4-20020a05600c0a4400b0040d6c48a1dcmr81594wmq.176.1703739326707;
        Wed, 27 Dec 2023 20:55:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fc20-20020a05600c525400b0040d6e07a147sm119460wmb.23.2023.12.27.20.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 20:55:26 -0800 (PST)
Message-ID: <b9a8eb6aa4e87cd96fbf2b5d514350508076d756.1703739324.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1623.v3.git.1703739324.gitgitgadget@gmail.com>
References: <pull.1623.v2.git.1703176865.gitgitgadget@gmail.com>
	<pull.1623.v3.git.1703739324.gitgitgadget@gmail.com>
From: "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 Dec 2023 04:55:16 +0000
Subject: [PATCH v3 1/9] CodingGuidelines: move period inside parentheses
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

The contents within parenthesis should be omittable without resulting
in broken text.

Eliding the parenthesis left a period to end a run without any content.

Signed-off-by: Josh Soref <jsoref@gmail.com>
---
 Documentation/CodingGuidelines | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 8ed517a5ca0..af94ed3a75d 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -450,7 +450,7 @@ For C programs:
    one of the approved headers that includes it first for you.  (The
    approved headers currently include "builtin.h",
    "t/helper/test-tool.h", "xdiff/xinclude.h", or
-   "reftable/system.h").  You do not have to include more than one of
+   "reftable/system.h".)  You do not have to include more than one of
    these.
 
  - A C file must directly include the header files that declare the
-- 
gitgitgadget

