Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90C7D1F406
	for <e@80x24.org>; Fri, 11 May 2018 22:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751313AbeEKWRJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 18:17:09 -0400
Received: from ao2.it ([92.243.12.208]:44942 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751204AbeEKWRI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 18:17:08 -0400
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fHGLS-0005pM-DA; Sat, 12 May 2018 00:16:58 +0200
Date:   Sat, 12 May 2018 00:17:05 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: fix config API documentation about
 config_with_options
Message-Id: <20180512001705.1ce66754ce72d2b57c7e6d96@ao2.it>
In-Reply-To: <20180509171950.GB63423@google.com>
References: <20180509131628.20099-1-ao2@ao2.it>
        <20180509171950.GB63423@google.com>
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

On Wed, 9 May 2018 10:19:50 -0700
Brandon Williams <bmwill@google.com> wrote:

> On 05/09, Antonio Ospite wrote:
> > In commit dc8441fdb ("config: don't implicitly use gitdir or commondir",
> > 2017-06-14) the function git_config_with_options was renamed to
> > config_with_options to better reflect the fact that it does not access
> > the git global config or the repo config by default.
> > 
> > However Documentation/technical/api-config.txt still refers to the
> > previous name, fix that.
> > 
> > While at it also update the documentation about the extra parameters,
> > because they too changed since the initial definition.
> > 
> > Signed-off-by: Antonio Ospite <ao2@ao2.it>
> > ---
> > 
> > Patch based on the maint branch.
> 
> Thanks for updating the docs.  Maybe one day we can migrate these docs
> to the source files themselves, making it easier to keep up to date.
> For now this is good :)
> 

Should I resend the patch to gitster@pobox.com with your Acked-by?

Thanks,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
