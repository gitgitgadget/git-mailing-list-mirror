Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5865320A40
	for <e@80x24.org>; Sun, 26 Nov 2017 19:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751723AbdKZTi1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 14:38:27 -0500
Received: from p3plsmtpa08-02.prod.phx3.secureserver.net ([173.201.193.103]:33285
        "EHLO p3plsmtpa08-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751532AbdKZTi0 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2017 14:38:26 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with SMTP
        id J2kreBvfThwvHJ2kxewoBZ; Sun, 26 Nov 2017 12:38:26 -0700
From:   Max Kirillov <max@max630.net>
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Max Kirillov <max@max630.net>, Jeff King <peff@peff.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH v6 0/2] http-backend: respect CONTENT_LENGTH as specified by rfc3875
Date:   Sun, 26 Nov 2017 21:38:11 +0200
Message-Id: <20171126193813.12531-1-max@max630.net>
X-Mailer: git-send-email 2.11.0.1122.gc3fec58.dirty
In-reply-to: <20171126015448.24111-1-max@max630.net>
X-CMAE-Envelope: MS4wfNd/V7RwTlv5EIG7Gjl3zAy5pCK792hRNugbJjAiE4sOCybIYuHZr6qNEo5v1MvvFUTS1EibazaDeFqKOlXVLsQ8Xlu0kicARdpdXgI7WiJBBJuzQJza
 l09ekZMxFoc/3VNRYC3GFxJ9hurXY4KoDg7pXln1un4POGUkofHHcYokVnpTCwMn2D2SaDvejttplDZMKlmL8GPm7mI4qNvz5iCEJBlJx50Le0/d0FdGIu8z
 Gmyd9Z5Tel5KvVp3a0RzJXAB+dJCN5hY75MUnHvfEs8Xg6XQ7pe8pc3RA0cy8l6ka+TcXyL+ev9pXtfO86vcZaGqBvUXjykUi111aRbAjc8jQzvTCR/VMCI9
 JLA7YwC5T5NSDpFWwhKgPaepMmTF0Of8oxiuruO0QhFPdZM0p/U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v6:

Do not implement generic git_env_ssize_t(), instead export git_parse_ssize_t() from config.c
and hardcode the rest.

Florian Manschwetus (1):
  http-backend: respect CONTENT_LENGTH as specified by rfc3875

Max Kirillov (1):
  t5560-http-backend-noserver.sh: add CONTENT_LENGTH cases

 Makefile                         |  1 +
 config.c                         |  2 +-
 config.h                         |  1 +
 http-backend.c                   | 50 +++++++++++++++++++++++++++++++++++++++-
 t/helper/test-print-values.c     | 10 ++++++++
 t/t5560-http-backend-noserver.sh | 30 ++++++++++++++++++++++++
 6 files changed, 92 insertions(+), 2 deletions(-)
 create mode 100644 t/helper/test-print-values.c

-- 
2.11.0.1122.gc3fec58.dirty

