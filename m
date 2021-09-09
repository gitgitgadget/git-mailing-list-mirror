Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AAAC433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 11:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E08D61100
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 11:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbhIIL2L (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 07:28:11 -0400
Received: from mout.gmx.net ([212.227.15.15]:45673 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234507AbhIIL2K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 07:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631186816;
        bh=5yZ/K3ohvUeR3yNrjs39nZSuJQdCciqXV+bmrgmpYTk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GgFmi7BPHFD5DylHQkWZndba+0OUatfqrYsmtBSyAKNH+KLSXDRbyLIz7Djk0tT5L
         pS9F3nI2HT3R6ytjRnd/6fAUabZTU6nRgCUcp3NRC4UFE35DMjOu+s+9eUQkLG+oAS
         ZP6jmDl8XMXNUjFUqOlrSXZCBbSlda+T2bf99bLs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.174] ([213.196.213.44]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSt8W-1mWQNK0o6o-00UNpq; Thu, 09
 Sep 2021 13:26:56 +0200
Date:   Thu, 9 Sep 2021 13:26:55 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Sibi Siddharthan <sibisiv.siddharthan@gmail.com>
Subject: Re: [PATCH] test-tool run-command: remove dead "testsuite" code
In-Reply-To: <xmqqtuiw9loh.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2109091323150.59@tvgsbejvaqbjf.bet>
References: <patch-1.1-d1e464da0a9-20210906T002938Z-avarab@gmail.com> <xmqqtuiw9loh.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-716780552-1631186817=:59"
X-Provags-ID: V03:K1:erN4vop759tywkJ2GmcBYkqUFWWcQd38OAxydAf6CoLiNwmVnGt
 MqFTNupXr4i4LTmCXN7UWVmvvnBbViorUAQb9MPOL0LEvmGTM9WsHLaei8Aqg7n1bAsCoWr
 50KXA9MMRrq3XEBsuBrM/R84Xr4Ay7KGUy1cNmkWUJQNny9sWgIXblu1qxyrLjde+f2X4/m
 nnritPlH54fpQS2fHELQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:feYDiFzRrWo=:bFwJFr5xmd7TgUnhQvAPKa
 klLQ18idktAeuGjT//Ok/1qggER9eEmsrosb+KAWtoRyU5yrvw7Ofll/TiRI2fX/zAPDAkT9f
 +9DWxrTYpry1UfHvxZim23b/wXwO31xioyR5KD12oi4iAjFZct3dvm4D8C/pU5SxBDXvL8nw1
 jSqOM+o+MUa9wtg2wK8S+F0WtckcdM+ID5473hkYTjVv2z3DtraGVPEQArOsP4HTJvfVeALiX
 mmjeJAUpooPz6xaF8Kg0C8R1DpLbB0taa+ktc24fF85zPSxU1D6uU0IKIxo0fEAhxWtldO9u0
 HcXUzwRrWirmht1ycvad7/c2g57VvdoNHBHVxDQh2iOAFYFLLiMr87a29uqNJ+FCHSsk1GIUE
 Pi2RG744AOhRvwTAfqmnfMuOp8clJ64jKjjLeSqH2UVRK3J09gTLyGkEmyfPYvCDc0J+9dmAL
 pLM5AjG/DtFeDt0rYRdeqgVyA0o1xZJkeWxMRmiZknEywWgVfZMZEVcFhsNnRZLo2MwCepFZj
 10Dk1ZT3oZM8/35feMeEMv2BwkMbpXVgL3petA44FCVhAad7Dnnn5M/C9OADfn5yAntdNzpOR
 O24u6udeFgsuqBQnpGtPHzZSZvGx0YWB6Mj2TvtdZ8aHrBj66iZjMjHMRN5o+8KDXNW0Brv7D
 a8IkVzQQSP6n/oL3QfawlTfp3uojLOxWZDqwx8dIDTmmdKXTrTos/ocUMjd7eExXCVDjW+AU7
 XrpLJyjMOxEOTXDG7invmTczYahVITrSVToaTZKB/ATTiZAOrkDN61rVL1wyBcNTxyRqFexzO
 PY5tim8K/DtvR5a91zrwV0Ufl/R7Qr/6lXMpmM6hbNCLCSiCN1tLuOudAtszGwhcaY6VpkWMD
 ANr5NQxIPiu4INPROFl+B+7zVZUkn39MsDwAvYksJ/aUJ7BFFGNekE+mKGtQUMzgXYStaS+wc
 1JGoYuHb+3qm0AKOq96Vt11NjqMrdiftELWusi0Zi5hg2J+ynvBGQYfGlS9eUKjn7Rgcgpwb0
 b/N4KCD0n5UYpH68ZVvkCq2ytBp6kP3sXuo3DaV+xrsng8SSe2bz1KtZP/snu/yVKtwHOI48y
 RJfPesuF6ux8Go=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-716780552-1631186817=:59
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Tue, 7 Sep 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
> > Remove the "test-tool run-command testsuite" sub-sub-command, it has
> > not been used since 4c2c38e800f (ci: modification of main.yml to use
> > cmake for vs-build job, 2020-06-26), see also the earlier
> > 6081d3898fe (ci: retire the Azure Pipelines definition, 2020-04-11)
> > for another phasing out of the command.
>
> I'll leave this patch hanging in the list archive until I hear from
> somebody from Azure camp say that they do not need it anymore and
> they do not plan to use it in the future.  Of course, if somebody
> else from outside the Windows circle is using it or plans to use it
> in a near future, they can raise their voice heard while we are
> waiting for such an Ack.

As I mentioned, I would love for this to stay.

The reason is that there is a long-running ticket about polishing
BusyBox-w32, polishing Git for Windows' support for BusyBox, and then
shipping a MinGit [*1*] version _without_ Bash and _without_ Perl.
Obviously, I would want to verify that it works as intended, and that's
where this `testsuite` command would come in (we already bundle the test
artifacts in our CI runs, so `test-tool.exe` would be available).

Ciao,
Dscho

Footnote *1*: MinGit is a subset of Git for Windows, intended to be
bundled by 3rd-party applications that do not require interactive Git
usage, optimized for a small disk foot print. For more details, see
https://github.com/git-for-windows/git/wiki/MinGit

--8323328-716780552-1631186817=:59--
