Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A3BD20A41
	for <e@80x24.org>; Sun, 26 Nov 2017 01:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751898AbdKZBy5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 20:54:57 -0500
Received: from p3plsmtpa08-02.prod.phx3.secureserver.net ([173.201.193.103]:35083
        "EHLO p3plsmtpa08-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751758AbdKZBy5 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2017 20:54:57 -0500
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Nov 2017 20:54:57 EST
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with SMTP
        id Im2ce86W4hwvHIm2hewPF6; Sat, 25 Nov 2017 18:47:38 -0700
From:   Max Kirillov <max@max630.net>
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Max Kirillov <max@max630.net>, Jeff King <peff@peff.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH v4 0/2] http-backend: respect CONTENT_LENGTH as specified by rfc3875
Date:   Sun, 26 Nov 2017 03:47:17 +0200
Message-Id: <20171126014719.23728-1-max@max630.net>
X-Mailer: git-send-email 2.11.0.1122.gc3fec58.dirty
In-reply-to: <20171123234511.574-1-max@max630.net>
X-CMAE-Envelope: MS4wfOt20xRmk6xNHqnsj6/GFmkzuWUrbY1nd3cvezNZBIdB9lV5JE+1pAyj1ZOgzH1zXK4MKS446J+7Sy1NcJh/M2BFWfrJjLWT2WycO+ncJnwgkTHIiLKf
 K164OFaQ/BF/7WHcriYjDA2XRZOU0P7S38HHvGyg2xFlUU05dgE/BbHqYYLMq9EbHVhP6UqtDs7I/UIuleh340RWUxgCPsNauXqLfIWM5r3Gy+SuxLoCvZjG
 iE2cgwarl8DjzkAc/nLNk+yKzE76SSP6TMs46zaREpBcZ7bdfQV9aDDqoKnOHoYoKDQkEpvhfEe8qQ1T+gZ+Py+YSeFVZ8apxnqs1JE0uQkPeXHAPFVgq8JF
 IQ/3gJT/6qjG3u77Qs8vKYCjdx60VReByxIEh4lGCC9Af5kE1uI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* polished style
* add tests
* marked the authorship more correctly

Max Kirillov (2):
  http-backend: respect CONTENT_LENGTH as specified by rfc3875
  t5560-http-backend-noserver.sh: add CONTENT_LENGTH cases

 Makefile                         |  1 +
 config.c                         |  8 ++++++++
 config.h                         |  1 +
 http-backend.c                   | 39 ++++++++++++++++++++++++++++++++++++++-
 t/helper/test-print-values.c     | 10 ++++++++++
 t/t5560-http-backend-noserver.sh | 30 ++++++++++++++++++++++++++++++
 6 files changed, 88 insertions(+), 1 deletion(-)
 create mode 100644 t/helper/test-print-values.c

-- 
2.11.0.1122.gc3fec58.dirty

