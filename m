Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E25120135
	for <e@80x24.org>; Thu,  9 Mar 2017 00:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752315AbdCIA4r (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 19:56:47 -0500
Received: from forward18o.cmail.yandex.net ([37.9.109.216]:55050 "EHLO
        forward18o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750707AbdCIA4q (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 8 Mar 2017 19:56:46 -0500
Received: from smtp1h.mail.yandex.net (smtp1h.mail.yandex.net [IPv6:2a02:6b8:0:f05::115])
        by forward18o.cmail.yandex.net (Yandex) with ESMTP id 0A8E822D2C;
        Thu,  9 Mar 2017 03:56:44 +0300 (MSK)
Received: from smtp1h.mail.yandex.net (localhost.localdomain [127.0.0.1])
        by smtp1h.mail.yandex.net (Yandex) with ESMTP id AE6918C0B33;
        Thu,  9 Mar 2017 03:56:40 +0300 (MSK)
Received: by smtp1h.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id U64ssKyenI-udZqrWqO;
        Thu, 09 Mar 2017 03:56:39 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtolstov.org; s=mail; t=1489020999;
        bh=2GELbpDWfNpZvUZliaWhkw555l6AEl/2M0o7ZQRBqVY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=kFwwHa7C9Xtfs5L4nZfOgQbfgcjKPB6TNzay5AervfoKa5woNAXWLULB/z3zUv52b
         HXfhmesAPwVoihcoqr68Uz0Ib3QSEE7qPQ64fJlq9VFg/YerYUP6sTm//Zj7DShsKZ
         c7BVZAZr7mr0r+OROv8DRl0zXa25XOo6SRBAhrMw=
Authentication-Results: smtp1h.mail.yandex.net; dkim=pass header.i=@vtolstov.org
X-Yandex-ForeignMX:  US
X-Yandex-Suid-Status: 1 0,1 0,1 0,1 1130000030716801,1 0
From:   Valery Tolstov <me@vtolstov.org>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, sbeller@google.com, me@vtolstov.org,
        gitster@pobox.com
Subject: Re: Re: [PATCH v2 0/2] Remove duplicate code from module_clone()
Date:   Thu,  9 Mar 2017 03:56:36 +0300
Message-Id: <20170309005636.20254-1-me@vtolstov.org>
X-Mailer: git-send-email 2.12.0.192.gbdb9d28a5
In-Reply-To: <20170309002818.GA153031@google.com>
References: <20170309002818.GA153031@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The usual protocol would be to rebase off of Stefan's series and build
> on that (assuming you have a dependency against his series), indicating
> that you are doing as such in your cover letter.

So, should I send only my patch, or current format (patch and dependency) 
is acceptalbe?

Regards,
  Valery Tolstov
