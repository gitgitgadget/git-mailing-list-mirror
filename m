Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17070202AA
	for <e@80x24.org>; Fri,  1 Mar 2019 13:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388045AbfCANtz (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 08:49:55 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50976 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387620AbfCANty (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 08:49:54 -0500
Received: by mail-wm1-f68.google.com with SMTP id x7so12532731wmj.0
        for <git@vger.kernel.org>; Fri, 01 Mar 2019 05:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=zMuvw2v2kw3DMCtdUnJOSUBst4KbXtU0yhUy5bCLO24=;
        b=W/wpWCqNh/h7id6qe0FazQ6YE/7jTd5T2FDGqkCqd1PkV2FEVX9u1zdt3wgZiSACvd
         hvd4nPeWsqvvSQQkeR0AiRmpNY/1P/nsZjATcKzJubWlMBMaaGwjaWh/i/pkHhxyJMNQ
         gHgDUCqFJATtKsvjY0eV6SVzb8MiMrybh8rb8CAwT4YKlvE5QxvbMqfWaeL0Ygf+3jw/
         KsjtT2JbtJ7WrKpNMEhsdd9F71TfqncJ+4J0CMBALczUn5qhhW52KqOln/r4DGSmLJre
         /veENnulJtq4ZYoVjttkOOYdtzpcdxUCgk3ZJBrxUDChiDW0HshGoiXbtd13ZzuvqIEk
         fT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=zMuvw2v2kw3DMCtdUnJOSUBst4KbXtU0yhUy5bCLO24=;
        b=G39k43syskmxzUSAlEUzkpYgxD+Bn+38wR56eky78VVLlLkJCbdx7oEly+9ShXbbfG
         6y9EC8oGr2jmrGdJBtY7G85r3kepgbZ2V/NtnEcLaqonKse/Bdid6CRoZkBT2Ckhw1NY
         6VA/BpTFB8G7H1bwKtGig+qH5+fuQ2fq+sGWdpSRuEU2vvycxRnrHjvDlCNpcYftV1lM
         codJ5wMfUNAb5p8asvuyev+0+1Ly9l4KBgl+an6biHpMbZZneL9LwyYHq3fx2D1LypWI
         UuzGCYlwl61w2ukt6MSBVvmVXsMdocq39dMvXKuJh8g+0aTgvEcWYp7AvseFX9ALBRiG
         qEmg==
X-Gm-Message-State: APjAAAWb5V0Vi7XUiCm8bILLD+ClEiDdTiMMnj2KpebZ8w5khgpNqWPs
        2pkO9wyYX5hYtdMdrTo+Pys=
X-Google-Smtp-Source: AHgI3IZAER5L8P1K/aUMH0gf39BDR2kRX8d/nswDq/lxtYdNw0vWx5bIFgPbuMewH8O96MZo7nda6Q==
X-Received: by 2002:a1c:c019:: with SMTP id q25mr3188405wmf.113.1551448192261;
        Fri, 01 Mar 2019 05:49:52 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id p6sm65558259wre.63.2019.03.01.05.49.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Mar 2019 05:49:51 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC PATCH v3 1/5] clone: test for our behavior on odd objects/* content
References: <20190226051804.10631-1-matheus.bernardino@usp.br> <20190226122829.19178-2-avarab@gmail.com> <CAHd-oW71N94vBvN4wYQVzXyUZjvVs3Ca9tM3VUEuqB66YNGDtA@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CAHd-oW71N94vBvN4wYQVzXyUZjvVs3Ca9tM3VUEuqB66YNGDtA@mail.gmail.com>
Date:   Fri, 01 Mar 2019 14:49:50 +0100
Message-ID: <87o96uvh4x.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 28 2019, Matheus Tavares Bernardino wrote:

> Hi, =C3=86var
>
> I'm finishing the required changes in this series to send a v4, but
> when submitting to travis ci, I got some errors on the
> t5604-clone-reference test:
> https://travis-ci.org/MatheusBernardino/git/builds/500007587

I don't have access to an OSX box, but could reproduce the failure on
NetBSD.

It's because there link() when faced with a symlink behaves
differently. On GNU/Linux link()-ing a symlink will produce another
symlink like it, on NetBSD (and presumably OSX) doing that will produce
a hardlink to the file the existing symlink points to.

I've pushed out a version of mine here which you might want to pull in:
https://github.com/git/git/compare/master...avar:clone-dir-iterator-3

I.e. this whole thing is silly, but just preserving the notion that
we're not going to introduce behavior changes as we're refactoring.

So it adds a commit right after the tests I added to detect this case,
and use symlink() or link() as appropriate instead of link().

There's then a commit at the end you might want to squash in that
reproduces this behavior on top of your iterator refactoring.

Of course the DIR_ITERATOR_FOLLOW_SYMLINKS flag at this point is rather
silly. We're telling it to stat(), and then end up needing both stat()
and lstat() data.

I'm starting to think that this interface which previously only had one
caller, but now has two exists at the wrong abstraction level. I.e. it
itself needs to call lstat(). Seems sensible to always do that and leave
it to the caller to call stat() if they need, as I believe Duy pointed
out. Also noticed that dir-iterator.h still has a comment to the effect
that it'll call "lstat()", even though we now have a "stat() or
lstat()?" flag.

> On Tue, Feb 26, 2019 at 9:28 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> Add tests for what happens when we locally clone .git/objects
>> directories where some of the loose objects or packs are symlinked, or
>> when when there's unknown files there.
>>
>> I'm bending over backwards here to avoid a SHA1 dependency. See [1]
>> for an earlier and simpler version that hardcoded a SHA-1s.
>>
>> This behavior has been the same for a *long* time, but hasn't been
>> tested for.
>>
>> There's a good post-hoc argument to be made for copying over unknown
>> things, e.g. I'd like a git version that doesn't know about the
>> commit-graph to copy it under "clone --local" so a newer git version
>> can make use of it.
>>
>> But the behavior showed where with symlinks seems pretty
>> random. E.g. if "pack" is a symlink we end up with two copies of the
>> contents, and only transfer some symlinks as-is.
>>
>> In follow-up commits we'll look at changing some of this behavior, but
>> for now let's just assert it as-is so we'll notice what we'll change
>> later.
>>
>> 1. https://public-inbox.org/git/20190226002625.13022-5-avarab@gmail.com/
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  t/t5604-clone-reference.sh | 142 +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 142 insertions(+)
>>
>> diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
>> index 4320082b1b..cb0dc22d14 100755
>> --- a/t/t5604-clone-reference.sh
>> +++ b/t/t5604-clone-reference.sh
>> @@ -221,4 +221,146 @@ test_expect_success 'clone, dissociate from altern=
ates' '
>>         ( cd C && git fsck )
>>  '
>>
>> +test_expect_success 'setup repo with garbage in objects/*' '
>> +       git init S &&
>> +       (
>> +               cd S &&
>> +               test_commit A &&
>> +
>> +               cd .git/objects &&
>> +               >.some-hidden-file &&
>> +               >some-file &&
>> +               mkdir .some-hidden-dir &&
>> +               >.some-hidden-dir/some-file &&
>> +               >.some-hidden-dir/.some-dot-file &&
>> +               mkdir some-dir &&
>> +               >some-dir/some-file &&
>> +               >some-dir/.some-dot-file
>> +       )
>> +'
>> +
>> +test_expect_success 'clone a repo with garbage in objects/*' '
>> +       for option in --local --no-hardlinks --shared --dissociate
>> +       do
>> +               git clone $option S S$option || return 1 &&
>> +               git -C S$option fsck || return 1
>> +       done &&
>> +       find S-* -name "*some*" | sort >actual &&
>> +       cat >expected <<-EOF &&
>> +       S--dissociate/.git/objects/.some-hidden-file
>> +       S--dissociate/.git/objects/some-dir
>> +       S--dissociate/.git/objects/some-dir/.some-dot-file
>> +       S--dissociate/.git/objects/some-dir/some-file
>> +       S--dissociate/.git/objects/some-file
>> +       S--local/.git/objects/.some-hidden-file
>> +       S--local/.git/objects/some-dir
>> +       S--local/.git/objects/some-dir/.some-dot-file
>> +       S--local/.git/objects/some-dir/some-file
>> +       S--local/.git/objects/some-file
>> +       S--no-hardlinks/.git/objects/.some-hidden-file
>> +       S--no-hardlinks/.git/objects/some-dir
>> +       S--no-hardlinks/.git/objects/some-dir/.some-dot-file
>> +       S--no-hardlinks/.git/objects/some-dir/some-file
>> +       S--no-hardlinks/.git/objects/some-file
>> +       EOF
>> +       test_cmp expected actual
>> +'
>> +
>> +test_expect_success SYMLINKS 'setup repo with manually symlinked object=
s/*' '
>> +       git init T &&
>> +       (
>> +               cd T &&
>> +               test_commit A &&
>> +               git gc &&
>> +               (
>> +                       cd .git/objects &&
>> +                       mv pack packs &&
>> +                       ln -s packs pack
>> +               ) &&
>> +               test_commit B &&
>> +               (
>> +                       cd .git/objects &&
>> +                       find ?? -type d >loose-dirs &&
>> +                       last_loose=3D$(tail -n 1 loose-dirs) &&
>> +                       mv $last_loose a-loose-dir &&
>> +                       ln -s a-loose-dir $last_loose &&
>> +                       first_loose=3D$(head -n 1 loose-dirs) &&
>> +                       (
>> +                               cd $first_loose &&
>> +                               obj=3D$(ls *) &&
>> +                               mv $obj ../an-object &&
>> +                               ln -s ../an-object $obj
>> +                       ) &&
>> +                       find . -type f | sort >../../../T.objects-files.=
raw &&
>> +                       find . -type l | sort >../../../T.objects-links.=
raw
>> +               )
>> +       ) &&
>> +       git -C T fsck &&
>> +       git -C T rev-list --all --objects >T.objects
>> +'
>> +
>> +
>> +test_expect_success SYMLINKS 'clone repo with symlinked objects/*' '
>> +       for option in --local --no-hardlinks --shared --dissociate
>> +       do
>> +               git clone $option T T$option || return 1 &&
>> +               git -C T$option fsck || return 1 &&
>> +               git -C T$option rev-list --all --objects >T$option.objec=
ts &&
>> +               test_cmp T.objects T$option.objects &&
>> +               (
>> +                       cd T$option/.git/objects &&
>> +                       find . -type f | sort >../../../T$option.objects=
-files.raw &&
>> +                       find . -type l | sort >../../../T$option.objects=
-links.raw
>> +               )
>> +       done &&
>> +
>> +       for raw in $(ls T*.raw)
>> +       do
>> +               sed -e "s!/..\$!/X!; s!/../!/Y/!; s![0-9a-f]\{38,\}!Z!" =
<$raw >$raw.de-sha || return 1
>> +       done &&
>> +
>> +       cat >expected-files <<-EOF &&
>> +       ./Y/Z
>> +       ./a-loose-dir/Z
>> +       ./an-object
>> +       ./Y/Z
>> +       ./info/packs
>> +       ./loose-dirs
>> +       ./pack/pack-Z.idx
>> +       ./pack/pack-Z.pack
>> +       ./packs/pack-Z.idx
>> +       ./packs/pack-Z.pack
>> +       EOF
>> +       cat >expected-links <<-EOF &&
>> +       ./Y/Z
>> +       EOF
>> +       for option in --local --dissociate
>> +       do
>> +               test_cmp expected-files T$option.objects-files.raw.de-sh=
a || return 1 &&
>> +               test_cmp expected-links T$option.objects-links.raw.de-sh=
a || return 1
>> +       done &&
>> +
>> +       cat >expected-files <<-EOF &&
>> +       ./Y/Z
>> +       ./Y/Z
>> +       ./a-loose-dir/Z
>> +       ./an-object
>> +       ./Y/Z
>> +       ./info/packs
>> +       ./loose-dirs
>> +       ./pack/pack-Z.idx
>> +       ./pack/pack-Z.pack
>> +       ./packs/pack-Z.idx
>> +       ./packs/pack-Z.pack
>> +       EOF
>> +       test_cmp expected-files T--no-hardlinks.objects-files.raw.de-sha=
 &&
>> +       test_must_be_empty T--no-hardlinks.objects-links.raw.de-sha &&
>> +
>> +       cat >expected-files <<-EOF &&
>> +       ./info/alternates
>> +       EOF
>> +       test_cmp expected-files T--shared.objects-files.raw &&
>> +       test_must_be_empty T--shared.objects-links.raw
>> +'
>> +
>>  test_done
>> --
>> 2.21.0.rc2.261.ga7da99ff1b
>>
