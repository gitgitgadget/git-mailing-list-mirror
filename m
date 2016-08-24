Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2CE11F859
	for <e@80x24.org>; Wed, 24 Aug 2016 09:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753101AbcHXJja (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 05:39:30 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33212 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbcHXJj1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 05:39:27 -0400
Received: by mail-wm0-f65.google.com with SMTP id o80so1788205wme.0
        for <git@vger.kernel.org>; Wed, 24 Aug 2016 02:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hmJFzzrYxFBD8PlbZvKFhHnvHzudooZsJsyyH9aXKS4=;
        b=FMvjqGApTvKGsFNqY/Tj33cgt31Da4PU/6HynsYBmcM98v2cwZbeab3izyTYVxOSMA
         rkXxO+fGcRV93zh9Pux1IKquPFKaNwgZ/ElpQPZhmgJaIcfipKKtCXPe746Ckfj8OyOx
         rvRqZOBHw08LOciSak2tFwjC/IcdtGVacLur11jV84vVJy2ArHeZZgm8M2iK1te4HrGl
         21CdlIi103ZilJXB79Dd+pCiUwe8jTxVqwoJ1v3xtzcTJYBeLpZxYX1VSTcUfFpla5Ad
         jwVB93atPXoC7NbInaUYh9bETEwFntCTdVr7UeDHt/9zc9LtIoxc8rgJzfIpQ/UwjlvT
         4DuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hmJFzzrYxFBD8PlbZvKFhHnvHzudooZsJsyyH9aXKS4=;
        b=RCC0uLACN5+WCEhdiL928TXptO3Uh+6uBLq8bmFEqZ+8KQGjZBXnseH8HPkVVp/MNZ
         m8xztzp3xSuMtJsFJVY9wi7FtCFOiLJbtSclgtaPT9lRcO1iVlcLirqocxJWA1zgotd5
         plfCXsN+FC/vN+jVk6o14tIuWHwrGePcBGee1g17a0bZscHoiwx4AS3hhVExgWNShf13
         MC+2Osj2x8Ah1yiWVSwTnVtENO6QO7sWNbwTn5AnGYdBKLU4B9GPXz5I8/Xa7o5zDrly
         p7c3rgrsqF6zs5HFnM208TraS2vl1rttJDGHpzCqNT7XYvGd59gEAT3kQlC/iB7P+/B4
         jrWw==
X-Gm-Message-State: AE9vXwO9g5fl3k/Ie4qBfOboiiggF42pKeLp/HjlBmQQ+yhJhsny5h25x/9hpa7p3W5u5A==
X-Received: by 10.28.225.4 with SMTP id y4mr2246109wmg.98.1472031521460;
        Wed, 24 Aug 2016 02:38:41 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id g67sm9697406wme.5.2016.08.24.02.38.39
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Aug 2016 02:38:40 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 1/3] diff-highlight: add some tests.
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqziocbftd.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 24 Aug 2016 11:38:39 +0200
Cc:     Brian Henderson <henderson.bj@gmail.com>, git@vger.kernel.org,
        peff@peff.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <C1987BCB-8FE1-43AD-B8A0-06F58A4E73F0@gmail.com>
References: <20160730151149.15980-1-henderson.bj@gmail.com> <20160730151149.15980-2-henderson.bj@gmail.com> <A2BCF055-D3FD-4EFC-88FF-A3916BCF8FDF@gmail.com> <xmqqziocbftd.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 16 Aug 2016, at 22:48, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Lars Schneider <larsxschneider@gmail.com> writes:
>=20
>>> On 30 Jul 2016, at 17:11, Brian Henderson <henderson.bj@gmail.com> =
wrote:
>>>=20
>>> ---
>>> contrib/diff-highlight/Makefile                  |  5 ++
>>> contrib/diff-highlight/t/Makefile                | 19 +++++++
>>> contrib/diff-highlight/t/t9400-diff-highlight.sh | 63 =
++++++++++++++++++++++
>>> contrib/diff-highlight/t/test-diff-highlight.sh  | 69 =
++++++++++++++++++++++++
>>> 4 files changed, 156 insertions(+)
>>> create mode 100644 contrib/diff-highlight/Makefile
>>> create mode 100644 contrib/diff-highlight/t/Makefile
>>> create mode 100644 contrib/diff-highlight/t/t9400-diff-highlight.sh
>>> create mode 100644 contrib/diff-highlight/t/test-diff-highlight.sh
>>>=20
>>> diff --git a/contrib/diff-highlight/Makefile =
b/contrib/diff-highlight/Makefile
>>=20
>> Would it make sense to add the contrib tests to the Travis-CI build, =
too?
>> https://travis-ci.org/git/git/branches
>=20
> The more the merrier ;-)?  I do not think of a downside, especially
> if you are adding it as a separate thing that comes after the main
> test, or for even better isolation, an entirely separate job.

OK, if I will post a patch (might take a while).


> By the way, how flaky are existing tests?  Are people actively
> following breakage reports?

Good question - I was curious about that, too.=20
That's why I made a little website (only tested on Chrome, requires JS):=20=


https://larsxschneider.github.io/git-ci-stats/

There you can see all builds for all branches including their failure =
reason.
In general I would say flakiness is no issue anymore.

I don't know who else is looking at the breakage reports but I do.=20
That's the reason for my "next" breakage reports in the past:

=
http://public-inbox.org/git/A6131C47-3230-4EC4-B3F6-B2507C937A22@gmail.com=
/
=
http://public-inbox.org/git/4877318E-3CBF-4C87-B24D-AAE35C427D66@gmail.com=
/
=
http://public-inbox.org/git/FB76544F-16F7-45CA-9649-FD62EE44B0DE@gmail.com=
/
...

Cheers,
Lars=
