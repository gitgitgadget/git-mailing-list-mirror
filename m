Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89C4B1F403
	for <e@80x24.org>; Sun,  3 Jun 2018 16:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751461AbeFCQfJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 12:35:09 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:35764 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751393AbeFCQfD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 12:35:03 -0400
Received: by mail-lf0-f41.google.com with SMTP id y72-v6so21551703lfd.2
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 09:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d1YkCQpsQ8sGQkUWtOBAQALDM1t4bRMKX8UKs7FpZi0=;
        b=tCmnId3iSMHbzGSFkap3u5Lfd+xBv7E/hHfPFA6cIJ32MFGU/BZs2Te1v8vFCrtfFf
         HMEKHoQzAmpM6GyJeTMl7mhDdMZZn17XbKWEywDYV6xCqWDTUMZcdHEhX62g/Hc/zWJ1
         DaLHPedzdCCfZVgwelC1mzvMWY+froQnOls8IUFv3ijmPgg/9D4OBKato8WEHNgpg/tZ
         CXDFbmGX/xDwKV/0byki6qlgCmjsa3EfyST/Fpr2uyt5/YoO01WcRHP6b8uqWB/ZUEUW
         0NW0eEkwyfdjMnKSAW8XD8r9EEMmGuKXd5D2OX30blpZde62ziqCh9cd8zhaHv8Lgss2
         DWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d1YkCQpsQ8sGQkUWtOBAQALDM1t4bRMKX8UKs7FpZi0=;
        b=NI7e7rhbcrkszO54nfURuuTNEeEul7ZDfc8SLg6JcFqUVA98EY+tYFJQYF6o/4iLur
         PubhBPwefKkf+4XoWnadWc0EEnEQ8x39rN0teXTkWRJLrG8EmWpk5LD8dlreho2cuj/j
         xqCPkWjms7/rChRR9QYjdZN4RGlQx34pyQPVnjQ715Ac//lYQeT4kbM5Q4QX8DC3mVb8
         03/zX9DOQXC1YeAen1woO2Px9CmWfWfcyXyt4LgfIHNOo7XCRTT0hhwvcf5HpjsdtM4c
         uDyhjHP/K1Mbcrd4ViIL2up3oupuIuTVPofSTM4yksYabATRzdaiyyBlE5X6d4jg7xGc
         BawQ==
X-Gm-Message-State: ALKqPwdTk6Wv6gJWAnKk0Xo6DtploDvHVlPgc62+4e8o9NQ5puC4biQ+
        bkSVL2XVvUto7QBRv2W4t8o=
X-Google-Smtp-Source: ADUXVKJ9PtgTZzUb+bPKy7EFzHuV+JeEOEAV+IqV5tbrHOiryIFWqwrBbESG3C/l3v94V6ySjb/qkQ==
X-Received: by 2002:a2e:302:: with SMTP id 2-v6mr12838619ljd.9.1528043701898;
        Sun, 03 Jun 2018 09:35:01 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v79-v6sm4726895lfd.32.2018.06.03.09.35.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jun 2018 09:35:01 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 19/23] replace-object.c: mark more strings for translation
Date:   Sun,  3 Jun 2018 18:34:16 +0200
Message-Id: <20180603163420.13702-20-pclouds@gmail.com>
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
 replace-object.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/replace-object.c b/replace-object.c
index 801b5c1678..ddc1546b8c 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -17,7 +17,7 @@ static int register_replace_ref(const char *refname,
 
 	if (get_oid_hex(hash, &repl_obj->original.oid)) {
 		free(repl_obj);
-		warning("bad replace ref name: %s", refname);
+		warning(_("bad replace ref name: %s"), refname);
 		return 0;
 	}
 
@@ -26,7 +26,7 @@ static int register_replace_ref(const char *refname,
 
 	/* Register new object */
 	if (oidmap_put(the_repository->objects->replace_map, repl_obj))
-		die("duplicate replace ref: %s", refname);
+		die(_("duplicate replace ref: %s"), refname);
 
 	return 0;
 }
@@ -69,5 +69,5 @@ const struct object_id *do_lookup_replace_object(struct repository *r,
 			return cur;
 		cur = &repl_obj->replacement;
 	}
-	die("replace depth too high for object %s", oid_to_hex(oid));
+	die(_("replace depth too high for object %s"), oid_to_hex(oid));
 }
-- 
2.18.0.rc0.333.g22e6ee6cdf

