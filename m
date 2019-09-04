Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0752C1F461
	for <e@80x24.org>; Wed,  4 Sep 2019 06:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbfIDGYv (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 02:24:51 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:34686 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728108AbfIDGYv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 02:24:51 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 46NYhK0H84z5tlF;
        Wed,  4 Sep 2019 08:24:48 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 062B3F99;
        Wed,  4 Sep 2019 08:24:47 +0200 (CEST)
Subject: Re: feature request, git-gui: add hotkey to toggle amend/new
To:     Pratyush Yadav <me@yadavpratyush.com>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Git List <git@vger.kernel.org>, bouncingcats@gmail.com
References: <CAGr--=Jw4DAqTi3ROujtE=xBMYErMws6B6vhuXYMQA+5Q1ccow@mail.gmail.com>
 <CAGr--=JkNqcrcenp6F1_CHTun_9wPLVvEWGOFJW=ng=XfO+jHw@mail.gmail.com>
 <CAKPyHN3Zvf6gtKAq03s8AsguaOFG=g2huGRCTWmBVWioDBqFWw@mail.gmail.com>
 <CAGr--=JyJHTxtQWSnU7ivQ79qXcg7o4N142+5FSdre851xss6A@mail.gmail.com>
 <CAKPyHN3S-jLWmfHUyH9mCBPjHCEaBCbrkVQEKFqHv59U37=Kyg@mail.gmail.com>
 <CAKPyHN08Z_9oByA8ruKwwXRcAfYPU95JaMb=pqQWwGwPVG=_og@mail.gmail.com>
 <CAGr--=Jn87r_ySYkZmtqUBA40+fwdn0MbuN6_LNDO4mOWyoKTg@mail.gmail.com>
 <20190903124541.2p5hmknolh2dwqh5@yadavpratyush.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <971bbc44-d3d4-552d-d18e-58a2315c6183@kdbg.org>
Date:   Wed, 4 Sep 2019 08:24:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903124541.2p5hmknolh2dwqh5@yadavpratyush.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.09.19 um 14:45 schrieb Pratyush Yadav:
> Can you try doing a Shift+Tab? For me on Linux, if I hit Shift+Tab, it 
> immediately takes me to the "Amend last commit" option. Then I can press 
> space to select it and Tab again to get back to the commit message.

That works on Windows with Ctrl+Shift+Tab, too.

> Also, since we are on this topic, how about making the "Amend last 
> commit" button a toggle instead? This would act as a "turn amend mode 
> on/off" button. Since "Amend last commit" and "New Commit" are mutually 
> exclusive, a single toggle to switch between those modes makes sense to 
> me.

That is worth a try. The check box title offers a natural hotkey then:
"_A_mend last commit", Alt-a.

-- Hannes
