Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 500031F732
	for <e@80x24.org>; Sat,  3 Aug 2019 20:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbfHCUnT (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Aug 2019 16:43:19 -0400
Received: from mout.gmx.net ([212.227.15.15]:42845 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728508AbfHCUnS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Aug 2019 16:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564864991;
        bh=VVjoBScNB+i1St3evj3urMXaDWqAIFXZu+h+G7rqIBY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hBldDlE8viSjYJ9SHpjpepSFkGTnaIpGLlZuOqfILiKu57SxvZDNgPorx1sZsJn+J
         8H/M0RiPazndt1RdP4S8zWLkU38yRuWKpjKqbnH0ZKrKS97k4ZPYPH1VcAvS4kDnCk
         4+KaXZu4LI4pYGOPsFALGlZZ9YsaS4TKx3J99VbA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7QxL-1iPOC22yXV-017np5; Sat, 03
 Aug 2019 22:43:11 +0200
Date:   Sat, 3 Aug 2019 22:42:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Git for Windows v2.23.0-rc1, was Re: [ANNOUNCE] Git v2.23.0-rc1
In-Reply-To: <xmqq36ijjk8i.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1908032241270.46@tvgsbejvaqbjf.bet>
References: <xmqq36ijjk8i.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:umuXr0o4kGIdHyCRcx2ZCdo9c2ssdfoMI0cF66gM677Qjzq/KA3
 ZXNu5f4fruPAVY1kZVBXgQDPefkjT7TUC0L167578/xkAjjDH3Fsl6AoZd36+DTMTiflOqj
 Joruf+LrXqcyCgpCuQRRu5GwcO8iX9h+Zysk5Zv9rlL/VV164EmbVguQX2O7a4DzWEBXJ++
 yZ7RHggKjHqXoe8vx+Xrw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mVocDVznqZw=:rZIUsYYUvrZVhFsfAEbFTh
 SHshzVV1s603qbFLIKuAAA94XZnVir6HHO2h/mo3xHkYNau3inElCFZ+Qt4wec+CwOsT2IF6W
 k/cao6G2kvIS6HpQjE++J8UJAkqIg60B1/UVSO9IsrQExJoFD6hRYfoKPpLpJCKg/w2KonhEJ
 89KJcldMYu1OZFGbD393gI84/gGRbzq2Ol8A/0yNBFaRQ7E8+BbZukfSg/NfJxiW+IlLgo/OD
 p8NLLSoCdYzyXomWigLa0byoV42iuWjkbyp0ArnbQrj/UnOOyiFeKQxZPN5zgHXh+YyeI8J8e
 4pzWUA0K8sH9z4HgP6j0NzDOZxA+tSm3wnBY9PchWzWAZTma/Tqq6bIIR9Dwy2DbjEQcLAyqh
 W6S3NSjCXmNN0MjRCbc4JxSzxG9/sMPI1kNqCTfgIpXxcb9o4zS0G6jvimtL1RMB/tJtqZVzZ
 3ZA/fjDkdoJq1PtRNatPuU/R+0L3zDmKTk9oiusxiBPN41kfI+hnXjOIWf7Hljj2VK6akZ5Jx
 /28TpdvYC/52HqnSTcj6W4/ChKYge2pvSoJgnxDglrzDAhliCXnW4zZQlftLvVZekIp0uOVGn
 Ssi6FHjgF9w5h3IUlzyMV3iKxxIn0D3I21q80h4poN8EaBvZEP6FIR6ewupQ06tn47cu0PHa5
 QrxlEVPrVoTF2KMgUfU3qCNe4V42yKSFrL+8K0h4g3Dzd9kK/sTQnKVaJMHJUZ8iJiAPZx5zI
 FEhVqxVJtz+jwDvJjqntlF/MoIuzdmS0j6kgmJfOaFnSah6ekqQZg/7q98RHk3EZqwPiN0pkM
 W0lmpo0sG8X7yMmVpTFP0MNRPEOPIXTgTJ3hjT+McQGLzMOGe0sFfwqNDJUuhFJMKTnseuAqA
 EqGnhzYUSSeYorCfF22FViWaZJv+K60JdaThX8/DeBYcM5xm1sLw3pc8WZp9L2P8vML582BQz
 27rt92IOxOad+jaUyqhCyUUcrll/3qf2Up0Nssd+ZVjXldUVGguDIDIiyBdJ3ZN11s+oqi0n6
 +2GkZGw1XvYKv22NzPjIcBuI9IzWhsPEguzyNLBi94soZzMXL6EGuXrn5R2KfYFJihnFjHj/Z
 mdmnY8m8z0iJrZKYmW4PrmCgSeCaLAhZrrIQmZUI1ZMXljPFCSIzuCe57z9R+UyKzo91uCNvC
 QkIgo=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Team,

On Fri, 2 Aug 2019, Junio C Hamano wrote:

> A release candidate Git v2.23.0-rc1 is now available for testing
> at the usual places.  It is comprised of 471 non-merge commits
> since v2.22.0, contributed by 63 people, 23 of which are new faces.
>
> The tarballs are found at:
>
>     https://www.kernel.org/pub/software/scm/git/testing/

The corresponding Git for Windows v2.23.0-rc1 can be found here:

https://github.com/git-for-windows/git/releases/tag/v2.23.0-rc1.windows.1

Thanks,
Johannes
