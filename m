Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 093421F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 12:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393199AbfJPMpX (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 08:45:23 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:15069 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbfJPMpX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 08:45:23 -0400
Received: from localhost.localdomain ([92.7.169.237])
        by smtp.talktalk.net with SMTP
        id Kig4iG3Y1draxKig4i49Np; Wed, 16 Oct 2019 13:45:20 +0100
X-Originating-IP: [92.7.169.237]
X-Spam: 0
X-OAuthority: v=2.3 cv=QfUYQfTv c=1 sm=1 tr=0 a=tcYJKHXJF8zWhnf8ZoLugA==:117
 a=tcYJKHXJF8zWhnf8ZoLugA==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=ldyaYNNxDcoA:10 a=ZZnuYtJkoWoA:10 a=8Z89Gh-dSkKwBLN_CHkA:9
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>
Cc:     Philip Oakley <philipoakley@iee.email>
Subject: [RFC PATCH v1] t/README: the test repo does not have global or system configs
Date:   Wed, 16 Oct 2019 13:45:15 +0100
Message-Id: <20191016124515.1807-1-philipoakley@iee.email>
X-Mailer: git-send-email 2.23.0.windows.1.21.g947f504ebe8.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfMBsvkYd4WzDgFCjFXn1Ch5ab2+QvAZBDWnNgmlFzqNThKlHG2Gz0wvZhkSkk8rZwH9aUael/p97dbeU2vxzn/XoE8MApMsWucmCEo5V2/dEDS9xFN8T
 3elJeMQW/YCuUdPXVtZFEEKpTZQCwYG4EVGapJGXK3zxFbfReOmwIbibAuB/sp8XoxVoWKJ3LamK00n7JfRxrkM20DdG2ZXfgr0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---

While tring to get to grips with some Git-for-Windows config settings
for testing >4GiB files, I couldn't find any note in the readme about
the test system config file sources. 

Is this the right place for the information, is it complete enough,
and is the default config template special?

 t/README | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/README b/t/README
index 60d5b77bcc..3daa1fa182 100644
--- a/t/README
+++ b/t/README
@@ -485,6 +485,9 @@ This test harness library does the following things:
    the --root option documented above, and a '.stress-<N>' suffix
    appended by the --stress option.
 
+ - The --global and --system config files are ignored, and
+   a basic --local config is created in the tst repository.
+
  - Defines standard test helper functions for your scripts to
    use.  These functions are designed to make all scripts behave
    consistently when command line arguments --verbose (or -v),
-- 
2.23.0.windows.1.21.g947f504ebe8.dirty

