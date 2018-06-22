Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 316291F516
	for <e@80x24.org>; Fri, 22 Jun 2018 20:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754269AbeFVUbn (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 16:31:43 -0400
Received: from ao2.it ([92.243.12.208]:53391 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754101AbeFVUbm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 16:31:42 -0400
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fWSi1-0003S6-RW; Fri, 22 Jun 2018 22:31:06 +0200
Date:   Fri, 22 Jun 2018 22:31:39 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/7] Restrict the usage of config_from_gitmodules()
Message-Id: <20180622223139.5fae4cc7d3c33128e28e81d3@ao2.it>
In-Reply-To: <20180622171310.GE244185@google.com>
References: <20180622162656.19338-1-ao2@ao2.it>
        <20180622171310.GE244185@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 22 Jun 2018 10:13:10 -0700
Brandon Williams <bmwill@google.com> wrote:

[...] 
> Thanks for working on this.  I think its a good approach and the end
> result makes it much harder for arbitrary config to sneak back in to the
> .gitmodules file.  And after this series it looks like you should be in
> a good place to read the .gitmodules file from other places (not just in
> the worktree).
>

:)

> As you've mentioned here I also agree we could do without the last patch
> but I'll leave that up to you.  Other than a couple typos I found I
> think this series looks good!  Thanks again for revisiting this.
>

Thanks for the review.

I understand your compromise solution for patch 7, but I'd say let's
keep it simple and just drop patch 7 for now.

I am going to wait a couple of days and then send a v2.

Ciao,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
