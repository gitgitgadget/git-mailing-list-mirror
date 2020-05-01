Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9E4C35280
	for <git@archiver.kernel.org>; Fri,  1 May 2020 20:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 154E4208DB
	for <git@archiver.kernel.org>; Fri,  1 May 2020 20:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ZBHgAjt8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgEAUKI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 16:10:08 -0400
Received: from mout.gmx.net ([212.227.15.18]:39907 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgEAUKH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 16:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588363793;
        bh=hceJkCRCtyuWGuPMhA4qWN0UY6xHskpMLxZHFBG0R3c=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZBHgAjt8L/+9yHfpqam2BI44GcuUlLgG/cNHm08fD9bYFB4ue3djYFofDUNslzflk
         U9QCmj1ZboUqQdz+LY3HvgFHnt1LhMWqBCoyKIaX9ukuCtY8RItTY2b2sw73fWLazA
         Lxfy5v8F/PeJMYRjBleLUWXZ98w3nZM8klDCMCsk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.213.255]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N3se2-1j4BDF0Yca-00zq2m; Fri, 01 May 2020 22:09:53 +0200
Date:   Fri, 1 May 2020 22:09:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>
cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 4/4] progress.c: silence cgcc suggestion about internal
 linkage
In-Reply-To: <d66d9aa677944205cdd5af77192c35ec929692ea.1587996766.git.congdanhqx@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2005012206300.18039@tvgsbejvaqbjf.bet>
References: <cover.1587648870.git.congdanhqx@gmail.com> <cover.1587996765.git.congdanhqx@gmail.com> <d66d9aa677944205cdd5af77192c35ec929692ea.1587996766.git.congdanhqx@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-253040544-1588363793=:18039"
X-Provags-ID: V03:K1:H15rLrblUm6uLzB6B9ORcMmglJLu3dY7o7Ex1gTpfhAJK2AS3W+
 h6gRXKcQ4r+v1EJ8gBx94H9UUaO046IH6euPiA2xfdckhn/+uKaQRjkpMVLkKBClDljRd4P
 /dX7P5YQDa/hQ64zI8K0jLwP/6nQhQUMciY71FR3xQaizALx8d5seMEw6dsiVm7ODqLk7mK
 pIF4789u5LA3WEeG93zEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xqUfT8eY9bQ=:++zyGYSccqK4mWxuIBCXrh
 AgtOnOgeXB6nK8EeOjTtdyyyZfSJTTYp0o65jr/ulZkbbVmMQe3aANmlJR2PVp5Cy4FMaRYxb
 O1G69L/1Rz7Yuimubzon5T7uMFcAvfeKnARg84ZYsFOLVE8C34YjYUmhfi5uwBnHU5/LWHGma
 aHkqCLTS8AEVRnHHWMj7MscKZfYbumoljml5w3l119v/vQ96+GgS3qok5aXSxd6fLrOBTdRJG
 0em6AAhhZaCe9NZpV4JdbmHKkJFB/sT0dH7iqudUqarsm87aeVhwE1d0wnoeKSCqQUflBDM9j
 NUVITn9Vc4qv/2WuQMGs52bg7DuR890AoD4i18l4XXy+8gRvSCdbhIq9wj3q472+QNG8NWMAG
 5H0PcADHHgxpRZUcm4ov/xcMP2GQvDKhlKBoJ7jieLjyjSOsX53teFAtRSb8JMmT4LXk6Frb/
 rnh/nnbJJ8Jr7p6IrLe05ImwzxbxKsQfon+yo2zLhgeyLIbOUoah2gWLzUKWikTw29+cx61Sn
 5NEIbl+LK+HYKo4O4u8b0TGL5iaixQwQwV1X6wNzp9CzNQd0J9hDAu1CkY4R8ud69DizwMcRm
 N+fxDYsDloEN6pyzFpQ84M4yZcmiVcnVVWAgS2efQIbwYeHnprRWFn9FwO/ZGSDf3fV3NxO/y
 77NJmMxrHxO4leBimfyBuQyrCpHRxx2hEw57h74o9LbGnkAFpc/W0UnVUp/kcw8Tv/9un8CO1
 IQYnPb4Y3S2vJoOFuhTngwdB70HtRSXTvHayTjjegoUoEnXqORxd9bvG89+QefsU58H1vJhA4
 YUR+3RDQnOkS/TIfqa5bvWQQ1O+Pv5byP/v2QVv9gTJyV6tUbyq9aUUOoOp6dMOGbBRHF6+bn
 cygZgoo1H1D5TmSlpMMehP5Dulc9VEaWmffyPM2A1JIoDub0MZwDO/SIqtuFMVeETMIzErIWx
 gqAzvrNLOKWU3RAN/yIAifi89IA+IE5sX2rquneMAgJRzBabDWmUcNgGS86uSUZJwb2NwNyhZ
 DRC0tGo31DxPzLxO1v1tNdP2/Fa7EnuZgnp+VrjQVn+MthwciVdjouElw9lfuSTsJpVT9exlN
 akX9Xede2kKJDJHYHpM6Q/JaAM8LqZkDopsEPGD2cEfx25FywZA4Qld1WxgpfNekoi7+lU+NU
 Tge1vZ7iK7HJivbQrsu6phrLeBh0+J+YTV1StLZ4O3hV+iyodOT5seHrTMEq8tT3MsKwxxyMK
 qt4VgAKt6AbGBhPF5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-253040544-1588363793=:18039
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 27 Apr 2020, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

> diff --git a/progress.h b/progress.h
> index 847338911f..f1913acf73 100644
> --- a/progress.h
> +++ b/progress.h
> @@ -3,6 +3,14 @@
>
>  struct progress;
>
> +#ifdef GIT_TEST_PROGRESS_ONLY
> +
> +extern int progress_testing;
> +extern uint64_t progress_test_ns;
> +void progress_test_force_update(void);
> +
> +#endif
> +
>  void display_throughput(struct progress *progress, uint64_t total);
>  void display_progress(struct progress *progress, uint64_t n);
>  struct progress *start_progress(const char *title, uint64_t total);

A slightly cleaner strategy would be to add a separate header file, say,
`progress-internal.h` or `internal/progress.h` to declare the variables
and the function.

I guess at some stage we really need to define a proper API of libgit.a.
Just because we refuse to declare such an API doesn't mean that people
don't use libgit.a in that way (e.g. cgit, cinnabar). We might just as
well face reality and split up `cache.h` and put the API part into header
files in a subdirectory `include/`.

Ciao,
Dscho

--8323328-253040544-1588363793=:18039--
