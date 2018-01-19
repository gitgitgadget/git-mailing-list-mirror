Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AA651F404
	for <e@80x24.org>; Fri, 19 Jan 2018 17:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932547AbeASRe0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 12:34:26 -0500
Received: from sonic307-6.consmr.mail.bf2.yahoo.com ([74.6.134.45]:39010 "EHLO
        sonic307-6.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932440AbeASReU (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jan 2018 12:34:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1516383259; bh=xf4ogDu5+wvU3g0vtmnT2PUHM9HJS69Ds0TRq4xBLzM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=uRiS3ttDftP8hgeQllbzpSs7nlya2vDNmQB+mTIbZZIr7ERHuYNef7TGgrGJAHYtvCEsVzS1hHS7RqxD+Q/V6f61M+mKYhtwRyJ7XvvpjZPUcGWJvhDxorpEO4rkc5SineeM2WZkRL9xd3hrqTfKXg/lPAJ9YNXSuM0VXwrZSLKrSeB3mi1t1GbqdQjYywNlOpV9ffuRJWj8Uc/UtXaO3T/qLlzCT5XIBjszjRO2I+NUiDPth4MbQi2OsIlrcXu6zOgtpLYYBgSMPNx/VlzprSNU6JCsZlIT3TUUCW1Mw6At0rAP72XlcsiUCaTk5H4s2TxZNwrxnLEl59oplCLc6Q==
X-YMail-OSG: I7sfaVgVM1nEsUCHgsJEuBQVj9RmwRQlkdmIbUMVcVHuq7QVJkkcfeQymr1qpBv
 VnCpwEC.2dRAtCOy7KvD58Wxoe.RJAflUYcbk6fuz313OZMLJubNU2WUA12wkA2CC5M4.1Tto92j
 saj6rMYq5jkYL8vZvEd46DxexEM3bEwWIcOSbsBDvZKolCFBwGl_GYgyJZmSf0GNkEqZTT.jTXLa
 kpPtN8135EjQOlSb7yap9yaJlGb8hF98TbgRo.S2sd9D1Zk1bZPQNYW4loB1pymo5DNvwCkSGA_v
 y4I.9_jOADS0u12yo2YRcrJ8MA30P6QsU4HkDD1qmXK8V8ffTgHbW0e6UpzphSuhF1u5O8G_dCAv
 AX2gIcsm46L8dWK1JO2euUqtyLpb_IOeHGL0vpJAa6ja1AuiW7a.zI32wyQT6n66aL4Lu.eMWDxZ
 nUcNzOHgfcqmaw1plHYtKcUlLhIJQdZlbY1srlTHI_AkvfFCLzwlGk1nM7btPsq7yc_bwdIvKSH7
 KI1u.kUG5wEPE7ImAh3TMVTC4OpqwXLRHQUvyenHHhaf58peoBQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Jan 2018 17:34:19 +0000
Received: from smtpgate102.mail.bf1.yahoo.com (EHLO localhost.localdomain) ([72.30.28.113])
          by smtp406.mail.bf1.yahoo.com (JAMES SMTP Server ) with ESMTPA ID e78d06b6c08cf8709c5b5470ad5cf24d;
          Fri, 19 Jan 2018 17:34:18 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH v2 0/6] Cover Letter for NonStop Port Patches
Date:   Fri, 19 Jan 2018 12:34:00 -0500
Message-Id: <20180119173406.13324-2-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20180119173406.13324-1-randall.s.becker@rogers.com>
References: <20180119173406.13324-1-randall.s.becker@rogers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

This is the second attempt at submission of the NonStop port to
the git team. This package is split by file but should be applied
atomically.

I am not happy with the change in compat/regex/regcomp.c and figure
this might change with feedback.

Sincerely,
Randall

Randall S. Becker (7):
  Force pipes to flush immediately on NonStop platform
  Bypass GCC attributes on NonStop platform where used.
  Add tar extract install options override in installation processing.
  Define config options required for the HPE NonStop NSX and NSE
    platforms
  Force test suite traps to be cleared for NonStop ksh
  Bring NonStop platform definitions up to date in git-compat-util.h
  Add intptr_t and uintptr_t to regcomp.c for NonStop platform.

 Makefile               |  6 +++++-
 compat/regex/regcomp.c |  8 ++++++++
 config.mak.uname       | 29 +++++++++++++++++++++--------
 git-compat-util.h      | 15 +++++++++++++++
 remote.c               |  4 ++++
 t/lib-git-daemon.sh    |  3 +++
 wrapper.c              |  3 +++
 7 files changed, 59 insertions(+), 9 deletions(-)

-- 
2.16.0.31.gf1a482c

