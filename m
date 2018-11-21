Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A63231F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 21:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389774AbeKVHoJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 02:44:09 -0500
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:48778 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732609AbeKVHoI (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 22 Nov 2018 02:44:08 -0500
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=thomas.baccab.home.arpa); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1gPZUJ-00055p-8F; Wed, 21 Nov 2018 21:52:43 +0100
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net
Subject: [PATCH 0/2] Teach log -G to ignore binary files
Date:   Wed, 21 Nov 2018 21:52:26 +0100
Message-Id: <cover.1542831544.git.thomas.braun@virtuell-zuhause.de>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1542834488;94e31291;
X-HE-SMSGID: 1gPZUJ-00055p-8F
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Based on the previous discussion in [1] I've prepared patches which teach 
log -G to ignore binary files. log -S keeps its behaviour but got a test to ensure that.

Feedback welcome!

[1]: https://public-inbox.org/git/7a0992eb-adb9-a7a1-cfaa-3384bc4d3e5c@virtuell-zuhause.de/

Thomas Braun (2):
  log -G: Ignore binary files
  log -S: Add test which searches in binary files

 Documentation/gitdiffcore.txt |  2 +-
 diffcore-pickaxe.c            |  5 +++++
 t/t4209-log-pickaxe.sh        | 21 +++++++++++++++++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

-- 
2.19.0.271.gfe8321ec05.dirty

