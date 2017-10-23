Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D65EE202A2
	for <e@80x24.org>; Mon, 23 Oct 2017 15:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751609AbdJWPFf (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 11:05:35 -0400
Received: from mout.web.de ([212.227.15.4]:54208 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751266AbdJWPFe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 11:05:34 -0400
Received: from [192.168.178.36] ([91.20.60.28]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LrbHJ-1d4GxX2Guj-013RTl; Mon, 23
 Oct 2017 17:05:26 +0200
Subject: Re: [Alt. PATCH] ls-remote: deprecate -h as short for --heads
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Thomas Rikl <trikl@online.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <63fe2a84-d991-9165-32c0-8087d8513ce6@online.de>
 <CAN0heSpPWWdWY4d1wCdRH8TjcmD3kAiSffL0-_9kJWkm5P2EkA@mail.gmail.com>
 <4d110305-0826-6fd1-91a5-c1ebd0b1e80b@web.de>
 <774f08bd-3172-0083-1544-e5f68f6798fa@web.de>
 <xmqqk1ztmkbn.fsf@gitster.mtv.corp.google.com>
 <26112a15-f02c-a910-c8bb-794ca84dc1e5@web.de>
 <20171019203249.76uu3b6ferquitcr@sigill.intra.peff.net>
 <xmqqlgk6iq94.fsf@gitster.mtv.corp.google.com>
 <20171020030524.4xlwrdag7e4gzg7s@sigill.intra.peff.net>
 <xmqq7evqidp3.fsf@gitster.mtv.corp.google.com>
 <437f4e47-fcb1-ff8c-3c5a-fa9a5cecedfe@web.de>
 <xmqqh8usg0cs.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <7c53071a-5154-1246-d2f1-1064e3f923d4@web.de>
Date:   Mon, 23 Oct 2017 17:05:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqh8usg0cs.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:DTU9R8ggDaIKNkbP2z+EZNXZR2M5762Bz33gwKpp9CNnVL0vUWX
 IWMW0LGaGQW3t2cPv944oiUzs51Oye67FLqr5L8N3mfGHFQu3QyXfsaszGMz3DuzwK5k2JJ
 NhuvGL67BnULX1nUf2uCDIMw8rlfTAY0Tc0dBpiFebNXQRuPxoErmzye/0OuLdJh1FHwQe8
 6+0j24xdd9qGXDf3N8YNQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kL0H/yND4ME=:EdwyDjxRI+BSEbuQHvFCBX
 kwJi2RoBprtA1AHUo2w4hn69KeIIFyhDnri1orLcTyvlFXM6JvatNiFDGSkesG9y/6yvRwgSD
 qttDFwSiQw9zLKO3viQklu1D1g7JQOHUXAzRnTHMiHXxYl2VSXO2k6iDAr5wWDNR7MlgyYLim
 fN68PyzTdEY/MtESub6xHfLbb5VlCJdQ3Kr1cD1cpSH+SyE7PK80C/hnEMl2uiW0bp9OdNAya
 EQrWIcxbEMTj5Jr3taN619Zk22nXB9V1dbPm+BR2QLeGsqu5AYU4AraLQMqSpr3cRvvKQpJFD
 murV9Mk4x56GQXNBDmyuKgtCS2N1WRmuaQbUgeDC7QTYEWL3Msv+cmLVPST17rxz8983G1Dgi
 MPDoL7VmGOIUQjVJtkOf3HktPo1Lj5q6EVDkSYTpIFncKT+Kg4SoaaTSzHTsC4X2y6XJUQGKI
 MMjulZ5znfRGSnWW9jdTApsFc9IRrhE0/Kx7OD/k3aWXkouyYtNfyOL4lk6UUAIyueiZLeS6D
 jvx/5uFmAJgVb2VCuq/UpAkIEOvs8ECLF+oXowMI97IsoY9EpOqrbrts1sa0TQjY04iFAT4vF
 9944fqFvei7Kr8GMUfm48hf5d4kCADiHI0rOOWQ9kTpEYZUXiHlzAqR4t69NShsYc+lGe5E4f
 IsVGaprhnGKsH+SEe44mwU+iOt2yUCH8ey5vz9iJOOVW98IYnmxwcM0PknvqbHTtLR2NoMooj
 bL5US2ScTI3TXAdNa1SuQPWx4caBwbKgmlGmo6dLt+hhvSmleC9BYGH0kGUBZTGo++JgnP0Tf
 8IIwvr/sSP3aWGutrPvaO3f9hxGbqcuBnYQ5f/+9GEu202kCHI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.10.2017 um 14:18 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
> 
>> FWIW, I use "-?" for that everywhere.  I have yet to find a command or
>> environment where it does something dangerous.
> 
> Yeah, it would have made the world a better place if we made that
> choice back in 2008.  If we start a transition to make it so right
> now, we might be able to make the world a better place by 2022,
> perhaps.  I am not sure if the pain during the transition is worth
> it, though.

"-?" works fine with builtins already -- they complain that the option
is unknown and then show the short help text.

If we removed the special handling for "-h" from parse-options it would
do the same for most commands, i.e. we'd get an additional error
message, followed by the short help text that we're used to see.  We
could check for "git grep -h" without any other arguments and show the
usage text in that case.  We could do the same for "git ls-remote -h"
as well, but I'm not sure we want to.

So the cost would be an extra error message in most cases, and possibly
the inability to show help with "git ls-remote -h".  That doesn't sound
very painful.

René
