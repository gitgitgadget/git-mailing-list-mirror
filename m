Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02F7539F8
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDrU3gMx"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d05ebe642so12969945e9.0
        for <git@vger.kernel.org>; Thu, 21 Dec 2023 08:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703176867; x=1703781667; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcI2SqQQB4Jltt9lH8a1zFwnKso4M1EWV/+giKCyLKc=;
        b=SDrU3gMxOsY34pD8/8LO4TJc6NKkFIPQ0DFPg3Z1O4tjly4O5hAnoW7reJthqLWAZb
         DeZnnburyYi5CWqeW4zezEIyFrFJgkchL198HxTqq4vUDrhx71sYzJpHl5l0F8izKsOG
         cLTfE0Om36SUluIX5vBOTNo51aZsUO1QIbrpbao08LKFma87b0DnozbAWOiqyvZe+HQo
         8VrmaVFyYvWZylpd7+UtPsxvn4YOlFhETTh3gSft594CDHIBL97yz63xej7HXowyA2mY
         GBb8dBcjS3He+t/3EuMPQEA5qCfZEjZr4HmdqSgJQhemrov44UdZw2vCR9ZRoDb8aKG/
         I6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703176867; x=1703781667;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AcI2SqQQB4Jltt9lH8a1zFwnKso4M1EWV/+giKCyLKc=;
        b=wKsygylqBBwf/EjX6Sf3fpB+uIRIAkmHLhCRbF0Q06z8ElYLFonnKDeVZiiSXmYTfu
         2Caqwuitl15ICcL0hNUQ6kfvOWtM/T+OkhSpWPug6BBX8nSei9BBeuoNRNQU+2pNziaJ
         n7S9lEPXF96nHNpZ6+9DDRCaFS/BmrJEExfledSWpBibjqxZSRKKdiRENroY5TZN+D8+
         bWerM6iUG9Jidrix1I624jOi0jlu3XgsW125hBqMjKJeL4JKi7EOkgNixPea+TbEmcHl
         CFu4AMVTAzYreXCG0hm1DviNP0y0rpAaqDQcHJ3Z4qx9nPSs6JfJdIuwdWxvutVMxZgy
         GGwQ==
X-Gm-Message-State: AOJu0YyWPnAXsTUc7F+VZfujxVP/c5L20qzqZ04GxGhudEO5xxUWbxin
	2QGIxOK4UXpyxYt05nX5tt6wMP8Jnck=
X-Google-Smtp-Source: AGHT+IEh+P3ctgX5AMlsuCz0V+tb8BHkMwjdY46gV7nS9EwSIavibr+vzpIcrjlltKgDKCJoIfMZWQ==
X-Received: by 2002:a05:600c:1f11:b0:40b:5e4a:233f with SMTP id bd17-20020a05600c1f1100b0040b5e4a233fmr613707wmb.65.1703176867427;
        Thu, 21 Dec 2023 08:41:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c4f8500b0040b36050f1bsm3856433wmq.44.2023.12.21.08.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 08:41:07 -0800 (PST)
Message-ID: <b9a8eb6aa4e87cd96fbf2b5d514350508076d756.1703176866.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1623.v2.git.1703176865.gitgitgadget@gmail.com>
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
	<pull.1623.v2.git.1703176865.gitgitgadget@gmail.com>
From: "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 21 Dec 2023 16:40:57 +0000
Subject: [PATCH v2 1/9] CodingGuidelines: move period inside parentheses
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

