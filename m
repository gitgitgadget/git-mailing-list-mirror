Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F2B125A8
	for <git@vger.kernel.org>; Tue, 19 Dec 2023 08:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6uePAS/"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40c3fe6c08fso49052075e9.1
        for <git@vger.kernel.org>; Tue, 19 Dec 2023 00:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702975323; x=1703580123; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IvwM4W/NlDHwNbKAl3tiFP3CE30lrBYpPWWZEMxuUY=;
        b=B6uePAS/LnayCuaUTKXjTrAqLW9e2lqU30sq1fLbF1rYx7jRzPmt0W1E9HK8YQN0cK
         aPgnz8iX9gv/D9ULNPj1aWcGYoroQWs6vjSN8OYvWaHRpamDZyNhloq+f7BHY4HSbeeg
         b0Io99w4Yxghk8ab/XZ1N6ZCfF1bnxoHnKWfP4H0cqaiOKQs4sVzCiDcbuZpohYvM32q
         xSRKl/CAP3U9S3NX9n9eJ4WtvolZPwUFNGBUahRy29OQAhGkdJ4LOjQIGjJLUC/Tgpp1
         DD8SFktCWF/87DW143Clws9V62o+CweevmccOxU6ma1YaOZd6QQssPogLoNm66HIV0CP
         mzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702975323; x=1703580123;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7IvwM4W/NlDHwNbKAl3tiFP3CE30lrBYpPWWZEMxuUY=;
        b=iG50Ly6XT3nyhS+Ehmbu9x6V7Qzb+aPpHsoDzlQ4pUUy5iNuOyNNzk2fOp895cWDIA
         bN/S4wXxkjKyrT5jAhf43ZNecBLLPW7Zr7Q+xFDGKPZKwM2cPtiCXjKuOdnNN5zirtvx
         Ir9LL+Y9hDQVk28zSZt22pdN/WGHoZthjfstzu+QicpWefpB4JPY9VRsjXj+Yp6Xv5Ea
         Yo/PV/g0yHFZgdfv/OmduGk1rPx3IH2dbqE0x3dkQjtPwwtKzqYobhzqLnCcTBnGu3ER
         iP8EsXvotHCtEmvY47TJOMXXrpBQWAVuqd+HqqKjFArqLkNr9J4MeSb272Af4HwqJMQo
         ZfBw==
X-Gm-Message-State: AOJu0YzpWn3LZohT0FvLeG8QUUbBWuHWbOQBH7gFmmyaulCoYu2Y644T
	SnQ6BTNh+Wv67tByPYw8Ze0qfOumf8k=
X-Google-Smtp-Source: AGHT+IHZf96ImVRheKihFUkxuYBnLRQeBvO3Vp8DL+xuu7OoXs3k7mx/dnTo6tOx+KXenoyASdiAlQ==
X-Received: by 2002:a05:600c:c1b:b0:40b:3fc7:c88a with SMTP id fm27-20020a05600c0c1b00b0040b3fc7c88amr6073775wmb.39.1702975323386;
        Tue, 19 Dec 2023 00:42:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id jb2-20020a05600c54e200b0040c4afa027csm1719404wmb.13.2023.12.19.00.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 00:42:02 -0800 (PST)
Message-ID: <22d66c5b78a6930e195141df848266cac099ca08.1702975320.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
From: "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 19 Dec 2023 08:41:54 +0000
Subject: [PATCH 3/8] SubmittingPatches: drop ref to "What's in git.git"
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

