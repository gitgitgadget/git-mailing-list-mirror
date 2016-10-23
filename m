Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E508120229
	for <e@80x24.org>; Sun, 23 Oct 2016 09:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756564AbcJWJ6U (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 05:58:20 -0400
Received: from mout.gmx.net ([212.227.17.22]:64582 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756533AbcJWJ6U (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 05:58:20 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MBZ9u-1c6XWq3010-00ATQ0; Sun, 23 Oct 2016 11:58:06
 +0200
Date:   Sun, 23 Oct 2016 11:58:04 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v5 00/27] Prepare the sequencer for the upcoming rebase
 -i patches
In-Reply-To: <alpine.DEB.2.20.1610231151140.3264@virtualbox>
Message-ID: <alpine.DEB.2.20.1610231157110.3264@virtualbox>
References: <cover.1476450940.git.johannes.schindelin@gmx.de> <cover.1477052405.git.johannes.schindelin@gmx.de> <xmqqinsk8g1b.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1610231151140.3264@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:f5Y2oAx/82yeApFXhaoywCzc1Sr61dlHNgDQbnmqjvbqXIE2P9n
 Dzn50bLdNyKu3KGcEiGToKpO0RxZYKpZgYkiVUisZRWNYaupaVhJzoAvkgfrxxyPSIUOlyx
 j9ZCOIr8GpPiEOFvDP6pMecJ/HxEY/BsgjWylbjPeq5o7QHnBE7MvOVOvrRMhJ4J/e+SJvA
 mu0VG1raPb+zfDlaXOmzA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Vlbq7ePqovk=:IYmwfI1Aligb5jO+qwtbtp
 1ZcNmyuFHRsWJ2B/KPycF/GEj0D553UsyFl2o1O/WZhlYu1IHoL+cDIwb6UcusCKIr3CC6LgS
 Yy6CHTrcw1UFmOOJzn1x13anjtFfhdtWAvYp49zH8YB5m7JtqcSzEmpXQ2Wy/AMc1UMxdQYsF
 ByacUbiGmRgCeBQp4Zy7TAdA8kUo5U+a0uRok3/aUV2IjYffI9rMmZ1BGOTIxFzrvoqdrbfqm
 y39vz0qKERO0QOgdIGz31yhfNfrMVJibEMalLlOfVTe3ZTeCTXiyqW7UrSvV0jQf4a75DcZwn
 0VH7/R8oD0F+qDNqd8ZKiKyaQ45nEvCVM8wthGWPioI+9thGcswjglXSr4aPboI+MskRYd8wG
 W9U8nB8BMtbnbMLDGYn4VFzaevdU6kvRm9R1PqT5RLGvwVu506YwHVPd2XJG4ugATkqlfFVQX
 Ipy+bbXcHFvr56o3CHABzUOTRmmsK0Ue+KK6S26iOIl4bDp8fbJ+i3JRWeuTAmkDTlcA4m3II
 XrzsRmhovM8helwkVGa5d9PNK9/Da30B/9u8lEtMYxqSodInT4uaeQrgQWxU+eWzrSKeYeidR
 3SzhYueePNkcbPyfQkXHWaWh8MzBr8jjNj4l2anjfLkJS5CnDU3vD+SRqu3inuZcGuLprfz2i
 Y2uwmC1Hwj3mw+5voM41WhK1GJgdxuLNI2etPGxm+fL4Dg6AIKtsHCofNs5KNY4myvaYrW3pq
 jwfm6iDJawNPyL1JuZqbB2lLoc4eyeoEnwV+rNbyjyhIvIIenobn+zixQzB9uNc9oocKaZpuf
 cTX82cI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 23 Oct 2016, Johannes Schindelin wrote:

> On Sat, 22 Oct 2016, Junio C Hamano wrote:
> 
> > Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> > 
> > > This patch series marks the '4' in the countdown to speed up rebase -i
> > > by implementing large parts in C (read: there will be three more patch
> > > series after that before the full benefit hits git.git: sequencer-i,
> > > rebase--helper and rebase-i-extra).
> > > ...
> > > It would be *really* nice if we could get this patch series at least
> > > into `next` soon, as it gets late and later for the rest of the
> > > patches to make it into `master` in time for v2.11 (and it is not for
> > > lack of trying on my end...).
> > 
> > This "countdown 4" step can affect cherry-pick and revert, even

Oh, I forgot to comment on this tidbit of your mail, sorry.

This *is* the countdown 4, as the remaining 3 patch series depend on each
other in the order I sent them out.

Ciao,
Dscho
