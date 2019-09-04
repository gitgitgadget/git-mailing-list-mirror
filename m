Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F76D1F461
	for <e@80x24.org>; Wed,  4 Sep 2019 17:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbfIDRqx (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 13:46:53 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:44047 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfIDRqx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 13:46:53 -0400
Received: from localhost (unknown [157.49.235.162])
        (Authenticated sender: me@yadavpratyush.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id AC3CE240006;
        Wed,  4 Sep 2019 17:46:49 +0000 (UTC)
Date:   Wed, 4 Sep 2019 23:16:43 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>,
        Git List <git@vger.kernel.org>, bouncingcats@gmail.com
Subject: Re: feature request, git-gui: add hotkey to toggle amend/new
Message-ID: <20190904174103.nrntgwv6zdqyjqsh@yadavpratyush.com>
References: <CAGr--=Jw4DAqTi3ROujtE=xBMYErMws6B6vhuXYMQA+5Q1ccow@mail.gmail.com>
 <CAGr--=JkNqcrcenp6F1_CHTun_9wPLVvEWGOFJW=ng=XfO+jHw@mail.gmail.com>
 <CAKPyHN3Zvf6gtKAq03s8AsguaOFG=g2huGRCTWmBVWioDBqFWw@mail.gmail.com>
 <CAGr--=JyJHTxtQWSnU7ivQ79qXcg7o4N142+5FSdre851xss6A@mail.gmail.com>
 <CAKPyHN3S-jLWmfHUyH9mCBPjHCEaBCbrkVQEKFqHv59U37=Kyg@mail.gmail.com>
 <CAKPyHN08Z_9oByA8ruKwwXRcAfYPU95JaMb=pqQWwGwPVG=_og@mail.gmail.com>
 <CAGr--=Jn87r_ySYkZmtqUBA40+fwdn0MbuN6_LNDO4mOWyoKTg@mail.gmail.com>
 <20190903124541.2p5hmknolh2dwqh5@yadavpratyush.com>
 <971bbc44-d3d4-552d-d18e-58a2315c6183@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <971bbc44-d3d4-552d-d18e-58a2315c6183@kdbg.org>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/09/19 08:24AM, Johannes Sixt wrote:
> Am 03.09.19 um 14:45 schrieb Pratyush Yadav:
> > Can you try doing a Shift+Tab? For me on Linux, if I hit Shift+Tab, it 
> > immediately takes me to the "Amend last commit" option. Then I can press 
> > space to select it and Tab again to get back to the commit message.
> 
> That works on Windows with Ctrl+Shift+Tab, too.
> 
> > Also, since we are on this topic, how about making the "Amend last 
> > commit" button a toggle instead? This would act as a "turn amend mode 
> > on/off" button. Since "Amend last commit" and "New Commit" are mutually 
> > exclusive, a single toggle to switch between those modes makes sense to 
> > me.
> 
> That is worth a try. The check box title offers a natural hotkey then:
> "_A_mend last commit", Alt-a.

Right now, the binding proposed is Ctrl-e.  My mental model for the key 
bindings as of now is having the "actions" bound to Ctrl, and bindings 
that move you around in the UI bound to Alt.  So it makes more sense to 
me to have a "amend toggle" bound to Ctrl.  Maybe that's just me though.  
Anyone else care to chime in?

-- 
Regards,
Pratyush Yadav
