Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D07D1FDEA
	for <e@80x24.org>; Mon,  8 May 2017 06:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752625AbdEHGjR (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 02:39:17 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36046 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752034AbdEHGjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 02:39:16 -0400
Received: by mail-it0-f66.google.com with SMTP id x188so6448321itb.3
        for <git@vger.kernel.org>; Sun, 07 May 2017 23:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lP6SkAaG2IHivKVqT1CEYhKiyH1jv9qT6A9N/nmjTt0=;
        b=lq7zYR1PNOnKNUXwUKoyDbpSpzXIdhworS8b/F5tmqo2Bssh4p5fEtDStQ6Bcm55r+
         vazLT52f1hB34yG2iQB9m8cgV018AX2Lg98O0NNw7C4f+Or7Vuf2yIE0SrF/5WNbzEgw
         maPGoSxZlP8vXg/dn3ghbjsG8N35LGPVoJ1I2kCN0s25BakTQBvmducGULx8E4eCfgNt
         3z0lIFNjYifdZr4YN2u2x54p95Csr7ssYvKgtwRXlAZ2C4M6Q/cpjRwb57FKJAVTeR9H
         xFH6Ml8Ves913BZMApsFasjN1frP8oB+F9/+5l4OUuZGA5Kk7td+bTRJ9gV5LWSvGVnR
         RW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lP6SkAaG2IHivKVqT1CEYhKiyH1jv9qT6A9N/nmjTt0=;
        b=lo0QNqzEJtN+KctvW6PCNwD7rGD6YvxAbtuyxtAOSIBpGZnt7KMiuLKNVEWaDExBAl
         4zgTBuJjNyWfLRpGk1f+5qDYdHZ6ZSDnLrbJnry7abn36Yzaz6lzfckjkNWA1udPwTBq
         NU0grGczgHfaQCGsIBwPQWQCmGy8ao332U2plFdXuKRVVD40zhFf89ayGfLvoWmQ8a3A
         C1zkhZObx0uHziaJuboPCAQrvBmU342/McAaTTPePy4kMofouMON8FuAprrzOahyZ+c6
         OORUDkbeJsP3cfy8bUipMS0WanaJQK5Q6fFtBTWcX9St3/1lMrubpdODei8MOV7yL42V
         VCAg==
X-Gm-Message-State: AN3rC/6ecEgiHbB1kmiBHDYYPOlbSFaQ8+iydFmc2/1F/S0AU7Kv6Ib3
        y8V5wjNYzaUlXJ9rfAMyyVWQuyZV8A==
X-Received: by 10.36.166.4 with SMTP id q4mr15470817ite.66.1494225555546; Sun,
 07 May 2017 23:39:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Sun, 7 May 2017 23:38:54 -0700 (PDT)
In-Reply-To: <xmqq8tm8cglo.fsf@gitster.mtv.corp.google.com>
References: <20170504220043.25702-1-avarab@gmail.com> <xmqq8tm8cglo.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 8 May 2017 08:38:54 +0200
Message-ID: <CACBZZX4UzmFxDUwTA8JBX-UHDm4+c90qX7VmKqfDi+=783LmdQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] Update the compat/regex engine from upstream
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Stefano Lattarini <stefano.lattarini@gmail.com>,
        =?UTF-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>,
        "Arnold D . Robbins" <arnold@skeeve.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 8, 2017 at 2:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> See the first patch for motivation & why.
>
> I do not think it quite explains the motivation, though.  "Doing
> this way, we can keep in sync with the upstream more easily"?  Or is
> there anything more to it, e.g. "and we need to update from the
> upstream now to fix this and that issues"?

It's just to bring us in line with upstream which as noted in that
commit has fixed the issues we locally patched (and more), and for us
to stop maintaining a fork of an old version of part of Gawk.

There's no known issue with the existing engine that I'm aware of
which impacts git, but given ~7 years of bugfixes & improvements
there's surely something.

> Having these "fixup!" as separate patches on the list makes them
> smaller and easier to understand.  What do we want to do with them
> once they are applied?  Squash them all up, because these do not
> have their own explanations in their log message and it is not worth
> keeping them separate?

Please squash them all up into this commit ("compat/regex: update the
gawk regex engine from upstream"), as noted having them as separate
patches was a hack to get around mailing list limits.

Also, un-squashed they'd break the NO_REGEX=3DY build for a few commits,
which would be a pain during bisecting.

>> The only reason this has a cover letter is to explain the !fixup
>> commits. IIRC the mailing list has a 100K limit, which this series
>> would violate, so I split up the second commit.
>>
>> Consider all these !fixup commits to have by Signed-off-by, easier to
>> say that here than to modify them all.
>>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (7):
>>   compat/regex: add a README with a maintenance guide
>>   compat/regex: update the gawk regex engine from upstream
>>   fixup! compat/regex: update the gawk regex engine from upstream
>>   fixup! compat/regex: update the gawk regex engine from upstream
>>   fixup! compat/regex: update the gawk regex engine from upstream
>>   fixup! compat/regex: update the gawk regex engine from upstream
>>   fixup! compat/regex: update the gawk regex engine from upstream
>>
>>  Makefile                                           |   8 +-
>>  compat/regex/README                                |  21 +
>>  compat/regex/intprops.h                            | 448 ++++++++++++++=
+++++++
>>  .../0001-Add-notice-at-top-of-copied-files.patch   | 120 ++++++
>>  .../0002-Remove-verify.h-use-from-intprops.h.patch |  41 ++
>>  compat/regex/regcomp.c                             | 356 +++++++++-----=
--
>>  compat/regex/regex.c                               |  32 +-
>>  compat/regex/regex.h                               | 120 +++---
>>  compat/regex/regex_internal.c                      | 118 +++---
>>  compat/regex/regex_internal.h                      | 118 +++---
>>  compat/regex/regexec.c                             | 242 +++++------
>>  compat/regex/verify.h                              | 286 +++++++++++++
>>  12 files changed, 1487 insertions(+), 423 deletions(-)
>>  create mode 100644 compat/regex/README
>>  create mode 100644 compat/regex/intprops.h
>>  create mode 100644 compat/regex/patches/0001-Add-notice-at-top-of-copie=
d-files.patch
>>  create mode 100644 compat/regex/patches/0002-Remove-verify.h-use-from-i=
ntprops.h.patch
>>  create mode 100644 compat/regex/verify.h
