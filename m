Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CD415CE
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 04:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZe6bwrB"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33686649b72so5810319f8f.3
        for <git@vger.kernel.org>; Wed, 27 Dec 2023 20:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703739328; x=1704344128; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZ+mRYR4ZuIXNnMs9/cNBaByPR4a4sdcF8Ik2YtQRXM=;
        b=MZe6bwrBBGlxBN7l39JMRcagpzHNkFs1VJeOlV6t7V1KHP4R/kFh/DqoctFAriiI8L
         s7eRWiAnzrZo65blqf2/kSRS95NjjoJ81JgjEkW6lm6yD8rChlY+jMfa1SsTFQ+3xWk7
         VZy1ltrDPHc/FnbK2vEOOI46gDkFTaLNYeq0JGEOgR0IgBlvB2Rqz5ehHopZDmvnxffR
         bSlhKPVdJrZfs84N7EI/TIkVwSTzdus3Y/QFhKUJ2S6FP29d8FxEgyE1AP5PKOH8ihaG
         7ZRzGmeq7VvDLTdwTU6d6G4RO9s5v6o5WfBnrSrWBCyC1WT6c/iWB6g7EeqZZKDToAD7
         c8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703739328; x=1704344128;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZ+mRYR4ZuIXNnMs9/cNBaByPR4a4sdcF8Ik2YtQRXM=;
        b=QqPE5NJMQpX0Y7+HmobuFv/zF9SN4BGm2yfjDoSSbCk9uHqQgVrtZIuEI4TvuClZeP
         3zyfpeCmrLV/fDe50kKQd2H150hUuVpgeyUO7H5gvzxvFkZOP+kj7kC5Y1MvrUShjPeY
         QISKGTQEKEdvK4tIWO1BSZnuRMjj+d9aWbBpvMtw3JnKhtJ77T5/QInJircne/uSza9D
         nAuZxaJ6Wtp/H8aExEKZulc4RyidfU1sMTenEbCvdjsHULESBDh2R74mcSKWkSmbmXJg
         hgr0Dwy/3fvyD3ZE4l9QF2B0XT6SYp/f41Q46bzwxeVSe6aRbxeTgEd5lZDQEKunfHsh
         QgXA==
X-Gm-Message-State: AOJu0YyJ90FNLHvLUONOM0wsvdcW3Y9Ek/XsbKicFMZ6fvET46n5ARhv
	piCRV9ZQtbHcENPg+n5CDGxO6DcrFfU=
X-Google-Smtp-Source: AGHT+IFBtzSTmnhZbNjGnpo5LQ+u4PlliIw5GeAp0fN34DH5nJIDD2k8MiBgsRdGn72S/1TQdf+emw==
X-Received: by 2002:adf:e943:0:b0:336:66f7:2d35 with SMTP id m3-20020adfe943000000b0033666f72d35mr4104992wrn.11.1703739328104;
        Wed, 27 Dec 2023 20:55:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b7-20020a5d45c7000000b00336c6b77584sm7122851wrs.91.2023.12.27.20.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 20:55:27 -0800 (PST)
Message-ID: <c0db8336e519cb43767effbe842dc8b97f914a4b.1703739324.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1623.v3.git.1703739324.gitgitgadget@gmail.com>
References: <pull.1623.v2.git.1703176865.gitgitgadget@gmail.com>
	<pull.1623.v3.git.1703739324.gitgitgadget@gmail.com>
From: "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 Dec 2023 04:55:17 +0000
Subject: [PATCH v3 2/9] CodingGuidelines: write punctuation marks
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

