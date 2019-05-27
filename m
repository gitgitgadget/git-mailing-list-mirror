Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73B661F462
	for <e@80x24.org>; Mon, 27 May 2019 18:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfE0Sr6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 May 2019 14:47:58 -0400
Received: from mout.gmx.net ([212.227.15.18]:49429 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbfE0Sr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 May 2019 14:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558982876;
        bh=edAskqX+cUfcirDpOqQ4GISBTJiL1w0QGluCupDiGIo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=akY3holwvdV621K5J4fjqtaVUPZArfqQqCsQ0m0zxHMQfCnvH7IgpaBDh4MZJOzLm
         6Omb/yDA5+05M0LQpRotLQsYFmMvMFuvs7CTKzw0YvC4iLhm9RM+jrqFO2V3Fyn+ud
         RXIWoV5cO5i1jDCsW7K5AwPCXvmxMqfM38qVRUnA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M2Ldk-1gde4u1WHk-00s4Nk; Mon, 27
 May 2019 20:47:56 +0200
Date:   Mon, 27 May 2019 20:47:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Brendan Boerner <bboerner.biz@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: 'git stash list' => Segmentation fault
In-Reply-To: <CAKkfZL2p8yFr3ecsQ63HzeZ+u-Jukf7YcYHk_8iBaKcA4WbEfg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1905272046250.47@tvgsbejvaqbjf.bet>
References: <CAKkfZL2p8yFr3ecsQ63HzeZ+u-Jukf7YcYHk_8iBaKcA4WbEfg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:sTgVen/8Qes0aqiR4f6Bqk9iK9sSnXy0x6rtGZJnxSdCtam7AWr
 6Mo4X6t6mipBBRxkm4avvOoe8Sg7Ei2+CaxRbyhmD3/2IwGTdE7CUsy/LMkNpXQKYKI592e
 YetObQx0zFjm4nXVN8TONxrzI2mCsx8oT02wl+d4QFQgCdxExanfzlL4Q9vtob5Mox67aef
 vof7A+m8yR/ow8tpi7+7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZbLc33A3aI8=:6Z2RCSv8dVc1+8r5mrwvtp
 DZkNtlsfKNjPcX0V4IEywHbOWH8jqgLek7ZgJowKSJH2PaQCwsuB0VeGYB9eHC1f0LQor2LG/
 dQi72Y3+TaBX6ETt1YulB/Vji38SYEgnB/S3L/A8rbTOoEi+pDqcTuzNvAQta/ry42aLHZEgl
 CMYML7+BOpMmbw+I9tbAyGPbNGkFbBONYX/k8lJACtJ3JNHk8xfwtP3dDM79c9dPh2PUZ2Ywv
 v0HjHH4HPQRwUbq0FxcPs1miDjFL6dngwYWmcLl0ftZV5lnj475NHIgt5kTtkFpo6j7YCsN+k
 I6gK/hKFtffw2gm5DVDV2PM8EHbBOY5L1U8EDEfxphN8hyiXfIx/PQFCOmdw6/31bRtVISDdL
 VECa58DIPSQBbggEFf4ptTj/+VhXLMGJVt0PsLzi2DLN9gtGnda4bGUKsMAzxUYB8sMpfMFaz
 ThcC0jmN2FTKfC67An8sSix35CaSyNGSH2yDePdHJtl3Z+SipTco1KJ2Uvm6B4YvcVi9V1agr
 0yqXZPoHCpprpszFUZX61F4b49EFnSfAR93RsctleJswaWm5wUlGfCKojBxcr6dpazhqYMlfc
 gdTp8X2RjyayycaZp/Nd5teEmvtLJ7B2SCsiwytj5pV9JV9Lkouwxmk+kqt3XnOGe8TJZr4t6
 e/nvO97S+gQFT74D7e4sUX7Q7w+Pch0Dpfx13L7GoezN+A1c88WQfY0eCGQrNnYyHOfZcroJb
 fpGiBtCTiViYGXYHq7ZzBUJqaSSmtsePcjN2ZZg6GcHKV0PUQ77Od0wbG+jINMp2T0gqnoODk
 mdLnisGp/BPLITxvYHmqAXhJzLQI69gI7sNVyLa2rc3I5n3Igu3xtAs1fWL4jvgRA8NSp/SOI
 T/q6392EUF3DWlmyoZfVfs9CMO3RptoAZ9TfofSQyP0G7K67ZmQBkVRaZbbGt5eVVFPhZUtat
 R0IOlOzXgHddWeszy4rD2HH4slkd1mcp7eHxgTcvAM7ADN5QlzlGd
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brendan,

On Fri, 24 May 2019, Brendan Boerner wrote:

> Ubuntu 14.04
>
> I was using some prior v2.x using linuxbrew, everything was fine, took
> an update, this started happening.
>
> I verified also happens using the 2.21.0 from the Ubuntu 14.04 PPA
> (this reproduction was using that build, not linuxbrew build).
>
> bboerner@myhost:~/funproject/Src/bash$ git --version
> git version 2.21.0
>
> bboerner@myhost:~/funproject/Src/bash$ git stash list
> Segmentation fault (core dumped)
> Segmentation fault (core dumped)
> Segmentation fault (core dumped)
> stash@{0}: On devel: NYFL optimization
> stash@{1}: On GL285: gl285

Unfortunately, this leaves *very* little in the way of actionable
evidence. Would it be possible for you to share a tar'red up copy of the
.git/ directory? Or do you find that this happens for all of your stashes?
What is the output when you run this with `GIT_TRACE=3D1`?

Ciao,
Johannes
