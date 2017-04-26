Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 745AB207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 19:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966064AbdDZTPu (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 15:15:50 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38168 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966056AbdDZTPs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 15:15:48 -0400
Received: by mail-wm0-f44.google.com with SMTP id r190so14170792wme.1
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 12:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eyuBIHT+V+E7P/a6AVltC3CD7bsbFCHl0pfeVqP/Xo0=;
        b=W4J80HWUZ2R5DSBF82jyAoUN99RC721yK3/AVrFFiRXmiXBBfeTNDxV/tz1eu2w2j6
         2NbXKVxAgmkH4hVvZPv5cfbqImQAWEVQ0u9t8T6U2TLxZ6Raot0/MFbwkqtp9unAFsoA
         dxp6DPdYB5KPBKsEwaUIOvBzj09bZ7LtR1b0NGbeJr88iGbi+L4l4Y5WZduAYb2GqFs1
         +gd2AXL1iC/6X6o1cuFNBfUuYBeIVTFx1Y2qlj0LODmskBEvKpin37Vq0h3Q578KXXsM
         LNbIkbpSg/IoO8BSR6tEagYLipM+KNZ+GeKGVIst4/Lak7N0LiUoquqlxCs/1lbrrpyF
         9d9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eyuBIHT+V+E7P/a6AVltC3CD7bsbFCHl0pfeVqP/Xo0=;
        b=AbgwwLxJStc7mht2pA3JGqJB50KzOBMq0I9FvD/Nf70F2we9MvoWKfs/DzktMqxnKc
         mrVTLf90x8wYCzxBiy4WHZovTMkAw3T/V6aZgaUq8Aiogn0mRlyb5E9xv60K0HOUbpoh
         2BDEcFw1IxEk+9ySwX0svBlbUPOZZrDzju8AaAv+H4jjJMqFT+1d1GC9POMS+j83qXvq
         6ES4+awjEi+XvQFv+r3Cq7HzLo0OuanAWqrCPqqK4yaYxr78UZgKoClb1t9fWhklkRuk
         60pk23q7kW5FShNoJVeSw1LPocHiUO1Aix/Fcms72kbDftKpgIqH2jTc1+g8g8pk4Sg9
         GfIw==
X-Gm-Message-State: AN3rC/7i4tgaOfpPzKNKmAiHHWKwZSxERiyqn7KVP7N5/0kIRhh+/uGc
        YxiBXjQLn6obnVMq
X-Received: by 10.80.163.231 with SMTP id t36mr1994061edb.59.1493234147282;
        Wed, 26 Apr 2017 12:15:47 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id n40sm275426edd.12.2017.04.26.12.15.46
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 12:15:46 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, gitster@pobox.com
Subject: [PATCH v2 0/4] travis-ci: build docs with asciidoctor
Date:   Wed, 26 Apr 2017 21:15:41 +0200
Message-Id: <20170426191545.27552-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.12.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

changes since v1:

* check Asciidoctor stderr output (Brian)
  http://public-inbox.org/git/20170418104411.hdkzh3psvej63tqw@genre.crustytoothpaste.net/

* fix make style nit (Junio)
  http://public-inbox.org/git/xmqq37dcorr7.fsf@gitster.mtv.corp.google.com/


Thanks,
Lars

Base Ref: master
Web-Diff: https://github.com/larsxschneider/git/commit/315affa7c0
Checkout: git fetch https://github.com/larsxschneider/git travisci/asciidoctor-v2 && git checkout 315affa7c0
Interdiff (v1..v2):

diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
index 81f123e68d..6214e6acb4 100755
--- a/ci/test-documentation.sh
+++ b/ci/test-documentation.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/usr/bin/env bash
 #
 # Perform sanity checks on documentation and build it.
 #
@@ -9,7 +9,8 @@ make check-builtins
 make check-docs

 # Build docs with AsciiDoc
-make --jobs=2 doc
+make --jobs=2 doc > >(tee stdout.log) 2> >(tee stderr.log >&2)
+! test -s stderr.log
 test -s Documentation/git.html
 test -s Documentation/git.xml
 test -s Documentation/git.1
@@ -17,6 +18,8 @@ grep '<meta name="generator" content="AsciiDoc ' Documentation/git.html

 # Build docs with AsciiDoctor
 make clean
-make --jobs=2 doc USE_ASCIIDOCTOR=1
+make --jobs=2 USE_ASCIIDOCTOR=1 doc > >(tee stdout.log) 2> >(tee stderr.log >&2)
+sed '/^GIT_VERSION = / d' stderr.log
+! test -s stderr.log
 test -s Documentation/git.html
 grep '<meta name="generator" content="Asciidoctor ' Documentation/git.html

\0

Lars Schneider (4):
  travis-ci: build documentation with AsciiDoc and Asciidoctor
  travis-ci: parallelize documentation build
  travis-ci: check AsciiDoc/AsciiDoctor stderr output
  travis-ci: unset compiler for jobs that do not need one

 .travis.yml              |  5 +++--
 ci/test-documentation.sh | 15 +++++++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)


base-commit: b14f27f91770e0f99f64135348977a0ce1c7993a
--
2.12.2

