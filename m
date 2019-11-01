Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1F321F454
	for <e@80x24.org>; Fri,  1 Nov 2019 18:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfKAS60 (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Nov 2019 14:58:26 -0400
Received: from mout.gmx.net ([212.227.15.18]:37339 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727372AbfKAS6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Nov 2019 14:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572634697;
        bh=k4UnVPAR7L4LNqd8ByUu9xNDCwB4QAB6nyNjPo+WnI0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TYTqsKJ15qQJz3Jko+/tDDBV8M/mXQziSa2zjfbqHYTbUjwBf/ggeoB56kywQfQJ+
         egoiSnFqqnGUC8+L38I1Ibv5isHly5AnIvJEIEorBi4TgehpzDWPoGpSqRRxC2wghR
         d3WZL1TpHv4WBPjYcuJwj4DWV97K3IZ1u7pNMsyE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McY8d-1hoGhQ2WPF-00d1Nu; Fri, 01
 Nov 2019 19:58:17 +0100
Date:   Fri, 1 Nov 2019 19:58:01 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Emily Shaffer <emilyshaffer@google.com>,
        Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        Matthew DeVore <matvore@gmail.com>, matvore@comcast.net,
        jonathantanmy@google.com, jrnieder@gmail.com, steadmon@google.com
Subject: Re: [RFC] xl command for visualizing recent history
In-Reply-To: <b0169b2b-0d8a-ee27-d0f4-6c7a6df55b5d@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1911011956580.46@tvgsbejvaqbjf.bet>
References: <20191029003023.122196-1-matvore@google.com> <20191031003929.GA22855@google.com> <nycvar.QRO.7.76.6.1910310851300.46@tvgsbejvaqbjf.bet> <b0169b2b-0d8a-ee27-d0f4-6c7a6df55b5d@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:W98mW6DV8ZVn/cxabAfpvusR/S+HE5OS3KOFN7qw1/TA78hqCoE
 i3QmT+OUy39eyWTY/irVXmWN274SdFES7GBigNvcERzmzztblxssX2sv6xNrrwBw0gy2P5j
 Kddz/jZh9ZHsCzlxw6rFizV2cFuCNLgR5BegXwqg85X6q4BszZfERMeeyvqsl/2omfDjKHS
 DUO5c+Y4zm5fR3Kw4AyaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BhaiOzr/Wzo=:21xm33TTtSckNV8P8lAShH
 mbsosMGenhQITtAVIVAmqtblsZmmbjFsrSnKElOW/AQ+JzJKMwk5l9MIpOD129cK7lvcYi1Wh
 2eO3oww2KLWUZN5KdfD8zamwfBikmCOkkywtY+A3nkPzXgMd9gbEZ85ROvI1v3MCa0WbcGoss
 Jhagc0rVvAEoLWa4CmDCtqwe1q9JY6wZ5bDvFFDfZk67k5Xucm1c/3slQSZDeR26tpmRIOXgz
 rOHa3YwDFkHK99Mc9Mx4+rYvNQgriTLPhZda5myFgqMWuG8OgfyqERl3qqc0YP3J+Ewnv2QVy
 fOE6z6YWYm9RLy4W8PFL/JXvQ568Ly28DgSTJDtQJSPT1aZR68VyWK4g593oGKWSw9xDaolZV
 2XFpeAahewntz5Uqr+5WgFCX41ZcPZDUnVNUMaSCnW1mA9QzRzVtcS6h0Ay4o8iyxKzoCZBVn
 xfptjzxEf7/MNnSq7rTTh+ecLNMrZeJru/YE3/HKinXPvTPy6dqlg+ePaEwA4dVrGX/E/NnVB
 uPUYDG3aIYWDW95UDh9DKSJmPT0VxYDLl/1my9wHaxZ7Jh7n8R89M3CI8QC6IVogmBY+U4x0k
 Ioj9Df9ZgdfU3zn7qEf+KXT4R1MMLC8jgJcZPZ+04+3VJqp8FwKpXzLY8C2Bo1B9MU5yYqnSE
 uZ2gHWb+BVx24pQN4CWipLHNtNPubXX7fDhPgM/E/Od2dcBt0uolXaE+QmceiPkEwCxIW+xft
 64cHpuBW4r6w5npmxiofrcO90w6lmyJ/ABiNXAeda039AaRUbNGuzvxGvxe7v3KasM9dt2yBD
 5AIieOgrBlb5Be24yONYpHAQ4+wUV/CgBj1FG+uNJEQvd+jC4l4AWxH4wjRUvovSXPUJ/vPcR
 TFNbf5hSf7vXq+ARCIjmZLBP7lns5cKb1c8c/BM3XbGuvbrVvHwb8mq8oXmVXm6MAYkhX2JU+
 mtP/jJQpaG+YsRvD6PIoqdiILwB3cpH092cl+aa1zY3Eh0NSlYTyx7nfwgtZxoBvL8MqFdngX
 c0nihjLe1jQSxa1JlghsA225/T6SbRu9d5CccgO3tFlb+7cKBPM8E8nT1m9xAh8iPRRVw1kdg
 NPoEFdwuq79i2b2DuI6/OXWzN0jF01cBZLPQ1GRVJ/KA2DjqM+kxLxfvIZ/xAE4ILG2vKBi1Y
 EDcrcUO1sM5QIF/k9QCW4ucK4t2/4MxIhig5UIn3J613Ut0owWrrIVQGpkob54upL6n2J0U3k
 pS0Fe16dYeN7/UhEWfYAYciu8cNoUCyF3qHbVC7d6UMRMkub6f3I+4ouFm+o=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Thu, 31 Oct 2019, Phillip Wood wrote:

> On 31/10/2019 08:26, Johannes Schindelin wrote:
>
> > Finally, I could imagine that in this context, we would love to have
> > refs that are purely intended for interactive use, and therefore it
> > would make sense to try to bind them to the process ID of the
> > process calling `git`, i.e. the interactive shell. That way, when I
> > have two terminal windows, they would "own" their separate ephemeral
> > refs.
>
> I like that idea, though I think it should probably be based around
> getsid() rather than getppid() (I'm not sure how that translates to
> windows)

Good idea.

On Windows, we would probably use the `HANDLE` of the associated Win32
Console.

Ciao,
Dscho
