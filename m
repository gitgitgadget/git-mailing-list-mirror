Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B41AE1F403
	for <e@80x24.org>; Sun,  3 Jun 2018 16:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbeFCQfL (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 12:35:11 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:37595 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751342AbeFCQfG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 12:35:06 -0400
Received: by mail-lf0-f68.google.com with SMTP id r2-v6so21549090lff.4
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 09:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d5H7Sk123fDJbajGQ9HYIeRbigizeffkVZj0BYgFc74=;
        b=qyn2Q9OIBpzTEvpdx92jBpQZfN4d3vVe6iZsUuhl/0/6A7dnOE5I+1jIWdTafb9V3W
         YCFyn4Mg9nQFdwl5CJY9Um8ChrUGuKoXXlpf1Zk10Bo9fLm8JYKlU6LeBGu/BhbDs9rg
         LoFimEBnbZvMmaNkBbjVxdb7wJv45AGeFHGYNEibCH1HUuONwU0v5o88EQVCR+LD3tud
         OOnQ1bRMd9nz5MsrxppYQAgVpNQK+urSgwRaUqLUgY9KNh2y+9CZyh7IEtqvHqDtS2Al
         i5Zp8FeLwnaKwM/TtECJfiaeqAEmdxaI5FJ21hjPnPgV6bnniuiE29b8mU26fSMeuZIV
         dcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d5H7Sk123fDJbajGQ9HYIeRbigizeffkVZj0BYgFc74=;
        b=dtcfVqCZxcTsqTZb5UpaEG5z0A3vmqBkFEuWQC77hsdyZ1m6hxMfkxLvfbG/cnPsaV
         XyLziVJwv6Fflk0f9CX/a6CQ0806Ns6z09O0xV2ihU48Pr8QCigHQYkrJl0k5hi6uTSb
         5QsaTFOD980YGx9od7onhWUuQ1LwK+mpzWMrjy+tQhdg28XOFccNTWCWvzwUMhiuhd40
         Ai6n9EGjBBg5aJ2sC2xmWRPCOY64gM7wryIu9aMvlQchDik5ePDzWOC7eyHgt92we4lv
         QCB9qMPnTM4l1sfw5kNuQR5ygcpb+hTPtRqG16Yckgy8cpJZyewkHw0JhOQ9ZDYUNLhw
         Cy2g==
X-Gm-Message-State: ALKqPwfYBdoF18Nsz8pTlKMMbD380Rwc4YSU9Otbip33rzY+hMZLO04o
        DzmaNwF9s2i4+xGiEQPwIpAQFA==
X-Google-Smtp-Source: ADUXVKL3QjZzKQcEGsa6Pdb5YXjF7wY4pbqauFg7q2PEy/D9QEun9fHXrlbC/j25RgkF15+po4Xeow==
X-Received: by 2002:a19:16e1:: with SMTP id 94-v6mr9949841lfw.45.1528043705234;
        Sun, 03 Jun 2018 09:35:05 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v79-v6sm4726895lfd.32.2018.06.03.09.35.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jun 2018 09:35:04 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 22/23] transport.c: mark more strings for translation
Date:   Sun,  3 Jun 2018 18:34:19 +0200
Message-Id: <20180603163420.13702-23-pclouds@gmail.com>
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
 transport.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/transport.c b/transport.c
index 2f6a7cb4cd..516a83b7f6 100644
--- a/transport.c
+++ b/transport.c
@@ -139,7 +139,7 @@ static struct ref *get_refs_from_bundle(struct transport *transport,
 		close(data->fd);
 	data->fd = read_bundle_header(transport->url, &data->header);
 	if (data->fd < 0)
-		die("could not read bundle '%s'.", transport->url);
+		die(_("could not read bundle '%s'"), transport->url);
 	for (i = 0; i < data->header.references.nr; i++) {
 		struct ref_list_entry *e = data->header.references.list + i;
 		struct ref *ref = alloc_ref(e->name);
@@ -654,7 +654,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 
 	switch (data->version) {
 	case protocol_v2:
-		die("support for protocol v2 not implemented yet");
+		die(_("support for protocol v2 not implemented yet"));
 		break;
 	case protocol_v1:
 	case protocol_v0:
@@ -780,7 +780,7 @@ static enum protocol_allow_config parse_protocol_config(const char *key,
 	else if (!strcasecmp(value, "user"))
 		return PROTOCOL_ALLOW_USER_ONLY;
 
-	die("unknown value for config '%s': %s", key, value);
+	die(_("unknown value for config '%s': %s"), key, value);
 }
 
 static enum protocol_allow_config get_protocol_config(const char *type)
@@ -846,7 +846,7 @@ int is_transport_allowed(const char *type, int from_user)
 void transport_check_allowed(const char *type)
 {
 	if (!is_transport_allowed(type, -1))
-		die("transport '%s' not allowed", type);
+		die(_("transport '%s' not allowed"), type);
 }
 
 static struct transport_vtable bundle_vtable = {
@@ -898,7 +898,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	if (helper) {
 		transport_helper_init(ret, helper);
 	} else if (starts_with(url, "rsync:")) {
-		die("git-over-rsync is no longer supported");
+		die(_("git-over-rsync is no longer supported"));
 	} else if (url_is_local_not_ssh(url) && is_file(url) && is_bundle(url, 1)) {
 		struct bundle_transport_data *data = xcalloc(1, sizeof(*data));
 		transport_check_allowed("file");
@@ -1143,7 +1143,7 @@ int transport_push(struct transport *transport,
 						      transport->push_options,
 						      pretend)) {
 				oid_array_clear(&commits);
-				die("failed to push all needed submodules!");
+				die(_("failed to push all needed submodules"));
 			}
 			oid_array_clear(&commits);
 		}
@@ -1265,7 +1265,7 @@ int transport_connect(struct transport *transport, const char *name,
 	if (transport->vtable->connect)
 		return transport->vtable->connect(transport, name, exec, fd);
 	else
-		die("operation not supported by protocol");
+		die(_("operation not supported by protocol"));
 }
 
 int transport_disconnect(struct transport *transport)
@@ -1347,7 +1347,7 @@ static void read_alternate_refs(const char *path,
 
 		if (get_oid_hex(line.buf, &oid) ||
 		    line.buf[GIT_SHA1_HEXSZ] != ' ') {
-			warning("invalid line while parsing alternate refs: %s",
+			warning(_("invalid line while parsing alternate refs: %s"),
 				line.buf);
 			break;
 		}
-- 
2.18.0.rc0.333.g22e6ee6cdf

