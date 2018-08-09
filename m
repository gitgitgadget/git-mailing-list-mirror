Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98BD31F405
	for <e@80x24.org>; Thu,  9 Aug 2018 10:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbeHIMlp (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 08:41:45 -0400
Received: from ao2.it ([92.243.12.208]:35575 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727858AbeHIMlp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 08:41:45 -0400
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fnhzA-0007aU-26; Thu, 09 Aug 2018 12:16:04 +0200
Date:   Thu, 9 Aug 2018 12:17:32 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        Daniel =?ISO-8859-1?Q?Gra=F1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: [RFC PATCH v2 01/12] submodule: add a
 print_config_from_gitmodules() helper
Message-Id: <20180809121732.02df3be299d42dc53dfa078d@ao2.it>
In-Reply-To: <CAGZ79ka-rbOiwWrwbW2vJW9ZOgSas23LkfmzBRLfK=g_cW=MhA@mail.gmail.com>
References: <20180802134634.10300-1-ao2@ao2.it>
        <20180802134634.10300-2-ao2@ao2.it>
        <CAGZ79ka-rbOiwWrwbW2vJW9ZOgSas23LkfmzBRLfK=g_cW=MhA@mail.gmail.com>
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

On Thu, 2 Aug 2018 11:05:02 -0700
Stefan Beller <sbeller@google.com> wrote:

> On Thu, Aug 2, 2018 at 6:47 AM Antonio Ospite <ao2@ao2.it> wrote:
> >
[...]
> > +extern int print_config_from_gitmodules(const char *key);
> 
> The only real pushback for this patch I'd have is lack of documentation
> in public functions, though this is pretty self explanatory; so I'd be fine
> for lacking the docs here.
> 
> In case a resend is needed, please drop the extern keyword here.
> 

I'll drop the extern keyword also for the public function added in
patch 02 then.

Thanks,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
