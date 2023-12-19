Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2858C12B70
	for <git@vger.kernel.org>; Tue, 19 Dec 2023 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYi1TBP0"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d190df5d0so24803185e9.3
        for <git@vger.kernel.org>; Tue, 19 Dec 2023 00:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702975325; x=1703580125; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/ZL9NM/c0Cbe4DjhVVMZWaNRupuk8zUqiiLwtorE2s=;
        b=bYi1TBP0hZU+tZnKAEf6a1ubqbd7KpETyy8r8pjVzoLZ5eKld4O4Ac6Wv/CLJv94yv
         TJuYqqmVcTQT+02mSksBbLunNYtcqrewufyZfbwIs0as6pCyenqJMWuvqFu7wUj1EH5R
         y2qPy6kCF3yhxwTgwEdTLhjkpBOEMO+LdzTlceX4zQa5yctJGCZ8lvxlkEjProrrbV4Y
         HIwTcIIqnIo+PdN+12Y7Fk0vrtdsdVDak8wuX2dH2jjhOlLP46DD9aIYO36p0tMtUjXf
         zvNEpMUVkR/8B4gME3pPN3Iy6piK3TDjuKjruBsJaxCYlfH7cleP1YGlWE5gvZpnr8Ds
         WlmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702975325; x=1703580125;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/ZL9NM/c0Cbe4DjhVVMZWaNRupuk8zUqiiLwtorE2s=;
        b=PvYEZ3jXtoIl6r/SR/hWL/4XrNhSCIlhu0JG76d4IuO6Gfw8H8CiJvc101SxpLxqPh
         PdihjLYVelDDK/wVz54O3eipLeAu+hZF/nN5KsmNa51CsBk9kUQ6SF3mPjSit+dQRuSq
         xYb+Q6FlLxRPxFE8Mdfeha8nkveqjEjVwXRgRYUXwo35lMiA2qNjUlUTkBlnl+yYysM4
         exyEk/bju30Ofh4aIc8h2v10bpGxB2M/D8om4gV8j30VaGw1TeHDpRQ3LGVi9yJLYGLo
         Sj/xB8mjyuAnpX2VQSVThRdtRoszJOmwT/WxJvKDzPCXxXsEOhAxsNQrue4bRTbr68eq
         Kpfg==
X-Gm-Message-State: AOJu0YzbHI+lJJ0N3LDO60ZIdz/UWs8GVTkFf1TZLUG0IfulBb8X9UdB
	/Yy0dKJr6sF/rnE/v1NW+s7Gil5rG8A=
X-Google-Smtp-Source: AGHT+IEfFqijo+O7z7GPQ4IgTmNQQ17rXzsCr89nz2X7wPbWl7dzYnxIkqHtoun6BwBKj2Asb0VtLA==
X-Received: by 2002:a05:600c:4384:b0:40b:5e1e:cf7 with SMTP id e4-20020a05600c438400b0040b5e1e0cf7mr9013512wmn.50.1702975324568;
        Tue, 19 Dec 2023 00:42:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n33-20020a05600c502100b004030e8ff964sm1812267wmr.34.2023.12.19.00.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 00:42:03 -0800 (PST)
Message-ID: <e5c7f29af439c48f59b2f35af93a7972e66a5b6b.1702975320.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
From: "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 19 Dec 2023 08:41:55 +0000
Subject: [PATCH 4/8] SubmittingPatches: update extra tags list
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

Add items with at least 100 uses:
- Co-authored-by
- Helped-by
- Mentored-by
- Suggested-by

Updating the create suggestion to something less commonly used.

git log |
  perl -ne 'next unless /^\s+[A-Z][a-z]+-\S+:/;s/^\s+//;s/:.*/:/;print'|
  sort|uniq -c|sort -n|grep '[0-9][0-9] '
  11 Helped-By:
  13 Message-ID:
  14 Reported-By:
  22 Acked-By:
  27 Inspired-by:
  29 Requested-by:
  35 Original-patch-by:
  43 Contributions-by:
  47 Signed-Off-By:
  65 Based-on-patch-by:
  68 Thanks-to:
  88 Improved-by:
 145 Co-authored-by:
 171 Noticed-by:
 182 Tested-by:
 361 Suggested-by:
 469 Mentored-by:
1196 Reported-by:
1727 Helped-by:
2177 Reviewed-by:
2202 Acked-by:
95313 Signed-off-by:

Signed-off-by: Josh Soref <jsoref@gmail.com>
---
 Documentation/SubmittingPatches | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 32e90238777..694a7bafb68 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -348,6 +348,8 @@ If you like, you can put extra tags at the end:
 
 . `Reported-by:` is used to credit someone who found the bug that
   the patch attempts to fix.
+. `Noticed-by:` liked `Reported-by:` indicates someone who noticed
+  the item being fixed.
 . `Acked-by:` says that the person who is more familiar with the area
   the patch attempts to modify liked the patch.
 . `Reviewed-by:`, unlike the other tags, can only be offered by the
@@ -355,9 +357,17 @@ If you like, you can put extra tags at the end:
   patch after a detailed analysis.
 . `Tested-by:` is used to indicate that the person applied the patch
   and found it to have the desired effect.
+. `Co-authored-by:` is used to indicate that multiple people
+  contributed to the work of a patch.
+. `Helped-by:` is used to credit someone with helping develop a
+  patch.
+. `Mentored-by:` is used to credit someone with helping develop a
+  patch.
+. `Suggested-by:` is used to credit someone with suggesting the idea
+  for a patch.
 
 You can also create your own tag or use one that's in common usage
-such as "Thanks-to:", "Based-on-patch-by:", or "Mentored-by:".
+such as "Thanks-to:", "Based-on-patch-by:", or "Improved-by:".
 
 [[git-tools]]
 === Generate your patch using Git tools out of your commits.
-- 
gitgitgadget

