Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C2B21F403
	for <e@80x24.org>; Tue,  5 Jun 2018 20:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752380AbeFEUYy (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 16:24:54 -0400
Received: from mail-yb0-f201.google.com ([209.85.213.201]:49188 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752276AbeFEUYx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 16:24:53 -0400
Received: by mail-yb0-f201.google.com with SMTP id j138-v6so2732491ybj.16
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 13:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=3Ot+nikV34IZKy3Ud1I8wNiFFwqJPiAylmlaFFkc3Yw=;
        b=tADdfTFedkM+8CUdlXLWrQy4FxRLOE052gU1+J8WILIzDJhks8jEDh4LA0WSa3gofL
         gcsgzGdmjm6ootNC52SKSTXGK3IwCZvDB9wjknOmxIqd5nEO6CWeNlCGHLhIFXVokYjY
         H0VdlbTlPevcG0vaoRwoVOO62upIENk9gTC9jvwr+e23bDlExqJHs0+Tk1kHJbYr05B2
         PkSsVdSfZEum4BH7CJ3MUkowRvqaLX36H062w6g19TYh+FOWEY81GhookFRwsEpP1Zum
         itA0xXdn3SBKGa8fCEnuEUWcqQa0olTROwZiCLwnRqZkQqcMjvcnV8sLRckDq7aS53bF
         Z6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=3Ot+nikV34IZKy3Ud1I8wNiFFwqJPiAylmlaFFkc3Yw=;
        b=psgMoxI54rFXIhqpZ/lLlVw02xbFQsePpMoIa1a8JShwlzsJSpOwUs3Wp9YqZIjuUM
         HxW6xBaaFfoa+ZpeTULzbC4hRps3vaTiXpNCn/8gUzc/08GkigsziOV0oHVEC6qLth0H
         55EtUAT3SpNApeUWDRdW4mlRTQUNczUc+dp2M+48a9B3XuHVvkjOXvaRhFX6jh3A98ZO
         +eVQTO0u6Tp6CGUHOXe+eBapyL8tAosTFkfl6md0+xg1wr6/61wFyK1cWbIW78n2Lh6V
         ycV8fOOFFpDmjMT/GxDcUDqghPss/sPC3BSYvveFYO2OxHhLVT6pdOLOYf2NVHnVCQbG
         Y6aw==
X-Gm-Message-State: APt69E1u1sJdvtTE3iEYNW/HZLbEBlcFEDIYueLvLwe7BtMEhP03hNSS
        S7lJ90q2nmf8TOoGQvwkAZ4wMRSLZmICu9vMndtXyIcoScqXQB0bW2SpjMF0e2TnqAZCRi7+JEI
        fz3JACz9O52Z/OWmsRUGIn0/p996FoGt8qB8Dedf4MoGdbgOJ3cctO5Z5ZA==
X-Google-Smtp-Source: ADUXVKI24rZ6H99bzh4pFa97TdEC8nTzkNv3oM2Wc8l91VGKdZ0wq3QSicNWwhq7OUN6Ia/9IwDEd0wmd9I=
MIME-Version: 1.0
X-Received: by 2002:a0d:ea09:: with SMTP id t9-v6mr43405ywe.9.1528230292615;
 Tue, 05 Jun 2018 13:24:52 -0700 (PDT)
Date:   Tue,  5 Jun 2018 13:24:49 -0700
Message-Id: <20180605202449.28810-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.1.1185.g55be947832-goog
Subject: [PATCH] docs: link to gitsubmodules
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a link to gitsubmodules(7) under the `submodule.active` entry in
git-config(1).

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/config.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ab641bf5a..1277731aa 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3327,12 +3327,13 @@ submodule.<name>.ignore::
 submodule.<name>.active::
 	Boolean value indicating if the submodule is of interest to git
 	commands.  This config option takes precedence over the
-	submodule.active config option.
+	submodule.active config option. See linkgit:git-submodule[1] for
+	details.
 
 submodule.active::
 	A repeated field which contains a pathspec used to match against a
 	submodule's path to determine if the submodule is of interest to git
-	commands.
+	commands. See linkgit:git-submodule[1] for details.
 
 submodule.recurse::
 	Specifies if commands recurse into submodules by default. This
-- 
2.17.1.1185.g55be947832-goog

