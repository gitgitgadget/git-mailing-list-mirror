Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA823C433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 08:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99F2E6101C
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 08:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbhJVIFL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 04:05:11 -0400
Received: from mout.gmx.net ([212.227.17.22]:37353 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231923AbhJVIFK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 04:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634889772;
        bh=vwoU5MNGu5ZIM8aJlxMJw1BxQOL/FbKQWDC9v1kqQT4=;
        h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
        b=V84fQYU6jfn0S0/m8v9iuY9pF+CKHfyl/2HUh1slLrX+szXT8uLTGHGDUADyWBm3Z
         9TH1GkXU61SXUTE0Pm2XeS0BAFOhkIPebVgFjiP4G7EKXMgPx4vgjmD8g1ktxwVfHQ
         BcyKQ5krBxvqw6j5f02NuUTK2j7dRHsjLyaJTIfE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.19.78] ([89.1.213.179]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVN6t-1mEA2t0tV9-00SRNh for
 <git@vger.kernel.org>; Fri, 22 Oct 2021 10:02:52 +0200
Date:   Fri, 22 Oct 2021 10:02:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git@vger.kernel.org
Subject: Missing notes, was Re: Notes from the Git Contributors' Summit 2021,
 virtual, Oct 19/20
In-Reply-To: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2110221000480.62@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:0D5kC7NmkRWyuVDajM32qukcIUh1hF0QCos3krOnihXzBO7WD4p
 bkBu5K9T4HPdqSVCy2xWMXbZwJSftMmNYKM77dOfNORSlDnVj7S1DiEiKUEMIqejIwvG28u
 +0/+QakobqZiRDje0LseMmEzDlvqFXwRLwHBDrOE4YBkOxVdz3Y8M8ux+o5IRNyDxAvonlK
 MLqBL4di972MZ8Mw+VrqQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cM+7nenSMTc=:FOHf4Iufj+3ol99j0Z9yWQ
 tsPe4XLeG3olpJaA1P1RN+8lC016BNtlVebCGsVdAEIyBiJB2fHHrdZkneyjzTJfQcSjiR365
 tYYHebiciqXu9kBBHL0OopDlYYw/iYIjW4+agtOZp+jJz0/ni/gsXAx9vrYkybUSQQnGqJwl0
 JoqblexEtsPrEuUYmuK5+S7rDUmn3lfAvSpGlQ1471Vc+CCKbbHAk63y4cgPXDiaAZg+9clxM
 CL6lkqeoiaLd+s2gto8FygKpG/UiHfTL0e1CnMnNaacpatrem6Xu0QrMnTbt60sPX13TT4ant
 9VfkfBSO4r6SyQPHxILhrDORRcdjttgOKEItk3qQ45fDJHbk717PlwJD4eArbJ7K3BEdtpPGV
 xb0tR6hCkdXnPjzg4ZdVam/Rdb7ACD7NgHFpw6b5CwhyyW+aIP8siRLydgaydJccTgsy0vBas
 zZMOskX7Tgb1qF6CsXp53aQiSQnT6LFI5Jlgdp8pDapA9GPheR6i9ZoZhdD7kbrlIJOf6RqgD
 g99t/HE4CaJgJSKlhzkIESb4r0HuvJyE3iQSk2QTnC8E9Gaq42NHCYLbv11XkSW2mGqQpPpeO
 6+DlkkEItSSpjjo1MGDSAjA2vsQ5Y47wgCvnnFSDkho/rhqHokBiSrO30pvFiQKNX/7etRxZY
 aSx6vm8xyFupT3gZAmefxdsx9C47yGgLzb1+6DDUMa8Ywr7GBHXk3v3Zk2DDpaQ6Ca6uex8gM
 lbDCx2dLONVyaJMg47P5pH77sVW9OUP3y13EQlPlC6KR8bluw7lGW/66ytlnR8t4VDW/nKvLG
 w4ZA4IC0GEaKVmqFCrur/+ENcgieSRiVT7gc2/acOjazUO7F+mO9AefzcZxWr0Y9aJgnVgUIU
 7WXjXwdEkYgnvrKKP4Ua6LJcpHzoA1abPdOCXKraQTooAO6YpGC174p7GEu8jAf8xX0HoM1dq
 nq0xbXaNFjA5OgWMX4Z1iWy1pjEfCuLIpmVy1CJJbto6OJCt5tFaGp6Nkc4eWxws/jD8qeNI1
 4udfmgbSDSV5MT+frOO7jffPcVhnsKABW4paV8LWnmoy/R5mzfSgFiRFh+EtJthajSuipFaWE
 5I3tUf/RhEtgwI=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 21 Oct 2021, Johannes Schindelin wrote:

> Team,
>
> we held our second all-virtual Summit over the past two days. It was the
> traditional unconference style meeting, with topics being proposed and
> voted on right before the introduction round. It was really good to see
> the human faces behind those email addresses.
>
> 32 contributors participated, and we spanned the timezones from PST to
> IST. To make that possible, the event took place on two days, from
> 1500-1900 UTC, which meant that the attendees from the US West coast had
> to get up really early, while it was past midnight in India at the end.
>
> I would like to thank all participants for accommodating the time, and i=
n
> particular for creating such a friendly, collaborative atmosphere.
>
> A particular shout-out to Jonathan Nieder, Emily Shaffer and Derrick
> Stolee for taking notes. I am going to send out these notes in per-topic
> subthreads, replying to this mail.
>
> Day 1 topics:
>
> * Crazy (and not so crazy) ideas
> * SHA-256 Updates
> * Server-side merge/rebase: needs and wants?
> * Submodules and how to make them worth using
> * Sparse checkout behavior and plans
>
> Day 2 topics:
>
> * The state of getting a reftable backend working in git.git
> * Documentation (translations, FAQ updates, new user-focused, general
>   improvements, etc.)
> * Let's have public Git chalk talks

You might wonder why I did not send out the notes for this talk.

But that is not true! I sent it 6 times already, in various variations,
and it never came through (but I did get two nastygrams telling me that my
message was rejected because it apparently triggered a filter).

I shall keep trying, but my hopes are pretty low by now.

Ciao,
Johannes

> * Increasing diversity & inclusion (transition to `main`, etc)
> * Improving Git UX
> * Improving reviewer quality of life (patchwork, subsystem lists?, etc)
>
> A few topics were left for a later date (maybe as public Git chalk talks=
):
>
> * Making Git memory-leak free (already landed patches)
> * Scaling Git
> * Scaling ref advertisements
> * Config-based hooks (and getting there via migration ot hook.[ch] lib &
>   "git hook run")
> * Make git [clone|fetch] support pre-seeding via downloaded *.bundle fil=
es
>
> Ciao,
> Johannes
>
