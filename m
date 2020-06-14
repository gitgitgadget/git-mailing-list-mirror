Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1046C433DF
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 20:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95B372071A
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 20:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="K2Lxua69"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgFNUh0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 16:37:26 -0400
Received: from mout.gmx.net ([212.227.17.21]:57565 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726857AbgFNUhZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 16:37:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592167042;
        bh=L69S6017ws3I7gxub4OVsYtHP+onYk5mhcvqljHkp2k=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=K2Lxua69Xqaw0eGTG3dtZy3Ayp4lINtL7VPGRfhOI+HNSYT/FRnTqPHRB+oRRMGFr
         Mart++zyMrKEx1uxEcqIvKJ4PensEBh1qEPaaWcKmSP/CopmKTn0CwkAMxwuZkBSLn
         pF7CFV1Y73im15twgJGeAhFXYBJwb0iVyE40a2EA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.173.52] ([89.1.215.43]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYvY8-1jOgxG2diy-00Unij; Sun, 14
 Jun 2020 22:37:22 +0200
Date:   Sun, 14 Jun 2020 10:04:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Adam <thomas@xteddy.org>
cc:     Simon Pieters <simon@bocoup.com>, Git Users <git@vger.kernel.org>
Subject: Re: Rename offensive terminology (master)
In-Reply-To: <CAOhcEPZ6Ygm5fpiYpR1VnHv8ZrvMtOtjc+DwW2QZZy47JE45yA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2006140500370.56@tvgsbejvaqbjf.bet>
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com> <CAOhcEPZ6Ygm5fpiYpR1VnHv8ZrvMtOtjc+DwW2QZZy47JE45yA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Cz0121BqylfWNvzl7DEfxhGHRdHnZmdrH7B5atrjFIV9bLQPxOw
 ZWBUjp7Ss36CYOctfSoZZflWp7+P/07SWh4g1hHZxcFJ8FmDJm/OdigPQxVIe08+6cznNQF
 z91IJG5EJk4VkrEbXmKEHmQiwgxqxpnIuuDJ8OtDaa3v0les0RLotAT757olxf0p+Qa0C4a
 PvpOF+bSVlGNXYfmlls6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M3TbRrmVgQU=:B4gRK06KNKdlNQ9MLZ+ZEH
 OKttl+Z36+5YuvNbRewyvgI/ZE92QpGNz01uL9zck6bjTmjW74ltty4IIikFVR8v1XD3dLEdt
 dECEQxiJXzzhfIZVBRhpKNG++Lyh1gCoTN08Vc8xiZmeinxI4ZFxl5TgzanBs+zzfDRKvDSUa
 QCoATdhPgS3pXpiaIaVtL7H/yCgHkbDA+FPuaBTfG1Y+SBKqsDnsInc1OfkQPV7bpTp8XHCD9
 AtO0ePbsLLTle8wmgq1pBAcRZJJ4ucU3y2PQ5tJmRx2yg2CU5uMrgEF/9B+aNmj/FqNVbEthP
 M+xZm0u0YxVsbUaTwkYMajtbmrzjlAcxg8B2ojZJfaEWQVA2Wga9AI6vb23vcuAuXeR8We5+v
 k2qgT+IhFPrfppESH38XiStMOmHcZd0+YBm1CjW+ev593BnLdC1oBLmoVcHF5rgUgCpgQExUw
 2r71BHYWy1lZhWM1/xpS3j5fqhmVY9O4xgwUi2PvEHaY9eubKZjVN+wFWss9wjLW11kKe0xPL
 VVyr8927LZI6mtDmVo7QJW1f4MPYY7MucXdbAMnawljPBI7TqcZc3Zm0f4q2NbPaA1tASpuZb
 B3C8mdVt4YUTT9ZN+ouUiYoqrxtuHx9QkRisRVXGVC5/9+R6qpuEK6nDRxuzH15qrOWiePgT1
 ipaWcWqzx3WcuDngJ4NGzvlvoQuQZL6xau9bnWCiIwCLQsDbTuJNwBXCoUez0MHsIfIJmatYv
 ng2jaFFa6aPSb6REqJfa0ib2OsQq3JVqa6Xhe2lKhrquRb7PIlDjCaBDqlT61qNZQ7+yhe4aJ
 2WUj1PirC/9TZ34o9Lmn+uWvqor4sBsYloVrrqUhepxxfMRIHCQlZnkszM8GVAole8fAywOqu
 lB9kUjmGqkHSObZwjj16ltD5+EcbFngaUPlhKIfjuuaTPdqbQi9GofJdyuZmHCNSTWEaDedg9
 SzNAExPsCDPSQ5RJgYKoK/+Mtt+PJN0NSYOOIO2HJS99oD+B6+HPJ0xpCJ7J/DhcQ6rrWzBEf
 8ToCzOMnVSvDqZy16zUNPO8qJA0GJbFS582LjF4Gso8iGFAazbgbnJUns7O9U05VtzOWs68iW
 wKKouKzLgLnRd20PT3of022geuXgf5tfYUni5W5V+/5rkFVUSBwHfP+2Li4G/jYI/4F7v3W6Z
 lWRS9SY0706uFgwWJXPThkBELwyV3zDTlMxr1LdzixcV6BE4g0b9IijqJX4ifoft701UU8gq4
 6FJ2mQW3/e/kMMV8P
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Sun, 14 Jun 2020, Thomas Adam wrote:

> On Mon, 4 May 2020 at 18:22, Simon Pieters <simon@bocoup.com> wrote:
> > To avoid offensive terminology and to avoid further inconsistency, I
> > think git should use a different branch name than "master" when
> > initiating a repo. I don't have a strong opinion, but I like "main"
> > since it shares the first two characters and it's shorter.
>
> Hi Simon,
>
> Definitely agree, and thanks for starting this.
>
> One question that's been rattling round my mind is how we change the
> documentation to suit.  By that, I mean, it has become common parlance
> at the moment to say "master" as the canonical branch, because that's
> the one that's been baked as the default.  Now that we're making this
> configurable, I'm curious how we're going to change our semantics to
> match the "default" branch (which was "master") when talking about git
> branches, either here on the list, or in documentation.

This has been on my mind, too. It is a big reason why I keep mullin over
the naming, like, a lot.

In my mind, it will be helpful for people updating documentation out there
to use terminology that was chosen with care. My current thinking is that
"main branch" is the best description of what the construct is about, and
"the default name of the main branch" is what we want to change.

Ciao,
Johannes
