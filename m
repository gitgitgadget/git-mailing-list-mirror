Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15C861F45F
	for <e@80x24.org>; Sun,  5 May 2019 16:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbfEEQHL (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 May 2019 12:07:11 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:52438 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfEEQHL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 May 2019 12:07:11 -0400
Received: by mail-it1-f193.google.com with SMTP id q65so15236476itg.2
        for <git@vger.kernel.org>; Sun, 05 May 2019 09:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VIeUW11pneVJsGTLIaQBeJtHbaw4Oght/gEo1s2JLdw=;
        b=O+wLglmAyGKOuC9ApEP3usBBcuLx5B2siB0UyciJKbCSKRnoyhA3Rov+vHcQ+qG4Yz
         4TPkcK9H60ko1cN3popOeIbUaHmgs4zFJUSEIE6Ys4eP5JlNMeZqgcn0pjqZv/fdVDw8
         ceVpGEVxLJOaDrRZtzjqzIVopYBb8/c7oPFTqvzU3BEPC+iy+WpAoaVoDSInBYxnehAy
         bVdhkr95sfNk84dK0ypAjbs2gbrfwIhJOHdt42lH4+pqG7YmTxkGR2ZgvelyaVhvlyZ5
         FqIvIUJK04Q1iDrcAWe4SXJA2X2qON/JasPFolqQST86lADp4rHnaKnm4c4s+MC6GTAm
         WZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VIeUW11pneVJsGTLIaQBeJtHbaw4Oght/gEo1s2JLdw=;
        b=k4Q7IqF06cZKuVw/i1lK0s0JtQJoP+OidLgS/gJj7IAWRFnul37IQuwKi9yChEyGII
         wSsyrGDYh5n+ml7R8ENfpChi37MbC+m79Xd5G0fvPgIRYwlxZc3JzqqGGBBeGgPU0jZs
         XGUNmmOPvAn5x91I6fho5eREtAsw0wMIjc2XQf0W5SNniUHaEiY/Tqmmuo/wJIoTRPeq
         Ban9JRNnPCsgE6+X39RmPBqCSUfZt/b93sbwVXcyk/8PGFZh9OObsl3qB/valr4filZm
         M2Fy2kqFlneMfJ+XR8iMr6LOvAOI+hBsliM7mUBjp824S65reCWn/ZxJTM4xTwxRQL7e
         p+wg==
X-Gm-Message-State: APjAAAUQE/8C0BoTJ7hJu54KpEkZ3P/YH7WwNKu4Sr8PlV3J+vABC10K
        kJMz1krXSzDTGP4rjtBlgcDHfEmE
X-Google-Smtp-Source: APXvYqzF5G/xYaZxCvVaUxs4kwj/3rDWSmqiDaKBemh3oz1WswKQ3sJCl5Mv8Y9qoOhruljF1VOxkQ==
X-Received: by 2002:a24:4145:: with SMTP id x66mr15752281ita.130.1557072430396;
        Sun, 05 May 2019 09:07:10 -0700 (PDT)
Received: from archbookpro.localdomain ([199.119.233.193])
        by smtp.gmail.com with ESMTPSA id j8sm3497143itk.0.2019.05.05.09.07.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 05 May 2019 09:07:09 -0700 (PDT)
Date:   Sun, 5 May 2019 12:07:07 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/4] revisions.txt: mention <rev>~ form
Message-ID: <1ba823024edddfb0e6ccb92647137eccf5d4c7d0.1557072286.git.liu.denton@gmail.com>
References: <cover.1557071877.git.liu.denton@gmail.com>
 <cover.1557072286.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1557072286.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In revisions.txt, the '<rev>^' form is mentioned but the '<rev>~' form
is missing. Although both forms are essentially equivalent (they each
get the first parent of the specified revision), we should mention the
latter for completeness. Make this change.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/revisions.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index dd99770c47..a38ec7fb52 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -139,7 +139,9 @@ thing no matter the case.
   '<rev>{caret}0' means the commit itself and is used when '<rev>' is the
   object name of a tag object that refers to a commit object.
 
-'<rev>{tilde}<n>', e.g. 'master{tilde}3'::
+'<rev>{tilde}[<n>]', e.g. 'HEAD{tilde}, master{tilde}3'::
+  A suffix '{tilde}' to a revision parameter means the first parent of
+  that commit object.
   A suffix '{tilde}<n>' to a revision parameter means the commit
   object that is the <n>th generation ancestor of the named
   commit object, following only the first parents.  I.e. '<rev>{tilde}3' is
-- 
2.21.0.1049.geb646f7864

