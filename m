Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 676C520248
	for <e@80x24.org>; Mon,  4 Mar 2019 03:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbfCDDpq (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 22:45:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35526 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfCDDpq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 22:45:46 -0500
Received: by mail-wm1-f68.google.com with SMTP id y15so3248594wma.0
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 19:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=/P5nyWYXG31pMi60f5fBieQCDrhPk0fDJ5tLghox5Gg=;
        b=slF5n1+F7awBb/Tza0mdi1EjVUXVETrlAaXFh38/iR6twWzhQFFUdk59x+GCvU/fS1
         2tiKIRj59RS9TBmiACr5o11vFl1cMvLVWTTABhYBxMwKnYtfpupxXg8GO1mhcpkXl+wL
         jOCv+73GHYYJvtEawdCXXgIpB7MTC4dVAn/509G5EL2CZw7mlG6ljvix+F0WGSvRwHGF
         xjT93txYLQrl1eUKSEju7AseRi7fgT+PdXagC1n+Dcwq4yCVVTQMfKwIfY5gqgU69fTE
         PXZ/B9D7ctcsGhHvh6GKhWW7pOx3QeTGlJJiNFmNVCH/xvk1xQUdSUQmHrWpTDUPZFc6
         c0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=/P5nyWYXG31pMi60f5fBieQCDrhPk0fDJ5tLghox5Gg=;
        b=T/nN/+2VclRHmcEXPfiwpmgZBUYxwLrZLIf3k0pNsEmHLS9+2MNQy/yZ7Vas8zF1QK
         NyYbVBr7A0RgwOrCnWagbplP3acPsTUalov1cr+MopAm4UYTA3qf7D1+MyMXvQKu+R06
         DNfzYo/ShjL6VGjEyGOlI4eS4exBtKjRcVl+bkJiaq7shN44a4JaidcWADpYVCdUUIl0
         xq2CYMydYYY92QYPhZmPLpAhBA7eB//ZwaIHS14aBqOwHEEvhfqBsoCOqoMXDXw2jbbd
         8NAovUaZkxxNuFOuFzwb/UVlOVeub377gqqW2f4YaBYYE1OM8Auxkpl8DMgzvGLUtXOr
         etZw==
X-Gm-Message-State: APjAAAWHhE/Sg4r3a5b0rE28WUzVaLe6j9/u5xHZybDzvqARMla+fpyz
        8ObFKDUK9EuDu4niFFkuH2I=
X-Google-Smtp-Source: APXvYqyI6wAkhGIQ42lCMzvB91++ovZxoMQ2j+Fc4sNiQ+tkIfSSrlo/tvybv2YEmwuCvpjQnjx9hw==
X-Received: by 2002:a1c:730d:: with SMTP id d13mr5146720wmb.37.1551671143184;
        Sun, 03 Mar 2019 19:45:43 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t3sm11917941wmc.20.2019.03.03.19.45.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Mar 2019 19:45:42 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     jrnieder@gmail.com, git@vger.kernel.org, peff@peff.net
Subject: Re: [FIXUP] Fixup on tip of jt/http-auth-proto-v2-fix
References: <20190226070408.GA117495@google.com>
        <20190226181859.65894-1-jonathantanmy@google.com>
Date:   Mon, 04 Mar 2019 12:45:42 +0900
Message-ID: <xmqqh8cjxpy1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> Thanks for fixing it.
>> 
>> Is there a particular patch this should be squashed into, or does it
>> stand alone?  It the latter, mind writing a commit message for it?
>
> Not sure if I'm using "fixup" correctly in the subject, but this is
> meant to be squashed onto the tip of jt/http-auth-proto-v2-fix -
> specifically, deb7d2094a ("remote-curl: use post_rpc() for protocol v2
> also", 2019-02-14).

Saying "Fixup on tip of" to mean that you are fixing the 5th one in
a 5-patch series is sufficient to convey what you want between
humans, but that does not help the machine to help humans reduce
mistakes.  It would have been even more helpful if you created this
commit with

	git commit --fixup 0cdb2a12ad

which would have produced something like the attached patch,
and that would have allowed me to do

	git checkout jt/http-auth-proto-v2-fix
	git am ./+jt-http-auth-proto-v2-fix-fixup
	git rebase -i --autosquash HEAD~5

or somesuch.

Thanks, will queue.

-- >8 --
Subject: [PATCH] fixup! remote-curl: use post_rpc() for protocol v2 also

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 remote-curl.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 8c03c78fc6..3c3872cca6 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -758,7 +758,11 @@ static curl_off_t xcurl_off_t(size_t len)
 	return (curl_off_t)size;
 }
 
-static int post_rpc(struct rpc_state *rpc)
+/*
+ * If flush_received is true, do not attempt to read any more; just use what's
+ * in rpc->buf.
+ */
+static int post_rpc(struct rpc_state *rpc, int flush_received)
 {
 	struct active_request_slot *slot;
 	struct curl_slist *headers = http_copy_default_headers();
@@ -773,17 +777,19 @@ static int post_rpc(struct rpc_state *rpc)
 	 * allocated buffer space we can use HTTP/1.0 and avoid the
 	 * chunked encoding mess.
 	 */
-	while (1) {
-		size_t n;
-		enum packet_read_status status;
-
-		if (!rpc_read_from_out(rpc, 0, &n, &status)) {
-			large_request = 1;
-			use_gzip = 0;
-			break;
+	if (!flush_received) {
+		while (1) {
+			size_t n;
+			enum packet_read_status status;
+
+			if (!rpc_read_from_out(rpc, 0, &n, &status)) {
+				large_request = 1;
+				use_gzip = 0;
+				break;
+			}
+			if (status == PACKET_READ_FLUSH)
+				break;
 		}
-		if (status == PACKET_READ_FLUSH)
-			break;
 	}
 
 	if (large_request) {
@@ -963,7 +969,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads,
 			break;
 		rpc->pos = 0;
 		rpc->len = n;
-		err |= post_rpc(rpc);
+		err |= post_rpc(rpc, 0);
 	}
 
 	close(client.in);
@@ -1319,7 +1325,7 @@ static int stateless_connect(const char *service_name)
 			BUG("The entire rpc->buf should be larger than LARGE_PACKET_MAX");
 		if (status == PACKET_READ_EOF)
 			break;
-		if (post_rpc(&rpc))
+		if (post_rpc(&rpc, status == PACKET_READ_FLUSH))
 			/* We would have an err here */
 			break;
 		/* Reset the buffer for next request */
-- 
2.21.0


