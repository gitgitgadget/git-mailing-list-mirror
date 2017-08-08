Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF81F1F991
	for <e@80x24.org>; Tue,  8 Aug 2017 08:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752528AbdHHIsB (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 04:48:01 -0400
Received: from benson.default.arb33.uk0.bigv.io ([46.43.0.16]:36129 "EHLO
        benson.default.arb33.uk0.bigv.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752064AbdHHIsA (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 8 Aug 2017 04:48:00 -0400
X-Greylist: delayed 2517 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Aug 2017 04:48:00 EDT
Received: from cpc91198-cmbg18-2-0-cust103.5-4.cable.virginm.net ([81.98.98.104] helo=dagon.hellion.org.uk)
        by benson.default.arb33.uk0.bigv.io with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <ijc@hellion.org.uk>)
        id 1dezWb-0000z0-8P; Tue, 08 Aug 2017 09:06:01 +0100
Message-ID: <1502179560.2735.22.camel@hellion.org.uk>
Subject: [PATCH 0/2] filter-branch: support for incremental update + fix for
 ancient tag format
From:   Ian Campbell <ijc@hellion.org.uk>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Date:   Tue, 08 Aug 2017 09:06:00 +0100
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've long (since 2013, urk!) been carrying these two changes to git-
filter-branch in the split out devicetree source tree[0] which extracts
all the device tree sources from the Linux kernel source tree.

I think it's about time I sent them here, sorry for the rather extreme
delay! I've rebased to 2.14 and retested, I've also pushed a copy to
[1] where Travis seems happy.

Ian.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
[1] https://github.com/ijc/git/tree/git-filter-branch
