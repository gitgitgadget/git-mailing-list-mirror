Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2921D20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 16:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753567AbdASQb2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 11:31:28 -0500
Received: from mout.gmx.net ([212.227.15.19]:63400 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753407AbdASQa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 11:30:56 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LmK3e-1bvT1W442M-00Zztq; Thu, 19
 Jan 2017 17:30:49 +0100
Date:   Thu, 19 Jan 2017 17:30:48 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Paul Sbarra <sbarra.paul@gmail.com>
Subject: Re: [PATCH v5 3/3] Retire the scripted difftool
In-Reply-To: <xmqqbmv49o3s.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1701191730040.3469@virtualbox>
References: <cover.1483373635.git.johannes.schindelin@gmx.de> <cover.1484668473.git.johannes.schindelin@gmx.de> <8238bba389c031b091a37396fed43cac94d944e7.1484668473.git.johannes.schindelin@gmx.de> <xmqqk29tcqb8.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1701181332230.3469@virtualbox> <xmqqbmv49o3s.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:u4MN362Q0h4F7Kwesn1DUUnXcgBze2VtCCbQ8i2h1fiR5rkOpXW
 jI2t+C6qY2DJRwPen7UaYGFy/Odid4gQWnDvUMMWanSI6ZfG8MocaOGxnv5wlFnMFjAfpk5
 Gb8FfJQUoIvzY/DVB8YCkRWoWrKFLdqYj9pwYpvJ/ksn6BVmai66SejCjCmO9+fQOUTdTCB
 4+n2fF5JY3FTME1H+clYQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:keV8op+ekGI=:Jd9j2bhHdJrePVQSB5gCvP
 tuOShkC+xKKZ7KDKlJn6Mg6wQ/cgjXsf3dP/C0+DXyLqLKc37BwQPlVNKoygXwUbmFU/PfmsX
 t5Vj8rWA34RABTesCMPw34uvQPY5zVGIwJ2hAseiIxGIZIzJ2DtEQvYRpqQ3Svc4S8YwlqtcA
 6WDK/DXTQj53GnH6HeQ2M4tYydSrIScBZpMUkpRZCA5ecbmsO606WAAjzRZH7fmLg595OxJ/+
 QIC2oxnkS4m8xJahViSvt0vARoZhIYRkVgSKDBXkPjkk7huB6597PxmqJlBrJJBsMeLxZ/Fg3
 cZ+AHM6LGToOHopg7pd9KqflLT6eAZjl/kwAkSayP5inPnwyFT7B/oOpqdIoU3NlxDZcKTzC7
 SBzx9By1wCqGou4ZWzGd8FdgOZPNh/wiQxWDJ4hQZRrA1dmAWo1MsVBorf/8mSr+tDnoe8fS1
 A3IRP0up8atV9ZKptyYwCReM3Pn7277a2YgD93BIOYZmH9GFKiACeXgGwNSOEcFD3Ve5AptHK
 cqIf+0P4gFs131OSVLgx1Wzk5Z9OKJLwj/ye1a9DlGJAEnV66Y0ArJGTtwBrwMN74sPlxHBkS
 WnHtvr7V4m+uTWPUxkC2KxVfUwIUnMoS5HhjGWkxJ+FKdeMopiBUr2qdQMXOqPVjKNEuuvXll
 yAvaeUSZASk5HypnAf9B5mIsl1rpJsTDYO2/CjcynZS/2LqNKSC8khl6lVjVibOCcVgXXBE1G
 3bQNTHTpxuynTk0VZvRmOX4C61Omv0nev56cYecKwx07/P8ivsSaCOE7VM9NnTc6nvFEmntrX
 1iyxPW6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 18 Jan 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Hi Junio,
> >
> > On Tue, 17 Jan 2017, Junio C Hamano wrote:
> >
> >> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> >> 
> >> > It served its purpose, but now we have a builtin difftool. Time for the
> >> > Perl script to enjoy Florida.
> >> >
> >> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> >> > ---
> >> 
> >> The endgame makes a lot of sense.  Both in the cover letter and in
> >> the previous patch you talk about having both in the released
> >> version, so do you want this step to proceed slower than the other
> >> two?
> >
> > I did proceed that slowly. Already three Git for Windows versions have
> > been released with both.
> >
> > But I submitted this iteration with this patch, so my intent is clearly to
> > retire the Perl script.
> 
> Ok, I was mostly reacting to 2/3 while I am reading it:
> 
>     The reason: this new, experimental, builtin difftool will be shipped as
>     part of Git for Windows v2.11.0, to allow for easier large-scale
>     testing, but of course as an opt-in feature.
> 
> as there is no longer an opportunity to participate in this opt-in
> testing, unless 3/3 is special cased and delayed.

Yep, as Git for Windows v2.11.0 is yesteryear's news, it was probably
obvious to you that I simply failed to spot and fix that oversight.

Ciao,
Johannes
