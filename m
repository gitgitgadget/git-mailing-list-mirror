Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C8BC33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 23:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753EC20731
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 23:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="T562CJ7n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgAFXHZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 18:07:25 -0500
Received: from mout.gmx.net ([212.227.17.22]:50387 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbgAFXHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 18:07:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578352043;
        bh=msoQG8s0StrBEP5gFqAQ5NGkAt+idplxvW+s5MG8Wwk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=T562CJ7nq7938xIwADR8zxl+zPOk+nLfEmEyLYXGcsXYgLQ8gjhOWTu1NguXLj2l9
         GxNch4oL/dyteQmkia/kpkSvh2Z6lhNvUCGTLmK9lT7vckr01af1nZkOE58rqwW13A
         j4miFtw5xmTBpIVbm/YpHoDE1okyEPQNqnkwRv8I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZTqg-1jBAQH24hC-00WTfJ; Tue, 07
 Jan 2020 00:07:23 +0100
Date:   Tue, 7 Jan 2020 00:07:23 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Nirmal Khedkar <nirmalhk7@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: Fwd: My Introduction and a Doubt
In-Reply-To: <CAFFaXsx3Mtrq4mEGq6GYct7ZcRtucmZdRG-PQmjLrvVVTfq2Wg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001070007011.46@tvgsbejvaqbjf.bet>
References: <CAFFaXszwB6F-Y9hHWW5ZuvuFSPqrOwkK=c2wUVMDm4yGq44X-Q@mail.gmail.com> <CAFFaXszUdyfun1W0TuvJuRihLo7Mz-XYL13Fm5gCv_gWrir-_Q@mail.gmail.com> <CAFFaXsx3Mtrq4mEGq6GYct7ZcRtucmZdRG-PQmjLrvVVTfq2Wg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bgz0Eb/0NFGVQ4owqAu6BZLDt0DMeEWFdKVHgtTYPRQ9rG9n0QE
 aYozE7xm8PcoFJqlHJao5tz8McGKXTA65v0J31rCXjlLmrVvkiU0A+0GMuSlrGX2PQ8OiM2
 bL1kQ4asZybhQvLq6J9w56B69u9nE+RBUrdH3ohRL3t5BysOPErsCFjRyeCVIkdvPLntmCi
 MII4vC2f3MAHiYIv7aIKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0ZgA9a73nBI=:/td6GXVWFA8TgaRsqZAny5
 XnRE/14PI5Kr81Y0iXOgf2bZrpWDQfIatOvmixHcHAZAnhRTb326CgRM0wwMNi28QUyufm8dm
 uKzz1sf182HfDC/lNt0JidlmjJWI8e0tHg6f0PqpiVEJZhSKJEODjUYJIBate9kCJH5rb2JR5
 eiaX7FgnPNFmAFm0S7Jj08ID9Kyb59XlC3cPtxO5cdEWfmlQXVh8dXPZK+GT+Hukg7ZRKOmlX
 nqHxwh/s3L2UvrJrpw6/dfQ4TaGF193i4R9Ajz1Ae9LHCYejjqxE2+d2Vl4MgV9Od5frWF6oW
 LO5laqCV0A4qPf7YdCE/klpEYTr07y2EM1Ua4QR4H8jlvYsLJde7RzaMnOH0f8x+SFSWe3LED
 G0HJWDSUhsXnHRfI+CfCj9CkeucOnwmN0BCH5J0gpY5s1dmQg0xv2SiAhQu6OyRFgoTV/Ivrs
 Tltc5xSUkOxmOlaP2lYBnZQzWwaurFALxCXSbfavOz0Z4sxMdg43dlORfaY1Et+R9szTllCNf
 tO7DJcdI0r0DN+rdOwbI54H9MurRHPeIqHU1AR3e3XM1b3UzFbtQvt6qoOa0yNkyZzVBxBr0v
 e3R6FYSz1YDl174+XHG8czTPfZNr314oEGfnBqlnDH02MY81QWKZj/M9ChCvg1RP77MqIGEf2
 wrwOPcoBDJJBpaySzAlsHueB2GsKimc9QuEYUbKZ/6YfEL1hqlITdK0IsQ3ogeyM355cOic0p
 eVypYsDD1VQs1GbsfO2kSmHajrdYwnzVLBhE9WO10pWcO8baxUZOx3BJNP0oLM4K+W+ZzEBRg
 t3nAHCosL7Eyw5d6yCVo4y9p8aPlDzcgqhZxn/RhZwh9rXUqpAsHUDxAP+jeKWp/R7ZHLoKQ2
 vGbYWyw9nVYK8laxNTO5wU8fPQisYRaodh+Rjg+GNZ3nUJdd7H1AU/FIjkb85nZvYSMJIv1QP
 33z8uCyCZ3K+dNjhE2Z9yf9D/QDbWzIClaI6shrVmITx9wjZvqux9NXpX6FkWPPu4Q7CzIYD+
 qBn8zHtUfKjj/OJq2cRyg62AeJkF0b5HWqlPFRsNXt1HshTRi/xn7SD/ASq13UOF936jiqCtL
 uUGkWJAy0tItrKomusg6yLoplDs9BPiUjSYSMpfZDiazzLdk8VXpWLuGGAV75kFOI98SjoKLI
 EdboZD/OIMQskqGiWr1Zuumd5jARhHHZix0D/bIJHuLJqE/dhrKVCVcWKrcKZWcWgxj6wEb1E
 ooYVLhzvHxr7AynHjaTEjbWKGK6JOWJcui/+p8WRYHQyjLZZSqaqSUSBfrWQ=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Nirmal,

On Sun, 5 Jan 2020, Nirmal Khedkar wrote:

> Hey everybody!
>
> I'd love to use this email to introduce myself to the community and
> ask for help.
>
> I'm Nirmal Khedkar, student from India. I love making end user
> applications, and in this FOSS world, there simply aren't many as big
> and impactful as Git. I'd love to contribute Git for GSoC 2020 as well
> as for long-term.
>
> Now the doubt:
> I'm trying to wrap up the issue mentioned here
> (https://github.com/gitgitgadget/git/issues/486) : basically allowing
> git bisect to work from subdirectories.  I do consider myself okay in
> C but I'm still kind-of stuck here: hence emailing this on the mailing
> list.
>
>  When you do "git bisect" in a subdirectory, an error "You need to run
> this command from the toplevel of the working tree." is raised. The
> error is raised in "git-sh-setup.sh" and the command begins execution
> in "bisect--helper.c", but I cant understand how the error appears.
> Additionally I'd love to know how the C files linkwith the numerous
> shell scripts within Git.
>
> I've searched all I could within the Git project, but if there's any
> existing documentation on this, please let me know.

I answered on that ticket:
https://github.com/gitgitgadget/git/issues/486#issuecomment-571355006

Ciao,
Johannes
