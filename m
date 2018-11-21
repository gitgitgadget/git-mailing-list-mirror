Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41EE91F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 21:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389499AbeKVHgz (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 02:36:55 -0500
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:37020 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726280AbeKVHgz (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 22 Nov 2018 02:36:55 -0500
X-Greylist: delayed 494 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Nov 2018 02:36:55 EST
Received: from app03-neu.ox.hosteurope.de ([92.51.170.137] helo=null); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        id 1gPZcF-0006kW-DH; Wed, 21 Nov 2018 22:00:55 +0100
Date:   Wed, 21 Nov 2018 22:00:54 +0100 (CET)
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net
Message-ID: <1535679074.141165.1542834055343@ox.hosteurope.de>
In-Reply-To: <84cbbfbd213b358d1e2d7cce8b4685b09efac3de.1542833244.git.thomas.braun@virtuell-zuhause.de>
References: <590f2ca6b5323c17365a1645b5d10e9ab30623c4.1542833244.git.thomas.braun@virtuell-zuhause.de>
 <84cbbfbd213b358d1e2d7cce8b4685b09efac3de.1542833244.git.thomas.braun@virtuell-zuhause.de>
Subject: [PATCH 0/2] Teach log -G to ignore binary files
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev42
X-Originating-Client: open-xchange-appsuite
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1542834057;ebb689ae;
X-HE-SMSGID: 1gPZcF-0006kW-DH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Based on the previous discussion in [1] I've prepared patches which teach
log -G to ignore binary files. log -S keeps its behaviour but got a test to ensure that.

Feedback welcome!

[1]: https://public-inbox.org/git/7a0992eb-adb9-a7a1-cfaa-3384bc4d3e5c@virtuell-zuhause.de/

PS: This is the (possibly missing) cover letter.
