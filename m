Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855F563D6
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 04:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CuS33hJ2"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d5336986cso42590725e9.1
        for <git@vger.kernel.org>; Wed, 27 Dec 2023 20:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703739335; x=1704344135; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8D8jHbiMD2I+daouYbFB1ELetJoaE38mbXQSDTUQJo=;
        b=CuS33hJ2/qoF4MKnRefRoIupS1K0jCjEaoEibD0E2CNUZRpciTdtQgkK63tKbeQdov
         6WpUHqCOAZ7Zt1Fe6mu4BQXlV91Gi15cOcVLrc8cfe6hn1ZgZRO0JWQqxArs4GJipMUF
         O177fQOudLYtT2CHZ01Bf8aKNbOvciDKcEfkgMpyfwKKKnOjvARe1wbnacD1lpBh1WMd
         kO/yPtsXBBS8JcHhRNNfH2HMhkvG7H3siDyOmKuqNeSVAmIqh/MMrWd7N6OhaNKq007w
         ukLMLaBb0yhLb5PAgtbnW9y2brxoh4P2/YnsjAhGFOWP6dZt0bjnKay39oBu+PIk9SpJ
         S7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703739335; x=1704344135;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8D8jHbiMD2I+daouYbFB1ELetJoaE38mbXQSDTUQJo=;
        b=weoxVRtOLmAPOixuViP6POnmvMo3fZP6MVGItxTEgBsGA0QWQJbEV6MqXTXMm21Ovs
         ZSlkkhmYXiLTUtXizn7hGJMnPfY2a0KB1li201QfJvB/EcRyOTpBYjBVG+Gt0wlD79BI
         Kpa5+EHiTx1ZDzOnnAEuCaCbmoXVcAXBG8jP55CMtI7SlRYh02eLPB4GnBTP63iKo1pX
         10FnLLYW6Wmp1jbCsBecBwd3P3FoI+T1Hh+diZipy5NULyHSAKh5HKh5E5odVbGGoji+
         ns8koNsCDqut+aRT6GGuRfMsTWWeTml82YWCPO/BTzROtxyHMwVaL3ZKbFO39vV7O9+3
         9BQw==
X-Gm-Message-State: AOJu0Yxkvk/SuKTftoCX8jQEJEREU//AencFCZYzD3AnTqfUsnTosIKR
	4iMiIdADInhDCYR6rhyw16xztKlQPQ4=
X-Google-Smtp-Source: AGHT+IFOFNGEZHnKQfr3NzfNUVJHZW9CxR3+BR6Zua4Shh/JKLoPoMNcHfvit4oLgkdQY4RzoZJhZw==
X-Received: by 2002:a05:600c:4da1:b0:40d:3c4e:a5a4 with SMTP id v33-20020a05600c4da100b0040d3c4ea5a4mr5068677wmp.96.1703739335079;
        Wed, 27 Dec 2023 20:55:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z10-20020a5d4d0a000000b00336a2566aa2sm11676242wrt.61.2023.12.27.20.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 20:55:34 -0800 (PST)
Message-ID: <b1b75cc6a3e4b6829a60550b394456dcb2a6ee25.1703739324.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1623.v3.git.1703739324.gitgitgadget@gmail.com>
References: <pull.1623.v2.git.1703176865.gitgitgadget@gmail.com>
	<pull.1623.v3.git.1703739324.gitgitgadget@gmail.com>
From: "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 Dec 2023 04:55:24 +0000
Subject: [PATCH v3 9/9] SubmittingPatches: hyphenate non-ASCII
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

Git documentation does this with the exception of ancient release notes.

Signed-off-by: Josh Soref <jsoref@gmail.com>
---
 Documentation/SubmittingPatches | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 5e2e13b5e09..e734a3f0f17 100644
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
