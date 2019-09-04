Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96F731F461
	for <e@80x24.org>; Wed,  4 Sep 2019 18:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387842AbfIDSwP (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 14:52:15 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:48760 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732885AbfIDSwP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 14:52:15 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 46NtGf5YvGz5tlF;
        Wed,  4 Sep 2019 20:52:10 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id CB5A91AEB;
        Wed,  4 Sep 2019 20:52:09 +0200 (CEST)
Subject: Re: feature request, git-gui: add hotkey to toggle amend/new
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>,
        Git List <git@vger.kernel.org>, bouncingcats@gmail.com
References: <CAGr--=Jw4DAqTi3ROujtE=xBMYErMws6B6vhuXYMQA+5Q1ccow@mail.gmail.com>
 <CAGr--=JkNqcrcenp6F1_CHTun_9wPLVvEWGOFJW=ng=XfO+jHw@mail.gmail.com>
 <CAKPyHN3Zvf6gtKAq03s8AsguaOFG=g2huGRCTWmBVWioDBqFWw@mail.gmail.com>
 <CAGr--=JyJHTxtQWSnU7ivQ79qXcg7o4N142+5FSdre851xss6A@mail.gmail.com>
 <CAKPyHN3S-jLWmfHUyH9mCBPjHCEaBCbrkVQEKFqHv59U37=Kyg@mail.gmail.com>
 <CAKPyHN08Z_9oByA8ruKwwXRcAfYPU95JaMb=pqQWwGwPVG=_og@mail.gmail.com>
 <CAGr--=Jn87r_ySYkZmtqUBA40+fwdn0MbuN6_LNDO4mOWyoKTg@mail.gmail.com>
 <20190903124541.2p5hmknolh2dwqh5@yadavpratyush.com>
 <971bbc44-d3d4-552d-d18e-58a2315c6183@kdbg.org>
 <20190904174103.nrntgwv6zdqyjqsh@yadavpratyush.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <8a726eea-f461-db90-7e36-70b708ff8915@kdbg.org>
Date:   Wed, 4 Sep 2019 20:52:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904174103.nrntgwv6zdqyjqsh@yadavpratyush.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.09.19 um 19:46 schrieb Pratyush Yadav:
> On 04/09/19 08:24AM, Johannes Sixt wrote:
>> That is worth a try. The check box title offers a natural hotkey then:
>> "_A_mend last commit", Alt-a.
> 
> Right now, the binding proposed is Ctrl-e.  My mental model for the key 
> bindings as of now is having the "actions" bound to Ctrl, and bindings 
> that move you around in the UI bound to Alt.  So it makes more sense to 
> me to have a "amend toggle" bound to Ctrl.  Maybe that's just me though.  
> Anyone else care to chime in?

"Amend last commit" is NOT an action. It switches a state.

It is common in Windows GUIs that every control, including menu items,
has a hotkey associated, the underlined letter in the caption, and the
hotkey to access that UI control is Alt+that letter. It's not
necessarily a matter of moving around.

And, BTW, this hotkey thing is also the case on my Linux desktop
(KDE-based).

But of course, git-gui is different and totally off track here. It has
*zero* controls marked for hotkey-accessibility. I was just hoping to
spark an effort to make some of the controls marked and hotkey-accessible.

-- Hannes
