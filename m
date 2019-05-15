Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39C491F461
	for <e@80x24.org>; Wed, 15 May 2019 22:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfEOWrS (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 18:47:18 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:43076 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfEOWrS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 18:47:18 -0400
Received: from localhost.localdomain ([92.1.197.142])
        by smtp.talktalk.net with SMTP
        id R2g6hewKCnuQZR2g6h9y9F; Wed, 15 May 2019 23:47:15 +0100
X-Originating-IP: [92.1.197.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=echDgIMH c=1 sm=1 tr=0 a=gH7h/AuSNjzKVpz8AWYPeg==:117
 a=gH7h/AuSNjzKVpz8AWYPeg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=anyJmfQTAAAA:8 a=7pA6vvupLKy4YpLXynMA:9 a=YJ_ntbLOlx1v6PCnmBeL:22
 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
From:   Philip Oakley <philipoakley@iee.org>
To:     Git List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 0/2] accessing the git(1) help page
Date:   Wed, 15 May 2019 23:47:07 +0100
Message-Id: <20190515224709.2936-1-philipoakley@iee.org>
X-Mailer: git-send-email 2.21.0.windows.1.1517.gbad5f960a3.dirty
In-Reply-To: <CAPig+cQ4FZeOxbVU-5qTrQm8Q-khwHuCwekAr-aGtbLKAVzY0Q@mail.gmail.com>
References: <CAPig+cQ4FZeOxbVU-5qTrQm8Q-khwHuCwekAr-aGtbLKAVzY0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfMCsYxDjuBtD9s5EbjAW/V1TAxEMlUFESAYMT8i2Wi1RuNAQ+36ea6vfKWx+nc0C7dukot1TuIoM2C95cRvkLwk0HlOaokrpmvqslRC9ifPoZGwLX+8p
 Jyjl/xEU7Q+8jNH2lXa/476kLiS8P2TTjngbzAr1yS5aooKF1jwausQwjBuvmXyUP+X/bUj6RU3fH+pmamG6EATwhP4wSdNERUoLYYSTzvL8cTQHaHt3Gl7R
 j0xK8Y5UHpXt/VuEuVhemLPwu9dODUiL/P6zUD+Sd8AD6IRXzFD+Z8oE0+SZDGE42nMRpEuRNfn7Qa7YRBFljstgJtI587AptEzX4mt8WjI5CMu8XL9n0MGD
 aoSRNlLNXPKswF87ntV1HQhP5qP0KA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This hopefully is a final version of the usage message to
show how to access the git(1) manual page.

The V3 change is Eric's suggestion to use 'See'.

I have also taken the opportunity [Patch 2/2] to pick up peff's suggestion
to include the git-scm doc link, and also correct the mis-quoting
of a link to the html formatted github doc pages.

Philip Oakley (2):
  git.c: show usage for accessing the git(1) help page
  Doc: git.txt: remove backticks from link and add git-scm.com/docs

 Documentation/git.txt | 3 ++-
 git.c                 | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.21.0.windows.1.1517.gbad5f960a3.dirty

