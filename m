Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26BEC33CB1
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 13:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C428120661
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 13:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Wd028Iki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbgAQNmI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 08:42:08 -0500
Received: from mout.gmx.net ([212.227.17.21]:33053 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726936AbgAQNmI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 08:42:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579268525;
        bh=ssHdRPHGDp1YEMF60nyPTdOiaiBu4+0iI+qipWU8OaM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Wd028Iki3pGi6SZtUc0KLr/qH/mg8ygrEIt9shPiB8nO9w6AzQPEtAp+2wvb5zG+O
         skuOjqX7EaRB6W+dUzUGlOstlhxsSUeElEkJN9ensOflzpYEMJ3gN19g9w1JOEaRop
         EqE14JnRtH9tSeR7E4wERZRGXjJ6hlt+TRhMmuio=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8hZJ-1iwYUW3C89-004k8U; Fri, 17
 Jan 2020 14:42:05 +0100
Date:   Fri, 17 Jan 2020 14:42:04 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ondrej Pohorelsky <opohorel@redhat.com>
cc:     git@vger.kernel.org
Subject: Re: Bash-completion missing option merge-base
In-Reply-To: <CA+B51BERnCMJMK5dgo6+=22yr8Upv6RbKPh-Br6fALubVN-D9A@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001171439290.46@tvgsbejvaqbjf.bet>
References: <CA+B51BERnCMJMK5dgo6+=22yr8Upv6RbKPh-Br6fALubVN-D9A@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1170878717-1579268524=:46"
X-Provags-ID: V03:K1:+QdRa2ptwUjxE8tgxVj8ekWsbb3BM0nYQwCzwMd/z5ErnzMkXVe
 11nmIJuUJtHOGwQ/J/o7FINOwaq4FSZdTaQg0O4j4YiZyYv4zYK4FC8fLxbisI/AUAde+o/
 IesPxfqt3Ns6ic4cxT47PrrYnHxQIbH6bDKg+3177ykaDNGWSfUol//alvdsOCafOWSX5hv
 zfWtTe8j2jYB4/ffjLQ4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HHIBkCubcW8=:XP8qf/C91zkO27CX2jqdkL
 BBZZ7rEj6mGAlAkEWO3MO0HVGo55S2QapoJCDrL1IFWtKlHFYG7+zPyMn4Rn/eO8atv3eb3fq
 AWFxj3pAgpXanzbhY9gO9g6kyIWTu/nmfV07LREbGrNjcjCjLEIla76vRco2B/GdScvXuTL7m
 jx+1GnshempTZ1J6wUmhuECPeIFrqTthkDZ7kXjroAYMLszUKb37ffu9cx9Ut/bDK76T1ftgq
 AFIn3AEIJB5coryY3iLGfHsHGvHJdJPuzoUytKPvbwPDffCRgrcPGoyX8s9SEtKFpQfYsjCQz
 0VtSgWbQY2k7kZ0kq2JJbgQ6NVIMcJs6CThpq3qBV+iH6Yl2WI5rKXZEXU6Atm6JP5OVxcIn5
 zqvC+SC+AFJPOADjL3YKD2TgpQkKhlIcWpCbhD154wKVRztL0pBB3zKTBu8nGFE/tTX6dS/B5
 apptxTCMmBlNiQC/9Ez7+IKhWLFHx8E3gcg0Eg83SbK5rZmwe8iPa9XS9gjnVmov71YNi5Vte
 6P2BDrbEklnp88R+OVm8rkKLYxRg2qqxeL6GTSMuOY5nb4f4kqQCVLJoAwdJi5MszY9ciy11N
 AeXSxKW19R+1jwM7WOQvNC7OlEm+Md2vBhGmq60hwua+0LqSgoxWoMmeNvrcybKvIHUE+JZ2t
 P4NwcDD9YZHZn/BteTsHjF6NRhGTk7oXScyoPQy2C7IIPgki33recth7vXmQ5gBRuZBrz1OYS
 Cc5Fqmz/BCLYa9ujdOdX9sO15TKr6GJEWRQ6Qoh2R9CbeeHfriPMep0kvTxoLP56h2h2ZDMhL
 P+55/4x40M+0AmarGqcap94jW0sNv9ci3hBfE+Lh6EK/a7fojFdfDDShoqh+a3/SPcdkO1ZNe
 xSr3cR6BpQofjgPkHxCQLYoJ7nWz1AtW92yK0hTUNToLbXDVpSdFmVt4ht/e4q8/aGdLYCVcR
 jDXGWEBBkqWhRGJH8hJayrKFJxsIjqDL44wKKBuMQ4JUSRzG2DvTyv1yLUpxmfV/G95KQhKJV
 1FW0mmcJTeHP2f1EiUiu05N8UI9FVH2sJuZrDDvGTVUuE3PeDq6tIVeQSsiRBa4HJXUArpsTF
 Ea2PT2n3nUYy1T0790rF2rvViMudV7lEjVTwcKCLmwQrxyRtID9yMJMZXRrQKKSBhsFn3oAWk
 0acaZY3MZzXJlhHUGdSO6Hjd0jVvP4jCkfuHUxuYxFihfNVHaC163f7cHA9caS23Cmp5xinTz
 FTvfwtkoN2NzaFVPz09Kb+FbxXfsgM7KqP3Mduowegnr/Kjf0/PLHbGuQEeg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1170878717-1579268524=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ond=C5=99ej,

On Fri, 17 Jan 2020, Ondrej Pohorelsky wrote:

> We have encountered a bug where merge-base is missing in bash
> completion. [1]

The `merge-base` command is not considered a user-facing command:
https://github.com/git/git/blob/v2.25.0/command-list.txt#L120
(the "plumbing" in "plumbinginterrogators" means that this is supposed to
be a low-level command, to be used in scripts, but not so much
interactively).

Therefore I think that it is intentional that this command does not
tab-complete: to declutter the list when typing git<TAB><TAB>.

Ciao,
Johannes

--8323328-1170878717-1579268524=:46--
