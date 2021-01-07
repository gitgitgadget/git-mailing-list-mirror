Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC38C433DB
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 10:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6B032312F
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 10:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbhAGKIz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 05:08:55 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:58949 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbhAGKIz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 05:08:55 -0500
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MUXlA-1kX1Ne1lNQ-00QQ7q; Thu, 07 Jan 2021 11:06:14 +0100
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id A9AA71E01E7;
        Thu,  7 Jan 2021 10:06:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AQ6mwTrRLpkX; Thu,  7 Jan 2021 11:06:12 +0100 (CET)
Received: from pflmari.corp.cetitec.com (28-usr-pf-main.vpn.it.cetitec.com [10.8.5.28])
        by mail.cetitecgmbh.com (Postfix) with ESMTPSA id 5DC151E01E6;
        Thu,  7 Jan 2021 11:06:12 +0100 (CET)
Received: by pflmari.corp.cetitec.com (Postfix, from local account)
Date:   Thu, 7 Jan 2021 11:06:16 +0100
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Config option to set the transport protocol version for
 network fetches
Message-ID: <X/bdGIF9A/wKAw5H@pflmari>
References: <20200916200203.GA37225@coredump.intra.peff.net>
 <20200917132047.GA14771@pflmari>
 <20200917133153.GA3038002@coredump.intra.peff.net>
 <20200917133525.GE8079@pflmari>
 <20200917145142.GA3076467@coredump.intra.peff.net>
 <20200917151730.GG8079@pflmari>
 <xmqq1rfhipjm.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1rfhipjm.fsf@gitster.c.googlers.com>
X-Provags-ID: V03:K1:YxIFvtzZKP0LPrSauvCRroW2ATfcPEoY593O2HeRZc53rjquC5E
 1Gu9O5vaWRf2fwqLA2UpTqYUeAgT0XsukmDQf17DOHOs9XKVKoMs6c14xtfNtOtcTPf1DAe
 nw/BWZyjwcKJNb+SNSNPaHgdxaAhAqUIerkVnG9KDU4KQYvb63UNDZcHIwL2shdAK/lYrsy
 uyndYzJP5+cqydQ4zKpzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VjejpkyX3jk=:ko/gqEg+nYfJfPV2/WxDWh
 HHbBqLr/CPT7Z/xZa9Wzf3QAnCNXFYjQKUqBaid2a5b4KMr+Ap0Mb0kpMQ2WvsX3OnKCq0UuO
 nW10EJ4s9NNlXJC5ebYLEL35uqTAXhFgFipR+k1kEqqw0t7/sLY4xs2jQlctKF2HFU5AlkIgh
 7kz3ozOoAMeHsx9V5IjFrfOP8wKxikejoJL1AaxMdsfnFA+JeavaJzABCcIkXNikoV1TeOFpe
 zinOvAv++5yFhtLFU/7L5NNT5p1PTmWjOJbusSYjcaRzSrAYx+O3YO98umRK7KbRM8a5AHWAS
 6tXnolvGW33G/9rArTGeTXlLmK/ir7E8Qd2Z0GugK/05Og015boptjWIMSShRRLhrckAPKWKr
 AZQdLUEHPMUO7OCtvo9oDkeUe943sKE04l0Iu+kRymVWbjWMXRywLkEkPLQOK8HXIc82iYLm5
 x0lHftc70g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano, Tue, Dec 22, 2020 20:55:25 +0100:
> Alex Riesen <alexander.riesen@cetitec.com> writes:
> > Jeff King, Thu, Sep 17, 2020 16:51:42 +0200:
> >> No problem, and no rush. I just wanted to make sure those bits didn't
> >> get overlooked.
> >
> > I'll try and do my best :)
> 
> If I remember correctly, this discussion started as an introduction
> of useful feature, but got stuck at the implementation phase of how
> the feature is presented at the UI level after we had general
> concensus on the design.
> 
> It has been about 3 months; has anything happened that I missed?

No, nothing happened.

> It seems that I kept the thread-starter patch in the 'seen' branch,
> but and haven't updated with a later attempt in the discussion.

Sorry. I got very distracted. As my situation seems to persist,
I cannot promise to do something about it soon.

I keep the branch and the discussion close by, though. Just in case.

