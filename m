Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F6EC2090A
	for <e@80x24.org>; Mon, 20 Mar 2017 21:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755123AbdCTVEA (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 17:04:00 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:14906 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753136AbdCTVD7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 17:03:59 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e35:2ef1:f910:5006:1621:c385:7777])
        by smtp2-g21.free.fr (Postfix) with ESMTP id EB0B12003CD
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 22:02:41 +0100 (CET)
From:   Jean-Noel Avila <jn.avila@free.fr>
To:     git@vger.kernel.org
Subject: Rework manpage localisation
Date:   Mon, 20 Mar 2017 22:02:23 +0100
Message-Id: <20170320210225.13046-1-jn.avila@free.fr>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20170312200248.3610-1-jn.avila@free.fr>
References: <20170312200248.3610-1-jn.avila@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The patch series has been reworked to remove the manpage localization
task from the main documentation task. The Travis build should be back
to normal, while still retaining the capability to generate localized
man pages.

Right now, there are some limitations with the version of po4a
provided by most linux distributions, so there is a great chance that
the install-man-l10n won't work on most systems.


