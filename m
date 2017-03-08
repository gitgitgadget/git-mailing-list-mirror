Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E41B20314
	for <e@80x24.org>; Thu,  9 Mar 2017 04:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750824AbdCIEP1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 23:15:27 -0500
Received: from forward10o.cmail.yandex.net ([37.9.109.60]:50551 "EHLO
        forward10o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750747AbdCIEP0 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 8 Mar 2017 23:15:26 -0500
Received: from smtp1m.mail.yandex.net (smtp1m.mail.yandex.net [IPv6:2a02:6b8:0:2519::121])
        by forward10o.cmail.yandex.net (Yandex) with ESMTP id C65A521C91;
        Thu,  9 Mar 2017 02:05:20 +0300 (MSK)
Received: from smtp1m.mail.yandex.net (localhost.localdomain [127.0.0.1])
        by smtp1m.mail.yandex.net (Yandex) with ESMTP id 81A3663C0D4A;
        Thu,  9 Mar 2017 02:05:16 +0300 (MSK)
Received: by smtp1m.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id q32sO1b9Pu-5ED0HLxa;
        Thu, 09 Mar 2017 02:05:15 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtolstov.org; s=mail; t=1489014315;
        bh=upr1hS5M3f9RNab2DFZP09h6gJZjuJzGqLnw1+/AdSs=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=i2yUff41UtBFWXpagWM0BDYcUiEyZb0tr1c3EYnt9jmspgN7wZ64fDSrKLayTFnYe
         QfoCIqjAWsujLNrQ6aNFNfQPxmI5DXzxmcDOsNQWKINPEYZ5ujc9Sv0SMCfhDgmi9Q
         45ColEphgNAjWjxiSwG9V9dApHQrM3fpLZegHBro=
Authentication-Results: smtp1m.mail.yandex.net; dkim=pass header.i=@vtolstov.org
X-Yandex-ForeignMX:  US
X-Yandex-Suid-Status: 1 0,1 0,1 1130000030716801
From:   Valery Tolstov <me@vtolstov.org>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, me@vtolstov.org
Subject: Re: [PATCH] submodule--helper.c: remove duplicate code
Date:   Thu,  9 Mar 2017 02:05:12 +0300
Message-Id: <20170308230512.30572-1-me@vtolstov.org>
X-Mailer: git-send-email 2.12.0.192.gbdb9d28a5
In-Reply-To: <CAGZ79kbnpUtrKdjQdQ-r6rRuVvnawooLFk1bO8jOSgxNkx2Dbg@mail.gmail.com>
References: <CAGZ79kbnpUtrKdjQdQ-r6rRuVvnawooLFk1bO8jOSgxNkx2Dbg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Then the next step (as outlined by Documentation/SubmittingPatches)
> is to figure out how to best present this to the mailing list; I think the best
> way is to send out a patch series consisting of both of these 2 patches,
> the "connect_work_tree_and_git_dir: safely create leading directories,"
> first and then your deduplication patch.

Is there a handy way to forward your patch in new patch series? Also, 
should I start new thread for new patch series?


Regards,
  Valery Tolstov
