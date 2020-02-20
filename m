Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB0DC11D00
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 22:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F643208E4
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 22:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="OEaCN2sM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbgBTWeD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 17:34:03 -0500
Received: from mout.gmx.net ([212.227.15.19]:47665 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728582AbgBTWeD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 17:34:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582238037;
        bh=j7vRSk8nCKCMfqQQ7nrrgUJhA1B3h5UZ3oYWOodv6m8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OEaCN2sMlzuqgC+DfXZJajbb4a8dMzqnc6ZcmpMH1hrP0eAgRD2Z6LFG9mD7VP8A4
         inh6Ji4Admu9aJ2uGKL7V6YBIuvJA2NGj2t7H5zxhC8rpwooBPqxkI1MnWeXz80uFG
         zyb8PJ6SSZ3z+O1FnynGnup8DOIxAoxNEXuckXOI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnJhO-1jlyz23qWi-00jIp7; Thu, 20
 Feb 2020 23:33:57 +0100
Date:   Thu, 20 Feb 2020 23:33:52 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v7 07/15] bugreport: add git-remote-https version
In-Reply-To: <xmqqpneacim1.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2002202333340.46@tvgsbejvaqbjf.bet>
References: <20200214015343.201946-1-emilyshaffer@google.com> <20200214015343.201946-8-emilyshaffer@google.com> <nycvar.QRO.7.76.6.2002191524460.46@tvgsbejvaqbjf.bet> <20200219222807.GB26221@google.com> <xmqqpneacim1.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Qi1yaOglNzsba+W3H9aGYuw0pBMZNNcKIczGaTjrhvHfexFeZDJ
 mXTWUs3Cm0qeFaCi4Kl3LCfVNHdp2p8C02ZYYYz0LQBUcFkHmXygbFzA3Rkd8c7o0raFQAb
 TtHUpmVI8vQELCjmC8DUTTgsYtSREFDg0ZPhqkkL90RYD6rEte/kHiBfxNzVa7wGt6AO+GE
 22iBFH5TAYn9DGvN+ei9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qtmIJWbzL9c=:U4j6Dv7W7XWvdQcwsds5lB
 hhbPYNSZHj30v+T00GTOLhYXA4noyodJ1LVaqbIZI3vbSlav9j26oUC7jTRoGojaq1X1w3Nbl
 DxwJcYbNU5vwAfdl2VTPZApmFzaJaooWFdb0RyzI3+dtOpxBkzNWZKAsOkgDfa3A4JVDIa92Y
 E1+BmvWYxkwezkfXDL7NuiMJ3SF981dywRb8Xe2INjXrSu1VO6G4wuI0odx6WG4dcpdkV66gH
 GxJaIAUJrJLHeFFHpdyi62UDiPqfgP08japfWPXQrmEWpIEoOeK7rGzR3IEm3FcVis+O5t78G
 tjeXM4lakhoad+n3tV38zQIgfTWGM8GdoM7glruaYRlU6GggBYKVogRjQBnYx44hUkRQZUQwO
 KAs8IDklzUJkyaj8fKN9d71MxnrsH5z5T60ca/P4iIv5Hu7vgtDEKyaEmhuEcyHYpUIBcXZmT
 W6ilrlXdq6pzd0IiAqfTocIOnBwNrHkzQDV5artonC3LiXqhHO49OvA+Aux8b9jiR5EG2m4A8
 P2BWIr1jG0RtuVPe63+ZTNUBtAeaHrNMyKStzvdwlzYpg/yi7wCr/iTppJZGmnBoVNIincqhs
 n/ZJmMfMqWpoU/QuIgQrI7P1ofHofOUEkoxmQLZBGChLKOrGdDESnsF3m8ilr2+fVJxot5trt
 Xj5Qgo64eYJBuZqawfIoDwlN0rUzp/lTfj0OUzc3MWHRs3njvP4KjdwRwUoXn52x6g225tVyi
 QorZ2CAjcmtoKhosK5DtCBlh6JJqjbxZXKosFLYLx6vSfJjstBIH1hHSsOQUNhdIy6CfR+UY8
 oKHOiiON6Z/u+u1uC0a0ZbiJjCUAMDiiAMbZ13f3VaTo1uG3apIrS826EKQtlyw02lqHcKJHM
 syYskk7MYCWezWQ5oBAfzMhl8vQoLq0zMm80YyvGX1MQX6lz68l+aTks+m0UWV80j7RFf8VjG
 cmmFtvOGgF0AFvppMYnIKyryx1iA8k9IMbCXhVLm+0ZNHRY5UXmePaefgY6JIouuhYYWw5FPQ
 RRx/WVhRAxuZy6jkkVcCkuYn+svzxmqvbHqcVeZYYw3yN/FPQHY9SO/59qUA1YOrMOf90RQOo
 tocX1NueIrYZBrB6jJTqre0JPvGJsN38Gp6ctD/VRFUdECYIDvKkqbRepRytOhkOJ3OQrsOa2
 2czBSZlHHTFkrM6K9LjlTS0AJFVJJCdEzuLThrCwtPdKgjvpZiNQnxpC4cZg5pI71VYkn1Gl5
 KxAHf7m6wjbwgusZn
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 19 Feb 2020, Junio C Hamano wrote:

> Emily Shaffer <emilyshaffer@google.com> writes:
>
> >> Also, in keeping with the existing code, we would need to use
> >> `--build-options` here (this is what `git version` calls the equivale=
nt
> >> mode).
> >>
> >> _However_.
> >>
> >> I like your `--build-info` a lot more than `--build-options` (because=
 the
> >> latter is very misleading: the commit and the date of the build are n=
ot
> >> "options" at all).
> >
> > Sure. Thanks for saying so.
>
> I don't think anybody would mind introducing --build-info to "git
> version" as a synonym and deprecate --build-options from it ;-)

Heh. I almost suggested this. Almost.

Ciao,
Dscho
