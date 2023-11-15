Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E07F23A5
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 03:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fud-cz.20230601.gappssmtp.com header.i=@fud-cz.20230601.gappssmtp.com header.b="mDkJzh9d"
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2EE18F
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 19:34:56 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6bb744262caso1481640b3a.0
        for <git@vger.kernel.org>; Tue, 14 Nov 2023 19:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fud-cz.20230601.gappssmtp.com; s=20230601; t=1700019296; x=1700624096; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QBdIt3p0dAk1PaJHzqbyqwbjiZ4ZWcTIRW8Tfd43Ews=;
        b=mDkJzh9dUVEBDJ1v7RkyRdpUcYXrDYuVQPGiTS66GLdJ5yBwFV7rkMsfni2vTKVj5M
         B+jewgdLKHLUof4VG1ABsmjjHNqNdouAhE7dbCiDqh1t9dImbZPctIakF4qS8XOlTwjG
         Tby4EUjD5YK4Iqfauki2tzymutgIodu6A6wR53M6OnwsV6TnUVxKyWzuSK9uY6r4jRxV
         QRFHUkO8nffcz1Q95kdjfpWRgtFbpgBaOXoSv5l6MYK+ue5jIkRRQkpWfcYRa4ots5eG
         8Q/dzmWaDtNDFPEKuy/L56aJUm+RMnqf3Jj8uNWnHusHHW3QLGY1fFursA145Svt70xk
         +5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700019296; x=1700624096;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QBdIt3p0dAk1PaJHzqbyqwbjiZ4ZWcTIRW8Tfd43Ews=;
        b=vWOkz8S25nONBR8TcHHwCEzbzltCLL4B5mJi7qy4PE7hEmLFgHkSMMU1td/1ps8YGg
         Nrs92sTqYFiEI7tSc5L+6mRX1Y12YJZ0iJya2jfvoEZ2n3bFLUytOl9UKufjfuAxqKOV
         5QsCNdNsTRIWPVdHKSJKhcUgbkHoVeld79Mxjsl99sE64px3cMKt2aerlj9LYqAyg+mm
         LH4PynRKa74JPSweSCynnHFOeyqKN9Fe7pSwyKbdx+22Gq4VXn+/MiEZWHpFEa6osvRB
         JzQ6fhbWlwaYCyyhpl3reYi5r+2dtg5OAkbuEZdV8olQJkksCefp+3chYciLQq2TPsC8
         3prQ==
X-Gm-Message-State: AOJu0YyvoHgzz1kS8bEe9HyUcEZo+9daTtqxcIvcqGg3aJi1B1AzzWuH
	Q8Ax0Mku5qYqYRQL1gUW27YRBO/7FcwfxRl2Ug38bsaoGJ0D44h3uU8=
X-Google-Smtp-Source: AGHT+IHV/ow+CUNWnkKMGiSByOebHTBjhciKxgxaiEgp84a4DPi3/xro1e5F4L4+PHwRWIkbidoKqNEnA3ETK82fmqU=
X-Received: by 2002:a05:6a20:8415:b0:186:10ae:152a with SMTP id
 c21-20020a056a20841500b0018610ae152amr1770135pzd.4.1700019296202; Tue, 14 Nov
 2023 19:34:56 -0800 (PST)
Received: from 305313025478 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Nov 2023 19:34:55 -0800
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
Date: Tue, 14 Nov 2023 19:34:55 -0800
Message-ID: <CAGE_+C5pnASOsrDr4ehNj-deYbSTr=pRgPcWqq5VSQs-Y08ttQ@mail.gmail.com>
Subject: [PATCH v2 5/5] http: reset CURLOPT_POSTFIELDSIZE_LARGE between requests
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

`get_active_slot()` makes sure that the reused cURL handles it gives
out are as good as fresh ones, by resetting all options that other code
might have set on them back to defaults.

But this does not apply to `CURLOPT_POSTFIELDSIZE_LARGE` yet, which can
stay set from a previous request. For example, an earlier probe request
with just a flush packet "0000" leaves it set to 4.

The problem seems harmless in practice, but it can be confusing to see
a negative amount of remaining bytes to upload when inspecting libcurl
internals while debugging networking-related issues, for example.

So reset also this option to its default value (which is -1, not 0).

Signed-off-by: Jiri Hruska <jirka@fud.cz>
---
 http.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/http.c b/http.c
index 8f71bf00d8..14f2fbb82e 100644
--- a/http.c
+++ b/http.c
@@ -1454,6 +1454,7 @@ struct active_request_slot *get_active_slot(void)
 	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, NULL);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, NULL);
 	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, NULL);
+	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE_LARGE, (curl_off_t)-1);
 	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 0);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
 	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 1);
-- 
2.42.1.5.g2f21867bd5
