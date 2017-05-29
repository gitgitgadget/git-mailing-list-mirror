Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B8232027C
	for <e@80x24.org>; Mon, 29 May 2017 11:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750898AbdE2LL2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 07:11:28 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:33522 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750871AbdE2LL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 07:11:27 -0400
Received: by mail-io0-f196.google.com with SMTP id m4so6577047ioe.0
        for <git@vger.kernel.org>; Mon, 29 May 2017 04:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fvE8UYr3IZiTK720rui/rSH+S7blXkfb8J5HXfxlMFE=;
        b=gks8tn710iQjJamiCB93bhAbFxVBeMt9DFvhzkuLf05Ud4hE076TrJKTs1Lrw2lTdz
         ivVMPjvawlfPsp9H+OkZRURfKeyrk0wZ3fN/oE8CZpNJyHtwAdQ5G+6Hd0HCy0K9Kuz/
         GZFBdD79TIRGW4hBVHpeGgubGKvXtN0LAGhSHw+EfjhB6KZP9NkboFPWM/L6HwRTgjiw
         bbdSeLnO3qkIiWLRtHG/drgjYcA8PEL+YMLZtaLOHi6mu5pJ6FsFZi7MG2I6TguJxLuw
         kcp5HgLrLqtvma0r557D+QnnxJVq9H90NgfPF/KtGcZG/ckDhVd9D5K5iIDzUCnpSew0
         7ymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fvE8UYr3IZiTK720rui/rSH+S7blXkfb8J5HXfxlMFE=;
        b=BdW2vhc9jp+cXAsPk8+uaoo8fSDQJrjSdKaQjKVj98LbbYW/cEUNccx6/AdkjutFqH
         w+h0mtAfo2DQhItTYBRKvsQBr4hbGshi7gikoMDKc0dHGYKbICXi9hBgW+S+e0PA9dFd
         9aQ2DZJhmtDmjciI8fHvJD7Wv1GmjsEhu583u+R1PDvDNZZ3csT71sjok+WvNbTLyYD1
         U90ojwCyrc91KpGQat2kaZmYbGQyvKM9y7eLWIdNaYFzJ7+Y5+XIW7sjBwjszMOTMvI+
         Dr6S0ya4PzoiAeGNNgGatp3bZfICZlqfFQvCPUNYkenQ9k/Tm+aKrYHnj73v+kLmtfv4
         CsEw==
X-Gm-Message-State: AODbwcDfwjgsFecCllKIf6ltq47SoN1RhRq8ym+UenOb/MbQ8NMXpDfs
        VmUaGaFuBlkJSR4HP/IdGbYWbMb9iQ==
X-Received: by 10.107.138.21 with SMTP id m21mr12311739iod.80.1496056286878;
 Mon, 29 May 2017 04:11:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Mon, 29 May 2017 04:11:06 -0700 (PDT)
In-Reply-To: <xmqq4lw4a2pd.fsf@gitster.mtv.corp.google.com>
References: <20170527111032.30897-1-avarab@gmail.com> <xmqq4lw4a2pd.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 29 May 2017 13:11:06 +0200
Message-ID: <CACBZZX70Ak2AEcDg_fRmA_XyM7dUuyZD4jVxQAZn1yFbXYSWZQ@mail.gmail.com>
Subject: Re: [RFC/PATCH] WIP: add deprecation & experimental process/interface
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 29, 2017 at 3:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
>> index 4f94fc7574..c76bbedf86 100755
>> --- a/GIT-VERSION-GEN
>> +++ b/GIT-VERSION-GEN
>> @@ -37,4 +37,5 @@ fi
>>  test "$VN" =3D "$VC" || {
>>       echo >&2 "GIT_VERSION =3D $VN"
>>       echo "GIT_VERSION =3D $VN" >$GVF
>> +     echo "GIT_VERSION_INT =3D $(echo $VN | sed -e 's/^\([0-9]*\)\.\([0=
-9]*\)\..*/\1\2/')" >>$GVF
>>  }
>
> Unlike Perl's v1.2.3.4 notation, this forces us worry when we go
> from v2.99.0 to v2.100.0 and eventually to v3.0, no?

Yeah it's just a dirty hack to get that WIP working, although at this
rate it'll take us ~20 years to reach 3.0 if we go up to 99, and this
would purely be internal to the codebase.

I think it make sense for core.version to be e.g. 2.13, and parsed
internally to 2013, then we have room to go to 2.999 or ~200 years at
the current dev pace.

>> +     } else if (1) {
>> +             /*
>> +              * TODO: Instead of `if 1` we should check a
>> +              * core.version variable here.
>> +              *
>> +              * I.e. if set to core.version=3D2.13 the user is opting
>> +              * in to get deprecations set at dep_at right away,
>> +              * and also perhaps experimental features from a
>> +              * sister experimental() interface.
>> +              */
>
> This essentially forces us to always read _some_ configuration.
> Some commands are meant to work outside repositories, so those who
> want to affect them needs to write core.version in their global
> configuration.  Some low-level plumbing commands may want to do
> absolute minimum without configurablity.

Doesn't making sure that those codepaths just don't call
experimental() or deprecate() solve that issue? Presumably if
something is such low-level plumbing that it can't call deprecate() or
experimental() we'd just create a new incompatible command under a
different name if we'd like to change it.

Or are there some edge cases I'm missing?

> I am not saying that it is absolutely a bad design decision to force
> us to read some configuration (yet); it's just that it is something
> that we have to keep in mind and always think about the
> ramifications of.

*Nod*. It's definitely a bit of a chicken & egg problem, especially if
we ever wanted to have experimental or deprecated config-parsing
directives, but for most parts of the codebase it should be fine.

>> +             die(_("Early bird deprecation error: %s"), message);
>> +     }
>> +}
