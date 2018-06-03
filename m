Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80FB01F403
	for <e@80x24.org>; Sun,  3 Jun 2018 16:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751345AbeFCQfe (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 12:35:34 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37587 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751370AbeFCQe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 12:34:59 -0400
Received: by mail-lf0-f67.google.com with SMTP id r2-v6so21548845lff.4
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 09:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=av0chTy8Rtl3JszY0OuLRdHC/lUIMw16iMymJ/a63ww=;
        b=ZYX0eYvWtzi5d/KP7CcH+sib9qT97XU6cYk/sN83IT/KXpbGwpGoOUS6RVgbOPlGbP
         3aaf0PtKyy6zUOYMUFmBqQlts555d5SDox6d7Nsx43ugVDW0/djPcNBSMwzZ+adBcRg9
         8GDkAer3qZGi3T1472MrvRvej4RuSt3LakbVVzrCNSE15O2bhFxWC1uc+bXBf7qGOyOX
         0iaLcRKXthAfc1fe5bNFtFuta6YXe+HpCnr8LD6Bd8EaHs43EAXkeHZ3KTG5HlcJwU/t
         GwfAOW0A61ONnSNL0qstujOea5MOFKjb0TkyhF7UJaaAT2NFlwYnyl1tvMA9TvLHZdvS
         f1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=av0chTy8Rtl3JszY0OuLRdHC/lUIMw16iMymJ/a63ww=;
        b=JvfOXuv9btPcZTDY2n3D9FlZqr/EQ9eTKO4yhTPjg09cVmd8Z7toIDeBpLvKeJGVVy
         nzidTnRKDMKVxK8Mf9vKnmUD4uU+gqRlYlFbrI0FJ9CcqYS95XQeEut+9/dJCxvI+Xry
         zEohcYIhZWTMqBfKxXNFUcHbKICxFFsgQZ+ui773ZwPcTVom1yW4oJS8b9SBtfg//uWf
         g+DNQJyYQUMVFyaoig/oZQh4GvQ4gQBcozLjSSPEyJ58n5QQxmUmhd+p+e+h4KH/Day+
         S7Oi3ZgEOjqDLcrP5+Ukfw2+xRNQk3zcKsPrX3MXAoj4Lu0E7pzbmvwz5yUMB/cfnhZG
         CrNg==
X-Gm-Message-State: ALKqPwd8c+Ptk+gMMl4hQ651tY+32+MN0sohOz8Zmh+KLiFeS9etAPjs
        PdcsDr+QYeZwqkgA5lBAgXCYYw==
X-Google-Smtp-Source: ADUXVKJOO3kWAPT5r2mOExx0jOxJnoXqRsX6FCgF6bOZmCGlnUng/WkfHW3xq7WbQter/oCuPaYUxQ==
X-Received: by 2002:a2e:5c89:: with SMTP id q131-v6mr12482239ljb.77.1528043697867;
        Sun, 03 Jun 2018 09:34:57 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v79-v6sm4726895lfd.32.2018.06.03.09.34.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jun 2018 09:34:57 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 15/23] object.c: mark more strings for translation
Date:   Sun,  3 Jun 2018 18:34:12 +0200
Message-Id: <20180603163420.13702-16-pclouds@gmail.com>
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
 object.c        | 10 +++++-----
 t/t1450-fsck.sh |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/object.c b/object.c
index f7f4de3aaf..c20ea782f1 100644
--- a/object.c
+++ b/object.c
@@ -51,7 +51,7 @@ int type_from_string_gently(const char *str, ssize_t len, int gentle)
 	if (gentle)
 		return -1;
 
-	die("invalid object type \"%s\"", str);
+	die(_("invalid object type \"%s\""), str);
 }
 
 /*
@@ -167,7 +167,7 @@ void *object_as_type(struct object *obj, enum object_type type, int quiet)
 	}
 	else {
 		if (!quiet)
-			error("object %s is a %s, not a %s",
+			error(_("object %s is a %s, not a %s"),
 			      oid_to_hex(&obj->oid),
 			      type_name(obj->type), type_name(type));
 		return NULL;
@@ -226,7 +226,7 @@ struct object *parse_object_buffer(const struct object_id *oid, enum object_type
 			obj = &tag->object;
 		}
 	} else {
-		warning("object %s has unknown type id %d", oid_to_hex(oid), type);
+		warning(_("object %s has unknown type id %d"), oid_to_hex(oid), type);
 		obj = NULL;
 	}
 	return obj;
@@ -259,7 +259,7 @@ struct object *parse_object(const struct object_id *oid)
 	    (!obj && has_object_file(oid) &&
 	     oid_object_info(the_repository, oid, NULL) == OBJ_BLOB)) {
 		if (check_object_signature(repl, NULL, 0, NULL) < 0) {
-			error("sha1 mismatch %s", oid_to_hex(oid));
+			error(_("sha1 mismatch %s"), oid_to_hex(oid));
 			return NULL;
 		}
 		parse_blob_buffer(lookup_blob(oid), NULL, 0);
@@ -270,7 +270,7 @@ struct object *parse_object(const struct object_id *oid)
 	if (buffer) {
 		if (check_object_signature(repl, buffer, size, type_name(type)) < 0) {
 			free(buffer);
-			error("sha1 mismatch %s", oid_to_hex(repl));
+			error(_("sha1 mismatch %s"), oid_to_hex(repl));
 			return NULL;
 		}
 
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 91fd71444d..7b7602ddb4 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -372,7 +372,7 @@ test_expect_success 'rev-list --verify-objects with bad sha1' '
 
 	test_might_fail git rev-list --verify-objects refs/heads/bogus >/dev/null 2>out &&
 	cat out &&
-	grep -q "error: sha1 mismatch 63ffffffffffffffffffffffffffffffffffffff" out
+	test_i18ngrep -q "error: sha1 mismatch 63ffffffffffffffffffffffffffffffffffffff" out
 '
 
 test_expect_success 'force fsck to ignore double author' '
-- 
2.18.0.rc0.333.g22e6ee6cdf

