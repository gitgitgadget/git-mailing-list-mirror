Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D833F1F461
	for <e@80x24.org>; Tue, 25 Jun 2019 10:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbfFYKt6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 06:49:58 -0400
Received: from mout.gmx.net ([212.227.17.21]:54725 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfFYKt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 06:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561459781;
        bh=btcWs/TK+VsG1/714TwT+v4GBAx5bi7qXoyYfuWLQWg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=M+6Y8uFyGatcy6hmFZv1/LV3+C/c64dc0/9prEIBn57PBVa/GAM3JUDBGkwY/8Zg+
         rGsG5Wp0frCxaTHSa2r6Hgo51ccRMDtqjgsQM3zqGzLeWS7UYbhWMWr68Y9MiozDiW
         763WzKdjvchjakHoN95F3hT61vRBP+tBGPNI36/M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LoJDJ-1iCHoz3mvZ-00gEty; Tue, 25
 Jun 2019 12:49:41 +0200
Date:   Tue, 25 Jun 2019 12:50:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: vger vs GitGitGadget, was Re: [PATCH v3 1/1] t0001: fix on
 case-insensitive filesystems
In-Reply-To: <xmqqftnyhkyu.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1906251147581.44@tvgsbejvaqbjf.bet>
References: <pull.151.v2.git.gitgitgadget@gmail.com> <pull.151.v3.git.gitgitgadget@gmail.com> <1f0ceee8687e9032a7777f764b34b1c9ccc68f38.1561379363.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.1906241938450.44@tvgsbejvaqbjf.bet>
 <xmqqftnyhkyu.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:xAeqGPY/9d4aRINHDvee8CMGI8kWJ/+kzxxkDiIQ/MeVqUMNdJx
 zhLUweTaTq4yB8rLy9yDxPvGhGKmaF0AwflHyzKDoL3fF140OCzPPCTzjr5/QcK9kIWXlV1
 ooPxI8POL2JVoSfXQwkCF1Z5E6HqdvFCpqbuczkRdhtIjrSLJDS6uIX3oIiOIMSp/KyhqzK
 bI/K/zK0U4wELYZdqdPzg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Kg+mLs1FlSM=:UwTiKL1eF48UPxRazjldsr
 c4643tDKzliYPymzSPQCQ1u3mELu2JfHcyyueKSqDpbuHP9FjNBWW1tq32TV/ViDY68lrr0xd
 HA2j9PWCkOmSGBjW+hNa9XsnxeP17V4ujrNNn1LVCdKCLnxuES5lxJJykEr8mEBZaSFS+Qa+U
 BKFFrLUWazudz5GvpqLVMQ7e1wO44gs7qrny6IPmtlP9QntWeL799lZ7SvMiQeNRx4Zqd1xRI
 fN1HHwUcv1hWQczZfH/iudj1VrVEbT8jBL6XoAqqYM1MMfAIUXem5TYaU/9WeW6nHseYXj81s
 igyka2QdiRvLv4W/Avrjp7/XF/dHxkaLUrPCXPJEyZGQGWNiC98pyz+wXcJVr9jQarrKcZBn0
 pD6/JSdtcqWqrWcUHiWmiG9yQnfNIDEYkB07NhY0Y+p5fT1BP3eKy9UNX1QwCjlzohCpjKR3w
 aHKXcQcVm8F7duxGBHZiiyFvR88TV3N9JmWw+zfA52+vH+n0zCOgB9JCgVpEvDoB8hBpcFSbH
 c8L5W79CBn93fWrAcpgl7Ke8KdlwGDhKkGrNFfV2ELwjggyY6/JQ+mnPeShgJj1hVycjfvQmS
 uXE/3+wouS8oqEYrshwFGZcAptRlgWifrjpK9DRCN+l2wK5YilezDCpnlhiJ78P/i657QgAPs
 syxeDMNn8sr8VCPusAnbcd999Pd7/VreleH0aMomCL0ii89RLr93xS2ACGwj2myF7jTkLvxRF
 YjJhb6yXzi2MgWiqt2AYbl9sJYnOULrYAfSM7/wRQr12kEd5NxIa6UWwnQPmuazRTHl1hCG1k
 gu4pXlez42RNqo6FGEmtsg753YDEeWtKISLcyCOG/26A5XPzl/HBLhu1h8nVzQwdyOy7FBiAh
 AEKggCqcGQXSM1cAox120apJHcXvswb4AnHEftESFhXI98Z19H2ynNZaS0aJkAbPKRKLDFAb5
 DasJzvcZvTgM28ncChunV8LxiIwoynO3AeiImj+Pw/AHK5KtDI9cW
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 24 Jun 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > ---
> >
> > 	Again, re-sending, as something in the mail (my guess is the
> > 	non-ASCII character in Martin's surname) seems to upset vger so
> > 	much that it drops the mail unceremoniously.
>
> Hmph, but in the copy I am responding to, I can see non-ASCII
> Martin's surname in the CC: header just fine, so vger may not
> be at fault, perhaps?

You can see the non-ASCII surname fine because you are responding to my
reply, which I sent via Alpine.

The original mail was sent by GitGitGadget via nodemailer, using GMail's
SMTP end point, and the fact that _I_ received it means that it was
partially successful in delivering that mail.

I can only assume that GMX or Alpine did something to the mail that made
it look better to vger.

*goes-to-unleash-the-power-of-investigation*

So I have a theory now why vger regurgitated on that mail: it had the
unquoted name brian m. carlson in the Cc: line.

Expecting that this is the culprit, I opened
https://github.com/gitgitgadget/gitgitgadget/pull/98 to fix that.

Thanks,
Dscho
