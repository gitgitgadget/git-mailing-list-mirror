Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52F9B1F453
	for <e@80x24.org>; Sun,  4 Nov 2018 15:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbeKEAjD (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Nov 2018 19:39:03 -0500
Received: from 0x63.nu ([109.74.10.199]:37194 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729786AbeKEAjC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Nov 2018 19:39:02 -0500
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
        by 0x63.nu with esmtp (Exim 4.89)
        (envelope-from <anders@0x63.nu>)
        id 1gJKFS-0005Wk-U5; Sun, 04 Nov 2018 16:23:37 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Anders Waldenborg <anders@0x63.nu>
Subject: [PATCH v2 0/5] %(trailers) improvements in pretty format
Date:   Sun,  4 Nov 2018 16:22:27 +0100
Message-Id: <20181104152232.20671-1-anders@0x63.nu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181028125025.30952-1-anders@0x63.nu>
References: <20181028125025.30952-1-anders@0x63.nu>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on 0x63.nu); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds support for three new options to %(trailers):
 * key -- show only trailers with specified key
 * nokey -- don't show key part of trailers
 * separator -- allow specifying custom separator between trailers


Anders Waldenborg (5):
  pretty: single return path in %(trailers) handling
  pretty: allow showing specific trailers
  pretty: add support for "nokey" option in %(trailers)
  pretty: extract fundamental placeholders to separate function
  pretty: add support for separator option in %(trailers)

 Documentation/pretty-formats.txt | 17 +++++---
 pretty.c                         | 71 ++++++++++++++++++++++++++------
 t/t4205-log-pretty-formats.sh    | 60 +++++++++++++++++++++++++++
 trailer.c                        | 28 ++++++++++---
 trailer.h                        |  3 ++
 5 files changed, 156 insertions(+), 23 deletions(-)

-- 
2.17.1

