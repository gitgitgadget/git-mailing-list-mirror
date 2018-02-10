Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E11F1F404
	for <e@80x24.org>; Sat, 10 Feb 2018 19:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbeBJTbl (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Feb 2018 14:31:41 -0500
Received: from mout.gmx.net ([212.227.17.20]:51411 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751622AbeBJTbk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Feb 2018 14:31:40 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx102 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 0MMpYB-1ec5Ll1Uyd-008YeN; Sat, 10 Feb 2018 20:31:34 +0100
Date:   Sat, 10 Feb 2018 20:31:33 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 5/8] rebase: introduce the --recreate-merges option
In-Reply-To: <xmqq607sgway.fsf@gitster.mtv.corp.google.com>
Message-ID: <nycvar.QRO.7.76.6.1802102030570.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de> <xmqq607sgway.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:lXbXtTGjx9z1XeDNCXdudBEEa/6J7UJ4Kp0g4BurnjhuLthlV8g
 BLPDq+IqwI8bL/o/IpudbO24YUATlGw8RhGCG0B0DqDgfRaC62phRAe0d+58lrSRxP6nDIz
 FQAFoRqRNIfVXlaaCIblmdXJUkhJVBCgQRNv/crW6HWMb1PuFSvXjDo3szn6g3ZQ63bUwH4
 Vc32xHKUrsGKu+EVo88fQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OCu9PuZ99/A=:2zwIIuYTUwDe9qth4VGA5p
 cTuuJCmnQeX+19ma+RbJ++ZWJpbtRQVQJUusCFF7ZA+GeW6Ay1A4XtAWnkVVPFJPtbwHPeFSM
 aV38NShRJ259Kptsm9mNs4bceAY/eQqLnphN/8VMGWbFi6RbCxD7nIgBMeZcDpJBpuz53zl6E
 ucev/LsO3Zd9L/iBliSNq5EbW9XCoYnJNDB2NPmArLu2UPJ/gUMGGFRrs3muj1RHu84PutTQQ
 zWg+THMeSCd0WppyP8LFf/kFUWZ3B0r9FpDePUIl1PBLu/afEtIT9hskpIS7ytLPzgCzIspxh
 tCjbVke4lCooo13OGIOsbCcSdoHNnYINLw1z5eccGLgQH9DYQdXSv8sXXswZarChRwtAOnuo8
 z5Tevnln1Ao7nvLmbpXyRmHPim5PGbz4RLQQLLlLib7qRx8kaYz2i3eErke21BvFS/t1bTv/X
 a+4N811RfoY6A3I4uQmXO5wX8nCCl9pRgG6aY6we91qov2k2YxxLw2sWWiOqSs3FWhNJIdaHx
 q+c+vbei2Vh5plEodoEaZHw+8MOzJYvMQuu6JnWfGo7ocIUOfdaLw2egDw8ef6lbHJ2WdchK0
 fQ7mx9ghkCjaAL+WVsOGm05VKyENqcZaSgBkS3ydB6tZUIY0vt8vFa++XA/mHj+J4kVjofDET
 ugDGBHEEkFLOXX7SEJE5wK2mYj/KkoP76LwGTSStgR5wvJTnNGlGYf4NoAi5w2BCpk3vYpdtg
 +pPvgz8CqJhtcFKwmX9yciQMPiKuJfj0DDOOrN/5DC6zuFFXQx4b7RZ4mN6QHOoKK+T3BTsBN
 IPnlf3tbUJleTKRGfK5gRkuWdJrwgEDfj9mSV5ZLMWUXQQolJs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 23 Jan 2018, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> > index 8a861c1e0d6..1d061373288 100644
> > --- a/Documentation/git-rebase.txt
> > +++ b/Documentation/git-rebase.txt
> > @@ -368,6 +368,11 @@ The commit list format can be changed by setting the configuration option
> >  rebase.instructionFormat.  A customized instruction format will automatically
> >  have the long commit hash prepended to the format.
> >  
> > +--recreate-merges::
> > +	Recreate merge commits instead of flattening the history by replaying
> > +	merges. Merge conflict resolutions or manual amendments to merge
> > +	commits are not preserved.
> > +
> 
> It is sensible to postpone tackling "evil merges" in this initial
> iteration of the series, and "manual amendments ... not preserved"
> is a reasonable thing to document.  But do we want to say a bit more
> about conflicting merges?  "conflict resolutions ... not preserved"
> sounds as if it does not stop and instead record the result with
> conflict markers without even letting rerere to kick in, which
> certainly is not the impression you wanted to give to the readers.
> 
> I am imagining that it will stop and give control back to the end
> user just like a conflicted "pick" would, and allow "rebase
> --continue" to record resolution from the working tree, and just
> like conflicted "pick", it would allow rerere() to help end users
> recall previous resolution.

This is my current version:

--recreate-merges[=(rebase-cousins|no-rebase-cousins)]::
        Recreate merge commits instead of flattening the history by replaying
        merges. Merge conflict resolutions or manual amendments to merge
        commits are not recreated automatically, but have to be recreated
        manually.

Ciao,
Dscho
