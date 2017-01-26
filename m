Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D54571F6DC
	for <e@80x24.org>; Thu, 26 Jan 2017 01:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752337AbdAZBRR (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 20:17:17 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:25302 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752326AbdAZBRR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 20:17:17 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 688801E2CE1;
        Thu, 26 Jan 2017 02:17:13 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id FZPpVED2aYgl; Thu, 26 Jan 2017 02:17:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 253E41E2CF8;
        Thu, 26 Jan 2017 02:17:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CUZ5i_c6TvfJ; Thu, 26 Jan 2017 02:17:13 +0100 (CET)
Received: from localhost.localdomain (aftr-185-17-206-216.dynamic.mnet-online.de [185.17.206.216])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id AA8B61E2CE1;
        Thu, 26 Jan 2017 02:17:12 +0100 (CET)
From:   cornelius.weig@tngtech.com
To:     peff@peff.net
Cc:     gitster@pobox.com, git@vger.kernel.org, novalis@novalis.org,
        pclouds@gmail.com
Subject: [PATCH] refs: add option core.logAllRefUpdates = always
Date:   Thu, 26 Jan 2017 02:16:53 +0100
Message-Id: <20170126011654.21729-1-cornelius.weig@tngtech.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20170125213328.meehgxvzuajjgvag@sigill.intra.peff.net>
References: <20170125213328.meehgxvzuajjgvag@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi peff,

 you made it easy for me. Most of your patch still applied, only the tests
didn't quite fit. Maybe you can have a look if I've overlooked something, since
you know the changes best?

Thanks for supporting this with your patch!

