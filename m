Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A752C1F461
	for <e@80x24.org>; Wed, 17 Jul 2019 07:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfGQHCk (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jul 2019 03:02:40 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:34378 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQHCj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jul 2019 03:02:39 -0400
Received: by mail-ed1-f53.google.com with SMTP id s49so24015580edb.1
        for <git@vger.kernel.org>; Wed, 17 Jul 2019 00:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b9OMIJ7xfbcfBNbY/eOutZB+L5aAEU3qKy5rEk5XtLc=;
        b=kfz3xSXNZGv8U/a92zwLPpIOpMLMSy06ER54AkVIk/Cdh4xJHRj1Zu5JUeHHSYC22b
         TXNEr5Tfn3MuITwsBlzliucauBdYN0rWTJNrWgLeC5METOU+UCDtOUbVG4G4Fu9f+hxM
         3/M42OiOF6s4kWw8FmaQkBG4qkUbK2SYFmE81Vjhx1qxG1U+5Rkse/gPMbi1AoAeeE24
         XjknTIXkpPi1XF4xKdFu8Wb2GrYgH2CJiT1AH4FSzp0oDdJ0HX74nCDu4ni1qpfQn/wp
         Ak373tF6gz7vzMRIDHU20mBp4T5wwWW5Be0LVFPJ28BFqKDt59/rewyGhbkczKT/3204
         WMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b9OMIJ7xfbcfBNbY/eOutZB+L5aAEU3qKy5rEk5XtLc=;
        b=YCAqVtw9Rqug44KUKHnOZyolWftc6/VU/7rdifzRvlgXhm5x/DBZ/aIHZfM473mbeX
         eaq2HYKYBbVDoxNVpFN2kByQOSJ+zlVE+k0nASiCHYw6TIL6gV64VqyzF2Hbnmh+Plpg
         8dw+ONDJIuEGVyDHXHiim9Z6lwyEmUWtpZBvqIEQcWIwTAhWUNChusdQeihH2b9A9kI1
         1OmP+UKoUcE6cqwLmuxWX2Nr0lhakffZeMgCIgLO8pS5h9Ctu3Ero58lXquXSdUmAYDM
         bip9Tno6Zn9EBuBIFRgGJTvrUZhrglWXN0HwJ0oz7PLD35FH93ZVYx+4N2IYWIQSlPXn
         yZLA==
X-Gm-Message-State: APjAAAX7CCzt0IKcTf1Ab+lk76uOL/LncSSYmwzZaDmMPmPJ5NVIN/ve
        bL5rVb4qhzWW8fVGy/y5aaHCvdnxeXC5F61KGQo=
X-Google-Smtp-Source: APXvYqw6LtkUsIb7BHhSFfXCfWt0+IxcvFizTFPVvc3r6dQ8vfPYPYKwIOOMtDYev1MX0jpA8seR7JqUZiAefqkIdnM=
X-Received: by 2002:a50:d1c6:: with SMTP id i6mr32814560edg.110.1563346958176;
 Wed, 17 Jul 2019 00:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq8st3otj7.fsf@gitster-ct.c.googlers.com> <20190714231558.GA24609@comcast.net>
In-Reply-To: <20190714231558.GA24609@comcast.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 17 Jul 2019 09:02:26 +0200
Message-ID: <CAP8UFD17pUNrDMQF1vRqaJiyhCn1Y+FkaTzp2V-sruW6nxzq5A@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2019, #03; Fri, 12)
To:     Matthew DeVore <matvore@comcast.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 15, 2019 at 1:16 AM Matthew DeVore <matvore@comcast.net> wrote:
>
> On Fri, Jul 12, 2019 at 02:02:52PM -0700, Junio C Hamano wrote:
> > * md/list-objects-filter-combo (2019-06-28) 10 commits
> >  - list-objects-filter-options: make parser void
> >  - list-objects-filter-options: clean up use of ALLOC_GROW
> >  - list-objects-filter-options: allow mult. --filter
> >  - strbuf: give URL-encoding API a char predicate fn
> >  - list-objects-filter-options: make filter_spec a string_list
> >  - list-objects-filter-options: move error check up
> >  - list-objects-filter: implement composite filters
> >  - list-objects-filter-options: always supply *errbuf
> >  - list-objects-filter: put omits set in filter struct
> >  - list-objects-filter: encapsulate filter components
> >
> >  The list-objects-filter API (used to create a sparse/lazy clone)
> >  learned to take a combined filter specification.
> >
> >  There is a bit of interaction with cc/multi-promisor topic, whose
> >  conflict resolution I have no confidence in X-<.  Extra sets of
> >  eyes are appreciated.
>
> Sorry for the delay. I was on vacation and then catching up for a week after I
> got back. I uploaded a merged commit here:
>
> https://github.com/matvore/git/tree/filts
>
> And the merged file itself (only this one had conflicts) is here:
>
> https://github.com/matvore/git/blob/filts/list-objects-filter.c

The merge and the explanations behind it all look good to me.

Thanks for your work on this!
Christian.
