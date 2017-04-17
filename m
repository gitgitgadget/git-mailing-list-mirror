Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E912D20A04
	for <e@80x24.org>; Mon, 17 Apr 2017 12:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753015AbdDQMoR (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 08:44:17 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35174 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751171AbdDQMoP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 08:44:15 -0400
Received: by mail-wm0-f48.google.com with SMTP id w64so33173996wma.0
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 05:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=imRqijN/xUeLJhBAlQtiAqWgoHl0pxJibyx8d2n/alE=;
        b=m298ol9IWvnpwhn8DPzQhdBbt2irWOHyGiPVxBGVUepTowfXziJlia/7HtaKW0FXAi
         65CXi1oGphAU3p1Ix7Z3TwhftMljSI+UO1H8+03+48ddXalXiTQbpYNo3Tl3mrU3UYgy
         GKWiDEHYMP6V96w1j2nkEcKtQofZIpaft1vYUiCLcQWjTu1P9ZgLrKVzeZbKkDdEgQG5
         QmPx/NYxPwZMj2lRrOW33JcD7N6DsaoBozcmT5v71WpNdxoqEizZd8zCxPgWCjCePizn
         8R6XtrLXbQJoBHuuuPoxkW2OxuZRLq+KgKlLb7qCSGLMugFFZPP2Ta2gTwSuaFRyI+Qj
         U09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=imRqijN/xUeLJhBAlQtiAqWgoHl0pxJibyx8d2n/alE=;
        b=tCPfuPvb8CrCZigeQz/KX6YmEXyz1C/2dxhIYEPtxe3ueMJwYpSa8w5bayYHvnvZBb
         TuUCUNUhbSuTAZxpaVaj/D6mtSzTTbo1+jgj90vzlEPL9eJ4HqaXP5VDHteSHOyiVXkf
         yzFwN4SYxeCEpOiujJx26FPHmHSn6CTFyzwx+8GRREHYp/oaHfEjc5tZz/RQ63xo2v6X
         gCVKxfxq4o5VrtOTUacmkLPK48BFIUVwNIHsAL/Thd1n3nmadjd9xGPj1qQ6wDXknAFa
         jl7EG3Pm6S6ikWAa/l2RtQVqXTeA79oqgctlfby74UIVkPwaJHA526tVO8JbAQOuB/uZ
         RIGw==
X-Gm-Message-State: AN3rC/6au392K8sKp/cN1LJZNDFI+tNBkZ3QAntvC/974QbLTUkjHFqk
        d3z0D7LXql6tRUpPn68XuHgqgtUZVA==
X-Received: by 10.28.197.135 with SMTP id v129mr9206089wmf.55.1492433054380;
 Mon, 17 Apr 2017 05:44:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.142.26 with HTTP; Mon, 17 Apr 2017 05:44:13 -0700 (PDT)
In-Reply-To: <xmqqpogblvfr.fsf@gitster.mtv.corp.google.com>
References: <CAJgfmqU+1Ex1YkP94H2amXV+oqscbQwvb-CueuCiM7-n0AAP8Q@mail.gmail.com>
 <CACBZZX4fDu-o+ERiTyjVq2rWkXK6rjErU4KyW33qMx1_6vjMCQ@mail.gmail.com> <xmqqpogblvfr.fsf@gitster.mtv.corp.google.com>
From:   "Fred .Flintstone" <eldmannen@gmail.com>
Date:   Mon, 17 Apr 2017 14:44:13 +0200
Message-ID: <CAJgfmqWf9j=R1=qy-kGTL4+y_40O+8S5q=VZuD3A-DbfRJer2Q@mail.gmail.com>
Subject: Re: Feature request: --format=json
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So I did "git rev-list --all --pretty" and it looks like "git log".
Which outputs a human-readable format.

However, if I want something more suitable for machine parsing, is
there any way to get that output?

Example maybe I want another date format like ISO dates, or maybe a
serializable format like JSON or CSV or something. Maybe I want more
data than commit, auhor, date, subject and body?

On Mon, Apr 17, 2017 at 2:38 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Sat, Apr 8, 2017 at 6:07 PM, Fred .Flintstone <eldmannen@gmail.com> w=
rote:
>>> $ git log --format=3Djson
>>> [{
>>>     "commit": "64eabf050e315a4c7a11e0c05ca163be7cf9075e",
>>>     "tree": "b1e977800f40bbf6de906b1fe4f2de4b4b14f0fd",
>>>     "author": "Tux <tux@example.com> 1490981516 +0200",
>>>     "committer": "Tux <tux@example.com> 1490981516 +0200",
>>>     "message": "This is a test commit",
>>>     "long_message": "This explains in more details the commit"
>>> }]
>>>
>>> This would make it easy to parse the output.
>>
>> The git-log command isn't plumbing that's meant for machines, but the
>> git-for-each-ref command is what you're most likely looking for.
>
> They are apples and oranges.  log is about traversing the history.
> "for-each-ref" is about listing the tips of refs.  It doesn't and it
> shouldn't traverse the history.
>
> The plumbing to use when you want to reimplement "git log" lookalike
> is "rev-list".
