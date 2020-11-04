Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C15C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 22:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 203AF2074B
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 22:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="GDbbdzSj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731629AbgKDWPw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 17:15:52 -0500
Received: from mout.gmx.net ([212.227.15.19]:46667 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727036AbgKDWPm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 17:15:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604528132;
        bh=6p4TWBlMwQ7E2KsMQGapEr8mIa3V7Fi0iH+6zzCvmbA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GDbbdzSjVvc/o//zipX9W459GEGnb7eCSKUcbmNE7Q237vqa/GIPDjtcYLjCszoMk
         l57hnKqDUrHA4NAQo0my9j4RQUMxvuos1xRWiUNrweatrvPUYqN3tte2snu6rjTgCJ
         cHq9FajOYJ0WIljF6w7wrlL1jloXxG/R+S6xagPo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([89.1.214.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOA3P-1kyRCc3ADZ-00OVuu; Wed, 04
 Nov 2020 23:15:31 +0100
Date:   Wed, 4 Nov 2020 23:15:31 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jiang Xin <worldhello.net@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v19 03/10] receive-pack: add new proc-receive hook
In-Reply-To: <20200827154551.5966-4-worldhello.net@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2011042236270.18437@tvgsbejvaqbjf.bet>
References: <20200824174202.11710-1-worldhello.net@gmail.com> <20200827154551.5966-4-worldhello.net@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1264853310-1604528133=:18437"
X-Provags-ID: V03:K1:U3TZsztP1gHtAUnsgq2l5XETF0pdBIn4okFXe1XouabIZV9IMpp
 UiXeqLvItCxrQPiPv9SB4vFGgaJCIHr1t9x4buXi6hvlGuRbMC+ggvGQIo6L0T8t543rxjv
 UxnDH4ndjDjzmcXysiJGxvtUBKF/Gxu/0UzcfLx7Fb4cmrN84iav03ZGfNZzwjCLrnyiOBv
 BaUPHkWJi90JPuvAFkSyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IHGjQocQGmM=:yOi3NMc40foOHPaTulXIiI
 kX7o7gHPBXWQmfIwaYc64MVnQi8J5KBK0e6Y/F8aTDFnwQaY2HXNdj70gd7HG80uXLLrxSLYg
 CqfBJrSloiy4bI8+B3kZRQaZoaAd0D/l+XPDtyqWQFG/AQzjvmTEz8jkoAkskt4S+cZazkImm
 aewG+as2xAf6VCyM0mwWgxR9kEpbadXEAdzC0qh4TTlgajzBAFForqIwaHMfhoZqukhpSriN3
 IzJ9xAG2EqRh9Q5SzYhwtckpvTZVUpoKY7J8DPNqWaBvaiBscx+otKs+2aF7xOKBnri/lgCHl
 b/pi4w6gXPidOjuPoWbwCKw/JgkkxIswSpTei3+9jaQV6gc8rtCdeptIbGHZsF96DMGxyJuSy
 P3mZo3NM9RRt+QOKH7N/rckIoc6Gt4AN6qnZWmksFZybFIggZY7/0buSVUvQdME0mUfjDDArU
 R8vxxMcnzWjHhJEI4nxcPGMUXPqcNaAJxwpV2wwbP7l2PwKrkbnON4gtj8uuWIgFP4co9YbPC
 mybljcHmiFJLKNPtDZlmcuRsZSLeSMWryqZ3/G//G8l7c29tSIFb/JUK/DANZJBHXjRpt7XXm
 MZL5fkFSmm266kn7Oj0ScAxRbpzHEZJlpzEtkma6Dej9mhYaKKoqpU73JyriK1EEZfu+G3B6j
 s32Jv6wat51U3Zb4S5lhfuUhd56Wfeil3WZ5ZPcYmou101IE8bNcidbq4ploCz6H2LvtA8Dvd
 wyDo0TGPPsOXSKmr2yoTIYI66jcoV/Pc1IJRmXSHW99rW76Zzq8nLSnE7KvvBHSlTSr/vEWtS
 LzozCJ8ARNaZPThJf+PA2y+Nfl+/9w0hWDwPenlNVD1T2p4ALfDhTs0JLyo92KFAS0EotnTWu
 oPDN+SCdDzLHGNcOFv2zmjRBij9986lEtMAVI6re8=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1264853310-1604528133=:18437
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 27 Aug 2020, Jiang Xin wrote:

> +test_expect_success "setup proc-receive hook (hook --die-readline, $PRO=
TOCOL)" '
> +	write_script "$upstream/hooks/proc-receive" <<-EOF
> +	printf >&2 "# proc-receive hook\n"
> +	test-tool proc-receive -v --die-readline
> +	EOF
> +'
> +
> +# Refs of upstream : master(A)
> +# Refs of workbench: master(A)  tags/v123
> +# git push         :                       refs/for/master/topic(A)
> +test_expect_success "proc-receive: bad protocol (hook --die-readline, $=
PROTOCOL)" '
> +	test_must_fail git -C workbench push origin \
> +		HEAD:refs/for/master/topic \
> +		>out 2>&1 &&
> +	make_user_friendly_and_stable_output <out >actual &&
> +
> +	grep "remote: fatal: protocol error: expected \"old new ref\", got \"<=
ZERO-OID> <COMMIT-A> refs/for/master/topic\"" actual &&
> +
> +	git -C "$upstream" show-ref >out &&
> +	make_user_friendly_and_stable_output <out >actual &&
> +	cat >expect <<-EOF &&
> +	<COMMIT-A> refs/heads/master
> +	EOF
> +	test_cmp expect actual
> +'

While investigating a flaky hang in t5411 in the osx-clang job of our
CI/PR builds, I ran into this issue (with --stress):

=2D- snip --
[...]
+++ test_must_fail git -C workbench push origin HEAD:refs/for/main/topic
+++ case "$1" in
+++ _test_ok=3D
+++ test_must_fail_acceptable git -C workbench push origin HEAD:refs/for/m=
ain/topic
+++ test git =3D env
+++ case "$1" in
+++ return 0
+++ git -C workbench push origin HEAD:refs/for/main/topic
+++ exit_code=3D128
+++ test 128 -eq 0
+++ test_match_signal 13 128
+++ test 128 =3D 141
+++ test 128 =3D 269
+++ return 1
+++ test 128 -gt 129
+++ test 128 -eq 127
+++ test 128 -eq 126
+++ return 0
+++ make_user_friendly_and_stable_output
++++ echo 4844d8acf2fc62b151a29cfb3b916b6778476b9e
++++ cut -c1-7
++++ echo c208c3bb8a1aeea6d4e40027a17251ccd59a2b1b
++++ cut -c1-7
+++ sed -e 's/  *$//' -e 's/   */ /g' -e 's/'\''/"/g' -e 's/    /    /g' -=
e 's/4844d8acf2fc62b151a29cfb3b916b6778476b9e/<COMMIT-A>/g' -e 's/c208c3bb=
8a1aeea6d4e40027a17251ccd59a2b1b/<COMMIT-B>/g' -e 's/f7cc02ec1b3393b9a9638=
a0e02a7039c234cffa4/<TAG-v123>/g' -e 's/0000000000000000000000000000000000=
000000/<ZERO-OID>/g' -e 's/4844d8a[0-9a-f]*/<OID-A>/g' -e 's/c208c3b[0-9a-=
f]*/<OID-B>/g' -e 's#To \.\./upstream.git#To <URL/of/upstream.git>#' -e '/=
^error: / d'
+++ grep 'remote: fatal: protocol error: expected "old new ref", got "<ZER=
O-OID> <COMMIT-A> refs/for/main/topic"' actual
error: last command exited with $?=3D1
not ok 34 - proc-receive: bad protocol (hook --die-readline, builtin proto=
col)
#
#               test_must_fail git -C workbench push origin \
#                       HEAD:refs/for/main/topic \
#                       >out 2>&1 &&
#               make_user_friendly_and_stable_output <out >actual &&
#
#               grep "remote: fatal: protocol error: expected \"old new
#               ref\", got \"<ZERO-OID> <COMMIT-A> refs/for/main/topic\""
#               actual &&
#
#               git -C "$upstream" show-ref >out &&
#               make_user_friendly_and_stable_output <out >actual &&
#               cat >expect <<-EOF &&
#               <COMMIT-A> refs/heads/main
#               EOF
#               test_cmp expect actual
#
=2D- snap --

The output of `actual` reads like this:

=2D- snip --
remote: # pre-receive hook
remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
remote: # proc-receive hook
fatal: unable to write flush packet: Broken pipe
send-pack: unexpected disconnect while reading sideband packet
fatal: the remote end hung up unexpectedly
=2D- snap --

Applying G=C3=A1bor's patch as obtained from
https://lore.kernel.org/git/20190830121005.GI8571@szeder.dev/ seemed to
help this issue at first, but then turned out not to prevent the same
issue from happening again.

Any ideas?

Ciao,
Johannes

--8323328-1264853310-1604528133=:18437--
