Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C66ED1FA14
	for <e@80x24.org>; Tue, 11 Apr 2017 08:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752029AbdDKIde (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 04:33:34 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33465 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbdDKIdc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 04:33:32 -0400
Received: by mail-wm0-f68.google.com with SMTP id o81so13538573wmb.0
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 01:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CU/0sVzeWseyJal3N5hUrO+dTpPt+LNp05zknG82yg8=;
        b=KvV5BHVnjeD3QXrau6mr4atBh9yCivDCGff1ZWKYx2LQyThYrEu++K3wGAzpPvV5BB
         JrVEpM6dSiZnjJBeCwWAO2GK9fm9fgdiP8HVrTp80K2P3aqwKTGivii7SoXO2MzwldBa
         o4YtJey+QibmHO4llP4igld1VRA/V7WwyuD2AqLLVfJoVVgMe3OKVPqVuvZREFb1iAxh
         75jREVVOg16qXPdOO5VnPt3EnA2a78wNri5H/Jy7LKYFvoVaB/uNAJowmXR0pdEwzn60
         Ol/emBmN0UWWtvwznT4lhbS+q1dxZoqkIYf+mcS6rpP3MieUAO5jtXDkSvh0eUtcEyBa
         7P/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CU/0sVzeWseyJal3N5hUrO+dTpPt+LNp05zknG82yg8=;
        b=n2L0x7rBnZfNsAA8LGqSZUqQbF2TlNXoUmY9sxOlj9RGrLVCGuGHx5WwRIqxd6JTu8
         bvZ5ibOtPNYk1SZVQzUU+iFWFBMx/Tm4nnBS+nN6/FKD3qezxeQNR+fj9sRNkjicwsqs
         FO8hWuaN+IM7JLFkUGWJ3fvH5HkSl7DocVvB/z3EOX5gqERu5A3BeR4ql8XQ4ogwgxXJ
         wzmhyLwuaM64CgiiceKICsVDXzZrzSLv8VouP40GvE0YCBwwVx3DAGmwukss8v+xUn1f
         O5lhjtNQazOPCo1kuuRVKCt4kDLyZdSWQD/4eCFqy+YsbAmuGMb5ZBkXntS/xe9WEAPX
         SgEw==
X-Gm-Message-State: AN3rC/7efhwSEGZ1Uk0/9wSCEvKnA5qSHoONqcgut5U4vo546xX/maBm
        tn2qVjA/oEd96Y0G
X-Received: by 10.28.137.208 with SMTP id l199mr13070708wmd.65.1491899611360;
        Tue, 11 Apr 2017 01:33:31 -0700 (PDT)
Received: from localhost.localdomain (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id d17sm1499083wmi.21.2017.04.11.01.33.30
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 11 Apr 2017 01:33:30 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net
Subject: [PATCH v1 0/3] travis-ci: build docs with asciidoctor
Date:   Tue, 11 Apr 2017 10:33:06 +0200
Message-Id: <20170411083309.58315-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.12.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

this is a mini series to build the documentation with asciidoctor in
addition to asciidoc on Travis-CI.

Cheers,
Lars

Base Ref: master
Web-Diff: https://github.com/larsxschneider/git/commit/88070fccc8
Checkout: git fetch https://github.com/larsxschneider/git travisci/asciidoctor-v1 && git checkout 88070fccc8

Lars Schneider (3):
  travis-ci: build documentation with AsciiDoc and Asciidoctor
  travis-ci: parallelize documentation build
  travis-ci: unset compiler for jobs that do not need one

 .travis.yml              |  5 +++--
 ci/test-documentation.sh | 10 +++++++++-
 2 files changed, 12 insertions(+), 3 deletions(-)


base-commit: b14f27f91770e0f99f64135348977a0ce1c7993a
--
2.12.2

