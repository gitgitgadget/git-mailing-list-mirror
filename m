Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12CD801
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 03:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fud-cz.20230601.gappssmtp.com header.i=@fud-cz.20230601.gappssmtp.com header.b="LyiDF3SZ"
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF259189
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 19:34:55 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-280b06206f7so896238a91.1
        for <git@vger.kernel.org>; Tue, 14 Nov 2023 19:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fud-cz.20230601.gappssmtp.com; s=20230601; t=1700019295; x=1700624095; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRYGsHh9ygz69tB7vbjgaQ9TYkpDYhG2a6X9oC16NDE=;
        b=LyiDF3SZg2l5j9ZxmbilcgdpOPKfrCcgL/lf8UNeejJ1OYSC/BmcWE+bWU2BUSyi5M
         eOgjSGVjYWKJseDmMICIh77aHTMyI3ir82gvRm98rDIZzt9gvD0trlyltr0yZy8MUhGn
         rhRlgPz5tbRn0dcKE2p7WF8m19ZbrfWDQQ4zL8W78bbyp/9qVEQ1ffm1Ivs4s2PxdPVH
         P6E4b3eY6++Gh1CZY8lj39l07mZmU62m2YIVpQvk47Q+mqVka82QY5wXVAsG579elvZN
         JE2NNTkT78evnPnqEimhHYxAMgFy111RqEtAM7xQ0P+sC3pXxGZB0ugXFGDjqB0eyc2v
         2yug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700019295; x=1700624095;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRYGsHh9ygz69tB7vbjgaQ9TYkpDYhG2a6X9oC16NDE=;
        b=Q2hU+wKbo06l0i5Zzy+/d1gxRezbZB2gFeajzCMwRjh8hAaVQ659rmdi7aaPGvQMWN
         cTc3A9YvvW+mAsnqees1GsUbtOxSZv/0Az8ZX40/Yswp3q+bPcA7zGqlbeLAyChM879u
         KAveujki6jBbOQbmpsBfF7JM2ZfTmL49JYMIeoAwsATz8o8z8kKtpRzuo0l8RgBsT374
         PH0RvT/mM+sJtoTO0/H/GXJjOvD+lwV6s6HxicWdx4jfU1Kop+p1h9h3S6oDJ+6GBf0V
         El6W0kTqrebJAJz2f4af/4mtvL4iVkfYZ0zgEytZKhxZxxz67m2+OygUDa0rfPozgOa/
         Zaqw==
X-Gm-Message-State: AOJu0YxR5zyhd7Rw3YJcdgIoxx+4NNqFr0KQDu7dPUrNS0UYV7qBzkgG
	Nb+U1CGuuq7wXplVIBP/rhK6soVQuFfCVX/3c90zyfJHy4UH0Q8jxfY=
X-Google-Smtp-Source: AGHT+IEFzKo+xt/OQMBVKhFDoGL9OSmvkE6PKmDMFy8oREPy7C4iKnjscFNH1He0V8uYgGosogGDl6iUrE6xHV7Bzv8=
X-Received: by 2002:a17:90b:3544:b0:281:291:a6e4 with SMTP id
 lt4-20020a17090b354400b002810291a6e4mr4052619pjb.1.1700019295254; Tue, 14 Nov
 2023 19:34:55 -0800 (PST)
Received: from 305313025478 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Nov 2023 19:34:54 -0800
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
Date: Tue, 14 Nov 2023 19:34:54 -0800
Message-ID: <CAGE_+C7CEh63ThpJx2BvMQLb==v=h79pMKHC14t_wYeRowMfwQ@mail.gmail.com>
Subject: [PATCH v2 4/5] remote-curl: simplify rpc_out() - less nesting and rename
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

- Remove one indentation level in `rpc_out()`, as the conditions can be
  combined into just one `if` statement without losing readability.

  Skipping the resetting of `initial_buffer`/`len`/`pos` revealed a bug
  in `stateless_connect()`, where `rpc.len` is reset to 0 after each
  request, but not `rpc.pos`. Relying on `rpc_out()` always doing this
  before has never been safe (it might have not finished cleanly, for
  example). So better reset it there, just like `rpc.len`.

- Rename `flush_read_but_not_sent` to `read_from_out_done`. The name is
  slightly misleading, because the "flush" might never be really "sent"
  (depends on `write_line_lengths`), and this is not the most important
  part anyway. The primary role of the flag is rather to signal that
  `read_from_out()` is "done" and must not be called for this particular
  RPC exchange anymore.

- Update/add some related comments.

Signed-off-by: Jiri Hruska <jirka@fud.cz>
---
 remote-curl.c | 46 ++++++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 690df2a43e..d5aa66a44c 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -606,13 +606,14 @@ struct rpc_state {
 	unsigned write_line_lengths : 1;

 	/*
-	 * Used by rpc_out; initialize to 0. This is true if a flush has been
-	 * read, but the corresponding line length (if write_line_lengths is
-	 * true) and EOF have not been sent to libcurl. Since each flush marks
-	 * the end of a request, each flush must be completely sent before any
-	 * further reading occurs.
+	 * Used by rpc_out; initialize to 0. This is true if a flush packet
+	 * has been read from the child process, signaling the end of the
+	 * current data to send. There might be still some bytes pending in
+	 * 'buf' (e.g. the corresponding line length, if write_line_lengths
+	 * is true), but no more reads can be performed on the 'out' pipe as
+	 * part of the current RPC exchange.
 	 */
-	unsigned flush_read_but_not_sent : 1;
+	unsigned read_from_out_done : 1;
 };

 #define RPC_STATE_INIT { 0 }
@@ -690,21 +691,29 @@ static size_t rpc_out(void *ptr, size_t eltsize,
 	size_t avail = rpc->len - rpc->pos;
 	enum packet_read_status status;

-	if (!avail) {
+	/*
+	 * If there is no more data available in our buffer and the child
+	 * process is not done sending yet, read the next packet.
+	 */
+	if (!avail && !rpc->read_from_out_done) {
 		rpc->initial_buffer = 0;
 		rpc->len = 0;
 		rpc->pos = 0;
-		if (!rpc->flush_read_but_not_sent) {
-			if (!rpc_read_from_out(rpc, 0, &avail, &status))
-				BUG("The entire rpc->buf should be larger than LARGE_PACKET_MAX");
-			if (status == PACKET_READ_FLUSH)
-				rpc->flush_read_but_not_sent = 1;
-		}
+		if (!rpc_read_from_out(rpc, 0, &avail, &status))
+			BUG("The entire rpc->buf should be larger than LARGE_PACKET_MAX");
+
 		/*
-		 * If flush_read_but_not_sent is true, we have already read one
-		 * full request but have not fully sent it + EOF, which is why
-		 * we need to refrain from reading.
+		 * If a flush packet was read, it means the child process is
+		 * done sending this request. The buffer might be fully empty
+		 * at this point or contain a flush packet too, depending on
+		 * rpc->write_line_lengths.
+		 * In any case, we must refrain from reading any more, because
+		 * the child process already expects to receive a response back
+		 * instead. If both sides would try to read at once, they would
+		 * just hang waiting for each other.
 		 */
+		if (status == PACKET_READ_FLUSH)
+			rpc->read_from_out_done = 1;
 	}

 	/*
@@ -967,7 +976,7 @@ static int post_rpc(struct rpc_state *rpc, int
stateless_connect, int flush_rece
 		 */
 		headers = curl_slist_append(headers, "Transfer-Encoding: chunked");
 		rpc->initial_buffer = 1;
-		rpc->flush_read_but_not_sent = 0;
+		rpc->read_from_out_done = 0;
 		curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, rpc_out);
 		curl_easy_setopt(slot->curl, CURLOPT_INFILE, rpc);
 		curl_easy_setopt(slot->curl, CURLOPT_SEEKFUNCTION, rpc_seek);
@@ -1487,7 +1496,7 @@ static int stateless_connect(const char *service_name)
 	rpc.gzip_request = 1;
 	rpc.initial_buffer = 0;
 	rpc.write_line_lengths = 1;
-	rpc.flush_read_but_not_sent = 0;
+	rpc.read_from_out_done = 0;

 	/*
 	 * Dump the capability listing that we got from the server earlier
@@ -1510,6 +1519,7 @@ static int stateless_connect(const char *service_name)
 			break;
 		/* Reset the buffer for next request */
 		rpc.len = 0;
+		rpc.pos = 0;
 	}

 	free(rpc.service_url);
-- 
2.42.1.5.g2f21867bd5
