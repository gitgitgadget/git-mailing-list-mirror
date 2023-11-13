Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B53F1CAA8
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 10:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHregjOM"
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DEA10CB
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 02:24:24 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c50ec238aeso60009231fa.0
        for <git@vger.kernel.org>; Mon, 13 Nov 2023 02:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699871061; x=1700475861; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lmp+39K4XkQih0RiO3PzbCM/gqqcmND2ys2ZgjDpzJs=;
        b=CHregjOMVF7RQadeiDyMMtK4YZsNltYfGgeUbDbqIBXwz1+Ax0nfYL3VRoLiYSxlju
         fdDoFzXM4Y1YFX/AYdkW0FLvv6spwHzXiQiDge4jG/OlDwJcovNdGu1p63u2GoqOag5s
         iniqeQcGy7PALDOxC7S8+/G9/jxNk/r9pyxymz59+F/AcM5qwlrEl0EtM3hYyyluTulH
         MuG7KqVP4uGmM3usVRU25mJE+MyIPCTNyGd1kRBpZaLnUGgel6OWc8LL3CQD2U7zJ7DP
         2qQwg2tuTxrUywVBoVey/RyrjOiDL91dwPmf3Us2pk2kKnr58x1vjrkKpdHLe6vygrHO
         kyWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699871061; x=1700475861;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lmp+39K4XkQih0RiO3PzbCM/gqqcmND2ys2ZgjDpzJs=;
        b=SEKvzIoiyFVOaDr464/gt8Dz2G2ZEp5Ppsb7C9BAZx30rK3nV3UWZnfNXIsVbX/YfD
         G0gURlJxuXp2YzB8iIzigauSCcxNIxTFl5oR2pD1mum04IFX58xschrGHzH1W1NeJpb3
         k2RHQqSp/zkmngyJjJiqiMCCKQKoxS7abrNW56pUR/lchJaCJjvXlwe1JKbX9b21vOTD
         sZaGcGOER4DLKgz7UjlOfMfWX+MX8PW8QogNCTNQpp0U4bnzrnzsX/M3+Duv/ejCKawD
         qoSODPqZV58BOdTifO/Kkhh7fLiM0qOXE3AgL6ozr89dYQhBXDf6tANXoVtl44DBUFHt
         kFmw==
X-Gm-Message-State: AOJu0Yz0fe+KoFg8yFFC5tOAre2k7bA9ivlmv7L1NWKCNYYJpHQX2ep5
	hOk9HjkHscc4zhCrnZYvZILMG2yn+mY=
X-Google-Smtp-Source: AGHT+IFeKsBTN2brpOU4Y3AL5WrMUbO3zqWkwkGtPlUjD+CaUdIPhECZ+XHs5Y79IqA/yu1+3CSnlQ==
X-Received: by 2002:a2e:6e19:0:b0:2c5:23e3:ed11 with SMTP id j25-20020a2e6e19000000b002c523e3ed11mr4976884ljc.30.1699871061504;
        Mon, 13 Nov 2023 02:24:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id be14-20020a05600c1e8e00b00401b242e2e6sm13340554wmb.47.2023.11.13.02.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 02:24:21 -0800 (PST)
Message-ID: <3b6d1f8066841e87bbbd31c55226209e54c64e03.1699871056.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1537.git.git.1699871056.gitgitgadget@gmail.com>
References: <pull.1537.git.git.1699871056.gitgitgadget@gmail.com>
From: "Haritha D via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 13 Nov 2023 10:24:07 +0000
Subject: [PATCH 05/13] fixes for build errors
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
Cc: Haritha  <harithamma.d@ibm.com>,
    Haritha D <harithamma.d@ibm.com>

From: Haritha D <harithamma.d@ibm.com>

This patch has fixes for build errors

Signed-off-by: Haritha D <harithamma.d@ibm.com>
---
 convert.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/convert.c b/convert.c
index da05f6c2e51..d3f204b4c29 100644
--- a/convert.c
+++ b/convert.c
@@ -1315,8 +1315,8 @@ static struct attr_check *check;
 
 static const char* get_platform(void) {
 	struct utsname uname_info;
-	char *result;
-	if(!uname_info.sysname)
+	char *result = NULL;
+	if(!uname_info.sysname[0])
 	{
 		int index=0;
 		result = (char *)malloc(strlen(uname_info.sysname)+1);
-- 
gitgitgadget

