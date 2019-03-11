Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1EC020248
	for <e@80x24.org>; Mon, 11 Mar 2019 21:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfCKVo1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 17:44:27 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:33623 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfCKVo1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 17:44:27 -0400
Received: by mail-io1-f47.google.com with SMTP id b6so268271iog.0
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 14:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=b5bjHwRLgCRE7cMCQDgI1U5ZyNb5P3NKrzGw30mkR8w=;
        b=nX5S/Rj+T5py5DwlvAFhFGwYVdo4xFemxX03z8pGlK9PC9MzK/trwkG00GUzISqPDj
         0qUbW3HJqUeX9ZmnfTSITV3i8EgmgIykYXtaS7ez7tUzY+zg6K3+weGvVmHo0JWrmvyJ
         VuPeGU/gy+Nq7TOGu9UsTwHbDqR6jT2EjN57Ls58g6WgZiiuQd0R1Z0zs3+W1opBurdX
         WjuaDku0liB8sgDHxh9DOQWHsRxlJQ7fMbwuDFu4HOksJM2KfNYLYQ+cWNaGRYQqPP96
         3CM9Gdp6ScVORnwpsbpwLkSy4y3YVRH/5Qju6Fl4KVsoE2mUL83y34aG0ClmrrJVXXAZ
         FWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=b5bjHwRLgCRE7cMCQDgI1U5ZyNb5P3NKrzGw30mkR8w=;
        b=XQ7eDMHy0Ybf/GjNN/lvfqNPoYVfCVLu2d9i7IEhM/Uga0OUy3hgkf2KEMKLuKgoQo
         j9ThkKRzcjx5tqx32HZfxbhWbw5VtLRHR9r9fJwanYXX+WfMQPvgcy198zDsU6umgD7m
         PywLHz/nM6xOv7PXc0gx+iDd+XhLxxZ2UDYicXjCHZHk/AiDModTA9Qml9j3cDJvN07p
         8WUBVQp8D8qZAoBUwfv927juzAvZ67h9zSuePeBhH1gAGH39p9NxaVnlfHSlyfLwT+fe
         yoFoKyhkw73W1lLPxXAR5S/i2sJJ3HgsqaWQfDWC6i8GS/bzwZEqqvqg1B863cgcUKKJ
         eHLw==
X-Gm-Message-State: APjAAAXcS5dPLJTwYvpc+6ZAch+HjE3rwzAVlWJelt8CyjoaItZ1sxQS
        rFxWze3Vj1Ffc6mJk6TM7DWnEKml7klr62hvjmj2Ojxl
X-Google-Smtp-Source: APXvYqxEIeN4EdKatRRLGfifM2wCMvu2hcVBc20Tjn7u0bPE8+h1rJJIezKlw/kRnQell888GCYywjtVTG+JkwS09xY=
X-Received: by 2002:a5d:9806:: with SMTP id a6mr11877261iol.296.1552340666386;
 Mon, 11 Mar 2019 14:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8nnFYt0raL+twrG_v8XZn_FDJWyM=tH=QL13Z70_bHRiQ@mail.gmail.com>
 <CAPig+cTCOfDCv=L3EWUqgVZx1VCdqt5ZjmSQMwHLX=R4C4hgTA@mail.gmail.com>
In-Reply-To: <CAPig+cTCOfDCv=L3EWUqgVZx1VCdqt5ZjmSQMwHLX=R4C4hgTA@mail.gmail.com>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Mon, 11 Mar 2019 17:43:55 -0400
Message-ID: <CAH8yC8=jtBURyr-mFJSe_cd4zNJfJDt672jZ+izo=z75ZBheug@mail.gmail.com>
Subject: Re: Solaris and sed: Too many commands, last: s/\n//
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 11, 2019 at 5:15 PM Eric Sunshine <sunshine@sunshineco.com> wro=
te:
>
> [cc:+=C3=86var]
>
> On Mon, Mar 11, 2019 at 4:32 PM Jeffrey Walton <noloader@gmail.com> wrote=
:
> > I enabled self tests for Solaris. Solaris has some anemic utilities so
> > I put /usr/gnu/bin first on-path.
>
> The first question is if you are really running GNU 'sed'? My guess is
> "no, it's still picking up Solaris's 'sed'".

I believe so. After modifying PATH, command -v returns:

    Solaris tools:
         sed: /usr/gnu/bin/sed
         awk: /usr/gnu/bin/awk
        grep: /usr/gnu/bin/grep

(This was added to my scripts to confirm).

Maybe Git would benefit from SED, AWK and GREP variables like PERL.

> ...
> > Solaris in a VM sucks. I can provide SSH access to the hardware if
> > anyone is interested. It is just an Solaris i86pc on an older Ivy
> > Bridge.
>
> I wouldn't mind taking a look at it, though I don't promise anything,
> and I suspect the only way forward is by ensuring that the GNU or XPG
> tools are used instead of the Solaris ones.

Send over your authorized_keys. You will connect with:

    esunshine@151.196.22.177 -p 1523

I'm in a dynamic IP address block. You will have to ping me on
occasion to get the updated IP address.

Some other machines you may be interested in:

  * PowerMac G5, PPC big-endian with OS X 10.5 (port 1522)
  * MacBook late 2012, x86_64 with OS X 10.9 (port 1524)
  * Intel Goldmont with SHA extensions (port 1526)

Andy Polyakov uses the PowerMac for tuning his ASM used in OpenSSL.

If you want to speedup SHA-1 (re: unaligned accesses) then try the
Goldmont machine. SHA-1 runs at 1.8 cycles per byte on Goldmont.
Here's the compression function ready for copy/paste:
https://github.com/noloader/SHA-Intrinsics

Jeff
