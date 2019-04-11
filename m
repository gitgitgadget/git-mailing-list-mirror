Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7773220248
	for <e@80x24.org>; Thu, 11 Apr 2019 15:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfDKPSl (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 11:18:41 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39590 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfDKPSk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 11:18:40 -0400
Received: by mail-ed1-f68.google.com with SMTP id k45so5555798edb.6
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 08:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d6/pwyygQtJkEfr0hzb0Qf8WkJMXz++VT18KpzqACm4=;
        b=sdc9t5RYic+KI/goLH4+usxcyIocKMg7F5cX54u6aW74HHXJw/62gPpmJc0NSyYrOo
         uP6rmbM2egTdB8mO8QAc3w8YHtYVgxsU+b5E0nTZCdoZDqRwJEebsfKVaLoJZMSf7lMU
         cpS48R+z3e3PGxJfvKXfu6JAsg6wzgLe+Ma+L/FVF3kUTp/y6KimDfbX0GWMacquMvIP
         ZgUezkefxjg4zCcqFRpAyLDK2I2RP6d1Jeh9dzPxHkGtrR80pmKkQLMZ6elWZWocnv8M
         Y0WttQ+4X5zu3fzzANYcmlxqoYiaumTT4atDGOYbuB9J94Z6QBXH2EVMBetvU6r9wWM/
         xWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=d6/pwyygQtJkEfr0hzb0Qf8WkJMXz++VT18KpzqACm4=;
        b=LppZ+bJoVIBA0axy3TYDWrPI/f/QYMEoBJrrKBvYkNhR1RjItdJjETsv84i0Mu1ij8
         xErMasm9PMphjfKw3i0DWo4oZzIik72CcpbOIJtmCAcdZ0iZoUfohNNJH3cgaEgaTxsd
         q4dpKquvoJOVNahTPWTns09cRw+BUELg9tek6jp76DJA5i9fCrQNK4o5o45fp4Qa9L53
         yjN5rQWm4098FAm+fut4qFLdYGT1ZBRhOVkZYFuWs234aYpjPMp9aBYR8uXa/Ek4+kZd
         qlanY70C3TdhzK4VTaj4XSev12yRRanRsvSMWijrgXGA/tbpHyraE8dfqaOpy5Vtl/3e
         w9DQ==
X-Gm-Message-State: APjAAAX/tLsDCLQidegi6BRZMs+kfst8eFFf5eB5Ngi7ZuxgwANp0rkl
        uc5HgEBu3fNuabMv7PTgMDglLnJX
X-Google-Smtp-Source: APXvYqz78rBqOEpxG+Yj/SrbzzbGJL+2OaSeEQZeL7JW9a1OKWmdd/P4XkRCWCgtJzoR+0DGI8IvxQ==
X-Received: by 2002:a17:906:1811:: with SMTP id v17mr28337505eje.109.1554995918769;
        Thu, 11 Apr 2019 08:18:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u21sm4358099eds.97.2019.04.11.08.18.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 08:18:38 -0700 (PDT)
Date:   Thu, 11 Apr 2019 08:18:38 -0700 (PDT)
X-Google-Original-Date: Thu, 11 Apr 2019 15:18:27 GMT
Message-Id: <ea8c199f911a84505b1aba5735a280ffc989e2a1.1554995916.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.169.v3.git.gitgitgadget@gmail.com>
References: <pull.169.v2.git.gitgitgadget@gmail.com>
        <pull.169.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 01/10] config: initialize opts structure in
 repo_read_config()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jrnieder@gmail.com,
        steadmon@google.com, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Initialize opts structure in repo_read_config().

This change fixes a crash in later commit after a new field is added
to the structure.

In commit 3b256228a66f8587661481ef3e08259864f3ba2a, repo_read_config()
was added.  It only initializes 3 fields in the opts structure.  It is
passed to config_with_options() and then to do_git_config_sequence().
However, do_git_config_sequence() drops the opts on the floor and calls
git_config_from_file() rather than git_config_from_file_with_options(),
so that may be why this hasn't been a problem in the past.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 0f0cdd8c0f..8e5f45fa20 100644
--- a/config.c
+++ b/config.c
@@ -2011,7 +2011,7 @@ int git_configset_get_pathname(struct config_set *cs, const char *key, const cha
 /* Functions use to read configuration from a repository */
 static void repo_read_config(struct repository *repo)
 {
-	struct config_options opts;
+	struct config_options opts = {0};
 
 	opts.respect_includes = 1;
 	opts.commondir = repo->commondir;
-- 
gitgitgadget

