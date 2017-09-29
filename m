Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD27320281
	for <e@80x24.org>; Fri, 29 Sep 2017 22:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752448AbdI2WeK (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 18:34:10 -0400
Received: from mout.gmx.net ([212.227.15.18]:57152 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752380AbdI2WeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 18:34:09 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mdr7l-1dhmYh1qAf-00Peft; Sat, 30
 Sep 2017 00:33:38 +0200
Date:   Sat, 30 Sep 2017 00:33:33 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Joan Daemen <jda@noekeon.org>
cc:     Gilles Van Assche <gilles.vanassche@st.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Keccak Team <keccak@noekeon.org>
Subject: Re: RFC v3: Another proposed hash function transition plan
In-Reply-To: <acd96750-c165-650c-c67f-44465f2075f2@noekeon.org>
Message-ID: <alpine.DEB.2.21.1.1709292355060.40514@virtualbox>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com> <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com> <20170307001709.GC26789@aiede.mtv.corp.google.com> <xmqqa828733s.fsf@gitster.mtv.corp.google.com> <xmqq1snh29re.fsf@gitster.mtv.corp.google.com>
 <20170911185913.GA5869@google.com> <alpine.DEB.2.21.1.1709131340030.4132@virtualbox> <CANgJU+Wv1nx79DJTDmYE=O7LUNA3LuRTJhXJn+y0L0C3R+YDEA@mail.gmail.com> <CA+55aFwUn0KibpDQK2ZrxzXKOk8-aAub2nJZQqKCpq1ddhDcMQ@mail.gmail.com> <alpine.DEB.2.21.1.1709142037490.4132@virtualbox>
 <59BFB95D.1030903@st.com> <alpine.DEB.2.21.1.1709182340350.219280@virtualbox> <59C149A3.6080506@st.com> <alpine.DEB.2.21.1.1709291416290.40514@virtualbox> <acd96750-c165-650c-c67f-44465f2075f2@noekeon.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ai+0vc6ikcp9fUsl47hpDx1sfspE2krXTmh8Krmn0at/QPcG1+2
 hSOf220zGP7k7XEdDIP8nUmHc9DeJ7WzvVdN6MTdpj8gPsCcrijDcuNo7PDELHyZePC362y
 nSTOYESqxoiffyQbpM81aOdM3scVVsWaNNMrnJPsPUrrG0M8F5pc4qjYhBGEe9WAfDC8ywl
 V1iIogm999erKdIYsiiuA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AkQlWlM/nOk=:luYAUpr0rYh1Qq9yeunxFE
 4AOBOS7ROFp2GcQAyMIbgLQt4g07b3+oYdhZspD0dbcSqINgXG2pZ70cUlxBmBjiAwazYUswu
 H6neZUHjJJ6ipYxx7nMZw7AhbB8QcnFtBj6MHXDrfpS0eT0rBVTFSeadp6eUeVp/ZXzC8xbVB
 w2GbR5sTbt6No7XUOGunJD6CdHU/8hYQj81eAl3BJwjJE+U99sCqYakkGT9XaKDpUi8YJ+h61
 gICu/OpGjvBlTqqfebL2Quvk+cmhX3XXnLBVGOJEsySWEZoOyEHe1Is4GIin8vgSJsxDQsHZT
 yqVcw4OjsTNh7KdXhqiySNygbGn6/05GzOMpdnu8YcvZKy3+RZ1HbrQGCJDDbSNEBRULPrC6D
 4IosnBDtHq9jIE+OE2cUxZ/cO+2rSqIuf9fVJkyMxXnR+5LpXspfqboML1idtEaEcA7X4kLIe
 2gNy0HeyGNlvmlHlGmzNMz+ZdJ7srF38fe2YqYuIIo0UPVlLXzGBnK98gCUwuRSUviL4Z8wZi
 OT2R2LbJss4LPMl4sDXX3WZqye8yC0oyzdsY6b6XKKZh2us+tHOiBvy93uZB6j8boFWQX0RaX
 zXpYHlcGnT9YOTcg8rgVRxKVZRra2ETU05M+JhMKRd+p/byKj8YxxuUBmr/styhoaAmGz5+Dg
 VJQDeF/fXQe7Um20aQ5D469x/ZPoq4h0gU8+4bL4xi9Zj/3jZh0Q7hl4uK4DPxHdZiR3IlGhL
 NGiyYG9JN+rBvfOOSlNODjtSGQ0R/4DXcFISolf9bK0A68ejBCTaoF4UqgCr/0qR1Ex05MTUp
 cLxRrtfaAOc0QyMoemgVoN7k8gkMRpu3swyXQn3tIanLiAEM6o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joan,

On Fri, 29 Sep 2017, Joan Daemen wrote:

> if ever there was a SHA-2 competition, it must have been held inside NSA:-)

Oops. My bad, I indeed got confused about that, as you suggest below (I
actually thought of the AES competition, but that was obviously not about
SHA-2). Sorry.

> But maybe you are confusing with the SHA-3 competition. In any case,
> when considering SHA-2 vs SHA-3 for usage in git, you may have a look at
> arguments we give in the following blogpost:
> 
> https://keccak.team/2017/open_source_crypto.html

Thanks for the pointer!

Small nit: the post uses "its" in place of "it's", twice.

It does have a good point, of course: the scientific exchange (which you
call "open-source" in spirit) makes tons of sense.

As far as Git is concerned, we not only care about the source code of the
hash algorithm we use, we need to care even more about what you call
"executable": ready-to-use, high quality, well-tested implementations.

We carry source code for SHA-1 as part of Git's source code, which was
hand-tuned to be as fast as Linus could get it, which was tricky given
that the tuning should be general enough to apply to all common intel
CPUs.

This hand-crafted code was blown out of the water by OpenSSL's SHA-1 in
our tests here at Microsoft, thanks to the fact that OpenSSL does
vectorized SHA-1 computation now.

To me, this illustrates why it is not good enough to have only a reference
implementation available at our finger tips. Of course, above-mentioned
OpenSSL supports SHA-256 and SHA3-256, too, and at least recent versions
vectorize those, too.

Also, ARM processors have become a lot more popular, so we'll want to have
high-quality implementations of the hash algorithm also for those
processors.

Likewise, in contrast to 2005, nowadays implementations of Git in
languages as obscure as Javascript are not only theoretical but do exist
in practice (https://github.com/creationix/js-git). I had a *very* quick
look for libraries providing crypto in Javascript and immediately found
the Standford Javascript Crypto library
(https://github.com/bitwiseshiftleft/sjcl/) which seems to offer SHA-256
but not SHA3-256 computation.

Back to Intel processors: I read some vague hints about extensions
accelerating SHA-256 computation on future Intel processors, but not
SHA3-256.

It would make sense, of course, that more crypto libraries and more
hardware support would be available for SHA-256 than for SHA3-256 given
the time since publication: 16 vs 5 years (I am playing it loose here,
taking just the year into account, not the exact date, so please treat
that merely as a ballpark figure).

So from a practical point of view, I wonder what your take is on, say,
hardware support for SHA3-256. Do you think this will become a focus soon?

Also, what is your take on the question whether SHA-256 is good enough?
SHA-1 was broken theoretically already 10 years after it was published
(which unfortunately did not prevent us from baking it into Git), after
all, while SHA-256 is 16 years old and the only known weakness does not
apply to Git's usage?

Also, while I have the attention of somebody who knows a heck more about
cryptography than Git's top 10 committers combined: how soon do you expect
practical SHA-1 attacks that are much worse than what we already have
seen? I am concerned that if we do not move fast enough to a new hash
algorithm, and somebody finds a way in the meantime to craft arbitrary
messages given a prefix and an SHA-1, then we have a huge problem on
our hands.

Ciao,
Johannes
