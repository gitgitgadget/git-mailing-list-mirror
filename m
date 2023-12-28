Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466BC4409
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 08:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4dRMuAH"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3369339f646so4773258f8f.0
        for <git@vger.kernel.org>; Thu, 28 Dec 2023 00:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703750462; x=1704355262; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9QcVt974x/rn/2JkuHfoX1h0H98Hyvw1AqCX+CkhSI=;
        b=j4dRMuAH38mrkXJfWEg9jG699OvTm6hHJyjZ+nOz+REfVUwKvhhoNYylZBYnbcCn/H
         6d4c3tCRLHk+SzPN7oEu9WEN6bhl//r1KlWy+VCdKz5prHC88sxAzs1YeZrU6nfgOVTf
         Vd9AIxPOCylTa/Fj9njtiHR87IyH5zT8aGknYCj7a6KINVAOtexX/ji9rKx/oJCJZU2a
         V2E2qLKB1HTNYTS0Q3rc/8ozB/ehCJXgYXQgg+3Cu6sGsONfvFy+aNrjyC17pjGvqQpH
         49vVcb/uWeLPnHquZLc6tS0q+S0+p8BqmlvmkSjRVOqUZDR9QOJLBJV17AtrH427Z4gM
         L9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703750462; x=1704355262;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9QcVt974x/rn/2JkuHfoX1h0H98Hyvw1AqCX+CkhSI=;
        b=I5Dg+yiQTjkaRYQwkxIw2aOMFG041sRc9/pG4SuK0OuI72qAMfK9FTR6DFpcpqHVYe
         udWQTzA6C9iqEolR3/x5wJ+l830dWQV3f31CG1ExstX7shciMmci9GLwWTVHeDTsLWOP
         98qN8Su0FOeMtPVKnFz9MfgaiLGUTwxOmuquOrlTp8T0G4b3foZDVeOxv/xLWtOcRQNu
         /jEDToTjqqFjqG7xzarX7SUCfDjZpqETRb56/fbzupagC62Phna/cmjkXqK1VjaOFMKY
         WCUkhDKfN+Vq0ZfvQesWgDjtin/q9n2S65/qgK20L+7ezKVaCGZKlbJ1h8UflCQIX1Wg
         zubQ==
X-Gm-Message-State: AOJu0YwwEelCOuDDjf5+UcoReiOL5LLrxNZkwDV/z2Dz30ZiDd/cFGYE
	AjczAFyP2ImChtkOli7DKZzWKaYnjiI=
X-Google-Smtp-Source: AGHT+IEmMp3G4oLkhtGdqmmIX1yoOM+/BbmJbIqj7GcBK1dFBwSNvcf52jJxGABz9tui8dIqxFEzQg==
X-Received: by 2002:a5d:4143:0:b0:336:c445:8565 with SMTP id c3-20020a5d4143000000b00336c4458565mr2997265wrq.27.1703750461890;
        Thu, 28 Dec 2023 00:01:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id df15-20020a5d5b8f000000b00336c43b366fsm7884682wrb.12.2023.12.28.00.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 00:01:01 -0800 (PST)
Message-ID: <pull.1625.v4.git.1703750460527.gitgitgadget@gmail.com>
In-Reply-To: <pull.1625.v3.git.1703672407895.gitgitgadget@gmail.com>
References: <pull.1625.v3.git.1703672407895.gitgitgadget@gmail.com>
From: "Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 Dec 2023 08:01:00 +0000
Subject: [PATCH v4] sideband.c: remove redundant 'NEEDSWORK' tag
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
Cc: Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Chandra Pratap <chandrapratap376@gmail.com>,
    Chandra Pratap <chandrapratap3519@gmail.com>

From: Chandra Pratap <chandrapratap3519@gmail.com>

Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
    sideband.c: replace int with size_t for clarity

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1625%2FChand-ra%2Fdusra-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1625/Chand-ra/dusra-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1625

Range-diff vs v3:

 1:  273415aa6a4 ! 1:  8c003256e5b sideband.c: remove redundant 'NEEDSWORK' tag
     @@ sideband.c: void list_config_color_sideband_slots(struct string_list *list, cons
        *
      - * NEEDSWORK: use "size_t n" instead for clarity.
      + * It is fine to use "int n" here instead of "size_t n" as all calls to this
     -+ * function pass an 'int' parameter.
     ++ * function pass an 'int' parameter. Additionally, the buffer involved in
     ++ * storing these 'int' values takes input from a packet via the pkt-line
     ++ * interface, which is capable of transferring only 64kB at a time.
        */
       static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
       {


 sideband.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sideband.c b/sideband.c
index 6cbfd391c47..266a67342be 100644
--- a/sideband.c
+++ b/sideband.c
@@ -69,7 +69,10 @@ void list_config_color_sideband_slots(struct string_list *list, const char *pref
  * of the line. This should be called for a single line only, which is
  * passed as the first N characters of the SRC array.
  *
- * NEEDSWORK: use "size_t n" instead for clarity.
+ * It is fine to use "int n" here instead of "size_t n" as all calls to this
+ * function pass an 'int' parameter. Additionally, the buffer involved in
+ * storing these 'int' values takes input from a packet via the pkt-line
+ * interface, which is capable of transferring only 64kB at a time.
  */
 static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 {

base-commit: 1a87c842ece327d03d08096395969aca5e0a6996
-- 
gitgitgadget
