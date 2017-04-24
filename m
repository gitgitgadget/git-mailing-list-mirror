Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A28E207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 14:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1171746AbdDXOYZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 10:24:25 -0400
Received: from mout.gmx.net ([212.227.17.21]:63635 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1169313AbdDXOYX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 10:24:23 -0400
Received: from virtualbox ([95.208.59.55]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MKLeM-1d10kT1UVK-001efa; Mon, 24
 Apr 2017 16:24:15 +0200
Date:   Mon, 24 Apr 2017 16:24:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Subject: Re: What's cooking in git.git (Apr 2017, #04; Wed, 19)
In-Reply-To: <a9685abc-50ad-3ee6-3384-0e043d205612@kdbg.org>
Message-ID: <alpine.DEB.2.20.1704241622510.3480@virtualbox>
References: <xmqq4lxjabce.fsf@gitster.mtv.corp.google.com> <D61D47BD-9750-4FB6-892E-013504E03738@gmail.com> <xmqqbmrq8z4j.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1704211135430.3480@virtualbox> <CAP8UFD19DVqQLHBta74uLcFPwJaRUKF8Ppmnhct5ub=OkKSqCQ@mail.gmail.com>
 <a9685abc-50ad-3ee6-3384-0e043d205612@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Htesu9PKwaKbYS2cujz8v16qCG/46jvyjqu5mBhVvhaB5InsAFL
 nvJiH2dAp83cmvQpPK9iip9huv3rsrNmR5/BDh7NTcTwdmAVhFc4k+wHdrll7YyVHzLaRdO
 1MMZjA8oh5Jj1Ty3Ympx+CQDyZi9eiHHKbhfd0Gydu/30hIAAsSFBG5wxDpN4Xa5pjj5qdf
 Xs93vE2jQBSuNUL9YmI2Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BKfF1KPD7PU=:p22JgscDk2aeB5+fhsS2Dr
 5+bKJc+m35wLKyCSDGTxd3qjYWhkYwZdmIa2qTJYa+GkPy9b3F6LF29+Y6azdN0D8dVsVg3eb
 +dKU3hypsMF1LPdhKEgnC29/glSydJmJK+FGwwlCt36MuGJOh91+fN0+wQuLdrNkkd/PRF5Ja
 YZTg+toCFOAOJ3sYLd16pcM2QEEtZyHUt6IWRmXoyV87ZFn7M5qsDgroqDvWzqHDlG/Ik8ZiF
 cL208hWxgRaa+DZGJ51uT8t3gaT/oaTW2wmDed/v/QHAxzTmFQjACuYngdtt9qNmM3APlKTWd
 XMhfRWj7s2zOkF3ftPs9hk8XO6Iynu8PdfE1X3uOHt5Jw+9npfHQNteihqcAXWpVG8gar+Vhq
 Q5MeH9GZquJ8WvK5CKWqZ4PX/9pMkJXYEeMH4SFi5t/ECU5prDMKM9L0AVcQo/VqveQkCFiTD
 nOlOXIyCznILQ+IwB17an2jSVtcBHxzQYdIn+/D/4lXwQie4owJTDysJe2wTZwxnDC018l5Jd
 XRpyUGdHULChxzXOX2M7yQx5JNjTHj9vnBPQSznZq36wCO2FW9T4aQ79iPA/PUbjJpmL3SuLE
 3tk19SwZFxxJ+ON7/WjCwbouZ4IAHZpNalKDRd00gE66F8ezDK8X0IFof0zcCdK0NrtB6/nVD
 K511AOwJu2nZLyUXd2hZjrk/GowSRbUEjH4LR+3Lwgh96URgBUvCxv7XF2xN0rbn/1ex8gEWz
 AFwHvKkcjNMxlBCipE6I5llcMkzQvrTF+1W5ucHqHkYOBHNOnfvOVxSoXQ6jW2Nu1/YPZ27Zm
 qZ0XFqZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Sat, 22 Apr 2017, Johannes Sixt wrote:

> Am 21.04.2017 um 14:29 schrieb Christian Couder:
> > First bisect should ask you to test merge bases only if there are
> > "good" commits that are not ancestors of the "bad" commit.
> 
> That's a tangent, but I have never understood why this needs to be so.
> Consider this:
> 
>    o--o--o--o--o--o--o--o--B
>    /           /
>  -o--o--o--o--g--o--o--o--o--G
> 
> When I mark B as bad and G as good, why would g have to be tested first? This
> is exactly what I do when I bisect in Git history: I mark the latest commits
> on git-gui and gitk sub-histories as good, because I know they can't possibly
> be bad. (In my setup, these two histories are ahead of pu and next.)

I guess the idea behind bisect's reasoning is that you could have merged
the "wrong" branch first.

Ciao,
Dscho
