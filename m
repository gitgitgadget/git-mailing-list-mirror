Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 182A12022D
	for <e@80x24.org>; Wed,  3 Aug 2016 14:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbcHCOjJ (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 10:39:09 -0400
Received: from mout.gmx.net ([212.227.15.18]:59952 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752182AbcHCOjH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 10:39:07 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Lugbo-1b4nUu3eca-00zr95; Wed, 03 Aug 2016 16:37:36
 +0200
Date:	Wed, 3 Aug 2016 16:37:35 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Christian Couder <christian.couder@gmail.com>
cc:	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] apply: mark some file-local symbols static
In-Reply-To: <CAP8UFD2NFZCAF=ZWNf4YF+F2L7A4ZM0XS98o-cR_MjuLLR8pfg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1608031635570.107993@virtualbox>
References: <a2b34209-2244-d498-6ed2-4f9fbf9f7ed1@ramsayjones.plus.com> <CAPc5daVo2o7zxTGVARoZc8AmX2WAJC1cWB4R=9sG8TH8ddKkuA@mail.gmail.com> <CAP8UFD2NFZCAF=ZWNf4YF+F2L7A4ZM0XS98o-cR_MjuLLR8pfg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:QHWzsASbPe7RwGs/Tk/AeeL2LAYvEYNFwHlzsNB0+Vi9jUTY0EA
 cZwmVzUdudCJpKohRV5dHrUjhr3bFrky2fEm4oWfP0LRPWPFdO3pXUxHd7T+4enh8Q+P4vb
 I4Mznpax05fnnqBD1kpX05pU2pebbT2rN4WqDg4QFxb34WQQEddxAo/A13bs++ZSsfFQhfJ
 I7HI8j/tcqxdEfUdoexVQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:CfXPZOfr1JY=:PsE9zCAdzgrl599sUwDESc
 dRRgl74Z3QE6n1OnJlPx7Xwx3mbOyGsREjtzgJ8s1NoJl/4YHF6eUoh6IRXrCKyOEVyrTda1I
 Xdvz47PB2SAMandebX7n27Dh6dNcMb/luzODHi+KIRMLHit5LAUmcZwLJ/tnKzhLWI8hhVKqX
 AlFvnBjIq+KJmcOPKbtMePe+hcFNF2y8tGOeukudh7QGOFnKtZjBsmaa4BotjzX3TSnkNzE6J
 JeCF86Qt7IE83IDsQiupf3cnhHKGubMASqp9hMZIjx4NniPCaPrtFakHqrTj/PR7zCkx6sIyz
 nkOS6pIs/g2Yg9Bwq1PjNKIbRauwCBNO1wRoBOirThEAxdHYVAytzFh8qn8w4O3aEh7XlpbNb
 TYl3WJC6Ior3jFE0gXh2P1M4pgXSGupPKYTs78Bbr5aLd4ZIOxBV0OJndx44l1smqoJEDNARX
 ifgv1Xo3XuPaI51nE8TPpRiVw8o4vCBzcisIXWW+Y7oOQ4BLOdgibo2t4DJdAY6JEoNw7QugT
 HQv659NjA3ro1BsSbN8zs0befpbNWY2mbyyJjQwGvH6/iXIgx2ITNPYGBoS7hTRb9DpYJCKrb
 1gShbokxCHByg6nAQD17M4YI/1lqjcd2yPFgz52ePNR6NiXZrbTx65ZgciLh5UVigxM1WN0Fj
 J87TjKg1znlbtkv23qlehGBUAZTwZKq5mtWlM6LeHuufDKAJK3W0lfQF3L9dnQz4Fpri2i0yC
 02Ht8zxysw9PyCuw7DdOgAGqey3A23NriIonc2Y+UmfGLFyCKDMe2vgsliPHyF0M2UEEr+j6H
 09RNDgU
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Christian,

On Wed, 3 Aug 2016, Christian Couder wrote:

> Now there are different options to fix this:
> 
> 1) remove the symbols in 9f87c22 ("apply: refactor `git apply` option
> parsing") at the end of the series, or
> 2) move 4820e13 (apply: make some parsing functions static again) at
> the end of the series and make it also remove them, or:
> 3) add another patch to remove them after 9f87c22 ("apply: refactor
> `git apply` option parsing")

You forgot 4) provide fixup patches that fix the patch series.

And 5) fix the patch series, push the branch to GitHub and provide a
pointer, but not sending a new iteration unless needed otherwise.

Ciao,
Johannes
