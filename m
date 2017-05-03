Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 892631F829
	for <e@80x24.org>; Wed,  3 May 2017 15:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751536AbdECPKN (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 11:10:13 -0400
Received: from mout.gmx.net ([212.227.17.21]:61715 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751275AbdECPKL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 11:10:11 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LxMgg-1e81jm3v90-01705E; Wed, 03
 May 2017 17:09:53 +0200
Date:   Wed, 3 May 2017 17:09:51 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 06/21] attr.c: use fopen_or_warn()
In-Reply-To: <20170503101706.9223-7-pclouds@gmail.com>
Message-ID: <alpine.DEB.2.20.1705031708350.3480@virtualbox>
References: <20170420112609.26089-1-pclouds@gmail.com> <20170503101706.9223-1-pclouds@gmail.com> <20170503101706.9223-7-pclouds@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1219580826-1493824134=:3480"
Content-ID: <alpine.DEB.2.20.1705031709030.3480@virtualbox>
X-Provags-ID: V03:K0:TQJOnD+L83aWSxISjEfyqtQqNQJVJ3Rfo77DSgvnRl1JzrX6v55
 N00wk9E9Qk5mFn4p5kwhLCjEuxer4uzJB+wCoTM/MAjil0gk/InAwhW7Pt0I4jB0nuHa3z3
 PA+faorRGinjBlk4Ze1xa7CQM8KV0cexJL7QtCMbdct2LF/1aHgYL/VPYYJpP2F8izUYPEC
 2OzKye8P/zXxKXjNG9IfA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:My6RMNNrfhM=:8xL40XhB8hCEeBFed4wzyP
 2+yAcws6XqlqJYhI7fps9S/l3kQqVUzCi8VSDZdBbJnpNMVokA3eLFS2Jkt4BHFty4ZAerabh
 5OBUJ+hrczXcSU4g1oewhFo8XS6wDUcvHMIAyBM8sEfqG4rfsO8hCipXl19qodPuE0SBkQ+g3
 wjNX7NklBGXeuC3bvP1S5O3yb8aduGoEbukAUAkWu4Vt08eWUD98RW2lt5dNShEhrFiK43F+F
 ensBTjnPYPFNZSdmkf/S1Vpc0Z05dvmwyxPxAPY71EIjaYGx27S8VNBVK74EpcaEEPlC6wkBX
 3ELkWO0Q07ch5sAZUskb7VGKd1W1wpT+KeFp5TvFhflcn2mJgUPkShNVWxlBwyYNZEgyA7nNL
 TVUUr5gSkjiR28C8yNkklBEqULNEXtdZyYE8PxwFu+BRllInV5ayZQ5uCChA0I1gcuOdOi62W
 cm54juOPEuFSgyBoN9tfos7JNSQLyq8heHoJBn1Ilre0Ka64qof2zBPk+xdNrmb2bwReTwE5R
 d+sNVACT0ESAjBKY3BRzPXBHPByHT2ITWA+RS7Cq7VR2yr6jPT4GKpyIdgjsqRXNPAgf73aVA
 FKz0YLopim5IMW9Qo7W1DKwxbDMDrAPpGlPSI2ACHFj7i/L3tdgmEvwyxaCDtqfrdiBDw2XPe
 T91VuJ7+dEFOdXdTJmGkPEEMv4lAhJcPprWQXFHtX7+1cZk+Ygbw/1wvUxvyBe8uiIJRmwO6s
 PradvHyX1JTgEjk/7dP+01VMTAXVfvTkPreY7Vm2Y1HasZR+AKwt8s/qQy4fJi9hU8eEm6Ruo
 Lz+9Job
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1219580826-1493824134=:3480
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.20.1705031709031.3480@virtualbox>

Hi Duy,


On Wed, 3 May 2017, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>

As commented about warn_on_fopen_errors(), I do not see a benefit in
separating the introduction of this small function from the individual
files' changes to use it. Let's bring it all together.

Ciao,
Dscho
--8323329-1219580826-1493824134=:3480--
