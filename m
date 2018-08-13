Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B1661F404
	for <e@80x24.org>; Mon, 13 Aug 2018 18:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbeHMVdD (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 17:33:03 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:39127 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729984AbeHMVdD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 17:33:03 -0400
Received: by mail-ed1-f54.google.com with SMTP id h4-v6so8793126edi.6
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 11:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=/CnPx1RcERKVzbeIv4/8fNRMD31+vYg1vIAnLzacad0=;
        b=IAseUgmcEfp+XK0aXNvl+fxv9uK9j+myQvXyOR4qXxHfqpoDe9G3MHKl81xx3Gff0S
         85/yHdI0ZbpdYU1YY0s5IcTVg4ZDOJQDSFvKYOstZSzl1LAD9Lop40JREaa3kUkmOWvu
         NwjpdSOwzgdiexAs5Z2L6Laafb5S9tE3IjBTrZmIhHBvaC+LHJV0I774y73inZC0F73X
         hBaOAYdfjyqPeVy7Pj6U2YucLuKHgAxzT41ZljwQ3LkW1tVeoPXv+lB0Ve5qjEnPEa9G
         Ku6hvjq8gDD/tSCNvsq2BaQjG3J8jj4QaTPmnRPkQpNqbRFJcD6KD4RgziaIAapRYykB
         Bzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=/CnPx1RcERKVzbeIv4/8fNRMD31+vYg1vIAnLzacad0=;
        b=njDImwUnopCyFd5sd1VSJ6Xje216ImB5eCYE4P/pVAHLSLmBwCGPVOCRMM6kJKc/R1
         p8CvjSgFHcX7UcE9hA5hZHfB23laRRN37ZRLBcYUQtbT+5rKD+McedVNsipr+jRTxwPQ
         ydopp+9vXv1zYQlyAtGW9YT8J3zdJ9BJLydVy2GNAhPjYb1CYSxJGov4NoMo+qZcknDl
         6z5m3f5rnU+9itRpVG2ha2gEKNs/6TrzQ/yvscFE03RiUvc4dBcPcRqrFXPwtjw2JqE+
         a1NR0SlQrvl3gPyZeXzFM5TUuOLj/nzv0abjVWTJ6RiPTUXqD/atrJ/COIY1IHM3Onl6
         O3pw==
X-Gm-Message-State: AOUpUlEwMfjX+0QUcGUfTs/grvQ3MJfHTSYhjlK+gvIEbTShwf6RTAEh
        JYR0+UPQ2+dnlDr+y05giiY=
X-Google-Smtp-Source: AA+uWPzZfbr+PQuuUkyfzlREiGE68J3zkbRUxjnFAx+mnNuTahDeS7vvrbJKrNV/uFvITd922IIg6w==
X-Received: by 2002:aa7:c6c2:: with SMTP id b2-v6mr22904895eds.302.1534186175069;
        Mon, 13 Aug 2018 11:49:35 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id x7-v6sm16512562edm.23.2018.08.13.11.49.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 11:49:34 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: Contributor Summit planning
References: <20180813163108.GA6731@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180813163108.GA6731@sigill.intra.peff.net>
Date:   Mon, 13 Aug 2018 20:49:33 +0200
Message-ID: <87h8jyrtj6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 13 2018, Jeff King wrote:

> For the past several years, we've held a Git Contributor Summit as part
> of the Git Merge conference. I'd like to get opinions from the community
> to help plan future installments. Any feedback or opinion is welcome,
> but some obvious things to think about:
>
>   - where, when, and how often?
>
>     Plans are shaping up to have Git Merge 2019 in Brussels right after
>     FOSDEM in February (like it was two years ago), with a contributor
>     summit attached.
>
>     Are there people who would be more likely to attend a contributor
>     summit if it were held elsewhere (e.g., in North America, probably
>     in the Bay Area)? Are people interested in attending a separate
>     contributor summit not attached to the larger Git Merge (and if so,
>     is there any other event it might be worth connecting it with,
>     time-wise)?  Are people interested in going to two summits in a year
>     (e.g., Brussels in February, and then maybe some in North America
>     later in the year), or is that diminishing returns?
>
>   - format
>
>     For those who haven't attended before, it's basically 25-ish Git
>     (and associated project) developers sitting in a room for a day
>     chatting about the project. Topics go on a whiteboard in the
>     morning, and then we discuss each for 30-60 minutes.
>
>     We could do multiple days (which might give more room for actually
>     working collaboratively instead of just discussing). We could do
>     something more formal (like actual talks). We could do something
>     less formal (like an all-day spaghetti buffet, where conversation
>     happens only between mouthfuls). The sky is the limit. Some of those
>     ideas may be better than others.
>
> I hope this can stimulate a discussion on the list, but of course if
> anybody has private feedback about past events or future planning, feel
> free to email me off-list.

A few things, in no particular order (also in-reply-to the thread at
large):

 * Yeah these are really useful. Let's keep doing them!

 * In terms of how many per year & location, I think it's most
   interesting to listen to take feedback from top contributors[1] and
   check why the people who consistently don't come don't. Whether
   moving it to any other location would be useful for them, or whether
   they're generally just not interested.

   I.e. there's some Venn diagram to be drawn here of people who'd come
   no matter where it's held, people who'd only come if it's held at XYZ
   location etc., and likely time is going to be just as important for
   some as location.

   It would certainly be interesting to hear what would make Junio turn
   up again, or Nguyễn etc.

 * I think we should tread carefully when it comes to say some form of
   remote A/V participation open to the Internet.

   It was fine to have Dscho on a chair, but it would be quite different
   if this were say streamed on YouTube and everyone felt like they were
   on stage the whole time, and if offhand comments / jokes etc. were
   recorded.

   I'm not categorically against that, it's just something to think
   carefully about. Maybe if there's demand for it we could dedicate
   some time slot to that.

 * Re the second half of "Not everyone can travel or can afford to do
   so" from Derrick, there's been travel sponsorships in past years.

 * In terms of timing, we've had cases in past years where some topic
   (say large binary issues or large repo performance) was discussed at
   some length in the contributor summit, only to be followed by an
   announcement in the general conference (in this case LFS & GVFS)
   which was clearly under embargo before the talk given at the
   conference.

   I've said something to this effect before, but it would be nice if we
   could think about some solution to this. I.e. should we always be
   holding one contributor summit right after (not before) git merge, so
   that we're not pointlessly discussing some area while representatives
   from some company or other have to not comment and say "we have
   patches for that"?

   Or would those companies be OK with trusting that some 20-ish of us
   can hold our tongues for one day and not ruin the surprise?

   There's also overlap with the remote A/V concerns there. I.e. an
   acceptable compromise for those companies might be to talk about
   those features freely in the contributor summit trusting that it's a
   closed forum, but that wouldn't work if it's going to be broadcasted.

1. git.git$ git log --pretty=format:%aN --since=2018-01-01|sort|uniq -c|sort -nr|head -n 20
   [...]

   (Yeah this is just git.git, we'd want to do some union of
   "contributes to git ecosystem at large" for a proper list, also
   number of patches is only a fuzzy metric for contributions blah blah
   blah)
