Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0C6B202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 20:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753635AbdCHUAb (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 15:00:31 -0500
Received: from forward10j.cmail.yandex.net ([5.255.227.111]:50371 "EHLO
        forward10j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751616AbdCHUAa (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 8 Mar 2017 15:00:30 -0500
Received: from smtp1p.mail.yandex.net (smtp1p.mail.yandex.net [77.88.29.84])
        by forward10j.cmail.yandex.net (Yandex) with ESMTP id 127672235A;
        Wed,  8 Mar 2017 22:59:27 +0300 (MSK)
Received: from smtp1p.mail.yandex.net (localhost.localdomain [127.0.0.1])
        by smtp1p.mail.yandex.net (Yandex) with ESMTP id 919601780BA4;
        Wed,  8 Mar 2017 22:59:25 +0300 (MSK)
Received: by smtp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id OD8RpB0DIY-xNYi1QRp;
        Wed, 08 Mar 2017 22:59:24 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtolstov.org; s=mail; t=1489003164;
        bh=oIamR2M5rphYOaA1fZPow+X9JUV+6NtkdBf/fm0Yczo=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=M0Pw0NrMtmUdoac09FKgljraGIzmFswZ7z+RTxFSS6wIKQ0CzI/6MjNw4O4Sdqkfl
         mf2HsaBKYER6Imi+XF/NEpspZtR2J8uheTQlycYpesVI0F4xDJ+6ZwlB6eEJqYvcZ9
         hKVpiiGr1Gfv0M+VAuBRD8NbTu+qR/+oBR+7kfDU=
Authentication-Results: smtp1p.mail.yandex.net; dkim=pass header.i=@vtolstov.org
X-Yandex-ForeignMX:  US
X-Yandex-Suid-Status: 1 0,1 0,1 1130000030716801
From:   Valery Tolstov <me@vtolstov.org>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, me@vtolstov.org
Subject: Re: [PATCH] submodule--helper.c: remove duplicate code
Date:   Wed,  8 Mar 2017 22:59:16 +0300
Message-Id: <20170308195916.7349-1-me@vtolstov.org>
X-Mailer: git-send-email 2.12.0.190.ge0688e9b2.dirty
In-Reply-To: <CAGZ79kYJ9he-jhnA35m6az-T5Z58efmKsUaBw--_KzdGJPZb-Q@mail.gmail.com>
References: <CAGZ79kYJ9he-jhnA35m6az-T5Z58efmKsUaBw--_KzdGJPZb-Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Maybe we need to have 2293f77a081
> (connect_work_tree_and_git_dir: safely create leading directories,
> part of origin/sb/checkout-recurse-submodules, also found at
> https://public-inbox.org/git/20170306205919.9713-8-sbeller@google.com/ )
> first before we can apply this patch.

Thank you for your detailed responses. Yes, we difenitely need this
patch first. All tests passed when I applied it.


Regards,
  Valery Tolstov
