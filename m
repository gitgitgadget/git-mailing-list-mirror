Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18475202DD
	for <e@80x24.org>; Mon, 30 Oct 2017 18:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752857AbdJ3S3j (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 14:29:39 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46027 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752636AbdJ3S3i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 14:29:38 -0400
Received: by mail-qt0-f193.google.com with SMTP id p1so17637137qtg.2
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 11:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9TeD/S70S2DWuTwR820ViA1xrBKWqqsq7oAOo32WA7A=;
        b=bqC2uiBX6mh5FfqHfJa0EY82P0iU2XiTOqjyWtvOp3fuF+X2Vq4t1tNDxngMngZMrF
         hSdxefVuViW0ygNsV7EjubCh9VFlMctZz4LsY34XnRwFguQ6wneAyryeU9jPHSel+Uwg
         MQPoCaLwZBZEJHrUrFBYvQSjrtBFHwnFmvrWdxZ5imkUTL9PudzNSIsUmypd8b0V5z+q
         oKARSzhE9XacOwObg7Fe9y6dCE/CDcE98M8Lq6jobbV65j9YXkrvDTgrLoZbfLEO+EYD
         hpNsx1VTUquQrj/FHWFYJ44tF9Ouazl5estkRPDsTZJY2H91KrwBVWWks1ac+nMPjXs0
         O+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9TeD/S70S2DWuTwR820ViA1xrBKWqqsq7oAOo32WA7A=;
        b=PHe261WkP75zGrOYWN7VqUGu23sjKsmeHYv516mEL5Fqxwupx3uEaMBeR3SpLUfi0y
         nNolev0CLKzZ/evZSCehHwsKOicechKoU8LWfhHlFmOYG1lESp3Yu4GVOWZqg3+S2HDu
         1huKqOtZ7QqrLeHjK0T6SUyWkF1hut6CwynRRnuMfbyxbVAL9eAbs6a1LppEkytJWH4h
         ei+HJhyier0zoty/JGEg+JUcw915j8Ef0cdWSJWSom3bPTMm4mpzf3ww1gScEKdiVzq9
         1/rJtxyqjnu7tOzJS8u7L3tP9tmDMDXSYAn1qy0S0t1tzHurdhUU7k9oS49rCOm610vO
         lGKQ==
X-Gm-Message-State: AMCzsaWl+8Zt+zqXXI1smjXq0IoabryYByZB2+ujPOpOqJYGPKe9WwmO
        a4JWb3Kep/YUPmuhuq7RoHu+RHtG2L1z2nDe2/McGA==
X-Google-Smtp-Source: ABhQp+TeMOeh7zx6+IcYl2LZ2AcZoqlMXixe1bY42ATIG4SDJGOSLW8cGDFuJ+zl+qJJLoz2XMSgRbdvN5VVs1tQm5o=
X-Received: by 10.237.37.132 with SMTP id x4mr13465928qtc.224.1509388177931;
 Mon, 30 Oct 2017 11:29:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 30 Oct 2017 11:29:37 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 30 Oct 2017 11:29:37 -0700
Message-ID: <CAGZ79kbHwXpWXhUkokA9=XGN9D1YZevO_8MhbOztMXpkkHMFbg@mail.gmail.com>
Subject: On the nature of cover letters [WAS Re: [PATCH 0/6] Create Git/Packet.pm]
To:     Jeff King <peff@peff.net>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 30, 2017 at 11:08 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Oct 23, 2017 at 01:26:41PM +0100, Philip Oakley wrote:
>
>> > Totally offtopic, but is it only me who finds these "section
>> > headers" in cover letters from some people irritating and/or
>> > jarring?
>>
>> Personally I find that, for significant patch series, that clearly breaking
>> out these distinct sections is of advantage. At this stage (the very first
>> patch 0/n) there is no specific conversation, so the subject line is a short
>> 'hello' to the topic, and then the contributor is (it is to be hoped)
>> setting out their proposal in a clear manner.
>>
>> So I do like these headings for larger series, though there is some
>> judgement to be made as to when the subject line alone is sufficient.
>
> I can live with fancily-formatted cover letters. BUT. I would say if
> your cover letter is getting quite long, you might consider whether some
> of its content ought to be going elsewhere (either into commit messages
> themselves, or into a design document or other place inside the repo).

I am of the opinion that in an ideal workflow the cover letter would be
part of the merge commit message. It may even be editorialized or
annotated by the maintainer performing the merge, but not necessarily so.

Currently I rarely pay attention to merges, because they are not exciting
(in a good way). I mostly know the texts that Junio puts into the merge
message[1] from the cooking email, and otherwise there is not much
information added there.

However looking at *what* Junio puts there, is "why is this worthwhile
to merge from the *projects* point of view?", whereas the cover letter
most of the time talks about "Why the *contributor* wants this merged".
Often these are subtly different, so it would be nice to have these
two competing views around.

[1] e.g. cf. da15b78e52 Merge branch 'jk/ui-color-always-to-auto'

>> As a separate follow on, one thing that does annoy me is that in subsequent
>> versions of the various patch series, folk tend to drop all explanation of
>> why the series is of any relevance, leaving just the 'changed since last
>> time' part. This means that new readers who try and pick up / review /
>> contribute to a series later on in its development are not told the purpose.
>> When the list is active it can, accidentally, do a disservice to the
>> potential contributors who may feel that only core contributors are able to
>> contribute.
>
> I actually have the opposite opinion. I find it annoying to have to wade
> through the same unchanged content for each round just to find the
> little snippet of "here's what's changed".

Would you be happier if the "What changed?" goes first[2]?
Though I think whether to just reply to the previous version, put an
explicit link or copy the cover letter verbatim from last time is up
for discussion. I tent to think a link ought to be enough, because
those familiar with the topic would not follow it (so they have no
additional burden compared to direct copy), and new comers to
that topic may be ok with links .

[2] I tried following that style, e.g.
https://public-inbox.org/git/20170630205310.7380-1-sbeller@google.com/


> I don't mind following a link to the previous iteration to read the
> back-story if I wasn't involved (it's a good idea to do that anyway to
> see what previous reviews have already discussed).

Such a back story would make an excellent merge message, too,
as it explains the big picture more accurately, often shows
alternatives considered etc.

Stefan
