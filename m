Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C79B11F453
	for <e@80x24.org>; Sat, 29 Sep 2018 19:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeI3CIO (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 22:08:14 -0400
Received: from feynman.df7cb.de ([195.49.152.168]:37300 "EHLO feynman.df7cb.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727425AbeI3CIO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 22:08:14 -0400
Received: from msg.df7cb.de (unknown [IPv6:2a02:908:1470:e5c0:76e5:bff:fef3:7e00])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by feynman.df7cb.de (Postfix) with ESMTPSA id 42MzP52wBxz3DyF;
        Sat, 29 Sep 2018 21:38:33 +0200 (CEST)
Date:   Sat, 29 Sep 2018 21:38:33 +0200
From:   Christoph Berg <myon@debian.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] grep: provide a noop --recursive option
Message-ID: <20180929193832.GA26553@msg.df7cb.de>
References: <20180929140132.GA31238@msg.df7cb.de>
 <20180929145527.23444-1-avarab@gmail.com>
 <xmqq8t3k9qjs.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8t3k9qjs.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Re: Junio C Hamano 2018-09-29 <xmqq8t3k9qjs.fsf@gitster-ct.c.googlers.com>
> I also expect folks who are used to "git grep --re<TAB>" to summon
> the only option of the command that begins with that prefix to start
> complaining that they now have to type "--recurs<TAB>" instead.

Fwiw I was just asking about -r. There doesn't have to be a
corresponding long option if the short one is a no-op.

Christoph
