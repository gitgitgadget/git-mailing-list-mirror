Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883D91170E
	for <git@vger.kernel.org>; Tue, 19 Dec 2023 08:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOjKIILD"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d190df5d0so24802665e9.3
        for <git@vger.kernel.org>; Tue, 19 Dec 2023 00:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702975321; x=1703580121; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcI2SqQQB4Jltt9lH8a1zFwnKso4M1EWV/+giKCyLKc=;
        b=MOjKIILDRBvy8YV+n/HbLDcN9AeEJR5XiCnytQdljiQq0S4FIy5raUGB8DbYDPPv+c
         7H6T1itmXqazcTwJ+agP9WKQ6w18FixB8qhbph79uuWIxaQa9vBCMQWzNYyU3La9d2Vf
         VSkIUch6Q7L2Qcp8nJ0XbOmcgEWa8B/JqNDnFGXZHki0yNIG0vpGff1/nUnCQJqy9MIQ
         TaVSV99oKQXjcaQIl9wd15evWfLTHVW3dwjur3DyxfoCsbYxl7i7BuZF+xxhWcePdL8U
         XOazBKQuNP/HLsEevLptTvwIa4GIH2DPe7JkrkOLgfRrfaLW65USFV6qr2o0/agxATfU
         29qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702975321; x=1703580121;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AcI2SqQQB4Jltt9lH8a1zFwnKso4M1EWV/+giKCyLKc=;
        b=fSejz8GDyshvenDgHS1+OncbyDQLJK45zBLZ1hSdTdSAolndZFvDh+6mXOeuCV6VQy
         eFQPLTbfRCWGJVTRv+rmP8lgUWiALt+hS0pbH47gn+cmSfTdzcIPIeyBaEAv6L0LAmfF
         rppdUbdMaRM7/gNyEk7gkA2UrqPmU5knDrvescvSJNYqmvH1FwTrHZQwFBN2VMugE0Wk
         WF7Lj0Rsm64HVk6hve2ujimlNkeRc6cfR6CPZxtBLV4FwJH3O+vNK683u7C0R7mxRiMg
         Jx1pAnBFAs6H45fvbX3A5MiywvG1JmRcp/DzpUWw7KM9iUsPCIFfhTd/LeMmGBFUU8aK
         qUHw==
X-Gm-Message-State: AOJu0YxMaQHhU3cQraHDICSIdLBq25/Rsn4S2h7fA8izBXkyEUaqXUcV
	orbo0woQF4eVQrMyOke/3te9zJkmQAg=
X-Google-Smtp-Source: AGHT+IGbAT07fA+oijPLQoZelS6rOOZ2XGfUC6R5Mr0bsh/6Mu6A4OLA8c9LU9WvaCcWLlCwr7MT8g==
X-Received: by 2002:a7b:c3d5:0:b0:40c:3774:8ae9 with SMTP id t21-20020a7bc3d5000000b0040c37748ae9mr9936102wmj.7.1702975321325;
        Tue, 19 Dec 2023 00:42:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m39-20020a05600c3b2700b0040d23cea7bcsm615527wms.1.2023.12.19.00.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 00:42:01 -0800 (PST)
Message-ID: <b9a8eb6aa4e87cd96fbf2b5d514350508076d756.1702975319.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
From: "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 19 Dec 2023 08:41:52 +0000
Subject: [PATCH 1/8] CodingGuidelines: move period inside parentheses
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

