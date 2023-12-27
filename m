Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6E82C866
	for <git@vger.kernel.org>; Wed, 27 Dec 2023 10:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hH3POYVh"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3368b9bbeb4so4381675f8f.2
        for <git@vger.kernel.org>; Wed, 27 Dec 2023 02:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703672409; x=1704277209; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWOmTuaq0cldnnlT34ipLqSxmYN/CkFWJZYiMprv4LQ=;
        b=hH3POYVhBUib6lL+fgsl/PDBQTlOIDHNsqiU2OPP+4HpJsj0VwzPu5ULe62IoEX5Yb
         li7ONvgZR46SSJwpErw2g+J78WoGUieCXYch3FOb5sO3+EhjAsGwSETlHxxcZw8sUgAh
         cU59k642UODRLeHEpRNotbAGbRB12ZHn7A2Q57h1OGoDtMUtrhMwGcwzCPS/vli74imQ
         +WjDck1DkccKe3apHMevS0Omf70SdxN9fkeOvDhb1mmxBsWOmdwR5w26SdCzE03vbfqN
         ZWlabNVwltadBlKUDqyagWcFgZ8+EJX/7inDNQpY/Ybqrk+6xeRL+x0uiNLx14hKyJYs
         +Hiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703672409; x=1704277209;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWOmTuaq0cldnnlT34ipLqSxmYN/CkFWJZYiMprv4LQ=;
        b=lw3pH/jebSuqNLfjSLhM9fFwrK2vfOx4yeUZMSNCiVA5s0GLLrE5LfOUylZm0R9xLk
         zlPG6lKAchEgi1MtsW1YDlnwYo/mI/E487K856+4cNxxxcleVPgN+pcsHqxPWSv80VJl
         Z20wr21JKSkuQEkkQunCup1qRZPWF3H9cfAei5zOsutqNNR1xXOLD6qqiTBUdnHS9+5T
         5rDlGUoaVejE3P5utZpSCmyXKWXm9J0UgjHBNbeVFg/IIgml5EkH91O2tDDN8XNeukLR
         jpKjNIX6X0Ysc1YF2HrakDdBxVdxMU08wCJ3u6o6pkUAse85hlBFJ9hFrpBP0r0JJfqa
         wLdw==
X-Gm-Message-State: AOJu0YzAUon3jEPbzygAusCqtAkAvE5GRzSyKiksseRGB0+IPGAjZ6r8
	9etYBMR9J+qJz+89Lq64T8wQHDXQozc=
X-Google-Smtp-Source: AGHT+IHo4zWbiz29ejggofd/Hg0oo334sHyYIC72ALXZRw+xszD+ru7ZK1/OL+tQQSa8XQdYdL5+dg==
X-Received: by 2002:a5d:5584:0:b0:333:3117:c434 with SMTP id i4-20020a5d5584000000b003333117c434mr2019034wrv.197.1703672408942;
        Wed, 27 Dec 2023 02:20:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z4-20020a5d4d04000000b00336a1f6ce7csm9996407wrt.19.2023.12.27.02.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 02:20:08 -0800 (PST)
Message-ID: <pull.1625.v3.git.1703672407895.gitgitgadget@gmail.com>
In-Reply-To: <pull.1625.v2.git.1703351016486.gitgitgadget@gmail.com>
References: <pull.1625.v2.git.1703351016486.gitgitgadget@gmail.com>
From: "Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 27 Dec 2023 10:20:07 +0000
Subject: [PATCH v3] sideband.c: remove redundant 'NEEDSWORK' tag
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1625%2FChand-ra%2Fdusra-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1625/Chand-ra/dusra-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1625

Range-diff vs v2:

 1:  fdacc69ae3b ! 1:  273415aa6a4 sideband.c: replace int with size_t for clarity
     @@ Metadata
      Author: Chandra Pratap <chandrapratap3519@gmail.com>
      
       ## Commit message ##
     -    sideband.c: replace int with size_t for clarity
     -
     -    Replace int with size_t for non-negative values to improve
     -    clarity and remove the 'NEEDSWORK' tag associated with it.wq
     +    sideband.c: remove redundant 'NEEDSWORK' tag
      
          Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
      
     @@ sideband.c: void list_config_color_sideband_slots(struct string_list *list, cons
        * passed as the first N characters of the SRC array.
        *
      - * NEEDSWORK: use "size_t n" instead for clarity.
     ++ * It is fine to use "int n" here instead of "size_t n" as all calls to this
     ++ * function pass an 'int' parameter.
        */
     --static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
     -+static void maybe_colorize_sideband(struct strbuf *dest, const char *src, size_t n)
     + static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
       {
     - 	int i;
     - 
     -@@ sideband.c: static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
     - 
     - 	for (i = 0; i < ARRAY_SIZE(keywords); i++) {
     - 		struct keyword_entry *p = keywords + i;
     --		int len = strlen(p->keyword);
     -+		size_t len = strlen(p->keyword);
     - 
     - 		if (n < len)
     - 			continue;


 sideband.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sideband.c b/sideband.c
index 6cbfd391c47..a89201d52ac 100644
--- a/sideband.c
+++ b/sideband.c
@@ -69,7 +69,8 @@ void list_config_color_sideband_slots(struct string_list *list, const char *pref
  * of the line. This should be called for a single line only, which is
  * passed as the first N characters of the SRC array.
  *
- * NEEDSWORK: use "size_t n" instead for clarity.
+ * It is fine to use "int n" here instead of "size_t n" as all calls to this
+ * function pass an 'int' parameter.
  */
 static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 {

base-commit: 1a87c842ece327d03d08096395969aca5e0a6996
-- 
gitgitgadget
