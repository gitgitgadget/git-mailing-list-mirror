Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B48151F404
	for <e@80x24.org>; Wed,  7 Feb 2018 17:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754311AbeBGRyf (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 12:54:35 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:52612 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754151AbeBGRy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 12:54:26 -0500
Received: by mail-wm0-f43.google.com with SMTP id g1so4754194wmg.2
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 09:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aIO2s8pIwMxFESZLvrz2yg2rF1H5SwJH+l45uAHxu/w=;
        b=QOt9aBo+Pijb5gE6RiHFQtmoPHqHDc6HwmJSbNQnRk2E8K/Xqv9mTSZD6wXfMeyDuJ
         Yr4YZdSsHZu6La0Qpu+57sEyMRDoMnWRVYu8+7RnrFCdkyRsIzVSPFbyWcqkuTNRUWdT
         JNH0eINaDbDsDKMYOEv0nF7XfQcJtc/SQAbDBko+LpeGVF4Zs+2OmZbXsX9RAZIimd2L
         pShs9XWnEhoJBRInqD2aQF4hCqaciUuD3KY0S8btmlpsTqx7bpTH8Oh72M8vRVCV0yEd
         uPOqNSPGdN/em/hY8hqZ+YXXyr6LTGYOx9pKJ6hZtD+w0VfkOMPOGY2LEPuM4vMUskH+
         +2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aIO2s8pIwMxFESZLvrz2yg2rF1H5SwJH+l45uAHxu/w=;
        b=CxQKoNTOXZUFP3FzYT++EzT20HcDFl0E4eIZn3QYKpymMJ/xiBQ+bwpI3dOjIRzbT6
         kkAw5XsjFks5HV0Vw0Wviw6nECGPFvYTnRQ4uORUE+dxjH5sCXX6RBBfv2JFO6oCzR28
         zk7RDYZEyszW6lkhPNBELqxV2KmPdNYlwQXNIhDe1sLLZZt36Ecnw6q8lq9gfWo5UHqC
         w5bG1psPaK/DUmzKeSl1Qgro8muMjS1Wvnl8Y1orKAhSL6agnz/FOMIJoDHDWtcIrJch
         UMOUxvky5gxciTZYzIOvD75o41jLzmAtrOrkeKuAvJfahz388Zw3sWQaGKal6doTnb2J
         d7kQ==
X-Gm-Message-State: APf1xPC49tRxdPWEGEGJOiO/ZBuj4suoxkQoisvtV50MvYchAAGsozQu
        6BsEK0KoVNEiJbbckFzhHgKGAy/0
X-Google-Smtp-Source: AH8x2251o4Og0ewtSf3AyKJUuKk+C1E4iw2poyaRvBEOBA9jSmNRRsgouqHMWAwQinFvAuVkgxs9hw==
X-Received: by 10.28.71.198 with SMTP id m67mr5966367wmi.40.1518026065585;
        Wed, 07 Feb 2018 09:54:25 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id b35sm4864926wra.13.2018.02.07.09.54.24
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Feb 2018 09:54:24 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: "git branch" issue in 2.16.1
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAGZ79kaxf3qUyOe6R-LCgyLtwzrwhB=y767tk2qPbC_KR473ig@mail.gmail.com>
Date:   Wed, 7 Feb 2018 18:54:23 +0100
Cc:     Todd Zullinger <tmz@pobox.com>, Jason Racey <jason@eluvio.com>,
        git <git@vger.kernel.org>, Paul Smith <paul@mad-scientist.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5A7788B0-6250-4D1F-A86D-E3155C03EF0C@gmail.com>
References: <2412A603-4382-4AF5-97D0-D16D5FAAFE28@eluvio.com> <20180206195754.GE1427@zaya.teonanacatl.net> <CAGZ79kaxf3qUyOe6R-LCgyLtwzrwhB=y767tk2qPbC_KR473ig@mail.gmail.com>
To:     Stefan Beller <sbeller@google.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 06 Feb 2018, at 21:05, Stefan Beller <sbeller@google.com> wrote:
>=20
> On Tue, Feb 6, 2018 at 11:57 AM, Todd Zullinger <tmz@pobox.com> wrote:
>> Hi Jason,
>>=20
>> Jason Racey wrote:
>>> After upgrading git from 2.16.0 to 2.16.1 (via Homebrew -
>>> I=E2=80=99m on macOS) I noticed that the =E2=80=9Cgit branch=E2=80=9D =
command
>>> appears to display the branch listing in something similar
>>> to a vi editor - though not quite the same. I don=E2=80=99t know
>>> the technical term for this state. You can=E2=80=99t actually edit
>>> the output of the command, but you=E2=80=99re in a state where you
>>> have to type =E2=80=9Cq=E2=80=9D to exit and then the list =
disappears.
>>> It=E2=80=99s very inconvenient and it doesn=E2=80=99t seem like it =
was by
>>> design. I=E2=80=99m using zsh in iTerm2 if that helps. Thanks.
>>=20
>> In 2.16.0 `git branch --list` is sent to a pager by default.
>> (Without arguments, --list is the default, so this applies
>> to `git branch`).
>>=20
>> You can set pager.branch to false to disable this in the
>> config, or use git --no-pager branch to do so for a single
>> invocation.
>>=20
>> I can't say why you're seeing this with 2.16.1 and not
>> 2.16.0, but I'm not familiar with homebrew, so perhaps
>> something didn't work as intended in 2.16.0.
>>=20
>=20
> Maybe the number of branches changed since then?
> As the pager only comes to life when the output fills
> more than your screen. Quick workarounds:
> * buy a bigger screen
> * have fewer branches.

Hmmm... there might be more to it. I just noticed the
pager behavior on macOS, too. Consider this call:

$ git diff --shortstat

This should generate at most one line of output. On Linux
the pager is never used. On macOS the pager is always used.

I tried older versions of Git on macOS and experienced the
same behavior.

@Jason: That might be a bug on macOS. However, I am surprised
you only noticed it after upgrading from 2.16.0 to 2.16.1.
Do you recall anything else you've changed?

- Lars

