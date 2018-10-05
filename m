Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADE9F1F453
	for <e@80x24.org>; Fri,  5 Oct 2018 08:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbeJEPNc (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 11:13:32 -0400
Received: from feynman.df7cb.de ([195.49.152.168]:53400 "EHLO feynman.df7cb.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727748AbeJEPNc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 11:13:32 -0400
Received: from msg.df7cb.de (unknown [IPv6:2003:5b:203b:100:7627:eaff:fe52:8e03])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by feynman.df7cb.de (Postfix) with ESMTPSA id 42RMyb3Fyyz3Dww;
        Fri,  5 Oct 2018 10:15:51 +0200 (CEST)
Date:   Fri, 5 Oct 2018 10:15:51 +0200
From:   Christoph Berg <myon@debian.org>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: provide a noop --recursive option
Message-ID: <20181005081551.GD13732@msg.df7cb.de>
References: <20180929140132.GA31238@msg.df7cb.de>
 <20180929145527.23444-1-avarab@gmail.com>
 <CAGZ79kbw96x2Dow7d-sUfOHXiVN8j9KgqEObo+TrVd5zWKbaEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbw96x2Dow7d-sUfOHXiVN8j9KgqEObo+TrVd5zWKbaEA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Re: Stefan Beller 2018-10-01 <CAGZ79kbw96x2Dow7d-sUfOHXiVN8j9KgqEObo+TrVd5zWKbaEA@mail.gmail.com>
> git-grep is always file/tree recursive, but there is --recurse-submodules
> which is off by default. Instead of providing a short alias to a noop,
> we could use -r for submodules. (And if you happen to have no
> submodules, this is a noop for you)

That would be fine for me.

Thanks,
Christoph
