Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D39E01FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 15:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933520AbcLIPwu (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 10:52:50 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36318 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932427AbcLIPwt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 10:52:49 -0500
Received: by mail-lf0-f65.google.com with SMTP id o20so365746lfg.3
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 07:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=mpFjYX5zYuBKahxstHElTG4pSBvfjkiny9bmAiIREmA=;
        b=hTvClgT7eCcijmytkCBqW0J/qJwDNQ7Nr3rTdeNkbXFbnG8rL0N/6r1LKA78tRlQtL
         5ksgSd8ld1K84ScTz6rCP3Ne1DubEzJPqLBY2G96xgJK/oflJ8+apB84MfoAjvkCwNjQ
         UgcC2Mbg/nsDIfk/gweW+CgL+xMgBZf9VYa+Qr3QUhJzoZlas/CVehoX4Tce7skLP5g3
         8Ao3Eb40zQpeoGfFVzqANc2L5cpCv7/XNR+JWKQX4mfijOpLIvdoLZ5Iz872aIi82VkC
         K/ict23kVmmnoSgfY1z9ofcRN4hJXwENc4iF9gsZMiLdVZ0RJ0Tpj5Ar+rlGieIdjFRY
         JabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mpFjYX5zYuBKahxstHElTG4pSBvfjkiny9bmAiIREmA=;
        b=CXmR6+NCTZ375aHRRsoJ8LOajgIkXSKqXVsgdR4m6zv3ryxYdNnIPZyia+Io0vJUoL
         K4Z6ahG/e3yLwSs4RvNq3ixDGLUhOKyUTev8L0YIRGbW46sn4cHf/C8erw6JvhjKLhJN
         Z2D4CmHIVMAXH+3OHOeTOOjrRW3O9SRKiy+t2SpcL7/T1NVkECYEIfmiFRL2BUbJmZUu
         TfsY+dhPYSnzPfvMV2GpT7LiRQ4bA4JX6r2/vXsro6JqwxOZUlFtUdEgu2GqnLzzN6Lk
         cV0v0YIJX7FxxCEDN/aBAf/yQNDRQAaF3E2fo/mVLglcIehKR0E7c1ySFuog5U9QMLJa
         7eiA==
X-Gm-Message-State: AKaTC01or57p/Ki3bUkFeVP/tyZbfUfwLGyLfKrzOmcsTh0ZLR+QJvjbQ4Ys2Ro/0hUYyQ==
X-Received: by 10.25.79.90 with SMTP id a26mr1231775lfk.181.1481298766849;
        Fri, 09 Dec 2016 07:52:46 -0800 (PST)
Received: from kristoffer-SZ68R2.privnett.uib.no (uib-guest.uib.no. [129.177.138.114])
        by smtp.gmail.com with ESMTPSA id r204sm6646500lfr.19.2016.12.09.07.52.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Dec 2016 07:52:46 -0800 (PST)
From:   Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com>
To:     git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com>
Subject: [PATCH 0/4] doc: fixes to gitcore-tutorial.txt
Date:   Fri,  9 Dec 2016 16:51:08 +0100
Message-Id: <20161209155112.2112-1-kristoffer.haugsbakk@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series of patches attempts to fix some minor mistakes in
gitcore-tutorial.txt that I found while reading it.  They are all
concerned with grammar and things like accidentally omitted words.

I previously sent a single patch on 2016-11-04 ("[PATCH] doc: fill in
omitted word").  The patch "doc: omit needless "for"" is a follow-up to
that, taking into consideration the feedback from Junio C Hamano and
Jeff King.

Kristoffer Haugsbakk (4):
  doc: add articles (grammar)
  doc: add verb in front of command to run
  doc: make the intent of sentence clearer
  doc: omit needless "for"

 Documentation/gitcore-tutorial.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.11.0

