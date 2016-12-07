Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D98201FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 20:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932594AbcLGUfb (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 15:35:31 -0500
Received: from mout.gmx.net ([212.227.17.21]:56279 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752885AbcLGUfa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 15:35:30 -0500
Received: from [192.168.178.43] ([92.76.239.239]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MRSeC-1c3d8m3MPQ-00Sjas; Wed, 07
 Dec 2016 21:35:24 +0100
Subject: Re: BUG: "cherry-pick A..B || git reset --hard OTHER"
To:     Junio C Hamano <gitster@pobox.com>
References: <xmqqlgvs28bh.fsf@gitster.mtv.corp.google.com>
 <6facca6e-622a-ea8f-89d8-a18b7faee3cc@gmx.net>
 <xmqq8trry08k.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder@ira.uka.de>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <8d32c645-e850-5e7c-b01c-6e4d81e2d672@gmx.net>
Date:   Wed, 7 Dec 2016 21:35:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.0
MIME-Version: 1.0
In-Reply-To: <xmqq8trry08k.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:ChLitNm7emgfU+AaZ3yIXtG7hXzjipBrmE98S5V3pI+gWY6NfB6
 5u3XoPQwpvYMRKGKy47LV1idlL3musxp6VlOH19VVcd5/uzVspoMuKb11yRmKrG1eevyWU6
 qVpqfal/oPVPMCKdZuzWUjg98kV1C3nokD0FowvdHynDrcAPA3qY2RyR5KjosOj58Tldj6y
 6AiF34HaWTuP0p3kl+Zqw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rqfu2Am61Jg=:6z6ZF8SPDgnAlqHufvxNOJ
 Sn1EIEc7AtNe9svgtrsjoiwbklcffLF+YJehLhP6W6ofM6jpT7HmVV3jeUCvYeCe8jAzhbc0x
 a+0B5tGdiGKpM7x58Mg74uO6c1C+gsVfnuNqir0ssvSnw04uyqpP/s2PxhX774HGyObxt3E5E
 ht46MKqPg3hElsV/QHMvcDQSBlaMG4ignZM2RMQuwY+kYtkAYg+4SKTgKpZNx9jEuykIhGvAD
 V88TXxrKoUMYTGGmGBRegG6qgM+rJpICQfEZfzbV38wCF9bjZOkGyIwHniFvb8x3mWFOKieWh
 7+ZiiLlr5zwSdLO9ue1NcCCtVVH0I208ixeQxCpdOlJ7QxJj38IbqJ6M53nva/fl5tcC3+M1j
 TU3RgaTTMFgMexont/xBLXqGiWxDIcxuKiAVUARDmhv5H81vY4pTgcf/z7cCoClaUCqG3MfaO
 d0V+3JqxKSmrDWJDil+lcvZjSJHC1k71GdB6pWOiMectwScDJQtjbUZXd2VX9TwwqSocYMB4e
 I/ml2pIqFyciT9T9+hxwKHVN7v+07Yg2dmpo4HRJEl+S1KdrHhiz95uNNl3MSn12fL+LpV3Jk
 FZXZ/fYVTc9VUXy9lUgbd97JCa5tzbJC7QO6OhlMApfOcEY904OmkbMqzU17XUzfLlRp3sPe6
 9A1otEeenYvUX7osxwD0fwQ7AwWrg6dFyCmLUUw/VWG1WkJ7P8UF4PCfren4VwtZkJZ/y6mi6
 0GPr9ebIc5yeC6786GWe+5dQPBBRiUC19HYQA15Sak0f3skGEVhwuaxUF/tvDY/o/S7k+fpeT
 +z9/Gzg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 12/07/2016 09:04 PM, Junio C Hamano wrote:
> Stephan Beyer <s-beyer@gmx.net> writes:
> 
>> [1] By the way: git cherry-pick --quit, git rebase --forget ...
>> different wording for the same thing makes things unintuitive.
> 
> It is not too late to STOP "--forget" from getting added to "rebase"
> and give it a better name.

Oh. ;) I am not sure. I personally think that --forget is a better name
than --quit because when I hear --quit I tend to look into the manual
page first to check if there are weird side effects (and then the manual
page says that it "forgets" ;D).
So I'd rather favor adding --forget to cherry-pick/revert instead... or
this:

> Having said that, I have a feeling that these options do not have to
> exist; isn't their presence just a symptom that the "--abort" for
> the command misbehaves?  Isn't the reason why there is no need for
> "am --quit" because its "--abort" behaves more sensibly?
You're probably right. I have no other use-case in mind than "oh I
forgot that I was rebasing... now just abort that and don't bother me
further (i.e. please don't bring me back)"

~Stephan
