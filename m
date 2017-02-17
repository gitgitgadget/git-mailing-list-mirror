Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7525201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 23:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964867AbdBQXFr (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 18:05:47 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34421 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964788AbdBQXFb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 18:05:31 -0500
Received: by mail-wm0-f68.google.com with SMTP id c85so4866440wmi.1
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 15:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5yvD0ZbJoHv/SJGKlGWsawkdp7U9XYyLAwLn3zxJWQg=;
        b=Rnr4y6+3KVLlaX7Ldb1FbeLvI9fkOHN49VvOdVVSXpi/SdHnNawcXK6fjU+wtth3Hv
         fRa95VTOGnseuZfOVa57vfvlPwd2A+gB/ja1qWlORdE/wSisRQeaAYCwYahWb8QxHWAu
         8VAVWPXilmgjD7TFESNlMC4fgVnS15tpRp9XtvOiG4AMwGtJ5QChIIInK+RHAHGjnBEE
         Sy9Dc4FReoAg2a9Z/lo/VYtItowhr2OD/Vma/SaZxoJetF+oUw5WHVSYSHfn1nhntFnq
         zmCxMhUy13YOCUdSNoqtC/95sR8EXU5ewOicAMVul22ErpUztcIk1eE3Ij8eimpJ7MvC
         /67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5yvD0ZbJoHv/SJGKlGWsawkdp7U9XYyLAwLn3zxJWQg=;
        b=uVNP744/Ct+IHRDbrBy1bocRd6/DBxqfWUpJDS5go4ypcLNrsP6fF33UJ3gwtDE8QU
         +qED/F6Qbrxd+/zF6iWd74SEs2LDamyaKt+UwW65Zc5/URLySgpX6RAwQMzKC5rx/DuD
         DvL9XdAB4V1GCcbxrHtqmgommm1vBLuBCn/14iPr8ie2xHRIZFWl4UAjz01QIzcyGh6Z
         IbwkrDh/7ldAztEPDJpomFS5B8WOkmyCBaDvPjdO7bF/YeJUQAbYbj72NpvHsk7lLhZi
         UCCqJ9IhkCqXX2fYQRmR+mjpCJkk4o29B96fkxChGZrXUuBWqA/1Xo4sT74Yk6Rr/MgK
         fWTA==
X-Gm-Message-State: AMke39kOM/HJVDKvIsApn/6UwhmAE4cFYuhbNASayuXr3mvLxaTajN4dmwjgo7GxwnwDNA==
X-Received: by 10.28.91.19 with SMTP id p19mr5663294wmb.49.1487372678862;
        Fri, 17 Feb 2017 15:04:38 -0800 (PST)
Received: from arch.fritz.box (i577ABC5E.versanet.de. [87.122.188.94])
        by smtp.gmail.com with ESMTPSA id d42sm14635827wrd.7.2017.02.17.15.04.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 15:04:38 -0800 (PST)
From:   Phillip Sz <phillip.szelat@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, Phillip Sz <phillip.szelat@gmail.com>
Subject: [PATCH] submodule.c: Add missing quotation marks
Date:   Sat, 18 Feb 2017 00:04:33 +0100
Message-Id: <20170217230433.23336-1-phillip.szelat@gmail.com>
X-Mailer: git-send-email 2.11.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

just found this while translating, sorry if this is intended.

Best regards,

Phillip
---
 submodule.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index 3b98766a6..b064ed080 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1181,7 +1181,7 @@ int bad_to_remove_submodule(const char *path, unsigned flags)
 	cp.dir = path;
 	if (start_command(&cp)) {
 		if (flags & SUBMODULE_REMOVAL_DIE_ON_ERROR)
-			die(_("could not start 'git status in submodule '%s'"),
+			die(_("could not start 'git status' in submodule '%s'"),
 				path);
 		ret = -1;
 		goto out;
@@ -1194,7 +1194,7 @@ int bad_to_remove_submodule(const char *path, unsigned flags)
 
 	if (finish_command(&cp)) {
 		if (flags & SUBMODULE_REMOVAL_DIE_ON_ERROR)
-			die(_("could not run 'git status in submodule '%s'"),
+			die(_("could not run 'git status' in submodule '%s'"),
 				path);
 		ret = -1;
 	}
-- 
2.11.1

