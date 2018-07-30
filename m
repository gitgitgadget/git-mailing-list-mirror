Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBDBA1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 18:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731637AbeG3UQL (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 16:16:11 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:45390 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbeG3UQK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 16:16:10 -0400
Received: by mail-qk0-f174.google.com with SMTP id c192-v6so8513977qkg.12
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 11:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=F5q0fyTONVDnNzYUjLvJYfOFfb0xQt5inXAjF0OQ5jQ=;
        b=UkkBc8JQygJ/8jI8RSoXZwLCjX9my6rZD1W4fCIU4Fv8No7tLiHGqgNn1v282oxS9R
         qw73P/R6Qy7yjJ0ArW/DfXCJOd6NTj1M32V/Xr13mYjKXP+64dWUCMffjouOQ5y6sczm
         VsTtvanDTgGZgg7U/lOl0EYS+ow1LvDEwOwO+0Mwg6lLiu9yc6z17O3v1yoKH9gwzLHw
         NsvDIPA2Pm1ieU/k2O0t9d5BSGNzngA69/cBFgj8ZUKeVwoSNfWTIVJHsD37criTiM6C
         s18CwAx9msZTSc07mNLZX2Ln9hRMwlxe5j7jaWDemIKciDlVUlM6M0lhTFvVYlYQci1e
         GDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=F5q0fyTONVDnNzYUjLvJYfOFfb0xQt5inXAjF0OQ5jQ=;
        b=cxzKKCXqJubdWXtejaMiYV4QPngSwOuVFSRE99UbhI+/y78IBwfgmjWCHDp8IPIPBd
         7V4WKK072/SLZ6YCsn3fRnBt6EtcKpaJMybLaW8vQdvkblAGmt5kzMDcht2f8prHpktN
         GhBpjeB/TCUWpRZphPhRRq3CLluCGvi/G3MyOTHlxQrfM2KpAqi9cwXg1MopvFOdTzMr
         TPWnVYv6XBcXwYMsikWVG86NatCGTKzQ5ebTo1jBLfUxpFrnHJ2fnsNlYwxFV4bBYTec
         rTxhwZ41bh2uYWMd+AGqxNP+Dp1/g0AsHlMiH/TU+D4YeReg52YiFsAmcBxzK3lkovGF
         YtNQ==
X-Gm-Message-State: AOUpUlER0CoiiW5Vmm2BsbC0FqsoTuGQPPRuXnxFpA6zZHOIImumAVM0
        0K0LbN5Q0gmmNJzTr9w/a5ReViMGmf9Aui6ncSA=
X-Google-Smtp-Source: AAOMgpczWPFWHGKuSks7GeeluVj3g7cUxEMPkSomtYD5t5+WW+4ZPsKpgerdJvRQYvYBW/Ajx6GH5CxiRmK4MKJukBw=
X-Received: by 2002:a37:4ed8:: with SMTP id c207-v6mr17472682qkb.164.1532975992759;
 Mon, 30 Jul 2018 11:39:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:25aa:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 11:39:52
 -0700 (PDT)
In-Reply-To: <xmqqh8kgfuba.fsf@gitster-ct.c.googlers.com>
References: <fb935882-25b1-db5f-d765-50dab297f733@felt.demon.nl>
 <20180729181006.GC945730@genre.crustytoothpaste.net> <2309fa7f-c2d8-ee57-aff5-b9e32d2da609@felt.demon.nl>
 <20180729192753.GD945730@genre.crustytoothpaste.net> <dfe374bf-d9de-8dad-6ec9-4edfa3e9b12b@felt.demon.nl>
 <20180729200623.GF945730@genre.crustytoothpaste.net> <701d9f4b-efbd-c584-4bec-bddb51b11d96@felt.demon.nl>
 <87wotdt649.fsf@evledraar.gmail.com> <xmqq600wkc4i.fsf@gitster-ct.c.googlers.com>
 <xmqqh8kgfuba.fsf@gitster-ct.c.googlers.com>
From:   Daniel Shumow <shumow@gmail.com>
Date:   Mon, 30 Jul 2018 11:39:52 -0700
Message-ID: <CADMpRy7f_Zr7Ay7bU_5eBS+7yO-58EVsEGE0k9qxefS-TO+z8w@mail.gmail.com>
Subject: Re: Is detecting endianness at compile-time unworkable?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Michael <aixtools@felt.demon.nl>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: multipart/alternative; boundary="0000000000007f6c0605723bc99a"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--0000000000007f6c0605723bc99a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The change was definitely made for performance.  Removing the if
statements, conditioned upon endianess was an approx 10% improvement, which
was very important to getting this library accepted into git.

Thanks,
Dan


On Mon, Jul 30, 2018 at 11:32 AM, Junio C Hamano <gitster@pobox.com> wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> >
> >> And, as an aside, the reason we can't easily make it better ourselves =
is
> >> because the build process for git.git doesn't have a facility to run
> >> code to detect this type of stuff (the configure script is always
> >> optional). So we can't just run this test ourselves.
> >
> > It won't help those who cross-compile anyway.  I thought we declared
> > "we make a reasonable effort to guess the target endianness from the
> > system header by inspecting usual macros, but will not aim to cover
> > every system on the planet---instead there is a knob to tweak it for
> > those on exotic platforms" last time we discussed this?
>
> Well, having said all that, I do not think I personally mind if
> ./configure learned to include a "compile small program and run it
> to determine byte order on the build machine" as part of "we make a
> reasonable effort" as long as it cleanly excludes cross building
> case (and the result is made overridable just in case we misdetect
> the "cross-ness" of the build).
>
>

--0000000000007f6c0605723bc99a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">The change was definitely made for performance.=C2=A0 Remo=
ving the if statements, conditioned upon endianess was an approx 10% improv=
ement, which was very important to getting this library accepted into git.<=
div><br></div><div>Thanks,<br>Dan</div><div><br></div></div><div class=3D"g=
mail_extra"><br><div class=3D"gmail_quote">On Mon, Jul 30, 2018 at 11:32 AM=
, Junio C Hamano <span dir=3D"ltr">&lt;<a href=3D"mailto:gitster@pobox.com"=
 target=3D"_blank">gitster@pobox.com</a>&gt;</span> wrote:<br><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">Junio C Hamano &l=
t;<a href=3D"mailto:gitster@pobox.com">gitster@pobox.com</a>&gt; writes:<br=
>
<br>
&gt; =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason &lt;<a href=3D"mailto:avarab@gm=
ail.com">avarab@gmail.com</a>&gt; writes:<br>
&gt;<br>
&gt;&gt; And, as an aside, the reason we can&#39;t easily make it better ou=
rselves is<br>
&gt;&gt; because the build process for git.git doesn&#39;t have a facility =
to run<br>
&gt;&gt; code to detect this type of stuff (the configure script is always<=
br>
&gt;&gt; optional). So we can&#39;t just run this test ourselves.<br>
&gt;<br>
&gt; It won&#39;t help those who cross-compile anyway.=C2=A0 I thought we d=
eclared<br>
&gt; &quot;we make a reasonable effort to guess the target endianness from =
the<br>
&gt; system header by inspecting usual macros, but will not aim to cover<br=
>
&gt; every system on the planet---instead there is a knob to tweak it for<b=
r>
&gt; those on exotic platforms&quot; last time we discussed this?<br>
<br>
</div></div>Well, having said all that, I do not think I personally mind if=
<br>
./configure learned to include a &quot;compile small program and run it<br>
to determine byte order on the build machine&quot; as part of &quot;we make=
 a<br>
reasonable effort&quot; as long as it cleanly excludes cross building<br>
case (and the result is made overridable just in case we misdetect<br>
the &quot;cross-ness&quot; of the build).<br>
<br>
</blockquote></div><br></div>

--0000000000007f6c0605723bc99a--
