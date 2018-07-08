Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F4A11F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 19:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932867AbeGHTBq (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 15:01:46 -0400
Received: from gproxy8-pub.mail.unifiedlayer.com ([67.222.33.93]:45506 "EHLO
        gproxy8-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932760AbeGHTBp (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Jul 2018 15:01:45 -0400
Received: from cmgw12.unifiedlayer.com (unknown [10.9.0.12])
        by gproxy8.mail.unifiedlayer.com (Postfix) with ESMTP id 147761AC1A5
        for <git@vger.kernel.org>; Sun,  8 Jul 2018 12:52:12 -0600 (MDT)
Received: from box5008.bluehost.com ([50.116.64.19])
        by cmsmtp with ESMTP
        id cEn1fVDjh0gMjcEn3fnAjf; Sun, 08 Jul 2018 12:52:09 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.us; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:Reply-To:From:Subject:
        Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YRqPdiOefcrMIAMSCPv7RQAVoikrStiRLt2uTo/UyII=; b=pojnnsfTppm5B+p6VC2fen/R7P
        b7mXaBmqo4pV9gPP8M7IKJ25QKosuOC60n3q6WHQpSe5jCgWjXcMCIs+ATou3FJciIzSFPFywExY0
        /Y2ZOjP0diy8uAfWzkiv0OuYX;
Received: from pool-72-70-58-227.bstnma.fios.verizon.net ([72.70.58.227]:35388 helo=homebase.home)
        by box5008.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <paul@mad-scientist.net>)
        id 1fcEmy-000VkI-D5; Sun, 08 Jul 2018 12:52:04 -0600
Message-ID: <bf0d4f33701ec694917f2e710c3fb097085c8d69.camel@mad-scientist.net>
Subject: Re: Git 2.18: RUNTIME_PREFIX... is it working?
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Daniel Jacques <dnj@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Date:   Sun, 08 Jul 2018 14:52:03 -0400
In-Reply-To: <CAD1RUU-4a_jV_JjozjXOR4bi+_7rFW_AjmHbbrw6NHJ77=oGkw@mail.gmail.com>
References: <97803ec8dae0a73bae301a37377b7b4a78f77e99.camel@mad-scientist.net>
         <nycvar.QRO.7.76.6.1807041312150.75@tvgsbejvaqbjf.bet>
         <986185d30a0f09b4e2a9832d324a265cd3da7354.camel@mad-scientist.net>
         <nycvar.QRO.7.76.6.1807061059260.75@tvgsbejvaqbjf.bet>
         <CAD1RUU-4a_jV_JjozjXOR4bi+_7rFW_AjmHbbrw6NHJ77=oGkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5008.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 72.70.58.227
X-Source-L: No
X-Exim-ID: 1fcEmy-000VkI-D5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: pool-72-70-58-227.bstnma.fios.verizon.net (homebase.home) [72.70.58.227]:35388
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTAwOC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2018-07-06 at 09:18 -0400, Daniel Jacques wrote:
> I forewent autoconf because I was concerned that the option was too
> obscure and the configuration too nuanced to be worth adding via
> flag, as RUNTIME_PREFIX requires some degree of path alignment and is
> fairly special-case. If you prefer autoconf, though, it sounds like a
> good thing to add, and I'm happy that you are finding the feature
> useful!

Well, far from obscure, I actually think that RUNTIME_PREFIX should be
the default behavior on all platforms.  In fact speaking for myself, I
see no value at all in the hardcoded path behavior and it could be
removed and RUNTIME_PREFIX be the only option and that would be fine
with me.

The only possible advantage I can see to the current default that you
can copy the Git binary alone somewhere else, but that's of very little
value IMO: you could instead create a symbolic link or a two-line shell
script wrapper if you wanted to have "git" available outside of its
normal relation to the rest of the installation for some reason.

Thanks for making this work in any event, Daniel!
