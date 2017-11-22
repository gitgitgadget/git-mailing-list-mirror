Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46D6E20954
	for <e@80x24.org>; Wed, 22 Nov 2017 17:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751662AbdKVRaQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 12:30:16 -0500
Received: from marot.dh.bytemark.co.uk ([212.110.172.17]:38894 "EHLO
        marot.bettens.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751458AbdKVRaP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 12:30:15 -0500
Received: by marot.bettens.info (Sendmail new on BidulOS, from userid 65534)
        id 7ACCA57058A; Wed, 22 Nov 2017 18:24:58 +0100 (CET)
Received: from machaut.bettens.info (dslgva4378.worldcom.ch [83.172.215.76])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by marot.bettens.info (Sendmail new on BidulOS) with ESMTPS id 5275257057F;
        Wed, 22 Nov 2017 18:24:56 +0100 (CET)
Received: from hadronsson.ici (hadronsson-fil.ici [192.168.1.9])
        by machaut.bettens.info (Postfix) with ESMTP id 1F3F61C9D;
        Wed, 22 Nov 2017 18:24:55 +0100 (CET)
From:   Louis Bettens <louis@bettens.info>
To:     git@vger.kernel.org
Cc:     jn.avila@free.fr, worldhello.net@gmail.com
Subject: [PATCH][l10n-fr] list translated to prune in command
Date:   Wed, 22 Nov 2017 18:24:39 +0100
Message-Id: <20171122172440.15106-1-louis@bettens.info>
X-Mailer: git-send-email 2.15.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"$ git worktree" when in a french locale shows an incorrect usage
summary.  This comes down to this trivial issue in the i18n.


