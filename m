Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 419A71F404
	for <e@80x24.org>; Fri,  2 Mar 2018 17:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946783AbeCBRjq (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 12:39:46 -0500
Received: from mail-pl0-f43.google.com ([209.85.160.43]:43383 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1165061AbeCBRjo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 12:39:44 -0500
Received: by mail-pl0-f43.google.com with SMTP id f23-v6so6077870plr.10
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 09:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vBWQogRUx2AlcJ33OiprxWbOcUk+d4jxBpLrEfwXQyo=;
        b=aXi8XNePXNTeKGJ+4p/Ju2Fa5vzMJb73qMrcYnEa3qZzs7TZ0qNCGqZFApcFSAX3S6
         S9/Ct0WdfuMxEWUhP9yYHlJ7x7JiC/BUlupqUmJRdU6gMHwCkRjEvXn8vIk9JAA9tJ5J
         cefyGcFvLZzzAHGSnsQOlHZ/YPV9oKdhE+YKdp+B52HX6DYXTsphXmnhTxG0lY0n4FW1
         poWSRoCPkMwpc2/7WDBBEvjc7iu44v6LJ+YVl9tzKhtk31m9rEmpeJqoCC6ygcZgMwNl
         LAE7VnfV7MLA4HzpDN0Yuz+C/7V2iVibz0yOOc7d+XdNVYwmMtBiJo9BsdHkgEfG8BQU
         XuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vBWQogRUx2AlcJ33OiprxWbOcUk+d4jxBpLrEfwXQyo=;
        b=Q+j/HZlZ92qwDRu3xYPryEUlR5h1VXDGzB10e/hZvSRCtgTtegpJjjIKkRGTPrHRo2
         vjoi2qeS9itMAo2FdaEYJbOFDmIVNhw9aTBeGUpReRJdWnRb4vc1cRQ+Voemd8t7wZqu
         L7WQ16mwAmWyMRk4UjQNAkburPbjTJVqomC7PCd6xqDNrQhirDgnAsT2FmJLhKyuVOqR
         aTMQjZV9ZJSYY+ASUG3NxZFywS7FbLocgr/Kt2AR1afMe60ZO7WHWz54xWcBJrfsA5i1
         meylmEV5u6yzQ2s0l+cGGWckoEnSca4+doDKZLZvig9DhkMBB2E5ubgRIP1SBYTXT4uK
         vvAw==
X-Gm-Message-State: APf1xPChKjCbPxah33nmYJiGxa9Dm5iyNOdsRdWzIBcZulehWJGKjSJF
        o6rmFvpK7McQNAcpibWL9Ro=
X-Google-Smtp-Source: AG47ELuJcQjLHdU2KHYunHixKBtEVsgufMxj0SlnJPpUhCifGE8+eaKFCwf1RsGsq0PJ46tmIT1e5Q==
X-Received: by 2002:a17:902:6b04:: with SMTP id o4-v6mr5993550plk.260.1520012383766;
        Fri, 02 Mar 2018 09:39:43 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id u79sm16580436pfi.186.2018.03.02.09.39.42
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Mar 2018 09:39:42 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Mar 2018, #01; Thu, 1)
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqsh9icsh1.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 2 Mar 2018 18:39:39 +0100
Cc:     =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3C32011B-30E5-4E63-8692-5D598430DC99@gmail.com>
References: <xmqqpo4ne8ud.fsf@gitster-ct.c.googlers.com> <CAM0VKjmRT-vdyxsXTk1FB4BMLc8z6968kapqyqx5djKof5hQFg@mail.gmail.com> <xmqqwoyucsom.fsf@gitster-ct.c.googlers.com> <xmqqsh9icsh1.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 02 Mar 2018, at 18:11, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Junio C Hamano <gitster@pobox.com> writes:
>=20
>> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>>=20
>>> On Thu, Mar 1, 2018 at 11:20 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>>=20
>>>> * sg/travis-build-during-script-phase (2018-01-08) 1 commit
>>>> - travis-ci: build Git during the 'script' phase
>>>>=20
>>>> Stalled for too long without any response; will discard.
>>>=20
>>> I still think this is a good change as-is and it does make checking =
the
>>> results of Travis CI builds easier.  The issue Lars raised in [1] is =
in
>>> my opinion a non-issue [2] in practice and Lars hasn't yet disagreed
>>> with that.
>>=20
>> OK, so I simply misread the discussion and did not realize that it
>> reached a conclusion?  If that's the case, good ;-).  Thanks.
>=20
> OK, I think I now understand what happened.  I misread the "fold"
> discussion and thought we were still exploring the possibility, to
> avoid showing uninteresting zero-status case to the users.
>=20
> If we do not care about that part, then it seems that the discussion
> thread is complete.  Let's move on.

All good with me. I just wanted explain my reasoning for the initial
implementation. I do understand Szeder's reasoning too and I am OK
with the change.

Thanks for improving the TravisCI integration Szeder!

- Lars=
