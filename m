Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A831EC4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 11:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 853416108E
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 11:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240316AbhHYLRH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 07:17:07 -0400
Received: from mout.gmx.net ([212.227.15.15]:48277 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236038AbhHYLRG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 07:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629890177;
        bh=LltSt5hujiU0FNHEBH9SG2Z96c5ebYyRYpG0y2fezPo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FwuJIf/MsH34sMFBf77TLuy/hUH7FzYWTVdsFU+LNH48GvFKBKmOsJWkHyCavhiRH
         FfmTF3u9vnDlDLsYZEvfLTw/kLBkD4kfA0ZKWNkBTcV+OExkIlRTfF3XFJuZmWsHkT
         nRiLLAZLCyiYA0r2yr/JMkOK3R3+TqV6sQFjGzy4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([89.1.214.7]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McYCl-1mtZDp3EIH-00cyWS; Wed, 25
 Aug 2021 13:16:16 +0200
Date:   Wed, 25 Aug 2021 13:16:14 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] whats-cooking: fix a couple of typos
In-Reply-To: <xmqqzgt6oet6.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2108251310430.55@tvgsbejvaqbjf.bet>
References: <pull.1075.git.git.1629810383934.gitgitgadget@gmail.com> <xmqqzgt6oet6.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:q4T8Mpk0d1ri5awdgueJCZYstAf8c8jX6FLF3lh6cHEHxWr+fdh
 CAdnLD/gYdjcJuqu/ANSmTdhJbEOvLo1K6qxgCB5e+TwhRpxiYiS/j8Hmj6UUiMCgSHs6ls
 pve7E1/jYxy2l/YFi3lfnS9dvvV+D3HB3OXaYwARnY1ybSHcXo4fvZYPFf41vhG97J9h+O8
 w1fnWl0QYlW++r01XLxNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:owHdJEa2twQ=:cfCwJ2LuBLQJCJh7pZVhIA
 gyK9A/EajNACOpLA2SAQP5P7DTIj/3SG23V1OJK6PaJhs1g1MG43a5i0jk8n//hJZEo2bgi4M
 TSwuqLhDcgR9VxLfEKOt3ygMfqI+CIl1+r80sTamK7z+5PqUmPGFfVKlGBsY21JKDoTZaOClf
 vfYi48vnGglvV6nts7StiLu6eLjtc+uVCsDcDlWBlLTKHWelUbF7JFgfmupW3Blg3l/QIj/L0
 aRZU0sMKWK1AFDW604ZX6viXmOSECNNIOKpwP94iDGLrewMalj2wKYk9+pRxkxMGi9c1OioZj
 WgfItPVvx7xE7/PJfXvpZeLw9YdNfLrBPY5t0TY2FFuguEjk4SyVuBMsWQMRCvgOVmkNWd0/p
 jdl1heHPfBq/Dav+Y/zMbFzrVqqJUBGOE12TNK6D/iG4hNX9PIjLQ+PW8eZn0Y+qKA7sRkMLO
 omvE4Vy8Q/qwXQaZVOdUV/rjlx1/wT6i7WRsDHxJhwREdi2gk1xfwP7loeUvmwRyyJZCGK5nq
 k+5kCwlH0BJU/Wsgz65RnCN0OTlqjpHbASl2DkGGj8kd1flPEA+EnuCVbshRLkLdOB/fApJbH
 5rW0Iu77ewbX4f4BLKIq5ipFx1qctEgkOmNzyRiFHgGKxN6RVznbvgEx1RQnOIso89bhaKoMA
 lFVAk829J9RgsxL4eEQjoe94pJAaVjOwPqkyojygUsNAIpLXehzty42Sf7ErxoNLWrdUby1wL
 JkLltqXpoj81r491WtSwrGDIFS/0pI/DH7YDKFyt9cMiPg7/uWsFaOt0GV7EqdKW9Bos7gmIp
 Iug/KM93P20kDt9zYd3as7/0r1JLhEV4fulkG6yRI2/qImvVnrV2HQ4zRhMZY3fhx0PAgYLon
 ZrvCACmffS95fD1/fh5b6AJupKKr4zPJyZVjG7xS0lV4/eMIGMjE6wfeyGAV0vQ6QXGZdUNTm
 utp81qOD+ZLfdsjAKw8ortwQ/5p875bZ6fbk0hT382NgeJ87jfh3wVForXxxxx4IvHxZ6pvij
 ecpzvKUe6g8QLuJ9xJ/k2Pbhg73ULON1Co5uKgOtBOn+eQuE/9Ox860MRV03Ll4arHL/9/CAT
 gvCfWTrCddTAp1qJITzDZ0cXKO902Bs+R0STZCpxm/F/qL6/8zaKcBRog==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 24 Aug 2021, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >     whats-cooking: fix a couple of typos
> >
> >     I noticed a couple of typos while reading the most recent "What's
> >     cooking" mail.
>
> Thanks.
>
> https://trends.google.com/trends/explore?q=3Dcodepath,code%20path
> makes it clear that "code path" is how the phrase is typically
> written, but we have 233 instances of 'codepath' in our tree vs only
> 39 of 'code path', according to "git grep" X-<.

Right. Where coding style is concerned, I prefer to go by what I find in
Git's source code, if only to avoid disrupting readers unnecessarily.

However, when it comes to English grammar and customs, I am fully aware
that many contributors aren't native speakers. Myself included. Therefore,
I trust spell checkers more than our source code on those matters (except
when it comes to those Git-isms like "submodule", "reftable", or
"superproject").

If you feel strongly, please feel free to drop everything except the
"submoudle" -> "submodule" fix.

Ciao,
Dscho
