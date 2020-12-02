Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B25C64E8A
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 12:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F59F221FE
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 12:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgLBMkH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 07:40:07 -0500
Received: from mout.gmx.net ([212.227.15.19]:35791 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbgLBMkG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 07:40:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606912704;
        bh=w7P14V75eSGeQRSAj30ZMVglfyXUa4AHQmGB+k9Q4Vc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Vj9snuUODKQscjkra99ZZh2Lct31L/SYdFSlxhC6O5fykQIiUHiy5uPDtKNaIJCMQ
         pGTZmead1bTbaoaj3jkSIjgqQkK8Fv2oC0M7DX8u8eslDWtPsgR7QhHFIaHthZ0aH4
         7cHndfFAYfMggZZgUr9qFI+X61fI6Pv0Riy1H628=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.88.62] ([213.196.213.207]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7K3i-1kpxBU05XA-007hbl; Wed, 02
 Dec 2020 13:38:24 +0100
Date:   Wed, 2 Dec 2020 12:03:06 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] gitignore: remove entry for git serve
In-Reply-To: <4e30fa82-fe24-1783-6f9a-13e1dd6f4ca9@web.de>
Message-ID: <nycvar.QRO.7.76.6.2012021202490.25979@tvgsbejvaqbjf.bet>
References: <20201201004649.57548-1-felipe.contreras@gmail.com> <20201201004649.57548-3-felipe.contreras@gmail.com> <xmqqczztqszv.fsf@gitster.c.googlers.com> <X8b7UMcsfaD0OFv4@coredump.intra.peff.net> <4e30fa82-fe24-1783-6f9a-13e1dd6f4ca9@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1281359522-1606906988=:25979"
X-Provags-ID: V03:K1:0eHOQx4OXV4iLcW7rJ+JlGEvP4VxL1Y+oU3AExdCJj/DBAkZBZx
 IomnJuwjTO/i/wrQS6MPIooA1C/CMktWWrtWq+rtD+KJzsw7PJ87UdstHa7A4Ea4aXXd+gU
 vn0c/eiuSfnFsTdAph6XfESNa0myIOFnVZUDknVufv1Zw7fh0EIQxOs+CX7LAuXS+qRx2ni
 biZo1W6/LVP9gCbWGeJng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bVH55fW8+2U=:O/ZgvVFJlzSM4ukFmUSZg9
 5t8+gfGeaGTkBh7+O6YNSb8NT38Ry5J9tcTQ8ADlmA2zkNe6hYGeL2DUkqhuPkqe+5vqf/jLJ
 +aFfdnUp9UjKIOJ7vlhvsX5JY66VIkFtUZakUy54eTBmcnctRjjQ7Rnk8SVJ+rabtW+7li8HN
 HMqCgZWxrjrO2YyRUIy/lPwHl4ubFXWyO6n4qVgLSRtrgU6i4pHQGtjwZYbbLGWFpj2XS9DMT
 CKKcHgM5c82+OAVtKXQQaawCJXjTrLoob9i1uINTC8DQ9GJgXlleZYoz4OQwBIsWF8u8IIKPZ
 o6Nh4i2ap0o16BV5Potm/UvtASq5j0nU1rFDxfes9KNvW40cl+2hJJ6DA7wNsh3RFF7iJ6K+/
 tYNNjCYLT9sBoHABmunGTpiN2guxZFXqK23nUzaB/IQ9vdkLRDcazE6fxKfAAvcPAC3ELcE4x
 JObH59BIzpPxbexr3VKLfwvbN5PETHBBCUhW4lSfiOaNLEDAFjV68FuvOdVUdKFt29TyINTA2
 zjGLQZCI/2SyK1xG885YLDWGSDbkewjzvFD4Pj2Mhnhtz1x8z69xpXHEENKYiAc22+VdcMDWa
 OvYaX61s6jbnyNp9EEexAWcWuuaytpWSkKnGLfFVnntpi5aohs4+l2mf43w6c9AGgx1RmRC9j
 UYg+t9y1phMMK4A2cSxAFbMtfo5r6O+R5kI561LIt5jE2ZEldXsZiatm5O4vbECLrnxs20Ygz
 zS4uQirXUZP5wqSMn9rhTsCMe1fl44DAIlZ/h6rJ0Q4vi+DPiZzNKsa5BpdaE2HDwO2QTLfTP
 SaJhg1F1YY4gw6HFTf0Gfq+1YLXHQDnDkyYTagpcxWXvIYh/abI8Dlyom6RP09z9sYaBRNOXP
 4DRtPBzOzm8OBxSoftsJmwv6UdUGHy3fg9Z+Y/3u8=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1281359522-1606906988=:25979
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ren=C3=A9,

On Wed, 2 Dec 2020, Ren=C3=A9 Scharfe wrote:

> b7ce24d095 (Turn `git serve` into a test helper, 2019-04-18) demoted git
> serve from a builtin command to a test helper.  As a result the
> git-serve binary is no longer built and thus doesn't have to be ignored
> anymore.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>

ACK!
Dscho

> ---
>  .gitignore | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/.gitignore b/.gitignore
> index f85d02c854..28c079f227 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -148,7 +148,6 @@
>  /git-rm
>  /git-send-email
>  /git-send-pack
> -/git-serve
>  /git-sh-i18n
>  /git-sh-i18n--envsubst
>  /git-sh-setup
> --
> 2.29.2
>

--8323328-1281359522-1606906988=:25979--
