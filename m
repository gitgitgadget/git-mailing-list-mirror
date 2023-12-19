Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B059D12B80
	for <git@vger.kernel.org>; Tue, 19 Dec 2023 08:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfQY9hMP"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d13e4f7abso24936075e9.2
        for <git@vger.kernel.org>; Tue, 19 Dec 2023 00:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702975326; x=1703580126; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvKhy32dP9r4we7s5Og96tKp8wPOp+8SHwgf4ZtHLMM=;
        b=MfQY9hMPQc3lNsjlK79/fYTrfxMKxnAZ8zBXkq+X7HFvbRdQkquS2JJ3keFaSSCPgv
         6jHG5SRM6NtgHhhamR3Fd5QFiK7sk+14455k9HOhfEfLfpneWriELDNGI3TzFVnn/oWA
         hpcCaMroPQmTVNVhWRl+8fC/JhcTRYsI1/gTkBbrEzULN/w0VAE07Ik+nlNo3XhFytaJ
         ox++s5DI5A6vpuVUCrffmT2d48/k8PYlOLNUQ+VF+dp6GLLyRsG7SCdR5E6DOShWO2A9
         VhYQGVG45a0zR9xUeR2+WD9N+Bh0pyVkOEsOJaouZz+rzR4GeOYOOr2777i1/q/QwgNI
         KUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702975326; x=1703580126;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GvKhy32dP9r4we7s5Og96tKp8wPOp+8SHwgf4ZtHLMM=;
        b=asJBD2MMwoqAnqo15xXhZIPo9InYe8NPIsLBgrsVbt4lMg9TfmqSQdOUKD0PUCnenZ
         FF0TUjPP4VIP26XPK/mAjsEd1yXNP+hqcTlGlqYjfniVWV0k8ruoXJ0J1sfzLZ0Vgelz
         aSFN05gsRWuYsBEhyPfWH/LOxnhHkug7RqZzLZAD7f93lJJsNVa5N9F41z0PuK8rOLzD
         kNcYOGSEcKS3oEaDXK60t41ox31E/pKKuT919PxUf6rLNg5ZhSdneOSHkuyTtfiTonRq
         WDEaZD9bLJlXXyNt8VNqx89143D5VKrauzXN/osqFii3pLvdF16dlU4qgffYQvF7lS3a
         L5Gg==
X-Gm-Message-State: AOJu0YxR9hiyc2uzOK+s+z8Ol9kj2/Yqi2HGUShiZpFCKg5JFbpKD6ae
	RUz4tCah3VGIri5S2EL5u0hnd4Uv8JI=
X-Google-Smtp-Source: AGHT+IEi273O9gBUu7USSxDwTUXQnSI6d9pNLdpoSdq3vbqXltIKWHjQFRr5YPX2JoBVs3xhHPWGFA==
X-Received: by 2002:a05:600c:450e:b0:40c:2b4c:ea8 with SMTP id t14-20020a05600c450e00b0040c2b4c0ea8mr10833563wmo.113.1702975325877;
        Tue, 19 Dec 2023 00:42:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay10-20020a05600c1e0a00b0040d1bd0e716sm1794304wmb.9.2023.12.19.00.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 00:42:05 -0800 (PST)
Message-ID: <11688e4360c1698e56b3485e3df4e171397d3c3c.1702975320.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
From: "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 19 Dec 2023 08:41:56 +0000
Subject: [PATCH 5/8] SubmittingPatches: improve extra tags advice
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
index 694a7bafb68..d7a84f59478 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -369,6 +369,9 @@ If you like, you can put extra tags at the end:
 You can also create your own tag or use one that's in common usage
 such as "Thanks-to:", "Based-on-patch-by:", or "Improved-by:".
 
+Extra tags should only capitalize the very first letter, i.e. favor
+"Signed-off-by" over "Signed-Off-By" and "Acked-by:" over "Acked-By".
+
 [[git-tools]]
 === Generate your patch using Git tools out of your commits.
 
-- 
gitgitgadget

