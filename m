Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C9AC04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 13:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiG1Nsr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 09:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiG1Nso (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 09:48:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530CA62A6A
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 06:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659016117;
        bh=dubwFxN0n6K9qu6iRdzPArnKuM3oQHrOt7alJqiJvSo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cxER4+9j46Exz7xmSD8iDdnHECF5fcl59/Hauoy3+nzedSpeqqNizyDz+4mUJiYmP
         iRSuzF/U5GEqhedAl+eCAaJIyfhZ7acbNivGQ3A9pPyKw4CVxf6KZaoclnWi/YvEE5
         iQ2UtFaDSEUBxtLbiic6QSfG1T4xWe/b3q7cknPs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.196.158] ([89.1.214.237]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M59GA-1oIAL23BvY-0018cI; Thu, 28
 Jul 2022 15:48:36 +0200
Date:   Thu, 28 Jul 2022 15:48:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Eric D <eric.decosta@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: fsmonitor: perpetual trivial response
In-Reply-To: <CAMxJVdH6=dP7vwruSnKFVTT4ZgygLK_2fu5TKoRia+WyMzATXA@mail.gmail.com>
Message-ID: <840r6312-3r19-n087-68s1-rpo1n9869osn@tzk.qr>
References: <CAMxJVdH6=dP7vwruSnKFVTT4ZgygLK_2fu5TKoRia+WyMzATXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Jl9uGSpcI+3FqGOFDaERqBNMh9UzDwSqdym0CN/XeRGSxk7Z6vG
 2hrXHYZJ4Djmt4F1Zqp7tIDdNd8RlrDrOoZsbsYhSNajZw1GTf9nfS80WxdkgD/HBI6F4VG
 0bKvn4KcqlVb/crkfEOnfaojpqd54wIr0+CzTFKODNh8MWiytP5PdehSnTTp9XNt+JzUYuw
 XrPy7o1Gk1u22QFpsWjEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cxau+yoxpWo=:mXmVqcto85MNaAixbHIpeT
 eaz/KevfHoCh7yCLLepKohFrPNrVncWZf1rYMF+tkRn0NAlphC/CrSbke/GFPKNaa2xsezLFg
 GCvj7atL9xeS2rN0mX+Ktdf3EYitPk330BlRU68V2P+58rWZi7rwxaviku7MJ9LDe7hdwEUew
 uY0dnwClmB8xKO3A8hGSiCTx9fy3u0NweiigmEXJGTmQandosUfIG6/pRAEnfRAwtwPQLc7gc
 D5xmDC3nv64Ysd2JzRJR9aXsPRpW3RiZcpn7UUbxZaHIJIHAdPDIK7EZztSM7x/z4Nqv3j0GN
 rZy1Gl18ZgUvX6+JnftSxps7l9p6TabRNoY6Yiwtf+UxuAPrGY2EaFtD5P8wpSv71bGaeUxQR
 9znONaJHSkTjwihT9AjhPed1ShtACwzvRXUvfuhN45GBbNKrXGAc8MGXvzu/ptmCUhHkvXXVX
 qH6XTY50J35TIqSVtph8X/8pkJs+Uv9szLnG+h20bO1ZREx+gyoF1cWKX8trfLQwNKxsSZJtX
 MCoVrinEz9TXPDw2uXXb/YZZEon+XS9imsqxUK2BaAIQ2p/VCjoFzX4mRNX9IrGX2meIKoRRh
 C433CjR/ywo3G35HyieiqJUnGUA8vN9CKxYHDjOZ6/qlYozI/9qWPQ39debvUrof9BNPM9wQr
 FtSCAucdaLCRmdeEHc2vpLoGMlndvVrjIhDDjDPTR8K/5O0aGMSTJ6UP1KaVKe1zjVZvGXOhA
 i4xiMH09b7jqWCphhiglzznUNV2psmof76DgCCpKT5m9w3OtCB5cjZ/oNCjkwZqbQzdkN9muZ
 DEEssf+rCyD/U/wG/e4XmE352MTedng9pGdckI7dS+TPdywq6z4bsPeKUTlxA7XjXPiajFUb4
 Cn00yUGTnu883AAmbdU5Sumf6yqMWQgGP1tASX/n2aVYlBxD9mfS0u9QBQWwpak+DICrC/BV1
 +Yr2k0kN07pUSn2+oiFkP7TJeefPR4IXffqSK+DRmsyFpE0xjvuVlP8lBsO2S9joelocSdmVn
 3BGlWFeAMup4z9+KvSKfI/BOwX/3ky7IzjHgfeEp88hDKysf06f7ZUG992JbC6zOVe5H4pwpN
 ncdfRWsujcNLqapLWUefpsO0ONnUlJcGxcU2dbVbPloMKokJjf1Chdjqw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Wed, 27 Jul 2022, Eric D wrote:

> fsmonitor daemon was started in the background (i.e. git
> fsmonitor--daemon start) so I could enable trace2 logging.
>
> 15:36:37.860862 ...n/fsmonitor--daemon.c:969 | d1 | th01:ipc-server
>       | region_enter | r1  | 124.965540 |           | fsmonitor    |
> label:handle_client
> 15:36:37.860862 ...n/fsmonitor--daemon.c:970 | d1 | th01:ipc-server
>       | data         | r1  | 124.965809 |  0.000269 | fsmonitor    |
> ..request:1658950597810367000
> 15:36:37.860862 ...n/fsmonitor--daemon.c:786 | d1 | th01:ipc-server
>       | data         | r1  | 124.965892 |  0.000352 | fsmonitor    |
> ..response/token:builtin:0.12336.20220727T193432.938608Z:0
> 15:36:37.860862 ...n/fsmonitor--daemon.c:822 | d1 | th01:ipc-server
>       | data         | r1  | 124.965969 |  0.000429 | fsmonitor    |
> ..response/trivial:1
> 15:36:37.860862 ...n/fsmonitor--daemon.c:974 | d1 | th01:ipc-server
>       | region_leave | r1  | 124.966000 |  0.000460 | fsmonitor    |
> label:handle_client
> 15:38:40.079662 ...n/fsmonitor--daemon.c:969 | d1 | th02:ipc-server
>       | region_enter | r1  | 247.186960 |           | fsmonitor    |
> label:handle_client
> 15:38:40.079662 ...n/fsmonitor--daemon.c:970 | d1 | th02:ipc-server
>       | data         | r1  | 247.187067 |  0.000107 | fsmonitor    |
> ..request:1658950720017776200
> 15:38:40.079662 ...n/fsmonitor--daemon.c:786 | d1 | th02:ipc-server
>       | data         | r1  | 247.187328 |  0.000368 | fsmonitor    |
> ..response/token:builtin:0.12336.20220727T193432.938608Z:0
> 15:38:40.079662 ...n/fsmonitor--daemon.c:822 | d1 | th02:ipc-server
>       | data         | r1  | 247.187448 |  0.000488 | fsmonitor    |
> ..response/trivial:1
> 15:38:40.079662 ...n/fsmonitor--daemon.c:974 | d1 | th02:ipc-server
>       | region_leave | r1  | 247.187491 |  0.000531 | fsmonitor    |
> label:handle_client
> 15:42:14.719673 ...n/fsmonitor--daemon.c:969 | d1 | th03:ipc-server
>       | region_enter | r1  | 461.821373 |           | fsmonitor    |
> label:handle_client
> 15:42:14.719673 ...n/fsmonitor--daemon.c:970 | d1 | th03:ipc-server
>       | data         | r1  | 461.821429 |  0.000056 | fsmonitor    |
> ..request:1658950934652816400
> 15:42:14.719673 ...n/fsmonitor--daemon.c:786 | d1 | th03:ipc-server
>       | data         | r1  | 461.821467 |  0.000094 | fsmonitor    |
> ..response/token:builtin:0.12336.20220727T193432.938608Z:0
> 15:42:14.719673 ...n/fsmonitor--daemon.c:822 | d1 | th03:ipc-server
>       | data         | r1  | 461.821486 |  0.000113 | fsmonitor    |
> ..response/trivial:1
> 15:42:14.719673 ...n/fsmonitor--daemon.c:974 | d1 | th03:ipc-server
>       | region_leave | r1  | 461.821497 |  0.000124 | fsmonitor    |
> label:handle_client
>
> Note that this is a slightly hacked build of mine where I disabled the
> check for network filesystems. I also added some additional logging
> that tells me that the query is successful, it's just that the
> response is trivial. The sandbox I am using is on the network and
> being accessed from my Windows VM.

Since you already "hacked" it, why not instrument it a bit more, e.g.
offering some trace2 message for all the places where `do_trivial` is set
to 1 in builtin/fsmonitor--daemon.c?

Or maybe you need to use `GIT_TRACE2_EVENT` instead of `GIT_TRACE2_PERF`
(I vaguely remember that `error()` messages are only logged in one of
these two modes).

Ciao,
Johannes
