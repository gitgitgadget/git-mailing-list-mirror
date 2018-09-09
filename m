Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C70A1F404
	for <e@80x24.org>; Sun,  9 Sep 2018 04:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbeIIJ3K (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 05:29:10 -0400
Received: from p3plsmtpa12-03.prod.phx3.secureserver.net ([68.178.252.232]:48713
        "EHLO p3plsmtpa12-03.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726527AbeIIJ3K (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 9 Sep 2018 05:29:10 -0400
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id yrWkf5AV1HF9yyrWnfMDQA; Sat, 08 Sep 2018 21:40:54 -0700
Date:   Sun, 9 Sep 2018 07:40:50 +0300
From:   Max Kirillov <max@max630.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Max Kirillov <max@max630.net>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jelmer =?utf-8?Q?Vernoo=C4=B3?= <jelmer@jelmer.uk>,
        git@vger.kernel.org
Subject: Re: [PATCH] http-backend: allow empty CONTENT_LENGTH
Message-ID: <20180909044050.GD20545@jessie.local>
References: <20180906193516.28909-1-max@max630.net>
 <xmqq1sa6z3zp.fsf@gitster-ct.c.googlers.com>
 <20180907032740.GA20545@jessie.local>
 <20180907033831.GB1383@sigill.intra.peff.net>
 <CAF7_NFRg8wOQ0JbjkJ2gpxKs+oh3s8qXVSPfsWSth2tiUK39hw@mail.gmail.com>
 <xmqqsh2ly6vw.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsh2ly6vw.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfAh7Af2O/GAue2GWW/YJr9tSs6IbmehOq2aeMxRyAt8qxwXuyRw2MWUaGhmg2E9DAIHH81/WJKUPFj1YvXwFTFM3uDnkJQNTYh6MYHpsWqs7th5X3npk
 hIwrkBwoV9VUVNRm/xiLsTZ3YrUDK5/maZa7JW2a4mtefP6DXlboB+rsFlggstPHV9z/JJI4eh/XD3en9RuLM9+sP6qBxLA7Rv1a3SxqD2HOlR1VU8C5ccCc
 2ZExIRPQTy+dqQ21e1lwa2tjUZxdXLlC1JYyMMATtP3gS6lfeqT74OPLdP0+0efO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 07, 2018 at 02:49:23AM -0700, Junio C Hamano wrote:
> In any case, hopefully we can fix this before the final, as this is
> a regression introduced during this cycle?

I think I am going to stop at the v4. Unless there are some
corrections requested.
