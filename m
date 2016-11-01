Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAC0520229
	for <e@80x24.org>; Tue,  1 Nov 2016 21:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753833AbcKAVKo (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 17:10:44 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:35527 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754629AbcKAVKI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 17:10:08 -0400
Received: by mail-qk0-f180.google.com with SMTP id z190so213957569qkc.2
        for <git@vger.kernel.org>; Tue, 01 Nov 2016 14:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=I7ImTxVsSVRmknbmv/4XBSYkQKaCgjn21BrcaQ/WSGY=;
        b=iE69PUkw1+VsjqDk68HC6uRaJ89B2sq9D239SufpAvDf0w9m/Dkpy6iDQELG9zRJs/
         85wHIFNlrlIgdSSws+l7BbbR4VDMc/R71wYmmZFzMmFwA9bOObTrcTAE/SxWV3fL3RBj
         G/pLX6FyIgKXzfKfWQxk94UmoB8FxtAQ7U5UiZcL6iaNyfDsjv6o5g2fmX1lGVF4hQDV
         KgZvyXZwFRqdNPsx/adetjMyec001FD8Wx7YZQrJcyOaiTLZ6g7fRfIQC9OVvMs54vNR
         ljUb9bZkbkZ7aGzJMgvnsdT/DkgKj0Y/TuAPoaT93uj2HH470pEqDneXLZPyQO5QOw/e
         o5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=I7ImTxVsSVRmknbmv/4XBSYkQKaCgjn21BrcaQ/WSGY=;
        b=ErMIM2lgzyU56Vyl7ZBfrNUs9x0jh03Cgrwta0SOdEZhcyH/jh8DUCgYd+Cf05vRuk
         fLsEgx9EJctxduXlM10IlB8hdzRuM9NrGSwD7BNRSkZwKfMlGS4txXlOmGPOh3RrS5/T
         XXRySDOOWsJmlZWn4iL+oXd0Zjb9EPNt4blQAo4x1jhda6pnU/y+n3Rd1he98RSakzdO
         YLEgElGCtrxm9+POy1k/NzQmXB5kpyMQ4EO5HRR3jRQZa/t7BR+vO+ToQCMPzlj0Z8gp
         TRls/q+BjEURByW5HT+pB3QX2Sd/Yk7uI3c+SAUQyZs+eWfL/8cGgfnUQ5P1NnceXN6K
         L1YA==
X-Gm-Message-State: ABUngveA78PQe1BhTN59XEj0Z95Hfmon82IYbt+3E/ZTZSDtkAQsYL7wl+lMX3+yl2Jr/SgH7k1l09t82frbvS80
X-Received: by 10.55.64.80 with SMTP id n77mr8045qka.173.1478034606886; Tue,
 01 Nov 2016 14:10:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Tue, 1 Nov 2016 14:10:06 -0700 (PDT)
In-Reply-To: <20161101205916.d74n6lhgp2hexpzr@sigill.intra.peff.net>
References: <xmqq1sywrxxl.fsf@gitster.mtv.corp.google.com> <20161101203637.3jr73wwpfal4brho@sigill.intra.peff.net>
 <xmqqlgx2or5p.fsf@gitster.mtv.corp.google.com> <20161101205916.d74n6lhgp2hexpzr@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 1 Nov 2016 14:10:06 -0700
Message-ID: <CAGZ79ka6un7nHaNk3F8yp3vFSnB-iGapqLcZ-ZC3EvcKE4DMNQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.11.0-rc0
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 1, 2016 at 1:59 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Nov 01, 2016 at 01:56:34PM -0700, Junio C Hamano wrote:
>
>> > As of -rc0, we have both --indent-heuristic and --compaction-heuristic
>> > (along with matching config), and they are mutually exclusive.
>> >
>> > In [1], Stefan suggested just replacing the compaction heuristic
>> > entirely with the new one (and you seemed to agree). If we're going to
>> > do that, it makes sense to do so before the release, so that we don't
>> > get stuck supporting --indent-heuristic forever.
>>
>> You meant "compaction" in the last part?  I think it is probably a
>> good idea.
>
> I thought the plan mentioned in the mail I linked was to keep the indent
> heuristic, but simply _call_ it the compaction heuristic. IOW, to swap
> out the implementation under the hood for something we know is better.

AFAICT Michaels design is better in every aspect than what I did initially,
so it supersedes the work I did there.  I would support the swap in names.

>
> We've already released a version with --compaction-heuristic, so we are
> stuck keeping it forever either way.

IIRC the release notes specifically noted this flag to be experimental and
may be removed in future versions.

When not doing the swap of the implementation, but rather remove the
experimental feature of compaction-heuristic and introducing a *new*
experimental --indent-heuristic, this may drive the point across that
these names are actually experimental.
