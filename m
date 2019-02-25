Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51A5520248
	for <e@80x24.org>; Mon, 25 Feb 2019 23:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfBYXtG (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 18:49:06 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:41910 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfBYXtF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 18:49:05 -0500
Received: by mail-pg1-f202.google.com with SMTP id d128so8192020pgc.8
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 15:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hIENCxMstlW4WIjVlIonz6RKznfymb/bzbVjy+fquFY=;
        b=eLGp6MZSFFqAQeoNK1L4Q+V0MGRAa1XFtyxMiNQtGxQ2+QdNxPZ7E+qxpoEwou7lsg
         4d1B0eifjo74qbVBMlgFwrMCoktLRM7c0SKb9TiGJi+yTMSIl6lR09O1asfxhKNF5dZF
         NHpuJoZ4BSW1MYnQ7Oj+bzv8ZbO+06Sgo3FjdNxYMYIMK4mtEpLvBDujSToSZzpFoOCr
         c7NznvyLtDuAP1Z+q8fE1KVSxzxyN0ZifrPt5j7vvWXUjtA2K01QW2grDsNVmm8uTBvS
         SHITS1oGcWRrvoeDqI7QXzfoKV+TS7Dtbo183P20R73TOGjo6kj+QGyUyIzKb2YMmPvh
         ymaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hIENCxMstlW4WIjVlIonz6RKznfymb/bzbVjy+fquFY=;
        b=NWGvHl8U8bDDFvD6ahRUX0g1Vt2Jk7UsPIXXuUgbO+4rXyYfgAaun8LDr+/oiCixp/
         CLAEPfLL6RDleNxPVaca5vpK5y+zs84OupU+DoV0CSTRqUPG/avczzwEI8dQmTRry1kM
         Y+S3kHydOaqgNvDVV881NI7olY3fnIWIqTUsBnD69XG38xHiXyMQieXwlswy9jlFoh/D
         7bYhvS5DPHEviZqTJ0wngWDwHjscMXdrHG37TTPSWRA5k7akfQj36F7oQvMTCcsvQBSg
         LFF0x+iVj0JIwq9gg+FBWCsKGFKZemhdNxSKpxkVA/ZOgiMAEuAxWuMVK4AJp/sNcTW1
         Zswg==
X-Gm-Message-State: AHQUAuax79XRxXijH7lFdn0Tc/pg4ENunWQtYwZPOPsj1HVxp0Qu159p
        3baULBN18A2iIGC3jtW5CWWXLuDbpTsjk/xSLNxkRx4S72/gaL2350tRRDPFWWJAGHUKtF07n49
        /IyJslD47or5f7mu5spfSj+SZ9UpSfeHrqLH7UDMyvfAoPXnJpdYNFicI52hC+fMrE+G2it2gt6
        jR
X-Google-Smtp-Source: AHgI3IYS+hMohmaCadmiBeaQ1Eg+mQxJgUtHWo0gIVop90pzgI097stU4d0a5CKZ5DMiOil/nxyifj/pXq1NPtOr4+nz
X-Received: by 2002:a62:e706:: with SMTP id s6mr7623361pfh.87.1551138544919;
 Mon, 25 Feb 2019 15:49:04 -0800 (PST)
Date:   Mon, 25 Feb 2019 15:49:01 -0800
In-Reply-To: <20190225220841.GA3248@sigill.intra.peff.net>
Message-Id: <20190225234901.65277-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190225220841.GA3248@sigill.intra.peff.net>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [FIXUP] Fixup on tip of jt/http-auth-proto-v2-fix
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, Peff, for noticing this. It's because the client sometimes sends
"0000" as a single request (that is, it flushes, and then before it
sends any data, it flushes again). And post_rpc() assumes that it can
always read something - which is usually correct, but not in this case;
we read in stateless_connect() first, and if we read "0000", we need to
tell post_rpc() to not read at all.

This is a fixup on the tip of jt/http-auth-proto-v2-fix that fixes that.

As for why the client sends a lone "0000", I'm not sure, but that's
outside the scope of this patch set, I think.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 remote-curl.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 2394a00650..6c0207f4f9 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -747,7 +747,11 @@ static curl_off_t xcurl_off_t(size_t len)
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
@@ -762,17 +766,19 @@ static int post_rpc(struct rpc_state *rpc)
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
@@ -952,7 +958,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads,
 			break;
 		rpc->pos = 0;
 		rpc->len = n;
-		err |= post_rpc(rpc);
+		err |= post_rpc(rpc, 0);
 	}
 
 	close(client.in);
@@ -1308,7 +1314,7 @@ static int stateless_connect(const char *service_name)
 			BUG("The entire rpc->buf should be larger than LARGE_PACKET_MAX");
 		if (status == PACKET_READ_EOF)
 			break;
-		if (post_rpc(&rpc))
+		if (post_rpc(&rpc, status == PACKET_READ_FLUSH))
 			/* We would have an err here */
 			break;
 		/* Reset the buffer for next request */
-- 
2.19.0.271.gfe8321ec05.dirty

