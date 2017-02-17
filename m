Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E3FF20136
	for <e@80x24.org>; Fri, 17 Feb 2017 17:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934599AbdBQRKE (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 12:10:04 -0500
Received: from mout.gmx.net ([212.227.17.22]:61999 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934325AbdBQRKD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 12:10:03 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MAQMg-1cXZym0nl4-00Bdiq; Fri, 17
 Feb 2017 18:09:42 +0100
Date:   Fri, 17 Feb 2017 18:09:41 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH/RFC 00/15] Fix git-gc losing objects in multi worktree
In-Reply-To: <20170217141908.18012-1-pclouds@gmail.com>
Message-ID: <alpine.DEB.2.20.1702171808460.3496@virtualbox>
References: <20170217141908.18012-1-pclouds@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-129518087-1487351382=:3496"
X-Provags-ID: V03:K0:RfQ6iYRcNblJua8tKbTSNVEKG8urhaJiGUqqrKHNq8Z3YmCs2HJ
 PthKw/0RaYyc8A+ttxCgF6o0l1eZugHzeJeDLBFvyyxEK6K/z0nfdjI2Re7Gi9INz983TtH
 +2bGN83GSax2Lk/5Ua+5Sia5E2GYFgA7ntHW6AFSHK1xMDO/KeRAnjrVOnhitqRGVXtFho2
 fM8S5sZaoRb/lpmP7Ly5g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MsLk1O96Md4=:qn4OIJhjEIn+sm91SLT0m/
 mIuaxhUdmoD1Gxu5NY/kSywzx++TcxjRFr8BFDw8WML3CGQwaj4FNJbKEwuY4cA9Z/gyAJkOF
 O12SjmxhZj5c5QszU03fJBWzRcO6Wc3qhBuV3cs5hxKc+RDlk+5KVkSTtzNdgkhwzybvxCE4o
 EtMsRLz/T6e2Z64tYsWZiS5nDL2BRXB4do9irolFi6KXGOs+qA4MkVqW5XsxwSoABKyG4gVhm
 iBiu3u0Nx/xZf/tmnKNkF4Z+P1VB2IJck73ObGbUBzOybX1UmjQBpLqIRT/tXdjOV+Q9XN3di
 1pFUrFfL9l5DnCkzkEY50eCDH2CYfCAo6rnhtiOkYbWO55LgK0u7DiZaVAh/oPy111Dh2RrVS
 dl6Lh5o8Mzx3+kxV5fkFCS+GjMtGZkFXr51Y9Tq27ETs/Argpvi6EiC9lmVDqqnJ+E5W22VgF
 ccrg41vHx79sxtn8FRHOvUKKmdOFV502XNz4vaLP4MCHctE9tMah9hRJEd9nK5e26MiKRQVYA
 LDXYcHkKm+aScroe/qFWbNVYSM1T76rfGUoxUFaGUW0RjWBJsaLW5X2FMl1ejCUkV4RA67zF/
 tWWgLATihJCjAIMHHfsAspCBMKXYyKA/YVE7udHBZht7u/CDS1rP6xO3+7uU94MBLNIo8OuhQ
 KkNWtQhMjWmPCW5j9QC/TPGLnjM66C1T9axMvEeUFAzF7by7u78xTXc3BQWnyMxBrcMHEZNjr
 RcrlOKWZ2tuyDTPEan6RtjrGzNvf0kOaDYXXwvbpaqtwpVJjHEi2d3LdJ5uqH1+aXNBf/SoM6
 spDFVhS6ZSFvuaXpUGNTNxSthzvGbIJ6zEHjHUVsU+GUK1ChsPfU5xnfAA31r7h4ayQyjAVwp
 cRubcvCwVGjsuIUhELyAB3pgeFOw2QDEEay6JCKszTRGVYeUvuk7FjWX8ElWJf75+vJ1LUmaY
 gezcpaR93jB/Ue99zblWm3ZVASzhqoODT2adYST0WsYMZxbi3Lqz3U0kI4NsGN0l1pHuA2B8Y
 biHjiKhxoibRnMn8Ny3gCok=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-129518087-1487351382=:3496
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Duy,

On Fri, 17 Feb 2017, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> So here is my latest attempt on fixing this issue. For people who are
> not aware of it, git-gc does not take per-worktree refs, reflogs and
> indexes into account. An odb prune may leave HEAD and references in
> other worktrees pointing to nowhere.

Thank you so much for working on this. The bug really affects my daily
work very, very negatively.

Will try to review as soon as possible.

Ciao,
Dscho
--8323329-129518087-1487351382=:3496--
