Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A83920281
	for <e@80x24.org>; Sun, 17 Sep 2017 08:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751298AbdIQIRl (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Sep 2017 04:17:41 -0400
Received: from benson.default.arb33.uk0.bigv.io ([46.43.0.16]:33435 "EHLO
        benson.default.arb33.uk0.bigv.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750861AbdIQIRh (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 17 Sep 2017 04:17:37 -0400
X-Greylist: delayed 2452 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Sep 2017 04:17:36 EDT
Received: from cpc91198-cmbg18-2-0-cust103.5-4.cable.virginm.net ([81.98.98.104] helo=dagon.hellion.org.uk)
        by benson.default.arb33.uk0.bigv.io with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <ijc@hellion.org.uk>)
        id 1dtU88-0006L1-Bc; Sun, 17 Sep 2017 08:36:40 +0100
Message-ID: <1505633797.22447.4.camel@hellion.org.uk>
Subject: [PATCH v2 0/4] filter-branch: support for incremental update + fix
 for ancient tag format
From:   Ian Campbell <ijc@hellion.org.uk>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Sun, 17 Sep 2017 08:36:37 +0100
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the second version of my patches to add incremental support to
git-filter-branch. Since the last time I have:
 * addressed the review feedback (see changelog embedded in final
   patch)
 * switched to using the (newly introduced) `--allow-missing-tagger`
   option to `git mktag` to allow early Linux kernel tags to be
   rewritten
 * split out some of the preparatory changes to make the final patch
   easier to read.

I've force pushed to [1] where Travis seems happy and have set off the
process of re-rewriting the devicetree tree from scratch (a multi-day
affair) to validate (it's looking good).

Ian.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
[1] https://github.com/ijc/git/tree/git-filter-branch
