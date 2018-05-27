Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF8681F42D
	for <e@80x24.org>; Sun, 27 May 2018 14:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965484AbeE0OEK (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 May 2018 10:04:10 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36798 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965011AbeE0OEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 May 2018 10:04:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id v131-v6so6495009wma.1
        for <git@vger.kernel.org>; Sun, 27 May 2018 07:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CFfTvHWYzHw+Gyebd4TAnmVKE9G4iSrSdty8OYAfuPo=;
        b=h1EsjpwFAuBWelmTwU1gVUd+d/WQE3+dtP60MGkv3W8hKHBexIu0znd/38qzqFkYBq
         gA+fQNBX/HQDZSXsopNihij41IoG20Z0ejEP6UDzokpJu7VK5ZBqpaJK+xN/wb6VoGHx
         +ZGFOaoElvBbIAKaLsm16RK20pVX7QMUtjMdKdgbxD/S4jotO585nv/Ph6gQOCvazr5F
         pu92QWNge7XUzbr4lxSDEyDk4tNy7pDQFG1cRwz0YiXeEVAF+OojPmJQb2ywAo0r49L9
         jlskZ0InRHvL2at7KWzFfW4ejPrF22ZST0yTBGIoF090GO0rQpvIgxasPNGwoMAFHelX
         D1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CFfTvHWYzHw+Gyebd4TAnmVKE9G4iSrSdty8OYAfuPo=;
        b=UArbe7uRvMXZQ7fjPEJbSTG6/gqkn5yruaAZbm5OrCw0RmlJK4YJ7sViUt4NexHxQg
         tstuHJ6B6JmkbFsURlRRGMGYkDv23FSpco1HgCTIXbI/+Tl9H7uw7SUoORDdeiP8H9QQ
         db1Zm2X6Urv8PGc8ORmqnUikdA9GxhmAYBDufTj3WI2SoYu76yytXuBRumeF3l0QHQrM
         9gfH//nqvyuGGTUGI4m3DJcik2NHHm75UD9KjGUXHXxR1TeygnphIfFBrgTZAPiuiTNP
         jjV8A5jj1inPzzkWg9r/ZXEy5LLdKVemJDaoF0fyV5om/vF+UVsvrpve2QLOVzy9kQkG
         z6vg==
X-Gm-Message-State: ALKqPwdWPlk0WZBHpH/sakt2J/iB7dIhmxRgEfU02oZbQbA/asMZQYit
        G8n6CT0+RgNmJJNcAIL0TBb/YeuS
X-Google-Smtp-Source: ADUXVKJaBafvdzscRiVt7H9mcQ5l3VWb1GlQgi80x7R7Hswq7RaKE1ihqS1Abat1P71lUdeBlYokVw==
X-Received: by 2002:a1c:ec82:: with SMTP id h2-v6mr5929322wmi.137.1527429847911;
        Sun, 27 May 2018 07:04:07 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id x24-v6sm8476270wmh.18.2018.05.27.07.04.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 May 2018 07:04:06 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH] README: note git-security@googlegroups.com
Date:   Sun, 27 May 2018 15:04:33 +0100
Message-Id: <20180527140433.32277-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.921.gf22659ad46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a mention of the security mailing list to the README.
2caa7b8d27 ("git manpage: note git-security@googlegroups.com",
2018-03-08) already added it to the man page, but I suspect that for
many developers, such as myself, the README would be the first place
to go looking for it.

Use the same wording as we already have on the git-scm.com website and
in the man page.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

2caa7b8d27 ("git manpage: note git-security@googlegroups.com",
2018-03-08) also mentions SubmittingPatches, but I think people are
much more likely to submit a report of a security issue first, rather
than sending a patch, for which I think the README is more useful.

 README.md | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/README.md b/README.md
index f17af66a97..f920a42fad 100644
--- a/README.md
+++ b/README.md
@@ -36,6 +36,9 @@ the body to majordomo@vger.kernel.org. The mailing list archives are
 available at <https://public-inbox.org/git/>,
 <http://marc.info/?l=git> and other archival sites.
 
+Issues which are security relevant should be disclosed privately to
+the Git Security mailing list <git-security@googlegroups.com>.
+
 The maintainer frequently sends the "What's cooking" reports that
 list the current status of various development topics to the mailing
 list.  The discussion following them give a good reference for
-- 
2.17.0.921.gf22659ad46

