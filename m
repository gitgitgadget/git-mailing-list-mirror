Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404D065C
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 03:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fud-cz.20230601.gappssmtp.com header.i=@fud-cz.20230601.gappssmtp.com header.b="wb0iKEXl"
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2CD127
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 19:34:54 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5bde026c1e1so441180a12.1
        for <git@vger.kernel.org>; Tue, 14 Nov 2023 19:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fud-cz.20230601.gappssmtp.com; s=20230601; t=1700019293; x=1700624093; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tji9w9bHnFxe6t1SXq4J/kBJPGajMnHpivdK7JFwJt0=;
        b=wb0iKEXlmR84ULwLkLAmanp1ICn7KAUy6bkg90bxI/jEzP5vyYe0hB29pmIxGuvdbK
         sQeF0LaohIwIMsrckB74Rs7gWMLCpiXb6d906Gjxx2qd9sJPr6uOyBViQxTuvDnxcfLl
         vmjub90STAvzCCjHsHyJLw3vvBCu0bfqig5De8trbXaKLDBxoVaoMQ1Ja7wFOifzmx+U
         2gN9YWGztVaLjqTEtNt8APuT2xl0eEIZK8Bw4X76izwmTn1zQ/oKbLbAa5TBJyYk4JmD
         WWNaayinjZ0IcpzgjbVSnzlrnNIryDXPoHlUeRSq0Iygu7xh5d9dF0ix0VHCqy9FhmHg
         Z+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700019293; x=1700624093;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tji9w9bHnFxe6t1SXq4J/kBJPGajMnHpivdK7JFwJt0=;
        b=fZ8Mkb9TGXjW4e6/mpGqr4UzXwAIw4Q6Yik+8xyiNw9MxDofp/6VTGygJdHhFfpj8p
         fafdimMfWLCUTgOmM481dyDyfrLV9NkWseBSG7Zdy7p5dOqY4VlG225sv77CMCy2vAhZ
         XMtwKmAqObegbV2SqNjDwBTMspg9iUHXbJKF+Av9V9HES+ut+PRGEgMWQgSyrOkzL/vR
         uMAX1SMfXa+9yZK7EO4mFtP3HvpemfcDGLEqYg/QVtqGl5aX6TC2HqsdeOUMG7mmRUul
         lH7Vzmw1M6DysCh+SP2M0kLpk1gNyjqZQlBn9bz6nXVSW6uqzH6Wen3xXnlZc4LA5jro
         bKqQ==
X-Gm-Message-State: AOJu0YydIJduirLfFrFBmsNalK6b1EbBX0S2Sa8Npimk+qjFD4s1OR10
	0t4V6cmWX1WKxfbI1kPMxgt1SHtqhoRugYmLyvR6p8qCTheXACWyoYg=
X-Google-Smtp-Source: AGHT+IHJ//mjqHBBgwc3R3735Se8z7rh5oz71GfRaJP4srRRkdQljKvvMU2yWj9FYj3rKw9LKvMkzdHaALWPLDaag4I=
X-Received: by 2002:a17:90b:888:b0:283:2897:91a4 with SMTP id
 bj8-20020a17090b088800b00283289791a4mr4028985pjb.2.1700019293330; Tue, 14 Nov
 2023 19:34:53 -0800 (PST)
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
Date: Tue, 14 Nov 2023 19:34:52 -0800
Message-ID: <CAGE_+C6ukSe-XTS2x8j3QDJ96yMib7kOtMbcrXes4zNbix0Oyg@mail.gmail.com>
Subject: [PATCH v2 2/5] remote-curl: improve readability of curl callbacks
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

The "user data" or "context" argument of libcurl streaming callbacks
is sometimes called `clientp` and sometimes `buffer_`. The latter is
especially confusing, because there is an actual buffer pointer
argument passed to the same functions.

- Make the argument consistently named `userdata` everywhere, just
  like the official cURL documentation calls it.

- Also add comments to all the callbacks, to make it easier to grasp
  what is the "in" and what is the "out" direction in this code.

Signed-off-by: Jiri Hruska <jirka@fud.cz>
---
 remote-curl.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 199c4615a5..428dd70aa1 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -675,11 +675,18 @@ static int rpc_read_from_out(struct rpc_state
*rpc, int options,
 	return 1;
 }

+/*
+ * CURLOPT_READFUNCTION callback, called by libcurl when it wants more data
+ * to send out. Used only if the request did not fit into just one buffer and
+ * data must be streamed as it comes.
+ * Has the same semantics as fread(), but reads packets from the pipe from
+ * the child process instead. A return value of 0 (EOF) finishes the upload.
+ */
 static size_t rpc_out(void *ptr, size_t eltsize,
-		size_t nmemb, void *buffer_)
+		size_t nmemb, void *userdata)
 {
 	size_t max = eltsize * nmemb;
-	struct rpc_state *rpc = buffer_;
+	struct rpc_state *rpc = userdata;
 	size_t avail = rpc->len - rpc->pos;
 	enum packet_read_status status;

@@ -725,9 +732,16 @@ static size_t rpc_out(void *ptr, size_t eltsize,
 	return avail;
 }

-static int rpc_seek(void *clientp, curl_off_t offset, int origin)
+/*
+ * CURLOPT_SEEKFUNCTION callback, called by libcurl when it wants to seek in
+ * the data being sent out. Used only if the request did not fit into just
+ * one buffer and data must be streamed as it comes.
+ * Has the same semantics as fseek(), but seeks in the buffered packet read
+ * from the pipe from the child process instead.
+ */
+static int rpc_seek(void *userdata, curl_off_t offset, int origin)
 {
-	struct rpc_state *rpc = clientp;
+	struct rpc_state *rpc = userdata;

 	if (origin != SEEK_SET)
 		BUG("rpc_seek only handles SEEK_SET, not %d", origin);
@@ -797,14 +811,15 @@ struct rpc_in_data {
 };

 /*
- * A callback for CURLOPT_WRITEFUNCTION. The return value is the bytes consumed
- * from ptr.
+ * CURLOPT_WRITEFUNCTION callback, called when more received data has come in.
+ * Has the same semantics as fwrite(), but writes packets to the pipe to the
+ * child process instead. The return value is the bytes consumed from ptr.
  */
 static size_t rpc_in(char *ptr, size_t eltsize,
-		size_t nmemb, void *buffer_)
+		size_t nmemb, void *userdata)
 {
 	size_t size = eltsize * nmemb;
-	struct rpc_in_data *data = buffer_;
+	struct rpc_in_data *data = userdata;
 	long response_code;

 	if (curl_easy_getinfo(data->slot->curl, CURLINFO_RESPONSE_CODE,
-- 
2.42.1.5.g2f21867bd5
