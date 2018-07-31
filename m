Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F10D1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 17:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbeGaTS0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 15:18:26 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:40083 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbeGaTS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 15:18:26 -0400
Received: by mail-qk0-f201.google.com with SMTP id i8-v6so14425039qke.7
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 10:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uswNY7o4k2z3sGPQnU/7aXIR83bXsGn9+HCYnCSxPsM=;
        b=upN7L6Cqs+GUog3dQ6FISo+67dRRNk5aWgAf3e2ndGZFXowtJPrknnrkNODCI79DEb
         lrrrWhliTaKOhg89aDjOY0J1XiCDGVfuJE3y2cphig15HZ9FYY+HaYGzAo5Qp20r+WDx
         lWvgh/nvS3SMID+C0rVv4jE6YXsFAHS3WmsOXXZ2S7y/LYKa9MCWsUz2XhWF/1ek+qv7
         TJmG46X4cllUoefZhGPESRDnz0zgYkNob/3QUNo0o5SEQQTMFTP7eOuA30BVN+SBCRMa
         1EgbkyHVGK/tp/IwMwy4rw9DexP4MVyO2gnYAnLJ9S/7qxXKFJxr8kLk6UFK/GamHM73
         zIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uswNY7o4k2z3sGPQnU/7aXIR83bXsGn9+HCYnCSxPsM=;
        b=Gia/eozizBbfc18QRcrpC765VO9CzyOAnfQrkd8bDZnxzQ/d3zk0TeQZh2/EOxMuJu
         dkVg3cUuH/TmSstiUkKO3FzZcBDPe0lHi40tUotouThkJu4pwRvO/9U6gJcYh2m4SQh2
         i8F/Z6jCYR6AMWO6b7ZNdPf2sCBOd8AOw1f2OjEkauxT/cJwApCfMVuaz0ziY36ApSCa
         R5WI2NmEGFkqKLpy4NP9HKJAduD5mcLG/aDSO1FJ27XXIWu6LWn6lPEFgZ/wwyChxtGt
         C8xsO4s7Sw6JJ1ZDumEkdksHu+1YkaC1laaZRWLnX9+Mcw8llp7AdFPxpqtUDDm5IC/K
         6x2g==
X-Gm-Message-State: AOUpUlERob4V23kzAfrK4kKt7AUpVBI7LEuAHCq2K7y94SfiX3basRXs
        gjPIyi0nbKib+m3hNE0zsNvB9bVrfY0=
X-Google-Smtp-Source: AAOMgpchImDnXSq5Lhxyj1b8amdk0nK4NzDiqsXI4BRwGB/BxJQenkkojRR9pXaGuDrrVl6Ah1/szFJzqVs=
X-Received: by 2002:a37:9807:: with SMTP id a7-v6mr13503105qke.30.1533058624051;
 Tue, 31 Jul 2018 10:37:04 -0700 (PDT)
Date:   Tue, 31 Jul 2018 19:36:50 +0200
In-Reply-To: <20180731173651.184716-1-hanwen@google.com>
Message-Id: <20180731173651.184716-2-hanwen@google.com>
Mime-Version: 1.0
References: <20180731173651.184716-1-hanwen@google.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
Subject: [PATCH 1/2] Document git config getter return value.
From:   Han-Wen Nienhuys <hanwen@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 config.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/config.h b/config.h
index b95bb7649..d39256eb1 100644
--- a/config.h
+++ b/config.h
@@ -178,10 +178,16 @@ struct config_set {
 };
 
 extern void git_configset_init(struct config_set *cs);
-extern int git_configset_add_file(struct config_set *cs, const char *filename);
-extern int git_configset_get_value(struct config_set *cs, const char *key, const char **value);
+
 extern const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key);
 extern void git_configset_clear(struct config_set *cs);
+
+/*
+ * The int return values in the functions is 1 if not found, 0 if found, leaving
+ * the found value in teh 'dest' pointer.
+ */
+extern int git_configset_add_file(struct config_set *cs, const char *filename);
+extern int git_configset_get_value(struct config_set *cs, const char *key, const char **dest);
 extern int git_configset_get_string_const(struct config_set *cs, const char *key, const char **dest);
 extern int git_configset_get_string(struct config_set *cs, const char *key, char **dest);
 extern int git_configset_get_int(struct config_set *cs, const char *key, int *dest);
-- 
2.18.0.345.g5c9ce644c3-goog

