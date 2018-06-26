Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C1D01F516
	for <e@80x24.org>; Tue, 26 Jun 2018 11:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934482AbeFZLHx (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 07:07:53 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:41332 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934074AbeFZLHu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 07:07:50 -0400
Received: by mail-qt0-f171.google.com with SMTP id y20-v6so14696212qto.8
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 04:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9zfOXEEVVuYmn3ApvhK5g/Jiz445wJ9H35fE7lEUE44=;
        b=Q1i73thdhq7k9q+QbG03mllANw3wjeIWceVRO5Rxqt880Vb6wh7IUxgAZaS8sAny1g
         vQUQbnM+E4xk+kVpBWUzZDpz6Qdu/lMwD/HgGkNiJQa58IXOzGBP7pHwrBKg8Puf6ZJ3
         2ASpODZIl4Ft4YUWAeADG91tLpzlyR4ZwTTTB3zUQf1yr5gSbAcl64EbrowP/EqZY7zG
         WuMn0Vv2+XuBJ00tajnlIqIaKDcEERTHmHOpB4VBwdYMej9Ix8oEXsuMW+57BWbRQFex
         VpJkW2UEy4E9/lkn9kNr7oSTjU2dgreATXjFqFjoUMHZVIFOR6wFRlerP38BRn4vq8Y5
         yu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9zfOXEEVVuYmn3ApvhK5g/Jiz445wJ9H35fE7lEUE44=;
        b=GZcIg4Rne+ulYWuzXZrwOQkAuovNaVwOCM4etD5M8bXWiutNCNQLv3eHMVqgDYiVOv
         lCzWvaW74bXaQKYPw/jGRbmG9EWCMTZFET8lqZ235jpKLo7YQabZCl0YtFk0I4CVhKKS
         jANBm8JA7rGp4+yTzXha1JCYNu5ZngRduAJw5zCWHXGMC8Z6SW7hI8dRdrEvQ4yRWf/f
         WAVQsKWd0wnudltKsSAKzPfBabfIPq0eWi4D7fZnCMEHt/VmOc9J4zNUyy3/xSAN/n7l
         A+dnTNNsCRvycLTVWi4zL0EGH46IDSZ3G89Qp/FA8Mbm3slFnn4xXTHoFwQglHhI4Jml
         TBYw==
X-Gm-Message-State: APt69E0+ifaXtMJ3D8S56cYR7l8B2l7Qj6AmrB/yam60+02OwxJrHFS2
        q9OE2aU6SspfSu0oUTjyg2nhlmwJ/Sg5TgmGswY=
X-Google-Smtp-Source: AAOMgpenrCrjYhoyWkiNgC29Iy11wasy1u9P+hD8vK/qV2OebLbcwmpX/kxn/Dxuu4KHqI34CzbwVT/hV84H/jxJT9k=
X-Received: by 2002:a0c:881c:: with SMTP id 28-v6mr842486qvl.109.1530011269748;
 Tue, 26 Jun 2018 04:07:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:c4e:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 04:07:29 -0700 (PDT)
In-Reply-To: <xmqqin66mql6.fsf@gitster-ct.c.googlers.com>
References: <xmqqin66mql6.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 26 Jun 2018 13:07:29 +0200
Message-ID: <CACBZZX4yG5h5kk4NFQz_NzAweMa+Nh3H-39OHtcH4XWsA6FGpg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2018, #06; Mon, 25)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 26, 2018 at 12:47 AM, Junio C Hamano <gitster@pobox.com> wrote:

Happy 2.18.0 everyone!

> * ab/fetch-tags-noclobber (2018-05-16) 9 commits
>  - fixup! push tests: assert re-pushing annotated tags
>  - fetch: stop clobbering existing tags without --force
>  - fetch tests: add a test clobbering tag behavior
>  - fetch tests: correct a comment "remove it" -> "remove them"
>  - push doc: correct lies about how push refspecs work
>  - push tests: assert re-pushing annotated tags
>  - push tests: add more testing for forced tag pushing
>  - push tests: fix logic error in "push" test assertion
>  - push tests: remove redundant 'git push' invocation
>
>  Expecting a reboot of the discussion to take it to some conclusion
>  and then a reroll.
>  cf. <f3b891c3-381f-de42-51d8-24fdfbca91d2@gmail.com>
>  cf. <xmqq603yn50l.fsf@gitster-ct.c.googlers.com>
>  cf. <xmqqzi1alodz.fsf@gitster-ct.c.googlers.com>
>  cf. <xmqqvabylnbi.fsf@gitster-ct.c.googlers.com>

I'm on vacation these days and won't submit a re-roll of this for 2-3
weeks, so I think it's best to eject it. I have a WIP re-roll of this.

> * ab/checkout-default-remote (2018-06-11) 8 commits
>  - checkout & worktree: introduce checkout.defaultRemote
>  - checkout: add advice for ambiguous "checkout <branch>"
>  - builtin/checkout.c: use "ret" variable for return
>  - checkout: pass the "num_matches" up to callers
>  - checkout.c: change "unique" member to "num_matches"
>  - checkout.c: introduce an *_INIT macro
>  - checkout.h: wrap the arguments to unique_tracking_name()
>  - checkout tests: index should be clean after dwim checkout

It would be nice to have this merged down. The only nit of the last
version was SZEDER's suggestion of using a test helper in
<20180605154501.13502-1-szeder.dev@gmail.com>.

I agree, but as noted I won't be able to re-roll this for some time,
and it would be nice to have it in next or master by then, I can then
submit a tiny series on top to fix that "use a test helper" issue,
which is something that can be improved in both the patch I'm
submitting & in several existing places in the test suite, so I think
it makes sense to address that as a subsequent cleanup series
unrelated to this new feature.
