Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9C2A1F597
	for <e@80x24.org>; Sat, 21 Jul 2018 07:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbeGUImK (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 04:42:10 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37229 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbeGUImK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 04:42:10 -0400
Received: by mail-lj1-f193.google.com with SMTP id v9-v6so12899526ljk.4
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 00:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NLAzSI51PQYeRiy1Gk9Tcc5WQ3Bb4IRHzyTbtcKCoBI=;
        b=CJOjLqXjMDIghEZQhUWjg5ymHRg9wNKG7aP3EXZry7Fg9nzXOtzHbiQbwkgcKW6Ubi
         cDZn4GtOlIkWbK7Bvzo0o+G/Lwo+CbBAHfYpKyULNMgFkdcNfjmI8YLXc66XsVtwsPrd
         jIGX/QgxyW410daCrPoLgaLzdHpv8wo8h8QkRVe9Zz6nShJsC0ZMtMP69u1BXjErGxla
         Ia/3DaUwz9BAjlzfwl7und5HyQDdz+a5b3pjTq7ebkWYajO1MF2TrHGKcojQzAL4WQRD
         kMYtqvkdRv5LhOLHjDDGCNchj4v0zocuS7qjkLMjcUlvbpabm7+usSGVA9u2J0+Ox+Ff
         ezQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NLAzSI51PQYeRiy1Gk9Tcc5WQ3Bb4IRHzyTbtcKCoBI=;
        b=kOQ3Nz8drnXtibbm8a4XkSE5m6ATWieLAs2vHA+UPxddZAmfnJhH2f9k2KvKRo13Q/
         GLTAJfLAFCjlStkmvfjCgeTLGnGh0IvgbF4/Ic7rpAcxfxEA3VyTPgsA7/4YmdlfG9yg
         GjYfzPfYkxj9wyuFSj2ygw+KTiRybwjQH3py+GgtS8bDuB1bUxKdi+dLatBE4dINiHcB
         8MGxXm4Dy2GVwy92FV4WWzaiC7Q/DGaNtvbvr9PcMx5WMydz1qQzILODmg4IM+VFLmze
         2SfI26cLaw8Ypr/2aK3rYL5HspuT8fFTORhTJ0y55/dsiQeL64OsMHxNmSoZr3RDuAWa
         6rjQ==
X-Gm-Message-State: AOUpUlEJXMxg5fgxfHfwOzT1R2i16Zjqwmud+NP7Gz2KMTIW1UDe5BtK
        Y1mccqXh/FMRn2tZPWjUnEg=
X-Google-Smtp-Source: AAOMgpffG6SUyZaxlz0C92Inp9EGEQEEiHEby6dMdz0IfEfGNCnoMKltF8MEWyjf7YiEGM7+UznutQ==
X-Received: by 2002:a2e:94d5:: with SMTP id r21-v6mr3584571ljh.126.1532159419949;
        Sat, 21 Jul 2018 00:50:19 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n3-v6sm759898lji.96.2018.07.21.00.50.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 00:50:19 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        stolee@gmail.com
Subject: [PATCH v3 22/23] transport.c: mark more strings for translation
Date:   Sat, 21 Jul 2018 09:49:40 +0200
Message-Id: <20180721074941.14632-23-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.656.gda699b98b3
In-Reply-To: <20180721074941.14632-1-pclouds@gmail.com>
References: <20180718161101.19765-1-pclouds@gmail.com>
 <20180721074941.14632-1-pclouds@gmail.com>
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
index 9fcc33915a..516a83b7f6 100644
--- a/transport.c
+++ b/transport.c
@@ -139,7 +139,7 @@ static struct ref *get_refs_from_bundle(struct transport *transport,
 		close(data->fd);
 	data->fd = read_bundle_header(transport->url, &data->header);
 	if (data->fd < 0)
-		die("could not read bundle '%s'", transport->url);
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
2.18.0.656.gda699b98b3

