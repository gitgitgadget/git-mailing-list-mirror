Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB1821F829
	for <e@80x24.org>; Wed,  3 May 2017 15:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751709AbdECPK4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 11:10:56 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:32846 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751601AbdECPKz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 11:10:55 -0400
Received: by mail-io0-f170.google.com with SMTP id p24so8145771ioi.0
        for <git@vger.kernel.org>; Wed, 03 May 2017 08:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AqIDS6TLNDKqF+2WWdUYx9y+tgXUuNbZprzO+uwA+uc=;
        b=AbUKTNzAX+j43Myiq3JRHcJCb4p4paCB1HtfYtUysNfK89Yra/TcUKfn6bnV8o145v
         zQn4VogSmxbKbdUfH4JaMyfq1bQUielWlRlWJ5hkkZ/ipuamhr1deFMepHunIH3pBZj3
         PxUWAP2mQIoH/UmwVY11dcFABCF9CgsPWd+5tqpgPQuBc1sfdWMpsiMkj7jJpOND+z3t
         Sr21kqazaVyHQ50cdK/NfCTDWJGd897W0QPWrpIFiWxcD3yJSjCtEMiXaKP6yQ4QkyY8
         WpDqIl7ZqONOYMVdjfh5MS0NZoPwjE4Vd6Jr++JM2uhVDspLH9d1umACJlST+eXJ+G69
         u69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AqIDS6TLNDKqF+2WWdUYx9y+tgXUuNbZprzO+uwA+uc=;
        b=mL+XQ9pTCm6yHCsOe8MOiXEZGXC1DEY9Jz1Hno8nxop00OmdtBkNwJbhvYDoi1Kxyi
         hQQXG/rM4LNdxYQ7uFabuRq2CSiybh9RG5ONB62E9F5/TZNwxdOpZQETkWWDtcvUMecx
         iNG+CphOGC/OpNx8BcUH+3zauj+cbbWmMU40tPxcWyTx+pnokTB+GYrRjx2FEKrhnScu
         ooQEQcTP3wR5QR+9O/wbbeRuLtxiKsGZjvnB6e/+oOZrALLsDSOY0UghV5x8sMBWlai9
         gYE486Q0XwQvmT9ZxzU+gFRZ/5fkJuBC/iqQfjQ0q2J/bKZES8OKJ6QqwZ8ob16F2sII
         YhKw==
X-Gm-Message-State: AN3rC/6ntCJnoj2Mpdyr07vu4cN5AW6hyp0GP75JeKs6ii08KTyRTJPC
        R2a+eTTW5B/m7GNY6wZoY7r+62Lclw==
X-Received: by 10.107.178.129 with SMTP id b123mr32368916iof.50.1493824254027;
 Wed, 03 May 2017 08:10:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Wed, 3 May 2017 08:10:33 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1705031139090.3480@virtualbox>
References: <xmqqefw9gmvq.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1705021406510.3480@virtualbox>
 <CACBZZX5M1Pnvw01wP8id75Ja9NJ3nwVfydsX6g0Ys_QD72r6dQ@mail.gmail.com>
 <alpine.DEB.2.20.1705021756530.3480@virtualbox> <CACBZZX6-qZLEGob6CEwpJ7jtEBG6WLPdHQsO4DsbkNZ8di5mjg@mail.gmail.com>
 <alpine.DEB.2.20.1705031139090.3480@virtualbox>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 3 May 2017 17:10:33 +0200
Message-ID: <CACBZZX6_5krLp93PmsW639-N4f1efUT5rPnN+5im=d9-66=QbQ@mail.gmail.com>
Subject: Re: PCRE v2 compile error, was Re: What's cooking in git.git (May
 2017, #01; Mon, 1)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Just replying to you & Duy in the same mail, easier]

On Wed, May 3, 2017 at 11:45 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi =C3=86var,
>
> On Tue, 2 May 2017, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Tue, May 2, 2017 at 6:05 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>
>> > [... complaint about the abrupt change that makes Git for Windows fail
>> >  to build because pcre2.h is missing ...]
>>
>> I think it's worth it to copy/paste the commit message where I made
>> this change, since we're having this discussion in this thread:
>>
>>     Makefile & configure: make PCRE v2 the default PCRE implementation
>>
>>     Change the USE_LIBPCRE=3DYesPlease & --with-libpcre flags to the
>>     Makefile & configure script, respectively, to mean use PCRE v2, not
>>     PCRE v1.
>>
>>     The legacy library previously available via those options is still
>>     available on request via USE_LIBPCRE1=3DYesPlease or
>>     --with-libpcre1. The existing USE_LIBPCRE2=3DYesPlease & --with-libp=
cre2
>>     still explicitly ask for v2.
>>
>>     The v2 PCRE is stable & end-user compatible, all this change does is
>>     change the default. Someone building a new git is likely to also hav=
e
>>     packaged PCRE v2 sometime in the last 2 years since it was released.
>>     If not they can choose to use the legacy v2 library by making the
>>     trivial s/USE_LIBPCRE/USE_LIBPCRE1/ change, or package up PCRE v2.
>>
>>     New releases of PCRE v2 are already faster than PCRE v1, and not onl=
y
>>     is all significant development is happening on v2, but bugs in
>>     reported against v1 have started getting WONTFIX'd asking users to
>>     just upgrade to v2.
>>
>>     So it makes sense to give our downstream distributors a nudge to
>>     switch over to it.
>
> I see where you are coming from.
>
> At this point, I feel that someone should recall into our collective
> memory what happened when we made a change similar in nature that broke
> existing build setups: by requiring REG_STARTEND all of a sudden ("you ca=
n
> easily flip the NO_REGEX switch", as if everybody should know about those
> Makefile flags we have).

And as a result grep/log -G got faster by default, and more
importantly since v2.10.1 which includes your 2f8952250a and made a
REG_STARTEND engine a hard requirement nobody using git is
mysteriously going to miss grep results because of some stray \0 in
the string being matched.

I agree that I should drop the patch to make v2 the default from this
series for now. Clearly it's controversial, and can be considered on
its own merits once the supporting code is in. I'll do that in the
next submission, which I'm planning to send after v2.13.0 comes out.

But aside from that, I must say I completely disagree with this line
of argument. I think to the extent that we did anything wrong with
NO_REGEX it's that I should have noticed that we could use
REG_STARTEND after I imported gawk's engine in compat/regex &
submitted a patch like yours back in 2010. Instead we got 6 years of
git releases where

Similarly, if PCRE v2 is less buggy & faster then we're looking at man
days/weeks and possibly months/years saved given how many people use
git v.s. how many are developing it & write build scripts for it.

Leaving user benefits on the table to optimize for reducing the
one-time inconvenience of packagers is the wrong move.

> [...]
On Wed, May 3, 2017 at 1:15 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, May 3, 2017 at 4:45 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>>>     So it makes sense to give our downstream distributors a nudge to
>>>     switch over to it.
>
> Some contributor (i.e. me) was not happy with this nudging though. The
> other day I switched to some branch (probably 'pu') and the build
> failed because, guess what, I didn't have pcre2 installed. If I set
> USE_LIBPCRE1 then I lose pcre support when switching to other
> branches. And no, I don't want to install libpcre2, not when I'm
> forced to this way.

Assuming that we'd want to change the default to v2, can you think of
a better way to handle this transition? As pointed out in
<CACBZZX6-qZLEGob6CEwpJ7jtEBG6WLPdHQsO4DsbkNZ8di5mjg@mail.gmail.com> I
can't.

Perhaps the best way would be to migrate this change directly to
master if there's consensus to move to v2 by default, that would avoid
the pain for developers related to switching between concurrent
branches while the change is cooking.

> 188 packages on Gentoo optionally depend on libpcre, 6 packages on
> libpcre2. Chances that a Gentoo user has libpcre2 already are rather
> low.

It sounds like two things are being conflated here, surely "a Gentoo
user", i.e. someone who's not actively contributing to git.git will
just get this via `emerge git` if this change were released, since the
ebuild will depend on libpcre2?

> I'll revisit my installation when the level of libpcre2 support
> grows a bit more than that.

There being few existing reverse dependencies seems like a strange
reason not to run `sudo emerge libpcre2`, but whatever, your dev env,
and we won't be breaking v1 support any time soon.

> You can nudge distributors directly, probably more efficient too.

My assumption in making this change this way is that there's a
decreasing amount of git users who'll get a change if:

* 1. It's made mandatory to compile git (100%)
* 2. It's made a default flag that must be turned off (e.g. our HTTP
support via curl)
* 3. It's something users actually notice being missing, e.g. PCRE
support in general via -P
* 4. It's the default mode of some opt-in flag, e.g. this change where
USE_LIBPCRE=3DYesPlease gives you v2, not v1
* 5. it's advertised prominently in release notes / the installation
guide / on-list.

Your suggestion is some variant of doing #5, whereas I'm currently
trying to aim for #4 (and in the future I think we should probably go
for #2 for PCRE, but that's another discussion).

You can E-Mail some distributors directly, but there's a big long tail
of git builders who maintain build scripts for their company, e.g. I
maintain one of those. If it's just advertised as #5 I'd probably miss
it unless I was paying close attention, particularly since there's no
#3 since I'd be building with v1 already.

Which is why I think if we're going to nudge distributors to move to
v2 it makes sense to do so as this patch is doing it, i.e. if they're
asking for PCRE already make the build fail until they declare
explicitly whether they'd like v1 or v2.
