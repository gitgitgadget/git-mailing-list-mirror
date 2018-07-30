Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0600B1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 12:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbeG3OA7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 10:00:59 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:53891 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbeG3OA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 10:00:59 -0400
Received: by mail-qk0-f202.google.com with SMTP id f64-v6so11037898qkb.20
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 05:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ewtBdLlFstyXu2rzv/9mOhAvT2zhsnePDQJRGRvSnD0=;
        b=hQ/OSmT3Z2tW84rO2Xl9eZFGFPpgosYPenoHhcTehQxvjhGfeVGufpv1CPOm9tvGe1
         xocQ9mx4lWzUzkHUxVs430F3wP2w9B3yhC/Y7YmKNyjAyPRY/w19Nf60ry4a5uzrwYh2
         hPsOj3M43y7fxBRqfTkrDmGr/mUCjZKFuyGZFOZTcJLKrqO1zsXG4H7D3Z3BaRqF7I9K
         v9KHjucWKbqWQuuzm1+4C3Arz2vIakyIq2G8GTJsDUfxseadHQH84eKJ3A72FY9Sp11Z
         znlzqaQCmiVLemrqYRZU+O7tEneCrtKZ9BmYLp07rbOo2/+I+X09OCve4HA5e/bgm+g1
         eN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ewtBdLlFstyXu2rzv/9mOhAvT2zhsnePDQJRGRvSnD0=;
        b=rxc5gDyrHGirq5S0Epzs0GjOoPKrdsJLIC7Am3N36+jaIpkfM1fAPHlpDognPrJHcM
         4OcSlN0sXGRpXb+/XybmrHmRLe3eFo0MpHnZz9EgT2OBo9BHWaJsh+JDsNbhA6xwGVi7
         JL0RIDtkYCF3ehbn4V3ePRw7CfboIHOmUvTBHon25jeSH2IU/CF9uOzDUfT1k1cWS+Y0
         t9v22893QEzpYv7IfDC8BqUnvfJvhAchkV6lpDBaC1LrMnuntFXARkHHuPnz8FvfmpzO
         FdFBE5EnUsmK2H5AKxsVyLp/vodG9+whVh7/OyyNED4njsxOKZpYvtgN/4LTvAPKMzrd
         Uqhg==
X-Gm-Message-State: AOUpUlGGyfyoeQcV5JrvhurV1P8tCvVioT0j9+589C4Xo1oPzPU3gZKh
        0R4EW8xC1SHLbUPjETEBNoRkliva+1ZgjtnbMHWH1aG7BcQYE1BOKeXDP6obB3tzG38wHSWvGyF
        gpYMt38StlWcsnm4VzE//u7Qb5rzuy9QozPhlBYsznOoGUtSQN42CTjmDPQ==
X-Google-Smtp-Source: AAOMgpddlIb2/wmb0pDWthRtVoiNCTFohmhJ5+CJM8sWMuJyZQ02CzhOo5dp07r4wYHYLMMYZIOtqgnrJIM=
X-Received: by 2002:a0c:f98a:: with SMTP id t10-v6mr9545368qvn.2.1532953574518;
 Mon, 30 Jul 2018 05:26:14 -0700 (PDT)
Date:   Mon, 30 Jul 2018 14:26:08 +0200
Message-Id: <20180730122609.57058-1-hanwen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
Subject: [PATCH 1/2] Document git config getter return value.
From:   Han-Wen Nienhuys <hanwen@google.com>
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>
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
@@ -178,11 +178,16 @@ struct config_set {
 };

 extern void git_configset_init(struct config_set *cs);
-extern int git_configset_add_file(struct config_set *cs, const char *filename);
-extern int git_configset_get_value(struct config_set *cs, const char *key, const char **value);
+
 extern const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key);
 extern void git_configset_clear(struct config_set *cs);
+
+/*
+ * The int return values in these functions is 1 if not found, 0 if found, leaving
+ * the found value in the 'dest' pointer.
+ */
+extern int git_configset_add_file(struct config_set *cs, const char *filename);
+extern int git_configset_get_value(struct config_set *cs, const char *key, const char **dest);
 extern int git_configset_get_string_const(struct config_set *cs, const char *key, const char **dest);
 extern int git_configset_get_string(struct config_set *cs, const char *key, char **dest);
 extern int git_configset_get_int(struct config_set *cs, const char *key, int *dest);
--
2.18.0.345.g5c9ce644c3-goog
