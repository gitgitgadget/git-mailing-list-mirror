Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAE6C11D00
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 22:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F77206F4
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 22:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="F9XTCIBa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbgBTWdL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 17:33:11 -0500
Received: from mout.gmx.net ([212.227.17.21]:50185 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728582AbgBTWdL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 17:33:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582237988;
        bh=CaRKc/4dUfQbkYCXkmsPnhuthMZpHqanSV4dF2vqDAg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=F9XTCIBaRQeGtIl6H1ZjSmuyeqVsrAF0tRYtzNpNNsXjpvHaRNY/myFtpL6ShPIBt
         A2ORupG67xSb/lD/UAFT3JnLcORMcy3HYLvsOzsI7S7MYNCn9n03UA8h9Nx8qV0rku
         3aOWLlvt6yCiALSUmQKl/mqod+VzMhadIuAg5VQk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mq2jC-1jqwly33Ja-00nD3I; Thu, 20
 Feb 2020 23:33:08 +0100
Date:   Thu, 20 Feb 2020 23:33:05 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 06/15] bugreport: add compiler info
In-Reply-To: <20200219224547.GC26221@google.com>
Message-ID: <nycvar.QRO.7.76.6.2002202306390.46@tvgsbejvaqbjf.bet>
References: <20200214015343.201946-1-emilyshaffer@google.com> <20200214015343.201946-7-emilyshaffer@google.com> <nycvar.QRO.7.76.6.2002191521140.46@tvgsbejvaqbjf.bet> <20200219224547.GC26221@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nk2aeqTFxEumrkjfLRH4drA8a5qsBlR4kVf1mfbheizXyt5uYYo
 Lv/pavZwxnx5oANYyjwRs1KdU2CmsfmLnG51/hwmAA5qR+qV+/aR/Gvzo9gqUcx/6yeEcIb
 2q5EV8wE/ilbaxu/E9OxxxFPRudpRXeRhQ2QYZqrS57wHmwk+jtLZC2r6h3kaFHFXY4HhWU
 +ELXxu68FBFLzBE5MfBQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CUZQEK8wIaw=:feKmjDPhlTS0Nf8vpl61/w
 e5RU4VGHEi+yLm7l7FjfZURBg5eoQ4ur692y/R0Taq1D+e0Oi3mz6zd5lgeoJothfSfbJd8oY
 POA/bGn+esqYPiCGA3o9zDp5Pn5E9Jiz4UOxm/h/dtGeMULg7m0E+X7KEs0ABunD8ftkRWjQA
 cEAj7YSdY5+nkxtgs3J9HQYkr6kUISiFOJQvazmsvHQY/8L/UmfGT3Lgi9NAlim1U3slFOUL6
 tAa3o8iGd2TVklGIjHNBa6c3LI8gFuk+TG4Bhoi2q4YDxUtHIhmf37jnONX3deKOk+yk1ElQD
 NJ8jtZRC2nahSC5TLJ0a3OZOKIstC1q3ywqb9CxQDFBtEdzhdMXYQX5G5F6RvR/VVCs7fFdj1
 r8v02lOs4z0fefBK2C6kBHFt5Rxtpt9afx62tbnj1n2rUna7gm8gs0hoU7CWYxqZzJRSyp7Cs
 oSwhTw/exZqsMqu5QuY6kvcHfRp7S9+RQ4SgrsFHzm/+tJU15k9swqdWmx/E/3LoYSQJAmNyN
 mqVfZVDqIgdYzelfa+LCWlKkDU+1a9q5DYcCW2g5tyGAH2hq/Nsj87t/XtbkIRb9wXMJ6BkP/
 jlVqL8PxEfcagHZnEgtgdktWt+/ePo6R2KCudVFTjyWBX9VBoUEw6mldKmtv0IS8LT6uhb5zy
 chiupRb7MV+BgqTqRk0mnIzvCasAd4DwplNQVexAdLmUEMpR7kf47+PcyUffsSnZ8eOIc1CSh
 OhzkP6MJBSbqKA7OLSmqQf5VpK0s5ozGIFb1NiRqMh2Vs+aUhSpxseAO/AUZ9fc+13AEQoEOo
 gDPwibAqkfzSezEojhkWIb0B54bLBTNu/NpwYrDRNP+AdNAINbQHoh1gdWgIj+2kvZBctuwHJ
 VhoDnl+aZ0rST/VxrclEl2zQWUSCNlR06Euq2WVyXcndf9ggiTFkVkB1FhyfYaAV2D6cf5yf+
 Gq/HAr/yCK2NNqm1uxJLwgADn77QK74ma8PfxUiAXoecJIaydUpENxo0uUFrsqYCNVFYjZWoF
 xsZplb0bBsDGzIgDcUu/7yuDk/iocRo28Hl9Mqqfm+ppQX09Ect1K4LZIVVYVwhvR9H+WeU4D
 mrD0wXTG3C114KA4RiTIAxD3VLcQ1x/yCy/BHF5BbBeKdVNYd35hT2PtvvahUQZw8FB6Eb9IH
 cjNef39vQhYYz3cAMmQ6fCU5kho07yjwD7tU8tD5y63JIwAmkr6g4Eq3iGYKjrXtM2OHeU0zy
 GlaLUiDWUS3BE3/Yu
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Wed, 19 Feb 2020, Emily Shaffer wrote:

>   #ifdef __GLIBC__
>   #include <gnu/libc-version.h>
>   #endif
>
>   static inline void get_compiler_info(struct strbuf *info)
>   {
>   	#ifdef __GLIBC__
> 	strbuf_addf(info, "glibc: %s\n", gnu_get_libc_version());
> 	#endif
>
> 	#ifdef __GNUC__
> 	strbuf_addf(info, "gnuc: %d.%d\n", __GNUC__, __GNUC_MINOR__);
> 	#endif
>
> 	#ifdef _MSC_VER
> 	strbuf_addf(info, "msc runtime: %s\n", some_msc_info());

You could do it this way right away:

	strbuf_addf(info, "MSVC version: %d.%d\n",
		    _MSC_VER / 100, _MSC_VER % 100);

Note: this is _not_ the MSVC _runtime_ version, but really the compiler
version.

You could also use _MSC_FULL_VER, which is a bit more complete.

> 	#endif
>   }
>
> The thinking being - this way if I decide to use, say, LLVM + glibc,
> then I don't need to reimplement this command with all the glibc
> diagnostics again. Or, if someone else already wrote diagnostics for
> LLVM with some other libc, then it even Just Works for me and my new
> combination.
>
> That said, I'm reasoning about these combinations of compilers and libcs
> and whatever else from an inexperienced viewpoint, so maybe this isn't
> necessary?

I would have hoped that the argument I made earlier about the broken GCC
version would have convinced you that the answer to this question is: Yes,
this is necessary.

Ciao,
Dscho

>
>  - Emily
>
