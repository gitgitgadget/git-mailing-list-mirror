Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A7B55E73
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeDENsrp"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40c2308faedso11314735e9.1
        for <git@vger.kernel.org>; Thu, 21 Dec 2023 08:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703176869; x=1703781669; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZ+mRYR4ZuIXNnMs9/cNBaByPR4a4sdcF8Ik2YtQRXM=;
        b=BeDENsrp0hPSyjWtpvq9sdt8fVozhqLtPGmnxIIZYEjwodh5ssbMqKhxMvrGCDxvwI
         IXD0DFxEbhYyL2EzVfyO5QfdNA7LY+K2GMFN7t+mnVt2WZGcWss7UNHbx8DSIFpFWByQ
         C8yXk5dmntrFaBuWDjXg1fkw2vG+93coxRr2gSNJ+wsXt1YYDFE2GpCCORf6r0Deyl1s
         d5ZvmaRCkbEm7+oJXuS0ytzg5/siE8lFt40nMimpFzrxOYQRiW5/z1RwvM9ya0qtXWoi
         wHEhqoLIU+BCPBiCcuGb+xfGX3sxqRxi+/GeyzOFxIXKGZ7aJXalKr2GJNOg3GK2GR5k
         gpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703176869; x=1703781669;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZ+mRYR4ZuIXNnMs9/cNBaByPR4a4sdcF8Ik2YtQRXM=;
        b=j5UnGujmvOsYsnoO0ZJlwRs3EncZp5baSxeD/RNr3c+9yqUA8cP7dyMYyOgkTtGjnQ
         MKl2+b5UkSYkjUXqBA3fl7mK4LM0l+fP2c8o3r1SX51gwxPjQKcSuLjdzN7Bb/Royncq
         cB3QwgQcUG7BI00Y22WMjwqJUK5X4qCTXUr3mkJ4VChoYo01x9+2rZ9+KLS6cx+kr2hg
         eLtefUzbLKFIyLuwjx/mMJUKOkQ1ysuOM0bjeQSL/UtnWFg13DcZeUVvTIFgDSiFd+M/
         Un0QQ3u5xd/3NIGyKb4REnsJXhw7oTMy2SLuc6/KVD2PFbFTGeWIiDpgjSJZcGYLNJut
         G3oA==
X-Gm-Message-State: AOJu0YxV0KgrMUe2Fg7LBihg0kD8IlP6myhurLmA9dh9f/Omxw1r1aqW
	HGjqTlG7F79ptyqgtvoKYFlr9DwMubY=
X-Google-Smtp-Source: AGHT+IHxvyhosvitCUN+52/rKREMPtnkmLjUpMXCzhflQ7VlTzSMYnm+q9mykYc5/mS/d1z28hWQ1Q==
X-Received: by 2002:a7b:ce0a:0:b0:40c:2c6d:c833 with SMTP id m10-20020a7bce0a000000b0040c2c6dc833mr950433wmc.137.1703176868563;
        Thu, 21 Dec 2023 08:41:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p35-20020a05600c1da300b0040b360cc65csm4094064wms.0.2023.12.21.08.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 08:41:07 -0800 (PST)
Message-ID: <c0db8336e519cb43767effbe842dc8b97f914a4b.1703176866.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1623.v2.git.1703176865.gitgitgadget@gmail.com>
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
	<pull.1623.v2.git.1703176865.gitgitgadget@gmail.com>
From: "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 21 Dec 2023 16:40:58 +0000
Subject: [PATCH v2 2/9] CodingGuidelines: write punctuation marks
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

- Match style in Release Notes

Signed-off-by: Josh Soref <jsoref@gmail.com>
---
 Documentation/CodingGuidelines | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index af94ed3a75d..578587a4715 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -578,7 +578,7 @@ Externally Visible Names
    . The variable name describes the effect of tweaking this knob.
 
    The section and variable names that consist of multiple words are
-   formed by concatenating the words without punctuations (e.g. `-`),
+   formed by concatenating the words without punctuation marks (e.g. `-`),
    and are broken using bumpyCaps in documentation as a hint to the
    reader.
 
-- 
gitgitgadget

