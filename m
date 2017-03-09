Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE6AA2031F
	for <e@80x24.org>; Thu,  9 Mar 2017 22:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753579AbdCIWyW (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 17:54:22 -0500
Received: from forward14p.cmail.yandex.net ([87.250.241.142]:51658 "EHLO
        forward14p.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753417AbdCIWyV (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Mar 2017 17:54:21 -0500
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [37.140.190.28])
        by forward14p.cmail.yandex.net (Yandex) with ESMTP id B013A21A5E;
        Fri, 10 Mar 2017 01:54:17 +0300 (MSK)
Received: from smtp3o.mail.yandex.net (localhost.localdomain [127.0.0.1])
        by smtp3o.mail.yandex.net (Yandex) with ESMTP id BF3962940E46;
        Fri, 10 Mar 2017 01:54:14 +0300 (MSK)
Received: by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id HDBxG7j1sf-sDY8r8Ib;
        Fri, 10 Mar 2017 01:54:13 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtolstov.org; s=mail; t=1489100053;
        bh=gdfJvENkEES3CK5kAgaQmEyZKA2/N+UaPdhNMfhd8wE=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=jBoaGrikZBOt7WV4T5tHDDeZrmC3lL2i08S3C4JsDlTbqTELz22gfxoj0CHpsNkem
         QyFzFc2mrErgeYiokitOBMnP8TLKvhfauW/W/VCLUJxnQ/whk2qLZfTM+pBFQFsqiL
         NLkfv0p9i8fonOumJuwWpagRd9E1ehjHYbwq5D8Y=
Authentication-Results: smtp3o.mail.yandex.net; dkim=pass header.i=@vtolstov.org
X-Yandex-ForeignMX:  US
X-Yandex-Suid-Status: 1 0,1 0,1 1130000030716801,1 0,1 0
From:   Valery Tolstov <me@vtolstov.org>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, me@vtolstov.org, gitster@pobox.com,
        bmwill@google.com
Subject: Re: [PATCH v3 2/2] submodule--helper.c: remove duplicate code
Date:   Fri, 10 Mar 2017 01:54:11 +0300
Message-Id: <20170309225411.2283-1-me@vtolstov.org>
X-Mailer: git-send-email 2.12.0.192.gbdb9d28a5
In-Reply-To: <20170309012734.21541-3-me@vtolstov.org>
References: <20170309012734.21541-3-me@vtolstov.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As remainder. It is better if only [PATCH v3 2/2] is taken,
on top the patch from here
https://public-inbox.org/git/20170309221543.15897-8-sbeller@google.com/

The [PATCH v3 1/2] is just a copy of latter.
