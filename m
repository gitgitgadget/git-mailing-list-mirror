Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 723D81F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 23:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751188AbdARXH3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 18:07:29 -0500
Received: from mga14.intel.com ([192.55.52.115]:32786 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751450AbdARXGb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 18:06:31 -0500
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP; 18 Jan 2017 15:06:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,250,1477983600"; 
   d="scan'208";a="54909590"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.35.174])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jan 2017 15:06:11 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v4 1/5] doc: add documentation for OPT_STRING_LIST
Date:   Wed, 18 Jan 2017 15:06:04 -0800
Message-Id: <20170118230608.28030-2-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.11.0.488.g1cece4bcb7a5
In-Reply-To: <20170118230608.28030-1-jacob.e.keller@intel.com>
References: <20170118230608.28030-1-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Commit c8ba16391655 ("parse-options: add OPT_STRING_LIST helper",
2011-06-09) added the OPT_STRING_LIST as a way to accumulate a repeated
list of strings. However, this was not documented in the
api-parse-options documentation. Add documentation now so that future
developers may learn of its existence.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Documentation/technical/api-parse-options.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 27bd701c0d68..36768b479e16 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -168,6 +168,11 @@ There are some macros to easily define options:
 	Introduce an option with string argument.
 	The string argument is put into `str_var`.
 
+`OPT_STRING_LIST(short, long, &struct string_list, arg_str, description)`::
+	Introduce an option with string argument.
+	The string argument is stored as an element in `string_list`.
+	Use of `--no-option` will clear the list of preceding values.
+
 `OPT_INTEGER(short, long, &int_var, description)`::
 	Introduce an option with integer argument.
 	The integer is put into `int_var`.
-- 
2.11.0.488.g1cece4bcb7a5

