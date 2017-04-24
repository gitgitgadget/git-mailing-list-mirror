Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BADD2207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 13:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1171324AbdDXN5p (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 09:57:45 -0400
Received: from mout.gmx.net ([212.227.17.22]:61928 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1171810AbdDXN5i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 09:57:38 -0400
Received: from virtualbox ([95.208.59.55]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0La3c1-1cHo9v1Mcf-00lki2; Mon, 24
 Apr 2017 15:57:30 +0200
Date:   Mon, 24 Apr 2017 15:57:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4 7/9] Abort if the system time cannot handle one of
 our timestamps
In-Reply-To: <xmqqr30i1omp.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1704241228510.3480@virtualbox>
References: <cover.1492721487.git.johannes.schindelin@gmx.de>        <cover.1492771484.git.johannes.schindelin@gmx.de>        <2b7f90c003a1f60ede39813530617edbbdf29607.1492771484.git.johannes.schindelin@gmx.de>
 <xmqqr30i1omp.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:60iRSE5eRgohv+PuNwcY/RQtB2ehPKIGGdBtio2QF5fPXvr1wmd
 cFpkWiHkWDTXGXb+Q4zLJ+5bYYmUnMtjbREClVP8u7JhZQSyHpBnoZzwnv68cNp26RlJwjo
 1DIDptrIwQCi34mlxlsktXQ2xkUvK/hQAJ5Ad2fPS00HEGw3ogRlft1oJKzpJHsPfK79nxT
 lne755ypjmIfMfz5pqW4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LXk8WJ49BcI=:3+hDCYrIiFw0IHpvRF/56a
 C8U2OkmCdcs2qq2DK1/xKnH+k2GuNlhxsFvHPRC0daXcAKcGXhOZX00oSiKaH/xjVUszlcGzh
 wUfAo7r6GzieCK5Db7LbeG70iAb8AVqn2DfivfTdA+liOkF6toAodXlXUA45bYzIRbHTGqvcq
 /YuYhrNnT6pCGE1w6Vxrg12z1mjmpvCFIBtNhpkVB2jbR8qvd9NfyuRsG/mdGi0e17mpULE0x
 5XOtM2ft8yhK+JKwhiemMeSL4n2jihn1pYLPSh4L9dMSdPcke+yeKH8Tg4YbAje34A9ajbhnD
 S1mVBhRTiYClczzgLhLG0t0hCqIvNKBdPGtmfeBI4p/RXZcYuEuyfvefzh2j6/vJ18OSSCvBi
 MQX/LJquAmKps839+FsUVzqsMKR0yEF8BGXqCAPmQv7gW+TbM0/+++Io2ht80tONBpJh2cWf/
 qXJt47TKp87y2XrR7eQcmhMhQAaHQQ+C6Vb9uNZcsZxuoDvve+S1NbVzFA7fPvmNCpGkapylU
 x+HbvS+PRIOdUGOcAH4jorEH0m+qBW6kfKFCMNT8Rv4zZ5EFQvb/MpkAIvuIeTXE+nWyvNyIe
 e/bMUXjWa/R/PjbCMLc/01/z5VHaviAod9ggjNNz2AtGtVKAr+hQzByg6LLXUX4/C3U4dZth5
 2yLl+VTByyaoD438QwPgMe1fkuJVSGH537ILmGoQ5cMmooBl11hS1C4J1MsYFXlCt1mgNXZrZ
 Tdlipf1OHp6uOVMawvoINKN78oSFvnhXUvkO6LNwY1HHMH5HiHhCFJ235jMTaWbOXTfclQvjn
 ex4yPNj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 23 Apr 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > diff --git a/date.c b/date.c
> > index 92ab31aa441..75f6335cd09 100644
> > --- a/date.c
> > +++ b/date.c
> > @@ -46,7 +46,10 @@ static time_t gm_time_t(timestamp_t time, int tz)
> >  	minutes = tz < 0 ? -tz : tz;
> >  	minutes = (minutes / 100)*60 + (minutes % 100);
> >  	minutes = tz < 0 ? -minutes : minutes;
> > -	return time + minutes * 60;
> > +
> > +	if (date_overflows(time + minutes * 60))
> > +		die("Timestamp too large for this system: %"PRItime, time);
> > +	return (time_t)time + minutes * 60;
> >  }
> 
> All the other calls to date_overflows() take a variable that holds
> timestamp_t and presumably they are checking for integer wraparound
> when the values are computed, but this one is not.

I was debating whether this extra check is necessary and had decided
against it. Apparently I was wrong to do so.

> Perhaps we want to make it a bit more careful here?  I wonder if
> something like this is a good approach:
> 
>     #define date_overflows(time) date_overflows_add(time, 0)
> 
>     int date_overflows_add(timestamp_t base, timestamp_t minutes)
>     {
> 	timestamp_t t;
> 	if (unsigned_add_overflows(base, minutes))
> 	    return 1;
> 	t = base + minutes;
> 	if ((uintmax_t) t >= TIME_MAX)
>             return 1;
> 	... what you have in date_overflows() ...
>     }

That sounds like uglifying the common case for a single user. Let's not.

The code would also be incorrect, as the `minutes` variable can be
negative, which the `unsigned_add_overflows()` macro cannot handle (it
would report very, very false positives, and it would hurt you more than
me because I live East of Greenwich).

Apart from that, the signature should use seconds, not minutes, or
alternatively multiply by 60.

I'll add a fixed extra check, to the single location that needs it.

Ciao,
Dscho
