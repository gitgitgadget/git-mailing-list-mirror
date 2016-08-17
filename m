Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AB2F1FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 12:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbcHQM4M (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 08:56:12 -0400
Received: from mout.gmx.net ([212.227.15.18]:62051 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750764AbcHQM4L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 08:56:11 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MNZ9u-1bYKWH0v98-0079rU; Wed, 17 Aug 2016 14:49:31
 +0200
Date:	Wed, 17 Aug 2016 14:49:30 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Vasco Almeida <vascomalmeida@sapo.pt>
cc:	git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>,
	Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/3] t3404: become resilient to GETTEXT_POISON
In-Reply-To: <1471003142-1739-1-git-send-email-vascomalmeida@sapo.pt>
Message-ID: <alpine.DEB.2.20.1608171448060.4924@virtualbox>
References: <1471003142-1739-1-git-send-email-vascomalmeida@sapo.pt>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:gTWlPgdECZCUpyDVxbF6RRs2qd+J5pFQBQbKQwtWSpr1CxM63zs
 WJZtRP3ZD4np6Xy7wyM7buRwsxL2tRz5BWyKp81/7xGkDP30irGIooHI6zIvlYcGbkHBZww
 Fv/RFMqj2ro686fA/2KPy6uUOJP4tpoeA40tz+e47e1BenEkmibWGb0J2Tpli9dZ5s79dNP
 YOPe98RHJi0pG3xjt0F4A==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:C2Kq+FLmtGk=:DKyCIhId+vdiKHFJb7k1AG
 MLBHUQ6y2cLd002CGaiqSY126flwMTFNdLsVHHUgVkiRe6VHqEIl0PJPDo+sgefiiE8+Gfy+s
 FUWsTLkTpe2JdURiLDXjq5m6lFpif9Kni692907XatEvTUH0AOfmvMk0AH/pkeLur7R6HzHKX
 8hCOUU/Me8gcwrtG4HobeiU0sg3ZbKNSZjn+PCtjoH1Ldj6fFhojj/XJSGRsdpvmYF818BuRx
 UOtNQxqgSCm0X43zPEOsYIG63qRe5ZKCSnRBhg03fq6DnBewCdOIrhhSwfzvkkgIgN+I0uNQ0
 xDs1mJZNMHS0nBlK1pHcZQcCJBtKSZADzTShb+MSRaIEpdP1a6YK7YywMLyCb2QYUKU/t7lCV
 PeGlTx0NSco8TNwxdxgMUjMtiiQhqS0YcfhTDINEYjNE8B2F6Da6b7ACPDL3qDEcaSbY3HluU
 7T5pCHE7yC5VOq/Pt9WYwhaGOMEOLRdAnKT+M3PVkk+Ik3wzSglX2naFLXeaMhQIrrpzZFUJK
 q1IlieXy1KPK2r8wF1y7+YTt9akXw35Ey7a3iv6Loibl+LPn4udWmHetjBJYwm3Z78rlq/Sse
 R5NmuiAGuyv1YS5pi2Ge2mqnKNfXJOFWyTUYzd1wWbMAk+ZMcrxbJdNd/+C+pjGmKXeKEtoV4
 wnqnMIuI2q3SlDbndNR8aCYCrFGaSYflGKVd8/Ro+RRrkaSvcVozqIAhVOIUX1hbYpCuivFuv
 Tuc/eU6yEFsykswJqf0QEinbTsaut5Tdqcb4oFnfdOsQQqPcPZwJiwsXSf4sWa86GTQuECPtE
 CaHGzLi
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Vasco,

On Fri, 12 Aug 2016, Vasco Almeida wrote:

> The concerned test greps the output of exit_with_patch() in
> git-rebase--interactive.sh script.
> 
> Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>

Thank you for keeping an eye out for these issues. I have to admit that I
am a bit confused when to use i18ngrep and when not, so it is good to know
that my mistakes won't survive for long!

Ciao,
Dscho
