Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4545233
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 04:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USfcnl80"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3367a304091so5576199f8f.3
        for <git@vger.kernel.org>; Wed, 27 Dec 2023 20:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703739332; x=1704344132; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HiDwYnTEYS8wC/JLKUqfDyVtGU0nU+z/+gFGFdt63aY=;
        b=USfcnl80DxMelnguhRPnvH6FlyMc8LsmnJvMwHdo/KcOBXcXcjSf+MokSJX6TGeKAh
         oUXIIIAl0Q3DKP6fgnp0tiDxSUyrkT1saPmxP2sq3O86zOvjwQP9xgi0AKkg8W6JdkhX
         UcFy11lOiemNes9yJt+sVPL0JBU31+HYpixQg4q7x7qv5rwRHXMAAUQR5OFEIrbxyqiS
         agiYsWntjSvINGbLDGzpQIosemCNg3Rbg20nYr6ZQbiejxPy8zGTvx8DaLYZ1JGqXQRI
         2PPFZN+qFbsrwV6zjo55BpzQq6DOJuoWm8BP7ru990+JI9CmhByrvnqLW1ic9ka1S6X+
         GZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703739332; x=1704344132;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HiDwYnTEYS8wC/JLKUqfDyVtGU0nU+z/+gFGFdt63aY=;
        b=Ete/88pjjqqTJ5CGgrRA4ucPNzNUnUFbkhmmATllx7UZqAX9u+a0CkJi++AacYpHS7
         FsTjZV9E40DzzsWe/kNCsD0CYUpTKz4ghZ9RryaAjQbz5+8ppxsw21G2qdmYVPKK4O5q
         QDOQmiJ0fKxFd14akPi/W9D9RKMZk7PsfnvZRoPG3zM4l/SR8s48PXjJ3J1uJAmh7giJ
         YdTuX/i0VcORL5SFjuaLDv6aI3MQYOmK1x94aZgqrRcAPT1f99j9TFR2csuB5Q9n6u5h
         dGRMM+zWeFlFjF5dRTvXcGXODu2fVeuAAFMNjbEN1BGYHpwdg2O+pZuO9HOmENmWNmFV
         LL1A==
X-Gm-Message-State: AOJu0Yx4ERun87qu9kHymn+LXz9vFoFem3m8cyJg1wKaGBUohw8lnkBd
	FJlM5RoTimeZB1/eDWpI+J2t3rB+uBA=
X-Google-Smtp-Source: AGHT+IHTYGj6UksPBJ6plKwdRpz5juryrkMpZoLb9F9v5BReqcnyjcg9dKA3w0hYTE94Ja3ScEGtVA==
X-Received: by 2002:a5d:530e:0:b0:336:7ce0:c32a with SMTP id e14-20020a5d530e000000b003367ce0c32amr3352439wrv.192.1703739332033;
        Wed, 27 Dec 2023 20:55:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a17-20020adffb91000000b00336e40af9e8sm4876065wrr.36.2023.12.27.20.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 20:55:30 -0800 (PST)
Message-ID: <f28c1011ba91ce6ddcf09346c59cbc2b06c68ffc.1703739324.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1623.v3.git.1703739324.gitgitgadget@gmail.com>
References: <pull.1623.v2.git.1703176865.gitgitgadget@gmail.com>
	<pull.1623.v3.git.1703739324.gitgitgadget@gmail.com>
From: "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 Dec 2023 04:55:21 +0000
Subject: [PATCH v3 6/9] SubmittingPatches: provide tag naming advice
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
index 31878cb70b7..94c874ab5e6 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -368,6 +368,9 @@ While you can also create your own trailer if the situation warrants it, we
 encourage you to instead use one of the common trailers in this project
 highlighted above.
 
+Only capitalize the very first letter of tags, i.e. favor
+"Signed-off-by" over "Signed-Off-By" and "Acked-by:" over "Acked-By".
+
 [[git-tools]]
 === Generate your patch using Git tools out of your commits.
 
-- 
gitgitgadget

