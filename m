Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0962C76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 11:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjC1LiH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 07:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjC1LiF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 07:38:05 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E15F5
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 04:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1680003479; i=johannes.schindelin@gmx.de;
        bh=s+c734gXKOotbhjZDjhzcnX/7MCKZyZiK5Em1FditGc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EsXo2vEPr1VgNFTsVK4B0qQaWOClD5gfC+4WKpSqe/cBzly1oxybd/ACHS15iZdMz
         12kAgZ2c8kHGGmM/1PVEyuMzRG7Sug7M/cQBhPtxXW8jmPT98pnpAcQey+TlzuEJX4
         t+7ShGS0HajifBU1VNomTd5BaBM8wChE17S8yE3tEuskGcR6HxvT+vpDxA/sW2dAuG
         KjVberkv0uKzj2lFKT/DvuwH5Xp06imdSp9ka9owBqVI42ecSi3gzlWfo8Gf3ieF2F
         r1YMbQU/xGzoL3DnQYzQFCyVcQrJBW62KgPagBO5Pi80WrAP14u6Suw5zvBRt/1/m2
         sxHS6+Tecnb1A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.93]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPGRp-1q6ccE0ZJt-00Peg4; Tue, 28
 Mar 2023 13:37:59 +0200
Date:   Tue, 28 Mar 2023 13:37:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
cc:     git@vger.kernel.org
Subject: Re: range-diff: slight usability problem with mistyped ref
In-Reply-To: <b93934a2-91e7-4645-9a24-4f2354172f31@app.fastmail.com>
Message-ID: <818b3ad0-df43-3484-8c19-d95026f6b2b1@gmx.de>
References: <b93934a2-91e7-4645-9a24-4f2354172f31@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1554220849-1680003479=:123"
X-Provags-ID: V03:K1:I+tE4q35/ZpaPSQYzxNj24Trqt6A5NJpBfkuAhVbOk5sjMHDbid
 wO9RRnc2idL9XZNU/Uq6sYmoz67eLKqGzP7YGoA4pqpoyfQmAD0Wvre9GTyquvmDAWNTgrB
 2sVPcKOI20918lL0UVdwEUumQl0BXlx71+SB0uyYwszWdh86P5fFm8kdWX0UvAW+z/p5lyx
 LpBcEl73k/qc8f8Ni66mA==
UI-OutboundReport: notjunk:1;M01:P0:AXaeY3WYums=;mO125ZMuCNIAPhnnRwc0E6HGvOD
 yZZQOLIUmwFKqgRForsp4PV6lZrqSfRr+IYsvh5yM2bufcYiuotmjiF0s6m4n78iLUfVS+oFt
 SXayKhyEqHyQjqEBPY99YBz+zL3maq0mAiCMtrnBtd7XmMqQPLJV1EqvzVO5gtQRS5B79dR9H
 xfgz+5DBWyX3oV4oxV8anbTgcrmaGvtbQoEc0nyvXoztAElUD9WqvDlWEIz6iOf/nNlXr1BQo
 zTR9nf9q6ykPNc5/ncWg/RGAjLcxGEb+VhTf2areExJ5WJwrlzqSd1MxUEMgobCJbgrsqwe3s
 fh/R8rURVRmtaUdp66rK/xKp2/RJBlay7iztOxBYw/+d/J1KchFcJaJkxeHh4gxxC/8mrVZbQ
 MXxbpKT4TQejP7zY5P0JvU8bB2rhHGo6++Rxa059addV38zy+I4uLkVdGIsTHh/jC2Yr7rwv/
 2DRB/QG2NYEtDOF7ZoJ4vz8DfeCgZsqMdE24ghi3qcaRgdNl6zefAgGav0Wt9mG/vBLOb6/qa
 gshXvNuoMeRH0rwk9FVUsH2O31SYSSLqV6dZcDteS3JASUseUVUGUYssJUBnND8TahU78uwBY
 b6D0GwOJa0y2W5J0mgS9adzPBg4A8+e2vPhFs6Vblp9hUASYrPtP0pQRXxXnz2v5snNcXtuej
 QrnP7pYjXkXgOlB49yVnBJEDdet5cOrhoK7vvC6FsFYK1fAhp2wzD8TO2P5KXC4gYiPG9KuW8
 zTKiq7hgKVXO3BlraoTg7NPIVUoxS1pYTIG8wZnFaIrZq+pTDXqRy2UapKAN+XRUWnxXolk5h
 GUQCEOtGhvqbRW9NVlOncQ8XrzdEZg6qSaAN+gbhYVqwu51i3rky2IL0eUUwVZ6AEV7v2N4ai
 dDLk2ItANANTtWHntJe1VuUF9B6jAnf+RznqbJZ1i+hjREkLCYC4Y3OfPRYiyeYFdUAFB2xCP
 e0KnnQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1554220849-1680003479=:123
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Kristoffer,

On Sat, 25 Mar 2023, Kristoffer Haugsbakk wrote:

>     $ # Misspelled ref `seen` as `seent`
>     $ ./bin-wrappers/git range-diff master next seent
>     fatal: need two commit ranges
>
>     usage: git range-diff [<options>] <old-base>..<old-tip> <new-base>..=
<new-tip>
>        or: git range-diff [<options>] <old-tip>...<new-tip>
>        or: git range-diff [<options>] <base> <old-tip> <new-tip>
>     [=E2=80=A6]
>
> Expected behavior: tell me that `seent` is not a revision.
>
> Actual behavior: generic error message.
>
> [...]
>
> In conclusion: IMO and assuming that my cross-version testing is
> correct, `range-diff` has a slight usability regression for when you
> mistype the ref. It would be nice if the error message without a
> pathspec separator (`--`/`dash_dash`) was as nice as the one without it.

I can see how the error message is confusing. At the same time, the usage
below the error message should provide an indicator what forms are
applicable (even if all of the synopses are missing the `[--] [<path>...]`
part).

Now, it seems to be very, very tricky to address your concern properly.
The reason is that:

	git range-diff a.x b c

could have a typo where the user actually meant to say `a...x`, i.e. the
symmetric range form. Or the user might have meant `a..x` and the full
history of `b` with a file `c`. Or `a.x` was a mistyped ref name and the
three-commit form was intended.

So even making the exact error message depend on the number of arguments
could result in misleading error message.

We _could_ extend the `else` arm in
https://github.com/git/git/blob/v2.40.0/builtin/range-diff.c#L142-L144 to
try to parse up to the first three arguments as commit-ishs and report for
which argument that fails, of course, but even that is subject to
ambiguities: what if the third argument happens to match both a ref and a
file?

Do you have any splendid idea how to phrase the error message (or adapt
it to the concrete invocation)?

Ciao,
Johannes

--8323328-1554220849-1680003479=:123--
