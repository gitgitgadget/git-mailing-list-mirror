Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2636564C
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 03:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fud-cz.20230601.gappssmtp.com header.i=@fud-cz.20230601.gappssmtp.com header.b="BakDMowI"
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9775511C
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 19:34:53 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2809748bdb0so893848a91.0
        for <git@vger.kernel.org>; Tue, 14 Nov 2023 19:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fud-cz.20230601.gappssmtp.com; s=20230601; t=1700019292; x=1700624092; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pB42FogzZIShWy61ip3sLbcALrE9H7uxsGf5YnXUpJk=;
        b=BakDMowID9fikTFfonziwxh6zRJwHb9ND4X20wc3cNGmYI3MWRYxPnFD8J3ZoziIjK
         KA1/JlyNZ9qhouJq7hmhXAVBUmdNJ4ln/sGoKR3c/Cg+1ELZWHp8iLCPqabM3ofhlW7+
         uewE0vo6LDHSzq70mE7HZhHvEBtWv6+xsT3G1B8BNgKYRtUvGLLKBKE7169QXP/Sg3+s
         1PBb55KMAbOuydYwOEYtBBik0J7MKBBnlX3GXB+N2P1DqeIe7g+yvbh8lCsOUC+o+cNK
         eEsbd5Fhe6L0YYULkXPkPCy4GBqFbGMZPfAlvnE+jLtKGjdHiOIUworQNsQnQruFna9r
         /eRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700019292; x=1700624092;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pB42FogzZIShWy61ip3sLbcALrE9H7uxsGf5YnXUpJk=;
        b=osjAJ4fRuHoAVtYp96Bg/w229D32YDH7rwmRA33ghctnZ6M8oEVI4+hQAa4H1hRJW3
         +URX1UnymW9KIdsy3CcqYH8qlld6WpzoxI/uxFeZKXMHfBp5obGP0paT3owUfZbZCrzp
         EKaadqFTpU+bqvhFZcuZhJiS+exEn5kps+zt4isABc7uTWr53twjHeA7Ul0GpBm0fE+c
         N+DmcsWvvV+rNdXTLO9/Dgp27RIPWSOOlwCE/ZA9lEYAORE6suduBwMkC/Mk4P/qaIms
         XBvOUHdFD3iDTqnGQCMLvVaM8qirErw77kLA9/emMQx5BQzvEZboIfHR1YPJAKVEr9ZB
         gozg==
X-Gm-Message-State: AOJu0Ywe30CaXaf9sQC8Qtd+Z2RxtrywV5+0n3R/URrXpAXkZo7KSQOe
	3tqpO7cglVDm+mwMcwmZNNDx3ovdwvSHr4o2LBVvi6zNvwRzifpo2Kc=
X-Google-Smtp-Source: AGHT+IFWS7ap/o1Wxr0xeA/eG0boBsnGRzy+qMGtTxZESypR1TAhMzX6eXG+F5BEOtClnW/Wlic5Z9mIf33mrdXnYuw=
X-Received: by 2002:a17:90b:8d6:b0:283:5405:9e90 with SMTP id
 ds22-20020a17090b08d600b0028354059e90mr4035339pjb.3.1700019292481; Tue, 14
 Nov 2023 19:34:52 -0800 (PST)
Received: from 305313025478 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Nov 2023 19:34:52 -0800
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
Date: Tue, 14 Nov 2023 19:34:51 -0800
Message-ID: <CAGE_+C4JWA0DrcV4rT7J6hXsbYPL2Po31wFPvLESe_sKq_16FQ@mail.gmail.com>
Subject: [PATCH v2 1/5] remote-curl: avoid hang if curl asks for more data
 after eof
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

It has been observed that under some circumstances, libcurl can call
our `CURLOPT_READFUNCTION` callback `rpc_out()` again even after
already getting a return value of zero (EOF) back once before.

Because `rpc->flush_read_but_not_sent` is reset to false immediately
the first time an EOF is returned, the repeated call goes again to
`rpc_read_from_out()`, which tries to read more from the child process
pipe and the whole operation gets stuck - the child process is already
trying to read a response back and will not write anything to the
output pipe anymore, while the parent/remote process is now blocked
waiting to read more too and never even finishes sending the request.

The bug is fixed by moving the reset of the `flush_read_but_not_sent`
flag to `post_rpc()`, only before `rpc_out()` would be potentially used
the next time. This makes the callback behave like fread() and return
a zero any number of times at the end of a finished upload.

Signed-off-by: Jiri Hruska <jirka@fud.cz>
---
 remote-curl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index ef05752ca5..199c4615a5 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -705,9 +705,10 @@ static size_t rpc_out(void *ptr, size_t eltsize,
 			 * The line length either does not need to be sent at
 			 * all or has already been completely sent. Now we can
 			 * return 0, indicating EOF, meaning that the flush has
-			 * been fully sent.
+			 * been fully sent. It is important to keep returning 0
+			 * as long as needed in that case, as libcurl invokes
+			 * the callback multiple times at EOF sometimes.
 			 */
-			rpc->flush_read_but_not_sent = 0;
 			return 0;
 		}
 		/*
@@ -963,6 +964,7 @@ static int post_rpc(struct rpc_state *rpc, int
stateless_connect, int flush_rece
 		 */
 		headers = curl_slist_append(headers, "Transfer-Encoding: chunked");
 		rpc->initial_buffer = 1;
+		rpc->flush_read_but_not_sent = 0;
 		curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, rpc_out);
 		curl_easy_setopt(slot->curl, CURLOPT_INFILE, rpc);
 		curl_easy_setopt(slot->curl, CURLOPT_SEEKFUNCTION, rpc_seek);
-- 
2.42.1.5.g2f21867bd5
