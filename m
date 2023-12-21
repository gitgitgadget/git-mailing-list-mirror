Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF20D62801
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 16:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDEtsHWg"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d31116dbeso11199435e9.3
        for <git@vger.kernel.org>; Thu, 21 Dec 2023 08:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703176874; x=1703781674; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bo9KrKd0uarMaCQRl4V5z2H51GssgCe/Oq2aIPJ3taY=;
        b=eDEtsHWgjANoF21Yr7bF337uVLt2SZ7Zu346vBXsvHFGkPxiKbJMTPpM/M9StQcn5j
         NmQnNPyk4iu9l6YunJ0+nMOrO2CK0BHV2YyxCqgFfsxUPw5znTmbFWrpRbu8CxI0s9K9
         Mk0qoscx92e9O9TxIC3Ap9Rupk9HsUj4qcKeMOo5uMaPXYvpcsKrYavoCMC8AbaDV+OT
         sVOTvml6TI6rbw3K63o3FHSfWtyePKY2N8jLsgML2hoaCSkIa2T8xUK5ffYXc/Olx7G3
         wbZT3svKUZC/iEtN4BUNcDB2YFl8bwK2r9oN2TVEJh4k5/Eip4rQquy7oTYxuKTqNY/r
         dP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703176874; x=1703781674;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bo9KrKd0uarMaCQRl4V5z2H51GssgCe/Oq2aIPJ3taY=;
        b=Ds8ZgLg2wg+PnXGtVpv3so+vOc1ugU0GKYuT+vKgW3Ba5izwoNIzYl4GrCK9ZV4SOd
         KjN2360jop2lLwvVOQpG1b3n/bMKnB5OXPV+eo42FVRAWr5xWHMASAdO4hXcAnQVlJoj
         rAtgApeRYMU/vvdDHCNn9AFFu6834G3LvKGmViEFSYMb8vauoeIxqz5g5qSUXBMo7xUv
         DTa0jms1rcH64WyAC8iImpd8rSTBd3hb1klz3hJuQ3hS/Xws6FS8Eal1CGxXdO0mWUHl
         26aXq+IblGc9onkSH1ByVNAQ8VG+2Il9XEt6rqMtCaICFgjR2NUKwGmfI9B9ebCM0gvQ
         gjJw==
X-Gm-Message-State: AOJu0YzdY82l464fifvo2V0Y64DZUuC9nMOc/fXZzPAOjsgJ5PCIdAHr
	VrcxESq2vvUQC1+2IkD1WYH3OPIyB54=
X-Google-Smtp-Source: AGHT+IEAo+BMOyrVmSq/uFXGS4Wzm7Q2lSVG65enqM6pl5XQ29IjnD0DF986IKxOAGLET5gBqtSZ2g==
X-Received: by 2002:a05:600c:2b0e:b0:40b:351b:fcc2 with SMTP id y14-20020a05600c2b0e00b0040b351bfcc2mr1256wme.19.1703176874573;
        Thu, 21 Dec 2023 08:41:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m5-20020adfe945000000b003366c058509sm2392129wrn.23.2023.12.21.08.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 08:41:14 -0800 (PST)
Message-ID: <a4878f58fe487460bdcf94e6de08e2d03c3bfa5e.1703176866.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1623.v2.git.1703176865.gitgitgadget@gmail.com>
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
	<pull.1623.v2.git.1703176865.gitgitgadget@gmail.com>
From: "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 21 Dec 2023 16:41:05 +0000
Subject: [PATCH v2 9/9] SubmittingPatches: hyphenate non-ASCII
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

Git documentation does this with the exception of ancient release notes.

Signed-off-by: Josh Soref <jsoref@gmail.com>
---
 Documentation/SubmittingPatches | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index cb0dcce6a17..9283eb0ef71 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -699,7 +699,7 @@ message to an external program, and this is a handy way to drive
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
