Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655CA101EF
	for <git@vger.kernel.org>; Tue, 19 Dec 2023 08:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJljmrYh"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40c3f68b69aso40662855e9.1
        for <git@vger.kernel.org>; Tue, 19 Dec 2023 00:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702975321; x=1703580121; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yXCdZWchH/MNI9GgukJev+rwH4EXMHXvejSN3wbjeto=;
        b=HJljmrYh2ka53mK6jO9Dqb7wDDpBwHbqndGr3GHyE6ugA2Pd9Z5SOxWvf30e06kV2H
         chTgT16+N6HHj2coyvWz9SfS/ho5oLjkX9mIF1Q7NYC+UCtyTuZlfNXybHBVQJZo/di1
         ApQyCoHRO0t07xB4UtnI3rwMAy2fC+EmFiODSUaa0zz1/Klibekb/0Ot1h4AH8euqpf8
         ySlKbAyZHj+3bF0b3TZXiXU5EcjbNYNLZDqkOfRZSoCiTfxqtJK9zlyaWlAMsPTB55OG
         YoUuh/ZSLbE2qssnz/ks/eouwkCIWunSGSPjkEKGy4oAZwai0cyeTWV+QNctMTDDTies
         ffEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702975321; x=1703580121;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yXCdZWchH/MNI9GgukJev+rwH4EXMHXvejSN3wbjeto=;
        b=eE5KBaxJzbcqjOpSuRNQb3gCNVFJt0mjMeLDMI5sOPioouhj3FDlkT6UPiAPIBxxCG
         mkXvV287yhbC5tti3ayr9T29e21rLt6a6RWDwtDOM/Sq46M2aPpxBqbDxH4ow7idhQq5
         Uta1TM+/uDBoumvyGF9+iibAWdbh1s+lSifiqQ31d2Ocvn0hb/aAYCVAOmTayw38sZxl
         DD3WbKI/0GxgCYhPqBV24sAUY6oyWh3RvOYhjgAfRRWqjQdy5h9DUUwyWYwAW1rr2c95
         exiOWwSTmMxVxx4LlwIpv3ggu6DxPxn4aFUpJI1vFqra+I8GnE2kJqw8GUU/VfWVhTlz
         ztHg==
X-Gm-Message-State: AOJu0Yy8Aq23ccfBWXwBmxPKsM+v6GAm+UiGUo+GdYEZVWPsBp0mx4ei
	jQ3unKtEbj34fKhTDX723TF5cLo5k5Y=
X-Google-Smtp-Source: AGHT+IF/TTc6z9fCUr5npR0AJNIGt4TRMsYL5WBf+YqQoHoiuYMx1V391tThEDHh3U6hNx5a3YA3jg==
X-Received: by 2002:a05:600c:3784:b0:40b:5e1b:54a8 with SMTP id o4-20020a05600c378400b0040b5e1b54a8mr9563288wmr.52.1702975320862;
        Tue, 19 Dec 2023 00:42:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f13-20020a05600c4e8d00b0040c4535f1a2sm1774504wmq.39.2023.12.19.00.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 00:42:00 -0800 (PST)
Message-ID: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
From: "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 19 Dec 2023 08:41:51 +0000
Subject: [PATCH 0/8] Minor improvements to CodingGuidelines and SubmittingPatches
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
    Josh Soref <jsoref@gmail.com>

These are a bunch of things I've run into over my past couple of attempts to
contribute to Git.

 * Incremental punctuation/grammatical improvements
 * Update extra tags suggestions based on common usage
 * drop reference to an article that was discontinued over a decade ago
 * update GitHub references
 * harmonize non-ASCII while I'm here

Note that I'm trying to do things "in the neighborhood". It'll be slower
than me replacing things topically, but hopefully easier for others to
digest. My current estimate is a decade or two :).

Josh Soref (8):
  CodingGuidelines: move period inside parentheses
  CodingGuidelines: write punctuation marks
  SubmittingPatches: drop ref to "What's in git.git"
  SubmittingPatches: update extra tags list
  SubmittingPatches: improve extra tags advice
  SubmittingPatches: clarify GitHub visual
  SubmittingPatches: clarify GitHub artifact format
  SubmittingPatches: hyphenate non-ASCII

 Documentation/CodingGuidelines  |  4 ++--
 Documentation/SubmittingPatches | 24 +++++++++++++++++++-----
 2 files changed, 21 insertions(+), 7 deletions(-)


base-commit: 624eb90fa8f65a79396615f3c2842ac5a3743350
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1623%2Fjsoref%2Fdocumentation-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1623/jsoref/documentation-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1623
-- 
gitgitgadget
