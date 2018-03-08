Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E344D1F404
	for <e@80x24.org>; Thu,  8 Mar 2018 15:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935311AbeCHPIc (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 10:08:32 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35341 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754302AbeCHPIb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 10:08:31 -0500
Received: by mail-wr0-f195.google.com with SMTP id l43so6018018wrc.2
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 07:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TGInPJGNe3F5UwxH41oDxSGzU9Fe3wICzYxFCmTOxC0=;
        b=AEZUU4liGDcOXUv/cBw7ZDEdC747UJ6MoxOzuDQfacpQ4LNbTQ0AF+2mk5iroghoXn
         wRcAG/XeYaODAmUEi1ynTn82I6ePFOU+ifFwVrkI+LA9JPOD9FlDQ7BrZszS4zU94cQy
         SgZWVixwAp6/tih8HXlgc083iuiBQs0o96rerhTUr/mhPY95WBqrw2H2FNVuk8Kaf0ko
         P7YAlW0ATgxWqfZAquvISvmHCsr80witm6hkAF24YnynlvzRUEM67xNxuTlVDH6nyRa7
         v0iaXWsMrsOUT2pxjDmE/JBUWotsPU3uWv/1+J1fWBmAknKigcHwaBUnLLKaOEpVyIYB
         qSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TGInPJGNe3F5UwxH41oDxSGzU9Fe3wICzYxFCmTOxC0=;
        b=J0/98uLOI3JH66bNwI7ITYS8BWxVrgIO2bVS4qx5fcjGfoVriwSqZWY8rVapkS/Kq4
         VRL4+udgfG9TBnQaM9tki2gnqYYij4xdgUPUgO+HxdiaeJVLw+P+vJ9/b9NGeYTqvfFa
         Auho1oOdaphha4wCDVPzmheXsbDm7+KPjE3dVEECxaywkBuRISmT1Lp65lX0A9oobwEb
         RkRecuxSDfMyMRtRpsNd3QdyMPkKQM4f32O8ulXF/sYQZ8qj6N41VCGCXS3V/0CfX0AP
         6H80tgVn8IX8L+M3T9iDql3+S/HW0RpjOYkNejRimhw5+o9i0jAHUutHnAoaO1RocS5h
         xzeg==
X-Gm-Message-State: APf1xPC0XAehJ304kn/r4S+r36CQNgZ+XITyXt0eWa66J9RulzXqTveN
        YMPY61g/EHO0XazFRaaGhFjoLZvx
X-Google-Smtp-Source: AG47ELsBrZJ6U9JVRjM5ZPsxA9rgeGRPTedxn6wsBLMZkXlL9pNA490x2PsSNvNsckBruTHykNtKMA==
X-Received: by 10.223.179.82 with SMTP id k18mr23179495wrd.173.1520521710225;
        Thu, 08 Mar 2018 07:08:30 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id r70sm23365857wmg.40.2018.03.08.07.08.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Mar 2018 07:08:29 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] git manpage: note git-security@googlegroups.com
Date:   Thu,  8 Mar 2018 15:08:20 +0000
Message-Id: <20180308150820.22588-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a mention of the security mailing list to the "Reporting Bugs"
section. There's a mention of this list at
https://git-scm.com/community but none in git.git itself.

The copy is pasted from the git-scm.com website. Let's use the same
wording in both places.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
Someone at Git Merge mentioned that our own docs have no mention of
how to report security issues. Perhaps this should be in
SubmittingPatches too, but I couldn't figure out how that magical
footnote format works.

 Documentation/git.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 8163b5796b..4767860e72 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -849,6 +849,9 @@ Report bugs to the Git mailing list <git@vger.kernel.org> where the
 development and maintenance is primarily done.  You do not have to be
 subscribed to the list to send a message there.
 
+Issues which are security relevant should be disclosed privately to
+the Git Security mailing list <git-security@googlegroups.com>.
+
 SEE ALSO
 --------
 linkgit:gittutorial[7], linkgit:gittutorial-2[7],
-- 
2.15.1.424.g9478a66081

