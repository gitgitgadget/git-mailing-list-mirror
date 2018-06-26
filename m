Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 622211F516
	for <e@80x24.org>; Tue, 26 Jun 2018 20:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752828AbeFZU5n (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 16:57:43 -0400
Received: from ao2.it ([92.243.12.208]:58287 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752548AbeFZU5m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 16:57:42 -0400
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fXv1K-0002ce-9Q; Tue, 26 Jun 2018 22:57:02 +0200
Date:   Tue, 26 Jun 2018 22:57:39 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 5/6] submodule-config: pass repository as argument to
 config_from_gitmodules
Message-Id: <20180626225739.eb839a246db6037ff8996782@ao2.it>
In-Reply-To: <xmqq7emljod6.fsf@gitster-ct.c.googlers.com>
References: <20180626104710.9859-1-ao2@ao2.it>
        <20180626104710.9859-6-ao2@ao2.it>
        <xmqq7emljod6.fsf@gitster-ct.c.googlers.com>
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

On Tue, 26 Jun 2018 13:15:33 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Antonio Ospite <ao2@ao2.it> writes:
> 
> > Generlize config_from_gitmodules to accept a repository as an argument.
> 
> generalize???
> 

Of course I was going to miss a typo in the first word of the commit
message :|

If this is the only change, I'd ask you to amend it when applying the
patch, if it's not too much trouble.

If instead I have to add also the comments about the new public
functions in submodule-config.c, as you asked for patch 2/6, I can send
a v3 and fix the typo there.

Thanks,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
