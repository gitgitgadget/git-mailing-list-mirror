Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C6E647
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 03:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fud-cz.20230601.gappssmtp.com header.i=@fud-cz.20230601.gappssmtp.com header.b="Hk92TkTN"
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168F6182
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 19:34:55 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cc703d2633so7784965ad.0
        for <git@vger.kernel.org>; Tue, 14 Nov 2023 19:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fud-cz.20230601.gappssmtp.com; s=20230601; t=1700019294; x=1700624094; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zfpf1krU+8LQ1xtLDxEMWh3mlz6AhALevkjyZtKxMAE=;
        b=Hk92TkTNmshA3Gnrqf/kenk+Jd4ki/zH0bdOV7pbA4V8OgcEEZdYxuXd+S4LYJ5hFw
         NU1f9eSDdkSC+f/WwKPQUNAJ6Uw4HYwVQjc2IEKF1J5+7zx9gPWrAu4U1B9pVtRtLo6Y
         c2A9OzZRpkhJwvS7U82BM9xJuLl99bPLVmAAz9q/JyPJl7zEFnGjqXPHgHNCKj/VCZzs
         4H69+h8FeGJzC9X4zqq9ek2l2E9s7CJVdgTJZxCDCvdMh936ZgWMPfwkOLaHuBq9ZG43
         zaDKQY1R2rYauLu/Xq+twhNT3wIpMaUcdSuLO4BggD1/zy43I2fzJNoE12o6o0zxKwdH
         EgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700019294; x=1700624094;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zfpf1krU+8LQ1xtLDxEMWh3mlz6AhALevkjyZtKxMAE=;
        b=G0ZAVSXx7l9BthRavvIqWs52WyWSDs9X+WBSruwYo4cjqEaDn7DbtdSatANpqfz3GK
         bJY2KgA7hfkfUb8tcKIc1nHXQOwVm5Hn6bFXBZCr2VKfLhsL6GO8IeLQJP4WX0FtHMXC
         X857ipsxPJ4kcxebFW1dWfsSuUIb3ZkHk8Sp+NnRfYau9bp+vHBeH37/7dTGTSboj9FU
         US5jXvvPYKEOyEOnwKRCgZKrccFMnyeFrecmJ4QZb5UvFApkiUzTwlZhbJLqR2hUBtBt
         1ZQFbn44V/LK/kKoCn1qdQx595zlCy9fs0ZBlX622fksX0hGY0IehYL7MUQ/LK+8Ro5Q
         R4kQ==
X-Gm-Message-State: AOJu0YwQkLGsPq1TkCmY5BAynDhxNC5wnUxDR5bmMt8fDH62xlh8tvUv
	ZUZrn818m9GmJ230c3hvmPeCSCbTocMyjlDBtLufrcjOeA/2Pi8IKD4=
X-Google-Smtp-Source: AGHT+IE5EMh3fw1FFAx4igPnw8+m7rvdDDIYePhveOGa/jnFizSqwE3hzt4x6YpZAMVVQ9OLnOWuBkwkWjzv+O0JTDs=
X-Received: by 2002:a17:90a:488e:b0:280:4da8:97a2 with SMTP id
 b14-20020a17090a488e00b002804da897a2mr4123097pjh.3.1700019294301; Tue, 14 Nov
 2023 19:34:54 -0800 (PST)
Received: from 305313025478 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Nov 2023 19:34:53 -0800
From: =?UTF-8?B?SmnFmcOtIEhydcWha2E=?= <jirka@fud.cz>
X-Mailer: git-send-email 2.39.1.windows.1
In-Reply-To: <20231115033121.939-1-jirka@fud.cz>
References: <CAGE_+C6DJMAO0bj5QHoKBBV3gMEMtZ-ajJ9ZnDGYq6eorr-oig@mail.gmail.com>
 <20231115033121.939-1-jirka@fud.cz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Nov 2023 19:34:53 -0800
Message-ID: <CAGE_+C58LWwF5YAm+S3Ynev+mTnm_ZSVuir9sZsHmeB+56T1kA@mail.gmail.com>
Subject: [PATCH v2 3/5] remote-curl: simplify rpc_out() - remove superfluous ifs
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

Remove the second set of nested `if` statements and an early `return`
in `rpc_out()`, because they accomplish nothing. The rest of the
function would behave the same without any branching.

Signed-off-by: Jiri Hruska <jirka@fud.cz>
---
 remote-curl.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 428dd70aa1..690df2a43e 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -706,25 +706,13 @@ static size_t rpc_out(void *ptr, size_t eltsize,
 		 * we need to refrain from reading.
 		 */
 	}
-	if (rpc->flush_read_but_not_sent) {
-		if (!avail) {
-			/*
-			 * The line length either does not need to be sent at
-			 * all or has already been completely sent. Now we can
-			 * return 0, indicating EOF, meaning that the flush has
-			 * been fully sent. It is important to keep returning 0
-			 * as long as needed in that case, as libcurl invokes
-			 * the callback multiple times at EOF sometimes.
-			 */
-			return 0;
-		}
-		/*
-		 * If avail is non-zero, the line length for the flush still
-		 * hasn't been fully sent. Proceed with sending the line
-		 * length.
-		 */
-	}

+	/*
+	 * Copy data to the provided buffer. If there is nothing more to send,
+	 * nothing gets written and the return value is 0 (EOF).
+	 * It is important to keep returning 0 as long as needed in that case,
+	 * as libcurl invokes the callback multiple times at EOF sometimes.
+	 */
 	if (max < avail)
 		avail = max;
 	memcpy(ptr, rpc->buf + rpc->pos, avail);
-- 
2.42.1.5.g2f21867bd5
