Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E1AC433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 15:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DC9B613B8
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 15:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbhDTPv7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 11:51:59 -0400
Received: from mout.gmx.net ([212.227.17.20]:50431 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232967AbhDTPv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 11:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1618933873;
        bh=eZgcio4LBOqCRfpk41kug5FDeL+xK21Qu0Ec3GF+GLQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HrjMOcHfwKUxW7ddu9aMWFa5PLCW6Cs2Nwzc4fhO/M1/tzulYAQSkw+edNDmIerJ0
         qIt/1mseIjLp5xHNp/VbyHmcTABvin4rwmGWwyV6O86l6l4EIwHSKoqPNu3lP9KHSh
         mmZMKauTuZgSDN+jBmvknPs8xhn4e2+Op9/1h6Y4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.111.181] ([89.1.215.94]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdefJ-1m8DXU3NkP-00ZjxH; Tue, 20
 Apr 2021 17:51:13 +0200
Date:   Tue, 20 Apr 2021 17:51:11 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org
Subject: Re: Random GitHub Actions added to git/git???
In-Reply-To: <xmqqmttt7q8f.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2104201748400.54@tvgsbejvaqbjf.bet>
References: <xmqqmttt7q8f.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:27WfjbYU/U8wmEPFe3gJozlC2K7IugeQN77FsrnyP4ZqaAoRfVG
 MYsFETSp6frOrBb6olnLdIPp6LLwR7G1y3ibZQ4THlz3xciqJ0K5Nhjr6ag8GhDwiTRsmKj
 qZH40cee8l78tzD8WwDSR62zZuAUG5XRwsWPf68rdKghXIXQOJGY3SlGuOf+vVxYbXhjvlk
 pJFpujWpZHMyR8DA7CP4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6ulqBetiGRs=:5VY6Gim1i/Mg1T7nbBvSdK
 CaHxPe7Xwk57U0/VgnEoJy+purszL9D9t6iRcBzHg/suhUJKVNm69GDJJzDJMj7NQL4QAt5IQ
 ZPKig/rWBQuIIFCOgDA3Dn2PtSPAKSYB5hxOrlrMNdSh6cWN7OVgHnl8Fk8ClWBwPc+dciLYv
 s4lu4DHv/0jh1K7YhMlLOdOEJL1EFM7ZIoFr7YQthFj4TjQr/psaJZLOu5E6KsZZ2OlXPvGuZ
 PvMMYU0LVDPi9/ReR7037WvdK8N+b1aOl6h9z678CXKSwvtIHqgurt0+3A8ibi81vRwlj7hvu
 tmVylA4pvVDQEDUeq5Kfhhy41fmUxU9S9+sb270Izw+CycT4phj2j2xamdiKCiZm8Eb1+0Hmb
 M523cqBRw06fENEaBKUlkzUnV0osiT7/Bt/3H8LeEAYwFY/TQurIgcAYrE+oSc0fKgnxWIFuI
 PU136jkHR3vTypuW0jrEl5upc82xzIcQy7ZXSI3aMGNemJlyhcHC0QZzwI11igcubSkPohxgF
 7rWSmv5j2un0AFgj5889+dkQlvYvNeF5WuL2gvrz0sC46NnzTR6fw/WM/SewGdX8nA3iLDnWd
 8sYQ+ru4BL9q8i8FfTAcGQgq1GvmGcpf3+3vxLSqafHAck6e8CjwXIulK5z41kK0gL6SVcAgl
 IWU5zDy+gD/NVfDE/Bm1YPfQHgLcdDqaDezsf9OB7+JRnjOSni80lzhKdpb1iT3mgGwkXN5t7
 SSAX0PE8JOBAMCfoyDZmshELHYN51xO7tTvv+YkpGxiHK3Xg44V1NFeaK65XwetNtj+b/Z1n5
 N7T/OpoIiDvEGTvSfw01P7vhg4nMUd2IT4c/csZ5hl5NFY+05M1s63WqfIgqmn/LOxgWczQqe
 aZ6LuiITeRL9PVbWksBwvra0x1aHuL3StXSF5EYS3RsOXzFn0nQvxKZeZtyYmjQ7dN9KCI+ns
 9bvKIFTCi5e/7DYGK1RQR5/H9NCrhsEuzSFllicv8fB7WRZjr2AxxMOC6IZwWMnP2iM/pZavr
 G9GbtLUuV0nmP9vLEJLEBXa6Mll3O9HxH6QPUUTffeUwoAqNSKv26CzOvxPXMZjtJreJfnFjl
 mX0pya7M5y76EH/JgYN54yO4Fj/pG8TgRjW5FxbOw2B5JBEelD9StGUwbgTkpb/kdUiIurQyX
 vp56JmSCK8Rcvcbi/+sDBkzB3YQxRCg0OpTdAYMO+avTQzUgk7nZpTPJu1r3/KHNbSohw40mQ
 tXoN7JoGNyM3Llhqn
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 19 Apr 2021, Junio C Hamano wrote:

> I was browsing https://github.com/git/git/actions and noticed that
> there are many "workflows", even though what we have in our source
> tree in .github/workflows/ define only two of them (which I consider
> "officially sanctioned ones").

If you are referring to the "Codacy Security Scan" things and alike, I
saw them, too, and I think it was a single contributor who opened PRs
adding those workflows.

If you click on one of them (such as above-mentioned "Codacy Security
Scan"), you will see that "This workflow run has been marked as
disruptive" (see for yourself at
https://github.com/git/git/actions/workflows/codacy-analysis.yml).

It is a bit sad that those are still shown at all, but I think it's just a
matter of time until they vanish.

Ciao,
Dscho
