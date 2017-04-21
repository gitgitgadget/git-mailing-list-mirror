Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8A9A1FE90
	for <e@80x24.org>; Fri, 21 Apr 2017 10:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1037662AbdDUKo4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 06:44:56 -0400
Received: from mout.gmx.net ([212.227.17.22]:62031 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1037648AbdDUKox (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 06:44:53 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MOkQc-1cymlD1Dew-0063EI; Fri, 21
 Apr 2017 12:44:41 +0200
Date:   Fri, 21 Apr 2017 12:44:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3 0/8] Introduce timestamp_t for timestamps
In-Reply-To: <xmqqpog647of.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1704211219460.3480@virtualbox>
References: <cover.1491159939.git.johannes.schindelin@gmx.de> <cover.1492721487.git.johannes.schindelin@gmx.de> <xmqqpog647of.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:SbdoNJ5bKc4pOklnUebdIVWZ92xn0eM0icc5CJtuhJs5XYo42vI
 8N96jZ2JHlKZWOjedINvJjUlNnYCIa/HfcxF/5fmPSNrE11i3fC0UqtiIfF0/WL4CsHrzw6
 kkep87Lj3OpuJ6ojJ4CaojXHSRGzAkmu2pmhejAyEQBOyTHVu7+l1+uFLgL3JcXw0z/oMBq
 5LI2JBc+php2cUZvekzQw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mJ9UC+UnaYE=:DauCmMiacuIzTFpfbJt9a3
 1sXqc8qquoLaEDfSi14KQyWExzWiH1i6Jo4SnlwL3rfej0f3jvp0SR2bbiNANpnlWlrTDrKhA
 NlvfchH3yNis3WLFPfW8LrILlOUB1R82wGJOAWqwqoIATpf1zfEt9PawvzswBS2zYQ/CBFAWh
 4Ty7bJjWVWqb34nCFyGUYbyaIKnplYtYbxzaeJHU5pzqONH1ZN6vfKGt4+Wh75i8vWyrIbRqR
 X6RfSQ3c+OMJUFKDMww/LO4ID/KZUt+FXxHDb3qqHVoxiQoaUkTekwVuV7oshfC0xNywpQbd6
 s2zc1bRsAqZ4YtrqiYZzMa2Ssu+sy97avZg04YtyLWsbQjGqCjF1uGQymUxH6jotd25AwoEMi
 QWFdIygFmwNXZSR0Uz82lKaUlsiMGQxH9fdrUjR8zcO0Zx4MSvzjns5dYCqyyZnzom3ULAgvq
 c8M3+eDYBFJ57BbZ1FXTH7y4QSnHrJZEB3AqiAYB4eKKo4oPxSbuCkLflifarDjfl8gCDqAxd
 lNYD7nQuIApGtkjKO2uMKDt7+K93TvbZ2Qt+QOU45KLfKe4LlZ9IDeMLcJGgOi08nygi8rcLY
 Pcrg/+abJkW9ivWZUXYlUQcicSKVrfqilneE7Ou/HC9tP3kHD2RGVP1KWzD+CqQ5MbttodZWk
 Dv/THNOzVGVsfNYOOtLyOHP0PldEiCvs6ZA1HYYhC8vBY6w3jwzrQlCx7JVOYF0wufE6KUwT9
 ss4tY/bp1BRQ3p3jAFjdKLmSXlRg7f+fOFlb/8dTsgPpU2lO3e44yf9DrITPOb+lSm5481ZGD
 xefKa4q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 20 Apr 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Note: while the `time_t` data type exists and is meant to be used for
> > timestamps, on 32-bit Linux it is *still* 32-bit. An earlier iteration
> > used `time_t` for that reason, but it came with a few serious
> > downsides: as `time_t` can be signed (and indeed, on Windows it is an
> > int64_t), Git's expectation that 0 is the minimal value does no longer
> > hold true, introducing its own set of interesting challenges. Besides,
> > if we *can* handle far in the future timestamps (except for formatting
> > them using the system libraries), it is more consistent to do so.
> 
> I somehow had an impression that the list consensus during the
> discussion on an earlier round of this series was that time_t is
> more appropriate, as platforms with time_t with inadequent range
> will be updated before it gets too late at around 2038 (or they will
> die off).

There was this sentiment, but that would require a change in Git's source
code where it can handle unsigned *and* signed data types for timestamps,
and that was too much of a change to bring in that late in the patch
series.

Besides, supporting a signed timestamp data type is a separate issue from
trying to support dates that are insanely far in the future.

> After all, at some point we need to interact with the
> platform functions that expect time_t as their interface and they do
> not take our own timestamp_t without casting.

No, not necessarily. When we generate a .zip archive, for example, we may
never need to parse or format the timestamps. When we log with a format
that does not require the system routines to format the date (e.g. Unix
epoch). And when we do not parse nor format the timestamps to begin with,
e.g. fetching and pushing or committing.

It is *only* when we try to parse or format timestamps, *and* the system's
time_t is not large enough, that we run into trouble.

This is an improvement from before, where we would run into trouble
whenever time_t was larger than unsigned long, *or* whenever time_t is too
small for those timestamps.

Your comment, and my reaction, reminded me that I had planned to look into
all calls to date_overflow() and remove those that are now unnecessary, or
at least move them to the place where they are absolutely necessary.

> But that is provided if not introducing timestamp_t and using time_t
> results in a simpler code.  I do not know if that is the case.

As I had pointed out in my reply to Peff: removing the assumption that 0
is the minimal timestamp is something I am unwilling to tackle, it looks
way too fragile/dangerous to me to do this in the time I could allocate
for that.

> For timestamps in the distant past, even though time_t could be
> unsigned, I do not think anybody came up with a concrete example of a
> platform with such a problem during the previous discussions, while I do
> recall people wanting to use Git to store historical documents with
> timestamps before 1970.  We do expect 0 can be used as a sentinel, which
> needs to be updated once we seriously start supporting such use cases.
> I think that (i.e. should the timestamp be signed?) is more or less
> unrelated to the focus of the discussion that stemed from this topic,
> which was "ulong that is often 32-bit does not necessarily fit the
> notion of time on a platform, which is time_t, and we need to widen it",
> which all involved in the discussion agreed.

If anybody feels strongly enough about representing timestamps earlier
than the Jan 1 1970, they should feel very welcome to work on this.

My patch series would make that task slightly easier, even.

> In any case, when merged to 'pu', this had a slight conflict with
> topics in flight in builtin/name-rev.c and I think I resolved it
> correctly, but please double check.

I double-checked, there were just two conversions from `unsigned long
taggerdate` to `timestamp_t taggerdate`. I repeated the merge with my
latest iteration and resolved them the same way as you did.

Apart from the date_overflows() changes I mentioned above, I also fixed
the problems identified by Travis CI and VSTS Build.

v4 is coming,
Dscho
