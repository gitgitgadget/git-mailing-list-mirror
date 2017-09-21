Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 871122047F
	for <e@80x24.org>; Thu, 21 Sep 2017 07:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751606AbdIUHtK (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 03:49:10 -0400
Received: from benson.default.arb33.uk0.bigv.io ([46.43.0.16]:43229 "EHLO
        benson.default.arb33.uk0.bigv.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751484AbdIUHtK (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 21 Sep 2017 03:49:10 -0400
Received: from cpc91198-cmbg18-2-0-cust103.5-4.cable.virginm.net ([81.98.98.104] helo=dagon.hellion.org.uk)
        by benson.default.arb33.uk0.bigv.io with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <ijc@hellion.org.uk>)
        id 1duwEM-0005NY-VP; Thu, 21 Sep 2017 08:49:07 +0100
Message-ID: <1505980146.4636.9.camel@hellion.org.uk>
Subject: [PATCH v3 0/4] filter-branch: support for incremental update + fix
 for ancient tag format
From:   Ian Campbell <ijc@hellion.org.uk>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Thu, 21 Sep 2017 08:49:06 +0100
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the third version of my patches to add incremental support to
git-filter-branch. Since the last time I have replaced `git mktag --
allow-missing-tagger` with `git hash-object -t tag -w --stdin`.

I've force pushed to [1] (Travis is still running) and have set off the
process of re-rewriting the devicetree tree from scratch (a multi-day
affair) to validate (it's looking good).

Ian.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
[1] https://github.com/ijc/git/tree/git-filter-branch
