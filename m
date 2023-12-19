Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656C513ADE
	for <git@vger.kernel.org>; Tue, 19 Dec 2023 08:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbGgwN75"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40d12b56a38so33258295e9.2
        for <git@vger.kernel.org>; Tue, 19 Dec 2023 00:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702975328; x=1703580128; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgKA2Zz3ci6RKvd4YBkO6M/PwiKD3KRRYNdreB/ehfI=;
        b=XbGgwN75z94Ds+GamPGn+dVZbhG80gWQhqgeuqBIWDBVNkWhyTiv5Y+WpJ/6g8hw6o
         2drZUw+xx2tWT6aSWuFNfzm+ocktj3Dvm06K/X4AJwd+yRphnr0wxNWBoOctdVT6azg7
         cmuHCTz+wv6P9U6iWG/5eJ/MUqYAZ/7EbNNJ/zayg9cTwOc1Dzm9sUlsxzQ+faO27fsY
         /w01bIRPfm9C51sChaO+sXwPk51MME/hGpUknB8eFHKnKIVcrc5K2haFi/CgMYm1JjVI
         O73gABaHBpIBeawb+cQmifFzzon127oVWpVVvWKVeXgaOWkY3dMGm3lxdK4IISg+X5Ly
         BRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702975328; x=1703580128;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgKA2Zz3ci6RKvd4YBkO6M/PwiKD3KRRYNdreB/ehfI=;
        b=oYbUKnYRowZtp4ghNi+1Jivlqjia3zhxO15+voPBJflX3w5cOLtGjKPlS0OdL7v40o
         B1sinWiZqZwgVWOijaPM2EZPbRnU9zaweYZ85mdNGAYckHYjQNc5EpksBf14T0/NioAB
         gAvkua0oAobX0J7WaRzIWszBr7FaFMZj1QBtSzg41W5rAhXEGMLXpy3g3Zu/kTzfsjRJ
         xDNMT4QaXT9MFHQSOTYpD6ni96IUdawwNAJs1qxM4TUDrDQMnmjHAhoFAEFqknkijBZC
         vK4xVcHTcCmQyVMe+qBfJDOcf90U3nfniVf0d5mA2u2huIaaV43PfeREl3CipV39wBuI
         3xqw==
X-Gm-Message-State: AOJu0Yws2q2brfhFWoKC5aP9YHg6YFaTV6FtHsykJB6mvdI6y326ODYe
	BuNA2f7jlVqlr8icQAGLuZuhpuednmA=
X-Google-Smtp-Source: AGHT+IEihPhnblG3clHAMvAA04Lyl91jwFu56rvCC0Hvt5fH943rbbJDJRSmeevJsXL0LTv8YXAU2Q==
X-Received: by 2002:a05:600c:4d0e:b0:40b:5e1c:2fac with SMTP id u14-20020a05600c4d0e00b0040b5e1c2facmr4285628wmp.60.1702975328117;
        Tue, 19 Dec 2023 00:42:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m34-20020a05600c3b2200b004042dbb8925sm1764231wms.38.2023.12.19.00.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 00:42:07 -0800 (PST)
Message-ID: <92469324813702418a9db0b2e760580518b225cd.1702975320.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
From: "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 19 Dec 2023 08:41:59 +0000
Subject: [PATCH 8/8] SubmittingPatches: hyphenate non-ASCII
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

Git documentation does this with the exception of ancient release notes.

Signed-off-by: Josh Soref <jsoref@gmail.com>
---
 Documentation/SubmittingPatches | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index b4fa52ae348..3c53592cfc8 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -700,7 +700,7 @@ message to an external program, and this is a handy way to drive
 `git am`.  However, if the message is MIME encoded, what is
 piped into the program is the representation you see in your
 `*Article*` buffer after unwrapping MIME.  This is often not what
-you would want for two reasons.  It tends to screw up non ASCII
+you would want for two reasons.  It tends to screw up non-ASCII
 characters (most notably in people's names), and also
 whitespaces (fatal in patches).  Running "C-u g" to display the
 message in raw form before using "|" to run the pipe can work
-- 
gitgitgadget
