Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9F971F453
	for <e@80x24.org>; Wed, 30 Jan 2019 20:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387973AbfA3U4f (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 15:56:35 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:42307 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387953AbfA3U4e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 15:56:34 -0500
Received: by mail-ed1-f48.google.com with SMTP id y20so773821edw.9
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 12:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jOEJLrRKSNU5Ubvoy4Sb+1LnpkiwcYXZTV6mBbN+Jpc=;
        b=dDmdTvWCfiBOFVhp7ZkzN07lQb3XSSVF+EYp+Hp/hOTjgis40iQkj+eE3pV9zojZwj
         KoQ81RRQQLF8vDN5j8NLGDeiW5LEEOiRRzQR5hKJpJU/umRU5keC8w147VYbWt8Vp9x8
         ke+/x0Y5rE/fww6A0NUJuGe6xUgjspc7yfMV6l4U9e2Vb7C2jhuDIg4rLPgK7JpnGHwh
         deFFK6RcIeh1ar2k+/YzPdbVvnS4nM+8YSr7PPmq/QSRsSkOZz9/VphX1M36r39uQHiK
         6IPpK/UzRsH3a1PFhYw5TTnQ4jpm1Zmg379ucftyMxWRmfxzt1jbDVrydFfKgf16feoI
         mfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jOEJLrRKSNU5Ubvoy4Sb+1LnpkiwcYXZTV6mBbN+Jpc=;
        b=Df9oTJ5HXHGvtRRir+2iykQMsdKLgrObs1Frx1I1LdN/5rLJDmZ2znkwYZ2jij8XdL
         +ojAPx6Mn1UXFq4hUbzAiEwUX6QE9ZVQ/MFkkyyTbxsrC5ZZXtpRgqpUMvq/oVLMnQnD
         hYsJeOiiDVQZh9V9QeNGS05z4SJNOGcXAFbTI3wy7EzzhmOeDdbrYbOMM4pPv2HgzFLT
         CtwsJbDD1ZqBW9l1/awplX2QC5n1sdVIsARicYDLRLMrPfo6tvcTe8xCDF9HIPw5BD2E
         yKaet0o1DnIoU8P8uMQoL5tJVns6uSxVxObiY0K2/xLEVxDYYEA4pzX0jmbqvIF4Hwdp
         G/Wg==
X-Gm-Message-State: AJcUukdi+HOBDXc2231Fyq5xks1vNE2Bgys/3/Jvi0SPQCw9LgFGEqDr
        TNB1pM6od2k2RXz83jcBNA36Ii55
X-Google-Smtp-Source: ALg8bN7jhNK4/gFYO5UWfb7zK3r58ywGrUkNYzZ/cU+z7v39zfGhGVk5fPNPGs71MQ7ZKDsPY5bj4A==
X-Received: by 2002:a50:af43:: with SMTP id g61mr29897017edd.286.1548881792848;
        Wed, 30 Jan 2019 12:56:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t26sm475167ejs.48.2019.01.30.12.56.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 12:56:32 -0800 (PST)
Date:   Wed, 30 Jan 2019 12:56:32 -0800 (PST)
X-Google-Original-Date: Wed, 30 Jan 2019 20:56:17 GMT
Message-Id: <ed1d6120067d78ed35cde8c6d3f609e9e5eed3a4.1548881779.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v4.git.gitgitgadget@gmail.com>
References: <pull.108.v3.git.gitgitgadget@gmail.com>
        <pull.108.v4.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 12/14] trace2:data: add subverb to reset command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/reset.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/reset.c b/builtin/reset.c
index 59898c972e..b65b4a66db 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -340,6 +340,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (patch_mode) {
 		if (reset_type != NONE)
 			die(_("--patch is incompatible with --{hard,mixed,soft}"));
+		trace2_cmd_subverb("patch-interactive");
 		return run_add_interactive(rev, "--patch=reset", &pathspec);
 	}
 
@@ -356,6 +357,11 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (reset_type == NONE)
 		reset_type = MIXED; /* by default */
 
+	if (pathspec.nr)
+		trace2_cmd_subverb("path");
+	else
+		trace2_cmd_subverb(reset_type_names[reset_type]);
+
 	if (reset_type != SOFT && (reset_type != MIXED || get_git_work_tree()))
 		setup_work_tree();
 
-- 
gitgitgadget

