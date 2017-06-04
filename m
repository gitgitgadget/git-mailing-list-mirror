Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD9D61F7D2
	for <e@80x24.org>; Sun,  4 Jun 2017 07:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751171AbdFDHzi (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Jun 2017 03:55:38 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:33030 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751005AbdFDHzg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jun 2017 03:55:36 -0400
Received: by mail-it0-f45.google.com with SMTP id w68so14945164itc.0
        for <git@vger.kernel.org>; Sun, 04 Jun 2017 00:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k4PAAUCldR/E9E1ZmwKlOwBfoU/nyssqNGIq0JuGPBU=;
        b=V9C/IqXgd30k4K7kNfJtcGAU77DJ5Xs61Y+SYbaUk2YIbkTzQJ10i8veZElJdVZLFl
         9wQVCXjjhE6hRfaqc+SHqqesyXMMk02FxSEnBNYUOnVYKX+CH1Q+1vvYNmoGD7yU9j8W
         oK5QjMQo+kajsQnPAuDoaX03EH/1hTWoaaJatJ4wuYxcNLF15/EhSwIf0fj1SbJa9v/m
         7iE6J/zHih4gvQFNAQGBNO8tDBdtl3XKw0a6wyGC92k9BLH/I7pg3R8zY0Xe8vN6f6QO
         IexFziycR1sCr3+YBQ/I0PdiK1I21v5K1QDejYqbMbDG5xMEt9sLNPjHhFPRcezuoD+A
         YduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k4PAAUCldR/E9E1ZmwKlOwBfoU/nyssqNGIq0JuGPBU=;
        b=ZzWXMqQBjs5/0OsxMr2spiRPfTgF+OJGx+tDznIbHKtt8pp3wo5LdfiZohYIoNpRTu
         17whJ3DAB91ibBTcfYor5qOJpCpsURi6WebThUVu3YxYWPuyLdZL3ZICT9DTbTEt5Loz
         6WB9Y5CxtakdgZSFomtAQWndiyLl4iYbH99mrbu00aTPjteLQpiwpQI2P+ezLMCTg4WV
         FPeYS81sbUWgFVE4kL5ARKQbbuyppo3UDsrhhE4D742eLR0J7kl7NNP6O+WfE3WIOlIP
         4bRmxYvZlx4vY3aZjebeuCQcLUivByv4USXzEYNsRhdpLguGPyVa9jlU1qPNf2/PfEb3
         Xseg==
X-Gm-Message-State: AODbwcDrzureh9zm+82L5WrOXhvvEsyKQPdaBY6K23Z39wu2+PZAHwzE
        vxdWQXo4IyZwk2OLQ9qV12tY1itaIA==
X-Received: by 10.36.233.198 with SMTP id f189mr6441690ith.94.1496562936048;
 Sun, 04 Jun 2017 00:55:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Sun, 4 Jun 2017 00:55:15 -0700 (PDT)
In-Reply-To: <CAP8UFD1u-C-T2X+H8WxxB7O+ajcGfygRBLN0t7+zJcOh_SrvFQ@mail.gmail.com>
References: <20170602103330.25663-1-avarab@gmail.com> <20170602184506.x2inwswmcwafyvfy@sigill.intra.peff.net>
 <xmqqd1amx80f.fsf@gitster.mtv.corp.google.com> <CACBZZX52O9Pf=5Xtq1Lg1=ZU26tm7pupvubk1ZjNJZp7kR450g@mail.gmail.com>
 <xmqqefv0wrj7.fsf@gitster.mtv.corp.google.com> <CAP8UFD1u-C-T2X+H8WxxB7O+ajcGfygRBLN0t7+zJcOh_SrvFQ@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sun, 4 Jun 2017 09:55:15 +0200
Message-ID: <CACBZZX4eCJJS6iaod+tWFF5M998Y5x88SdYR2ZekAJeeOiU8ug@mail.gmail.com>
Subject: Re: [PATCH] perf: work around the tested repo having an index.lock
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 4, 2017 at 9:37 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Sun, Jun 4, 2017 at 2:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>>> My feeling exactly.  Diagnosing and failing upfront saying "well you
>>>> made a copy but it is not suitable for testing" sounds more sensible
>>>> at lesat to me.
>>>
>>> This change makes the repo suitable for testing when it wasn't before.
>>
>> Perhaps "not suitable" was a bit too vague.
>>
>> The copy you made is not in a consistent state that is good for
>> testing.  This change may declare that it is now in a consistent
>> state, but removal of a single *.lock file does not make it so.  We
>> do not know what other transient inconsistency the resulting copy
>> has; it is inherent to git-unaware copy---that is why we discouraged
>> and removed rsync transport after all.
>
> If we don't like git-unaware copies, maybe we should go back to the
> reasons why we are making one here.
> In 342e9ef2d9 (Introduce a performance testing framework, 2012-02-17),
> Thomas wrote:
>
>     3. Creating test repos from scratch in every test is extremely
>        time-consuming, and shipping or downloading such large/weird repos
>        is out of the question.
>
>        We leave this decision to the user.  Two different sizes of test
>        repos can be configured, and the scripts just copy one or more of
>        those (using hardlinks for the object store).  By default it tries
>        to use the build tree's git.git repository.
>
>        This is fairly fast and versatile.  Using a copy instead of a clon=
e
>        preserves many properties that the user may want to test for, such
>        as lots of loose objects, unpacked refs, etc.
>
> Is a local clone really much slower these days? Wouldn't it is use
> hard links too?
> By the way the many properties that are preserved might not be worth
> preserving as they could make results depend a lot on the current
> state of the original repo.

AFAICT from some quick testing it'll hardlink the objects/ dir, so
e.g. you preserve the loose objects. Making the results depend on the
state of the original repo is a feature, but perhaps it should be opt
in. It's very useful to be able to take a repo that's accrued e.g. a
month's worth of refs & loose objects and test that v.s. a fresh
clone.

But there are other things that ever a hardlink local clone doesn't
preserve which might be worth preserving...
