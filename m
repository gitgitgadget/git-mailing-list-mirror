Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8CF5990E
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 16:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwpbYgcP"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40d4103aed7so6413835e9.3
        for <git@vger.kernel.org>; Thu, 21 Dec 2023 08:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703176872; x=1703781672; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQn41U9cIu1gfcQ6LDtbl9WzjXJ83wxBa+4cgT8xkao=;
        b=hwpbYgcPqSY2P3V5KgIRroWlM0pN2rYHLhztlDS7oAlvk9+/pYiZoL4eCZD1KuNR9m
         eB/M31L6K7PZONclkQiH6LFqccF2/ljaP7SOoLGd0HysImplOJk1QjRM5dsCv7R6iFY3
         BdFwMpQp3iUurkuP6Zfq9x6f1Z9mAR29vu6kBG1L9SmExNLxW0REoL03GX9lnmfWZOsF
         XwNSZfVGBBUXQX+W02v+/W2j3Hc6l7/PW2A26y4dyf5bmMpj5HkqzgQtq5yIvn0DhoRz
         TT9rgPhe8qN9Wev15S8W8dc1mbh3qQdshDrwaUir1ia15KYLZ0adUBlbsIzEn/sjCgFT
         3lWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703176872; x=1703781672;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQn41U9cIu1gfcQ6LDtbl9WzjXJ83wxBa+4cgT8xkao=;
        b=rbM8mOQZu7AD/ifDto2fRKFOxYbAhz61iiQGSnJu7KDe3ejABZl09j9PncIx1m3KEg
         HnEsyutgDj862eqwfC88o6Ghk+ra/tmGDAN55XYLf9QVx8bUqo9Z6QOBalLBoCwKrTqJ
         SQZ37N6yXO5F6DwF6VgMuFSiBB/0n/6vN+HqKcthxUcaiczu3Eoex6L1npHKivukGIvi
         SMFPpJrFeRB6CDIAQejNQgp7OSNJQk7E6elX58nKsLCjOLhYxSL8AdewLbEH6FZgl/ms
         ebZ4JJrv4N7Vb3OEzl878kC5ZJI67at1sW8sEy9T5O79FOExHXxGrW4BnxGd0VhX4XbS
         FpfQ==
X-Gm-Message-State: AOJu0Yx5AmXSJidOT62UxJyl8T7ZXSuRtboCAXSBA7evVPzUQX6oZlGX
	ups3lpILs7KB80IkzfoG1ZSbWlVJMXo=
X-Google-Smtp-Source: AGHT+IF6YJk5X0QRqzrrPwfKQXzpAIDPTc1NVJwpYAQdDLKF9uUB07R7MEFzQfJVFjvzEtHDDiro4w==
X-Received: by 2002:a05:600c:19d0:b0:40b:5e59:cc9e with SMTP id u16-20020a05600c19d000b0040b5e59cc9emr936936wmq.127.1703176872157;
        Thu, 21 Dec 2023 08:41:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 14-20020a05600c020e00b0040d23cea7bcsm2008522wmi.1.2023.12.21.08.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 08:41:11 -0800 (PST)
Message-ID: <8f16c7caa7366cab22ad332c402f80823add8224.1703176866.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1623.v2.git.1703176865.gitgitgadget@gmail.com>
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
	<pull.1623.v2.git.1703176865.gitgitgadget@gmail.com>
From: "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 21 Dec 2023 16:41:02 +0000
Subject: [PATCH v2 6/9] SubmittingPatches: improve extra tags advice
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

Current statistics show a strong preference to only capitalize the first
letter in a hyphenated tag, but that some guidance would be helpful:

git log |
  perl -ne 'next unless /^\s+(?:Signed-[oO]ff|Acked)-[bB]y:/;
    s/^\s+//;s/:.*/:/;print'|
  sort|uniq -c|sort -n
   2 Signed-off-By:
   4 Signed-Off-by:
  22 Acked-By:
  47 Signed-Off-By:
2202 Acked-by:
95315 Signed-off-by:

Signed-off-by: Josh Soref <jsoref@gmail.com>
---
 Documentation/SubmittingPatches | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 31878cb70b7..4476b52a50f 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -368,6 +368,9 @@ While you can also create your own trailer if the situation warrants it, we
 encourage you to instead use one of the common trailers in this project
 highlighted above.
 
+Extra tags should only capitalize the very first letter, i.e. favor
+"Signed-off-by" over "Signed-Off-By" and "Acked-by:" over "Acked-By".
+
 [[git-tools]]
 === Generate your patch using Git tools out of your commits.
 
-- 
gitgitgadget

