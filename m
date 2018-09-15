Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFB2A1F404
	for <e@80x24.org>; Sat, 15 Sep 2018 20:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbeIPBh7 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 15 Sep 2018 21:37:59 -0400
Received: from ao2.it ([92.243.12.208]:47749 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727716AbeIPBh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Sep 2018 21:37:59 -0400
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1g1Gya-0005r0-Hf; Sat, 15 Sep 2018 22:15:32 +0200
Date:   Sat, 15 Sep 2018 22:17:43 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2018, #03; Fri, 14)
Message-Id: <20180915221743.a018386eb34f6ac792c6e694@ao2.it>
In-Reply-To: <xmqqy3c3agkr.fsf@gitster-ct.c.googlers.com>
References: <xmqqy3c3agkr.fsf@gitster-ct.c.googlers.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 14 Sep 2018 14:56:36 -0700
Junio C Hamano <gitster@pobox.com> wrote:

[...]
> * ao/submodule-wo-gitmodules-checked-out (2018-08-14) 7 commits
>  - submodule: support reading .gitmodules even when it's not checked out
>  - t7506: clean up .gitmodules properly before setting up new scenario
>  - submodule: use the 'submodule--helper config' command
>  - submodule--helper: add a new 'config' subcommand
>  - t7411: be nicer to future tests and really clean things up
>  - submodule: factor out a config_set_in_gitmodules_file_gently function
>  - submodule: add a print_config_from_gitmodules() helper
> 
>  The submodule support has been updated to read from the blob at
>  HEAD:.gitmodules when the .gitmodules file is missing from the
>  working tree.
> 
>  Expecting a reroll.
> 
>  I find the design a bit iffy in that our usual "missing in the
>  working tree?  let's use the latest blob" fallback is to take it
>  from the index, not from the HEAD.
> 

Hi Junio,

I did send a v4 addressing this:
https://public-inbox.org/git/20180824132951.8000-1-ao2@ao2.it/

In case you missed it I might as well send a v5 with some minor
cosmetic touches suggested by Ævar:
https://public-inbox.org/git/87wosfesxl.fsf@evledraar.gmail.com/

Ciao,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
