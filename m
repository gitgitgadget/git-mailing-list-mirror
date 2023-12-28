Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE9523CC
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 04:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXySZoXy"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3370769018cso475199f8f.3
        for <git@vger.kernel.org>; Wed, 27 Dec 2023 20:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703739329; x=1704344129; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IvwM4W/NlDHwNbKAl3tiFP3CE30lrBYpPWWZEMxuUY=;
        b=dXySZoXyqHaVJOk9PI+3PWVRaKDD15yp7vBCc5P+XEfFtRokG5RHyNcMQ9jbXxaXix
         FA9VTRT8NlmyyJm0pV/gq971wKAswrggIq8jDyYmOU2OZN4BE8LuHRAAJDZBti4ydy9F
         kgc508T7EPPqh5l+YcshNsVS2+eBdh2DoRSo/5Vny7QTuQZsLUpZ/L2C/pBHrTg6i6ME
         pNpJbWSDg6qzPFnrX/53NU7vxSzBxae/j69KJcaxsZTah/KQ20zHPPVv1X+8tRI8gqwU
         cq6K9izwj7zLRVhfQF2+TWvxncKteRcAPj2AhSIPddOEB+ByDPsPV4ADNLDGLuFyTEwJ
         cZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703739329; x=1704344129;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7IvwM4W/NlDHwNbKAl3tiFP3CE30lrBYpPWWZEMxuUY=;
        b=DaZafKCrtbGFLzfxM++boPi3iYy6M/g4i/SS+gQ0n8xG5M+rmCvGnlTX3d2iAj4RwJ
         ONL18+q9t1Ab2MV/jho2enCFiD3GaH5lEI+AdHWAf7+uJ+5neLIXP2sZZsLHhom3zXqN
         0P3jS2z5OUA5yTgz3m1C1mIJlNgOLyn5438gK4pmqjE0MPdCQUNXNWM2Ivq5PzEiig/b
         TmghDvjpSbBCG1+hTCniQx6cTwm1KPGH/n3whBkjE7AtBtOVYMlY/N21dqCdIFnhrob/
         aiSn1EN7+v1seKLSotYP4j93Ud+zG2f1V1Grl14caAng3IAvu7a1v3vjQsHxFHUd9N4+
         6xEw==
X-Gm-Message-State: AOJu0YyEZvtoJMWOXyYKBaJOJilAT9r1Sg8550bnTKhjISr7PiQ3fio/
	Ytzmd6eKqKQl5EyouSkNehLtclAEVTk=
X-Google-Smtp-Source: AGHT+IEPx0Ko6QguI+Gfi3OiKZkl5GyO+yuKuXfCgxIwc4SdHIEhIt5iuDopra864yqkjB8gqQjvnw==
X-Received: by 2002:adf:e743:0:b0:336:7885:fff7 with SMTP id c3-20020adfe743000000b003367885fff7mr4908297wrn.52.1703739329115;
        Wed, 27 Dec 2023 20:55:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f8-20020adffcc8000000b003366b500047sm16075455wrs.50.2023.12.27.20.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 20:55:28 -0800 (PST)
Message-ID: <22d66c5b78a6930e195141df848266cac099ca08.1703739324.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1623.v3.git.1703739324.gitgitgadget@gmail.com>
References: <pull.1623.v2.git.1703176865.gitgitgadget@gmail.com>
	<pull.1623.v3.git.1703739324.gitgitgadget@gmail.com>
From: "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 Dec 2023 04:55:18 +0000
Subject: [PATCH v3 3/9] SubmittingPatches: drop ref to "What's in git.git"
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

"What's in git.git" was last seen in 2010:
  https://lore.kernel.org/git/?q=%22what%27s+in+git.git%22
  https://lore.kernel.org/git/7vaavikg72.fsf@alter.siamese.dyndns.org/

Signed-off-by: Josh Soref <jsoref@gmail.com>
---
 Documentation/SubmittingPatches | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index bce7f97815c..32e90238777 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -570,7 +570,7 @@ their trees themselves.
   master).
 
 * Read the Git mailing list, the maintainer regularly posts messages
-  entitled "What's cooking in git.git" and "What's in git.git" giving
+  entitled "What's cooking in git.git" giving
   the status of various proposed changes.
 
 == GitHub CI[[GHCI]]
-- 
gitgitgadget

