Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05ABA207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 14:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1171904AbdDXOCi (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 10:02:38 -0400
Received: from mout.gmx.net ([212.227.15.15]:64049 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1171300AbdDXOCg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 10:02:36 -0400
Received: from virtualbox ([95.208.59.55]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lhwt0-1cFtjy2bPW-00n5a7; Mon, 24
 Apr 2017 16:02:28 +0200
Date:   Mon, 24 Apr 2017 16:02:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jacob Keller <jacob.keller@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH v4 0/9] Introduce timestamp_t for timestamps
In-Reply-To: <CA+P7+xoZ_dTvg9b6uckD4-=hHHNE42SCApzs9QO0YddpKXCR5g@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1704241601140.3480@virtualbox>
References: <cover.1492721487.git.johannes.schindelin@gmx.de> <cover.1492771484.git.johannes.schindelin@gmx.de> <xmqqbmrm1o1k.fsf@gitster.mtv.corp.google.com> <CA+P7+xoZ_dTvg9b6uckD4-=hHHNE42SCApzs9QO0YddpKXCR5g@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:5eDBAP6OHZy0Jokij1CQHNtKcKRh2f6JW+9ug3oc/am/veIbvFT
 jo0yOCypFmLWfWB4PLHmR7hqYyvsEd3RJnQZhWV+kfanbhgAOtA///BXnHBADTIqs6kUxJW
 9InAwKmCblFoQlmn5zN2qkNNEysB8TjIXtUCGVIyRwbM+sE5kDTXkB9X0zWP9xDYFUbT8l8
 MRmJGW0wqhmK3LOl7I0vw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:l6I5bMRlkHM=:JkcS3zd1ztta7CurFfmdRX
 FRj4zry0keEWFVKQzDTAH9e8tKX5Et0ghMf5zHRSOR9VzJ/6WIS8UsePG8E0/EyUBOodC5JBX
 BO/YSHrYl68OeK99Ik7htinjQh7oaGi+Kt8XpAg1vUjSkSVhImOPGk/KegFULf3MGYGTzzABs
 SS12cgEQ/Nw1q6CnryRIVRuebbxARKUZU172LwCEtWN78JppHFvxv0TUTcPpgprdhNP9MOe4y
 ApI61wNSfNbFL7Wo3iQIi3Xh3JTFmsoyosR/ZMGPd8PfAp5U/Zi61pIWNpOvQ+JFXJVqtV4Z6
 V0FEgH+bemE2vn0iH+dQ628MbYHeBJl44s1YY7YMc4r5P8wp885V5+faInOw3bTYNsYYkelCg
 wxwfSynjTnweNd5o71QuhfdwzJX2ldfMelbIebXQ3O4f6SY92liBeXvwAJT5hy/ezrM+y2w/S
 XlCUT6korigLrGdkO5obGvnfHI9OpkBRL3Fy6L8LeOULHi0DRKHTDYRr9Xqu9zO4HSizotVkb
 ZnsokQztYv3/vQcj8XcmsUz0He1OCLrpOtHXgOi0HEum5r7uhlyFxRCA+QSS6RpzHI4aCvrX/
 AFbThRsNUQLTYiO/49IY3/JzYPqffxO8WaqJ68Ba0u7FP5Y7wCfxhkvIkFAvotjGgTTifs5HQ
 8IPK+NoqNXyUE+v4J/K+D8amYP1TVkH4Zag/T2oap3q15H76orMd7az3kCHwSVlBGr5wZZwiX
 6/sibq2t95KDXS9uMeJ+zLFirKXE2a5Aj60PpgHsC/GUIh1Gk8sIS7x6L3xBwGFfDHQ0blRwL
 RxR/Eax
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jacob,

On Sun, 23 Apr 2017, Jacob Keller wrote:

> On Sun, Apr 23, 2017 at 8:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> >
> >> Changes since v3:
> >>
> >> - fixed the fix in archive-zip.c that tried to report a too large
> >>   timestamp (and would have reported the uninitialized time_t instead)
> >>
> >> - adjusted the so-far forgotten each_reflog() function (that was
> >>   introduced after v1, in 80f2a6097c4 (t/helper: add test-ref-store to
> >>   test ref-store functions, 2017-03-26)) to use timestamp_t and PRItime,
> >>   too
> >>
> >> - removed the date_overflows() check from time_to_tm(), as it calls
> >>   gm_time_t() which already performs that check
> >>
> >> - the date_overflows() check in show_ident_date() was removed, as we do
> >>   not know at that point yet whether we use the system functions to
> >>   render the date or not (and there would not be a problem in the latter
> >>   case)
> >
> > Assuming that the list consensus is to go with a separate
> > timestamp_t (for that added Cc for those whose comments I saw in an
> > earlier round), the patches looked mostly good (I didn't read with
> > fine toothed comb the largest one 6/8 to see if there were
> > inadvertent or missed conversions from ulong to timestamp_t,
> > though), modulo a few minor "huh?" comments I sent separately.
> >
> > Will queue; thanks.
> 
> I think that this timestamp_t makes sense. I didn't get a chance to
> review the code to make sure nothing was forgotten, but I think the
> direction makes sense to resolve the problems with current time_t and
> ulong assumptions.

TBH I rely a bit on the combination of compiling on Windows and on 32-bit
Linux to make sure that all the callers are converted. Originally, I was
more diligent, of course, but it took a while to get this patch series
into `pu` and there are so many possible new callers...

Ciao,
Dscho
