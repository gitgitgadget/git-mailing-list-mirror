Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEF9E1F97E
	for <e@80x24.org>; Mon, 20 Aug 2018 16:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbeHTUGy (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 16:06:54 -0400
Received: from ao2.it ([92.243.12.208]:52431 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbeHTUGy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 16:06:54 -0400
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1frnMG-00083b-AT; Mon, 20 Aug 2018 18:48:48 +0200
Date:   Mon, 20 Aug 2018 18:50:29 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org,
        Daniel =?ISO-8859-1?Q?Gra=F1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 4/7] submodule--helper: add a new 'config' subcommand
Message-Id: <20180820185029.ba1f20d79db5479255f0ff68@ao2.it>
In-Reply-To: <20180814171058.GF240194@google.com>
References: <20180814110525.17801-1-ao2@ao2.it>
        <20180814110525.17801-5-ao2@ao2.it>
        <20180814171058.GF240194@google.com>
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

On Tue, 14 Aug 2018 10:10:58 -0700
Brandon Williams <bmwill@google.com> wrote:

> On 08/14, Antonio Ospite wrote:
> > Add a new 'config' subcommand to 'submodule--helper', this extra level
> > of indirection makes it possible to add some flexibility to how the
> > submodules configuration is handled.
> > 
> > Signed-off-by: Antonio Ospite <ao2@ao2.it>
> > ---
> >  builtin/submodule--helper.c | 14 ++++++++++++++
> 
> >  new                         |  0
> 
> Looks like you may have accidentally left in an empty file "new" it should
> probably be removed from this commit before it gets merged.
> 

Yeah, I had added it to test "git cat-file -e new" for a later patch and
then I must have messed up some rebase. Thanks for pointing it out.

Ciao,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
