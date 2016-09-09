Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01D4F1F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 15:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751836AbcIIPMX (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 11:12:23 -0400
Received: from mout.gmx.net ([212.227.17.22]:51392 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750848AbcIIPMW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 11:12:22 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LlV4F-1b9sCl2D5j-00bLAo; Fri, 09 Sep 2016 17:12:16
 +0200
Date:   Fri, 9 Sep 2016 17:12:15 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 13/22] sequencer: remember the onelines when parsing the
 todo file
In-Reply-To: <xmqqeg53wj7a.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1609091708480.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <12bffd6ca4eb7acc00a102d13348bb96ad08371d.1472457609.git.johannes.schindelin@gmx.de> <52d61bef-668b-fdc4-30b3-a34c11b39f81@gmail.com> <xmqq8tvc21re.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1609011052260.129229@virtualbox> <xmqqeg53wj7a.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:B6Y3o0kzqbxfiKyv5WO99cT6aphjABYVAJGKBpC84lTcuxFjYw+
 pd8meg9jUIJReFcLOVS7gQh/RZhdunNCAdblYTcNabX8QxTKrMhziffH6Xzt/toqk/JpOlW
 nppV/s35Ch15Js5RPqKKge1nz2924UQNkAEKWYbDW5oHEiTM5FlaygZghJTsXg8sjdEcGFV
 wh1GWhykL1R0NowMXDCVw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iXr5+VnYODk=:EqrKCPQac6ZL3Ac+6BGiDc
 nYnKt1SQ3hkJA1EQ+CpBet3mUw2BwxX1OKYuNgQxw2ZyoMPiu2j/rULlc5G/jh6124MZhbj7k
 UJeMTsq/Z7G+yg+8rCYxRhxFcTDq5xAfk0WrSidjwYT/xUH2+qJ/F4DAwWNJVxDCjMNtPFqDT
 Vl+muWmZEs2uDYjA3X5w68NuqD+FyqxJzMv75TKaJyuoRKzI5dpJ36tzm+FWXWrsv5PTzWzxC
 8SuPSYa2IjIoDNVJ/DN8qwz/FK39c3exSU1fy7CbAFUnrCSErXAYf2EgXf8R6thSch0Q7yT2Y
 oO4a+fDQb5DRBDwOneEgCapO2mlWgN1UPFpS1axgo2qpt0WLOwEoF+0H9OPOaLjq9opaWrr0f
 uZ5mBH5AbqgXDZnncwIP8gVJV08/O6zhPPzs60v+TfJNo7A2/UiPhrt4IBJFFFiKpYc30l9Yy
 JiN5J+QDV2nWNpQLiPo/QETAK5kOEICe4TkJgl1ilbg6D+PFYIQW1JNBw4JDozaaP+9Ov3P2o
 4EW6plxrL5eKXp7TEI+vMGSoCaGNLBQQfCDnKr76PmYvt0fvam8D4feOWZyFE7ZWibl97ALi0
 Tbi57nR07Uyp6y2t+jDECqChj65F27Koo7WULx2zmwEMmGCbJbiPLNYCun9IgcY3ItbySfKh/
 5M6FBuwhECQudOkbSXdfdkjXNQypOlfv114Kdf54dyG80L4LuxRsrdkgSPk34je4aPiIFmpWe
 YQsvVHNYMtwPh+/HBw67ha5/KLeMdRqpsmoFDQlbtqPmDF2VSCKVaSg71m7jBBTL3SeLvU7bZ
 2RbUaZs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 1 Sep 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> though).  The "one sequencer to rule them all" may even have to say
> >> "now give name ':1' to the result of the previous operation" in one
> >> step and in another later step have an instruction "merge ':1'".
> >> When that happens, you cannot even pre-populate the commit object
> >> when the sequencer reads the file, as the commit has not yet been
> >> created at that point.
> >
> > These considerations are pretty hypothetical. I would even place a bet
> > that we will *never* have ":1" as names, not if I have anything to say...
> > ;-)
> 
> If you can always work with pre-existing commit, then you can
> validate all object references that appear in the instructions
> upfront.

Or if *some* of the commands work with pre-existing commits, *those*
commands can be validated up-front.

Which is exactly what my code does.

> I was sort of expecting that, when you do the preserve-merges mode
> of "rebase -i", you would need to jump around, doing "we have
> reconstructed the side branch on a new 'onto', let's give the result
> this temporary name ':1', and then switch to the trunk (which would
> call for 'reset <commit>' instruction) and merge that thing (which
> would be 'merge :1' or perhaps called 'pick :1')", and at that point
> you no longer validate the object references upfront.

Except that is not how --preserve-merges works: it *still* uses the SHA-1s
as identifiers, even when the SHA-1 may have changed in the meantime.

That is part of why it was a bad design.

> If you do not have to have such a "mark this point" and a "refer to
> that point we previously marked", then I agree that you should be
> able to pre-validate and keep the result in the structure.

Even then, those markers should *still* be validated. They, too, need to
be created and later used, usage before creation would be an error.

But...

1) this is not yet a problem, so why are we discussing it here? Do we not
   have actual problems with these patches to discuss anymore?

2) the SHA-1s that *can* be validated *should* be validated, so I find the
   objection a little bogus.

Ciao,
Dscho
