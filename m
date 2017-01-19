Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 981DF20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 22:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751947AbdASWEe (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 17:04:34 -0500
Received: from mail-it0-f54.google.com ([209.85.214.54]:36603 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751498AbdASWEd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 17:04:33 -0500
Received: by mail-it0-f54.google.com with SMTP id c7so7111872itd.1
        for <git@vger.kernel.org>; Thu, 19 Jan 2017 14:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bqv+lLiPgjExFOFM1HWQbzMipKgYGRLaYhfHMY1WE24=;
        b=vWmBDoYzRv34fyf71BlVzeSvwzeFbBTePm+ZUernRsR4S/jBEPwLMoi3kWKmx7e6Pu
         cmJ3dK4s9gH4CE9l64aouD6JN7IdgvscapSJSbSidN5bLlRLxPUm7bo80iZcmnpItE6W
         4dTFDx93l6+12NDRq+Q0k96iYTignm6tliktCUIR31d8JUMvlIgEjZs8Ck8VUemM+0Zc
         uB6lVe+NNqpDdiMMiXcCm1Io1xOGYjoCCHzgGN05J12JWverWFB3SEn2CTKu7RRdyWrc
         /Qd7tV47wZG51OoQ7foUztvDUXkpIbjQQ1xE/J6MQx3fLay0zOXGxCbV1PItFnBI69dk
         sz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bqv+lLiPgjExFOFM1HWQbzMipKgYGRLaYhfHMY1WE24=;
        b=gSPvMQgvjJtmyzDB+i7vHa2fybtxJJZ5mGxkEfx7E7jfrKDYej14ahKdfFWKOkYyIE
         jeTfmCXQ+26r3rvNcgt2SLT44LfFrfnhs0QSLzrqLph5prfyQKRcZzK/fp12E0K89TsV
         OSlv3g2BcKaTr/lot550CccG9INfax3Uuy+NpVP8t5kTgLe5PLIb6YYzl+tcZjSs0mMK
         BkD/HZKxX9yr64HXcHYcvatPgvtiZ3d+cl/h5IFrhUyJlUQWrR+wE7K0Z6RvcyEfdKPM
         X5JQBf/9tMhK96ROqGdURgB0jE4vOH86briIYwCmltsoy20w9a+I5AswcTYFKzOngsFI
         g2LA==
X-Gm-Message-State: AIkVDXJlGH2BK9CCeZ6fW/oArg9/gTfHjfOGH+utgrAizCBq00951vWc2Ir10ttOExo3UMZoGN2Gus+0wKxcJWlJ
X-Received: by 10.36.169.12 with SMTP id r12mr769964ite.69.1484862951602; Thu,
 19 Jan 2017 13:55:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Thu, 19 Jan 2017 13:55:51 -0800 (PST)
In-Reply-To: <xmqqo9z2zs2o.fsf@gitster.mtv.corp.google.com>
References: <20161228180205.29213-1-sbeller@google.com> <20170119202941.6575-1-sbeller@google.com>
 <xmqqo9z2zs2o.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 19 Jan 2017 13:55:51 -0800
Message-ID: <CAGZ79kam9ACf+xa3nvHT2KYqPR6qPM4ohKt7gtEv21-rmBdEuw@mail.gmail.com>
Subject: Re: [RESEND PATCHv2] contrib: remove git-convert-objects
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 19, 2017 at 12:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> git-convert-objects, originally named git-convert-cache was used in
>> early 2005 to convert to a new repository format, e.g. adding an author
>> date.
>
> I think this description is not wrong per-se but misses the much
> more important point.  In the very early days of Git, the objects
> were named after SHA-1 of deflated loose object representation,
> which meant that tweak in zlib or change of compression level would
> give the same object different names X-<.  This program was to
> convert an ancient history with these objects and rewrite them to
> match the new object naming scheme where the name comes from a hash
> of the inflated representation.

ok, in case I reroll again, I'll fixup the message.

>
>> By now the need for conversion of the very early repositories is less
>> relevant, we no longer need to keep it in contrib; remove it.
>
> I am not sure if removal of it matters, and I suspect that we saw no
> reaction from anybody because nobody thought it deserves the
> brain-cycle to decide whether to remove it.  I dunno.

I do think removing this would improve contrib/, not just because
it would better align with contribs mission statement in its README, but
also for other reasons. Why would a user look into contrib/ at all?
* to find interesting contemporary bits and pieces
* if they want to find old stuff for educational purposes, they ought to
  be looking into contrib/examples instead.

So maybe instead of this patch, just move it to the examples section?
(That way we archive the same goal: a cleaner, fresher contrib/
that doesn't look as stale)

Thanks,
Stefan
