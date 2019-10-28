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
	by dcvr.yhbt.net (Postfix) with ESMTP id A49F61F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 13:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388776AbfJ1NHs (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 09:07:48 -0400
Received: from mout.gmx.net ([212.227.17.20]:38921 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388578AbfJ1NHs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 09:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572268058;
        bh=muHbvI6OvRJxVvagUBV9jue6WvTjnlIzrCFd9ECXc7Q=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=RtxLn+chGaZuU20W0CAOhjcmNHuPl3M7+0EGGGs7q4t/YRks+sE2XNRz+UmaD9D/4
         gApqwicIRxNOe/F7pgIJpCmiJM3o4zBWK6xwmnUkq/2h3UwWQj2jJd8/uzdxILjjMA
         Mhb4PWfegyeshmZkWRaCtH2LWU0CTJ0KyKSMr5d8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MC30P-1iHc6J08bN-00CNUF; Mon, 28
 Oct 2019 14:07:38 +0100
Date:   Mon, 28 Oct 2019 14:07:21 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
cc:     git@vger.kernel.org
Subject: Re: [BUG] git 2.24.0-rc1 t0500 on NonStop in Jenkins
In-Reply-To: <011f01d58ab6$91fee620$b5fcb260$@nexbridge.com>
Message-ID: <nycvar.QRO.7.76.6.1910281405000.46@tvgsbejvaqbjf.bet>
References: <011f01d58ab6$91fee620$b5fcb260$@nexbridge.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/1EJbbam3EeMVrlh+YFjnPOJK9CwhiDUsOpvt0e2dP/V86zHRYL
 zt68+h0y8UzRgSF5R+arD4Yjt2yjIlJvOCOyiPWxAhazBdct7+YAMZuuVwhKBFwzlDj840J
 uCVr/angYOOFxcUH7ePYJ5Nv/xMI0Vhu2qRO0y7W5EemvelmglHeHZLJmiV+RkRBa0lraQD
 MGBluLjMx+k4iSJHQPZfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/V6DM04jjVQ=:nqVCZTSQhlSYk0aZ7OYkFt
 PT2fvdZbBMCj0NZKBOgEeAy1jCPxPEMoUMxhq2RGTG8JCcTw4mITCs1bzhj4Lecor69eWNquD
 jvLE61vc8MHcWknGGNODHvRl/pS1bR1esp5+KIDTsmDBbXTjt3E3QSe39qagLea0Thwp4V5+T
 aP2yfbnHevXC5rKSzabGhuGRWwKwvOBqsNiyEeNYnuV1ef9KV8rcKtRfrOgKIIsmoUK5EL+0E
 3RqXj8ZeJtfwUH5azDnmXFMjov8xi0XPyt7VjVgfTQ6agiY64eISecpPhtAAdYzImMebU4Ytr
 4yJzp77TZCIf+eI88sfilousHM29tbJ6uJKIvInTTNlRFDGseYMFJmPHmoC7ANdP7dnlOkeUF
 kG4k+s1l0KRmERP0bkKLTYtFYqy3u5U6BaqS+lhUuVuakekPEWyoiDojcIYxHt1I6hfpej30V
 wVLbkgGmXvq7Ov2HFxuTxU6QlHDfF3DRN/G24SLGwO2UQuOZ2Z9ng+fRO8aFEvZb73nB9hvPz
 WLByXG9EuRPeKM+5vuFSn89Vya1vxNY+R60rWf9EteceKQQVsRK1eRk4/OBD4QXI+FLXyg5zK
 rjYHHYXhHS3mnS6Ac9hc6IH1IK4wg90r2f9CP+AYai7tSRQoxyBZdm1xeVjmy3PEm00y695Ad
 Tjpl5RzKH5JLKSJlnRgqqTFKWycybHtmKS/fZ29MlXwG1jeXYr8XaasWXOk0mBcCl6DXv8+eK
 6W5eXQPmM1dYXU8A+54ZwsNsuOX+WwCpEsLCBowkhjh7GukLSC4vqn/AOQJxKNG+0YIyrQX90
 96Ygu9qItInG5Fskd1UN/QZB38oROKAVdzU9oIRcIN8UVb9kWHJ+s4ufd66f8lBAl8t5Mi+Bv
 O5O4pakrPldvDQLJE9hJxxGP61KP+Z6WJjmUx/UTRSpo/B8XVNqsBTNlSpJMtLHCCzNHpQtn/
 wxqQd6+njcCJz3DP+u8rvHzlhgahHgMhbifFvfrXXUlKatAatptLtjBwMVBtKzAuVh1yC1izR
 qdlszf5J30Ki5HUmAmWckpYPLn9eOQ4+p8ZzSnA/fmrmfcMD0G1SZ/ar6wqllKPSRE+wqYvAw
 52j3tLGJ+95wfcAVBn8g0GdxIOSzWDovlJ+PBEuSxq2UhpXwXK/Yy654B5yPAYB+FvgMT7LDH
 xTxxDo69QIrb5UVS3FTl0cVEJhC6rpmeQxuEirvEwYfSU++e4O8NuW8qFPKYsKtiaAp51W6Fh
 H4C9ufCi/J3twmSfiaymtrs03RKdwU6sfvtcSFYbJJt740xKWYoWv2tGnJLo=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Randall,

On Thu, 24 Oct 2019, Randall S. Becker wrote:

> We are running the regression suite (as we always have) in Jenkins and a=
re
> finding that t0500 is basically a complete failure. I cannot recreate it
> using bash where we have a real terminal, but without one, the t0500
> consistently fails. I wonder whether any other platform is experiencing =
the
> same situation.

This says that a test failed, but it lacks the verbose log, so there is
little else left to the willing reader than wild guesses that are almost
certainly completely missing the culprit.

In other words: verbose log, please. That is, the output of the test
script when run with `-i -v -x` (or `-i -V -x` in which case you will
want to analyze the contents of
`t/test-results/t0500-progress-display.out` and if that does not help,
paste it into a reply).

Ciao,
Johannes

>
> We also find that we cannot run the main test suite as a background job =
- we
> get segmentation faults that I have yet to isolate, but when run in the
> foreground, no problem.
>
> I wanted to get this out there because 2.24.0 goes too far as this did n=
ot
> happen in 2.23.0 or any release prior.
>
> Sincerely,
> Randall
>
> -- Brief whoami:
> NonStop developer since approximately 211288444200000000
> UNIX developer since approximately 421664400
> -- In my real life, I talk too much.
>
>
>
>
