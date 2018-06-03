Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0CEF1F403
	for <e@80x24.org>; Sun,  3 Jun 2018 16:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbeFCQfd (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 12:35:33 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:44582 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750996AbeFCQfA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 12:35:00 -0400
Received: by mail-lf0-f68.google.com with SMTP id 36-v6so19620255lfr.11
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 09:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2uCcXhrk9DK6YqOxDS/6hpT8TOvoNcAgIEYnApHAftc=;
        b=uvojboVymIq8/ySqh5QFr3nyWsFaF8JrJ2luQMWdwiPXfjuiGONT+LIoF7HrIT+Msu
         iQUdrZN0OWM/LZbh7vEFI7OZ4S4bE7s8xXGOGmxqNQTCFjTaxzdSKAbo13H9T2sLb37A
         fy/Kz/MZLJSnWqWuJeI5ymwrVjupsyroPDyf/J1rna0C8eEzA7+CXEfUNJA5xHmy1a6q
         fWGvRB/8fJvR1rQlMs8fhZYudmG01szQsyq7b+pg8XYojvh5XGDiP99QWACk6eHWMUGC
         mXa7nICAyUUM7uGqufYestx11OQnqm+o2YztVmd7j7yvOotLzCcZaHH7AIbjllw3y5zx
         3mzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2uCcXhrk9DK6YqOxDS/6hpT8TOvoNcAgIEYnApHAftc=;
        b=qFo4j/q3NyKTN8qrAmMTcz6VzasmoPhDGfABFDDFqY3c1ieZcK/UXaDYDn5q5uVPI5
         crC3zOheR1uBtQOvc4dTPZiAv9SfaNHpJUmsCnFY7oGojThnHZ6IPTN5BEDP/c1GgPpO
         zokB6CIpMoXc/QB2pB5rjw3X2hylRaZtKAhCbNGd0sBywZJCknciCxivn0WD3jITlAFc
         tTkciCtr5bYtX7Toy6iTUYDf/GS6NT9aZqKcZZ+2XzlOnnz8u78S2uwi1UgTvcenKYuR
         lWeZGWwVHIvAe+juy3MhMkX9JxrZ/EdU2eT60GGE7oFFOh/H+xxAWkzzsrK19uw7ayc8
         H+aQ==
X-Gm-Message-State: ALKqPwejAf29KzLQwD4J8SGcQUivJCZ8Wcki1Z0ntaFl/+b+SZXOx8Nh
        AFp2vEoq5piM4nyJTQXdDP9mMA==
X-Google-Smtp-Source: ADUXVKKqwwtJDkWQN0w4TlO51fTjfpIuQ1EZijAY9rMPCsEYhf3UjBcvrIOZsl6rVXSWbk9REyFqvw==
X-Received: by 2002:a2e:9ed7:: with SMTP id h23-v6mr12858512ljk.88.1528043698778;
        Sun, 03 Jun 2018 09:34:58 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v79-v6sm4726895lfd.32.2018.06.03.09.34.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jun 2018 09:34:58 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 16/23] pkt-line.c: mark more strings for translation
Date:   Sun,  3 Jun 2018 18:34:13 +0200
Message-Id: <20180603163420.13702-17-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180603163420.13702-1-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com>
 <20180603163420.13702-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 pkt-line.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 941e41dfc1..04d10bbd03 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -101,7 +101,7 @@ int packet_flush_gently(int fd)
 {
 	packet_trace("0000", 4, 1);
 	if (write_in_full(fd, "0000", 4) < 0)
-		return error("flush packet write failed");
+		return error(_("flush packet write failed"));
 	return 0;
 }
 
@@ -139,7 +139,7 @@ static void format_packet(struct strbuf *out, const char *fmt, va_list args)
 	n = out->len - orig_len;
 
 	if (n > LARGE_PACKET_MAX)
-		die("protocol error: impossibly long line");
+		die(_("protocol error: impossibly long line"));
 
 	set_packet_header(&out->buf[orig_len], n);
 	packet_trace(out->buf + orig_len + 4, n - 4, 1);
@@ -155,9 +155,9 @@ static int packet_write_fmt_1(int fd, int gently,
 	if (write_in_full(fd, buf.buf, buf.len) < 0) {
 		if (!gently) {
 			check_pipe(errno);
-			die_errno("packet write with format failed");
+			die_errno(_("packet write with format failed"));
 		}
-		return error("packet write with format failed");
+		return error(_("packet write with format failed"));
 	}
 
 	return 0;
@@ -189,21 +189,21 @@ static int packet_write_gently(const int fd_out, const char *buf, size_t size)
 	size_t packet_size;
 
 	if (size > sizeof(packet_write_buffer) - 4)
-		return error("packet write failed - data exceeds max packet size");
+		return error(_("packet write failed - data exceeds max packet size"));
 
 	packet_trace(buf, size, 1);
 	packet_size = size + 4;
 	set_packet_header(packet_write_buffer, packet_size);
 	memcpy(packet_write_buffer + 4, buf, size);
 	if (write_in_full(fd_out, packet_write_buffer, packet_size) < 0)
-		return error("packet write failed");
+		return error(_("packet write failed"));
 	return 0;
 }
 
 void packet_write(int fd_out, const char *buf, size_t size)
 {
 	if (packet_write_gently(fd_out, buf, size))
-		die_errno("packet write failed");
+		die_errno(_("packet write failed"));
 }
 
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
@@ -225,7 +225,7 @@ void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len)
 	n = buf->len - orig_len;
 
 	if (n > LARGE_PACKET_MAX)
-		die("protocol error: impossibly long line");
+		die(_("protocol error: impossibly long line"));
 
 	set_packet_header(&buf->buf[orig_len], n);
 	packet_trace(data, len, 1);
@@ -288,7 +288,7 @@ static int get_packet_data(int fd, char **src_buf, size_t *src_size,
 	} else {
 		ret = read_in_full(fd, dst, size);
 		if (ret < 0)
-			die_errno("read error");
+			die_errno(_("read error"));
 	}
 
 	/* And complain if we didn't get enough bytes to satisfy the read. */
@@ -296,7 +296,7 @@ static int get_packet_data(int fd, char **src_buf, size_t *src_size,
 		if (options & PACKET_READ_GENTLE_ON_EOF)
 			return -1;
 
-		die("the remote end hung up unexpectedly");
+		die(_("the remote end hung up unexpectedly"));
 	}
 
 	return ret;
@@ -324,7 +324,7 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 	len = packet_length(linelen);
 
 	if (len < 0) {
-		die("protocol error: bad line length character: %.4s", linelen);
+		die(_("protocol error: bad line length character: %.4s"), linelen);
 	} else if (!len) {
 		packet_trace("0000", 4, 0);
 		*pktlen = 0;
@@ -334,12 +334,12 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 		*pktlen = 0;
 		return PACKET_READ_DELIM;
 	} else if (len < 4) {
-		die("protocol error: bad line length %d", len);
+		die(_("protocol error: bad line length %d"), len);
 	}
 
 	len -= 4;
 	if ((unsigned)len >= size)
-		die("protocol error: bad line length %d", len);
+		die(_("protocol error: bad line length %d"), len);
 
 	if (get_packet_data(fd, src_buffer, src_len, buffer, len, options) < 0) {
 		*pktlen = -1;
-- 
2.18.0.rc0.333.g22e6ee6cdf

