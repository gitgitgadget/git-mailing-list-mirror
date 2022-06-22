Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0531C43334
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 08:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbiFVIYt convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 22 Jun 2022 04:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236755AbiFVIYs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 04:24:48 -0400
Received: from mailproxy09.manitu.net (mailproxy09.manitu.net [217.11.48.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB7C381A3
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 01:24:44 -0700 (PDT)
Received: from localhost (unknown [IPv6:2001:9e8:6a6b:a700:9406:4033:4544:efd4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: michael@grubix.eu)
        by mailproxy09.manitu.net (Postfix) with ESMTPSA id A7DE512000D8;
        Wed, 22 Jun 2022 10:24:42 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <xmqq8rpqja0v.fsf@gitster.g>
References: <cf6aee9acadfb666de6b24b9ed63e1a65bfc009e.1655220242.git.git@grubix.eu> <nycvar.QRO.7.76.6.2206151649030.349@tvgsbejvaqbjf.bet> <165537087609.19905.821171947957640468.git@grubix.eu> <nycvar.QRO.7.76.6.2206181342200.349@tvgsbejvaqbjf.bet> <xmqq8rpqja0v.fsf@gitster.g>
Subject: Re: [PATCH] t3701: two subtests are fixed
From:   Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org,
        =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <165588628205.6252.637148192313375325.git@grubix.eu>
Date:   Wed, 22 Jun 2022 10:24:42 +0200
User-Agent: alot/0.10
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano venit, vidit, dixit 2022-06-21 17:45:04:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> in config.mak. Nothing else strikes me as potentially relevant.
> >>
> >> Ævar noticed this and has a better version of my patch, I think.
> >
> > So you did not find it utterly rude and presumptuous that somebody sent a
> > new iteration of your patch without even so much as consulting with you
> > whether you're okay with this? I salute your forbearance, then.
> 
> I had an impression that these (wasn't there another one) were
> independent discoveries and patching that happened at the same time.

Yes, while it looked funny at first, Ævar explained it well. So,
everything is fine for me. Besides, we're no strangers to each other ;)

As for the question which version covers the expectations best: I'm
lacking the necessary overview of the expectations (which implementation
to check by default, in CI etc.) which is why I won't chime in on that.
