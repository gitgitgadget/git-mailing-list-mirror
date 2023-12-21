Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C9F58214
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 16:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m75eHebX"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40c41b43e1eso12369345e9.1
        for <git@vger.kernel.org>; Thu, 21 Dec 2023 08:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703176869; x=1703781669; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IvwM4W/NlDHwNbKAl3tiFP3CE30lrBYpPWWZEMxuUY=;
        b=m75eHebXoC4E7f7Ux8GZyStvcsxdbl1v4Hk6AQmjw2h/HDbXUcbSr+4sqYMlAhCWD8
         uEq10+OAu3yBMDC6FcPaqHdIohUb2lg53BoDNvbGkd6tPwZu764JjUXVInG1xXhG+M3e
         QH8NBx/Oi04j2vWbqjlWgkURKyOqJMfGRsLKcI25xJeSQuc8WmjjASfDUP4/IBE6m17U
         wE/l3I/oV19kKHQSfHP2vpQFnAZFZ/AAdyCfbkS0xTgnrBrddGPzg5UgZFGqI/6LyK4Q
         XVFsgx0UU9unAUVXxh6Nrj3DFj5dwZHakEacpAw4PXtkYo1sHaU6fBemKhPfNtkPbdnY
         8XGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703176869; x=1703781669;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7IvwM4W/NlDHwNbKAl3tiFP3CE30lrBYpPWWZEMxuUY=;
        b=qoXJKkPb3LpzIOcMtVfPg+i55QZqQo/lw0/IJxQNhIbriBpxLdM5LwlmSR6KCrUUl/
         UwPX/frBfW2rU9adYLB8lPmQplK8xfaMHJmZbODK8bY0mbtY7VkPRH0I5knjg24g01K1
         7wMl1TSMI25fU6KifJjsgyEIv54NjHJolsheVsAUzFhDfnBN0KyevLuWTAEdS3hGx4JD
         Cj34UbTWp3e13kTSWIbNWudnkrrbzvWPV7miY2jfms4GsCh5ocIuKjBxpSNPgyZxOnGm
         XvenFfqgL/N9I8OT1Sc55r1FPUVSoQNsoWFHR0pSUlf0n+aXEqLYYRJbxQRacEMaODqb
         AAUA==
X-Gm-Message-State: AOJu0YyCPg3rlYXjfIiEIc2qo75HBpZ6vAwvPuqZOTt6uZfxPYhPQ2xQ
	U5zAhBy+nkt9Ek2SJwTyggJlY5XlYEA=
X-Google-Smtp-Source: AGHT+IGzY2zp/NsAFPJCB9BwwVPhpRtw44XY6WzoioMRue8EX9HC+lJAkJLWblGJ3rISPWRRCWNWJw==
X-Received: by 2002:a05:600c:511d:b0:40b:36e9:bf4b with SMTP id o29-20020a05600c511d00b0040b36e9bf4bmr8879wms.41.1703176869061;
        Thu, 21 Dec 2023 08:41:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c10-20020a7bc2aa000000b0040b2b38a1fasm3804691wmk.4.2023.12.21.08.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 08:41:08 -0800 (PST)
Message-ID: <22d66c5b78a6930e195141df848266cac099ca08.1703176866.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1623.v2.git.1703176865.gitgitgadget@gmail.com>
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
	<pull.1623.v2.git.1703176865.gitgitgadget@gmail.com>
From: "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 21 Dec 2023 16:40:59 +0000
Subject: [PATCH v2 3/9] SubmittingPatches: drop ref to "What's in git.git"
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

