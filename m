Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02DA220756
	for <e@80x24.org>; Fri, 13 Jan 2017 17:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751166AbdAMRUW (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 12:20:22 -0500
Received: from mout.gmx.net ([212.227.15.18]:55484 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750964AbdAMRUV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 12:20:21 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Me8di-1c5cLQ089G-00PvNz; Fri, 13
 Jan 2017 18:13:34 +0100
Date:   Fri, 13 Jan 2017 18:13:32 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Eric Wong <e@80x24.org>
cc:     Pat Pannuto <pat.pannuto@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] Use 'env' to find perl instead of fixed path
In-Reply-To: <20170113165819.GA6069@starla>
Message-ID: <alpine.DEB.2.20.1701131813190.3469@virtualbox>
References: <20170112055140.29877-1-pat.pannuto@gmail.com> <20170112055140.29877-3-pat.pannuto@gmail.com> <6fe462dd-929a-671b-a210-36ee38e99115@kdbg.org> <CAAnLKaGbf9-GAF19+61=7_RfCOBM0=Ounwf8KkL1jS6HX3pOag@mail.gmail.com> <alpine.DEB.2.20.1701121118170.3469@virtualbox>
 <xmqqbmvcj9le.fsf@gitster.mtv.corp.google.com> <CAAnLKaGvz4Wzs36gMSdoYCg+tzx6KFCe59FNnk5zNQ-L58ww1g@mail.gmail.com> <20170113024842.GA20572@starla> <alpine.DEB.2.20.1701131626160.3469@virtualbox> <20170113165819.GA6069@starla>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:0j+mEUKkQ0mwor/MMo4cCV4ypT2NtN7atpmjGEvLJQqAWggZ1Mg
 9NSUT+nSlZh2rFDp0yeR0GAb53Q0m8RYBPrFy417xYA6SZ0poqpMEh/9aNlbRe0qUCpmLqE
 xoXKKtB46TJGBgBF+iYcv8t1l7x8fulRLsgDH+sA7P6E2v2rFdu5BI9E2V372trBTcq3cg8
 XWo+jI0NZ2iWug7HyMCww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KAzOb/I/3QM=:N2NpFGNZSZ+5x/pUZyT4ry
 sNv4AVsEuj5bW5f+Q6rtQ2pq3woRLjYl2r39feSn09j30HCWNSPAeYofzWV5JCe82sPXPNDO1
 CzrIrcB1ndzth/D00lfQjrWrhZhwjfC1WqcQ6mmj8qfzcGffpmwHSzyHF6sbc4AtNU7CcAlP8
 zd6UIx4OgLVGcgWtc3K4Hez8JEAa8t6Cxscq4ueRWORHVM46GXYmEjZU9y5q/wrsYnKcsL4yB
 LsSAr/RPDawGYkCiK98L438J7yScVfOhJceKDZBlJ576croloJgDcE6xi3Unnc6PeGU9Q5jLd
 y8ogJqY7qbd5VBEo/lbp8otRQvfIQghjWLQM6u86XS8v/J9OCRAvFyjtFRgTFVif1Ra6DCwpQ
 K5N5eHcH31ezT4tvSvaPZWqFaovtBiJFbgTH8U1acUH0lIaRhN6YGGkjQKbzYiY1jw2F/lPLL
 17/Ogw9968KWW7TSTFnvYvafuM77emF3mHO3KJuNoq6g6TvHRmqGpbbvS7BvhJqHAlVW97hcw
 +W/5gKCssdZD7rmj7iT3KN+Ndpx34NW++sxH47ZG+a/w8weo13J39TTUr9Nrc2PaNzL189P+S
 WO3kNoPbpBUEVhkeMhikthCbDfhhqora9cCl9tGSrTg3wqfh+kJprsFOxZx2p8BzjlRTRtEbk
 W5jsFH2fZEhr57PZgtq/K4eQguWcvxwQ2FUkW0CECdIyr3clldA7xsbjfMW10p/AJmwYqSz1i
 ZAHWvS2T66ZT4+bWPY2wK+qLEtruVrozsK2jRpWCxkDgAM2qf9Pe5L2j3knsWJbn1WQpfvuyE
 j4IlqoH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Fri, 13 Jan 2017, Eric Wong wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > I guess I do not understand, still, what the difference is between using
> > -w and adding `use warnings` *very early* in the script... Could you give
> > an example where it makes a difference?
> 
> "use warnings" won't leak across files/modules.  In the following
> example, only the "useless use of join or string in void context"
> from void.perl gets shown w/o -w.  The VoidExample.pm warning
> can get lost.

Okay, thanks!
Dscho
