Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD9A220954
	for <e@80x24.org>; Sun, 26 Nov 2017 01:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751911AbdKZBzB (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 20:55:01 -0500
Received: from p3plsmtpa08-10.prod.phx3.secureserver.net ([173.201.193.111]:33024
        "EHLO p3plsmtpa08-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751900AbdKZBy7 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2017 20:54:59 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with SMTP
        id Im9jetQwL0TufIm9oeDkya; Sat, 25 Nov 2017 18:54:59 -0700
From:   Max Kirillov <max@max630.net>
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Max Kirillov <max@max630.net>, Jeff King <peff@peff.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH v5 0/2] http-backend: respect CONTENT_LENGTH as specified by rfc3875
Date:   Sun, 26 Nov 2017 03:54:46 +0200
Message-Id: <20171126015448.24111-1-max@max630.net>
X-Mailer: git-send-email 2.11.0.1122.gc3fec58.dirty
In-reply-to: <20171123234511.574-1-max@max630.net>
X-CMAE-Envelope: MS4wfLX4kBsT0dJNPN3ySSjldxLMQ7oL9D6Qeh07YFUQTiTiL938rA9JCj+SqbpUay7k4GOd4u0c22MDBeoOQzIPaYmvXbmj7UxT+K2LXFIEf1/SYE4tqgGX
 p38eljmy6ZI9044HQPZa2tlLRMyLnkV2Zg0+cy2gJQOhIe4ytKbvPKyCJEYfZzi3c9iGOXUF5Pe5c6zdVKRQA/uJTn5uBwfnMwlm1E/YV6cX7hDxVWjs23s9
 mDSf+zICm920cL0Uz6qcM8GXF9D5aYToWlaX4zExYhy8vj7KMbSpp9Zp1A5E7N0JM1xGxgvhcNLwZUlTNfNIALY/rqdVe8br9Sxo1pfQaml1X30wUMRVubWa
 WUUAawx5Q9U/IelrFk5iDVR0JO928xl/VHyQ0/y1JKkeUWQgf/o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I seem to forgot to put the authorship lines, and also did something with
replies, so sending another sequence.

v5:

* marked the authorship more correctly

v4:

* polished style
* add tests

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

