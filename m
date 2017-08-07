Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB6EB2047F
	for <e@80x24.org>; Mon,  7 Aug 2017 21:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752076AbdHGVPG (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 17:15:06 -0400
Received: from mout.gmx.net ([212.227.15.15]:50789 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751662AbdHGVPF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 17:15:05 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M5tU1-1dPTN01dof-00xohC; Mon, 07
 Aug 2017 23:15:03 +0200
Date:   Mon, 7 Aug 2017 23:15:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] test-path-utils: handle const parameter of basename and
 dirname
In-Reply-To: <5bfd3c7c-c3c8-5115-713a-63f6f8cd7eb7@web.de>
Message-ID: <alpine.DEB.2.21.1.1708072314420.4271@virtualbox>
References: <5bfd3c7c-c3c8-5115-713a-63f6f8cd7eb7@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-415137267-1502140503=:4271"
X-Provags-ID: V03:K0:QO5fqiH8xv66bixb7g2S4gnajRo3SgP9TqxDxHRf3vP7QOxIZFi
 KCVHxDoItwRoxvYPXrRYRyo1GRG8MFPpkdilCQHdUKyFAIowezQ2S6oP/kna5CnmP4BTg21
 mB28HHG+4h7K36NdUyXQ56J9XBr5FiPoLsV9WndZ+3SurPayRkwpjJPV/2Ed4iFt5xmB9gb
 rj8ZAVsHkMCVqB8QZcRqQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NjQaEqOseZE=:k7NEEsQK+6YSrvD6tR1w1B
 L6/CeR/F2YKqEYdHsxpoyOSXdbwL2a05iLfQq2FO3ePE1Vj42ICQcX9pMwDgVAFUbJBBMdzNL
 4nRocFnxUt/QRhkhBvhR6PPlCVcN2yYRLG8lVgnyAhbxlSyMNfsazzySD+TIemCXtOl2Xm/34
 zGkBxawATKdLxKRpEzXChxrV8vznhS21jrGx1aEfNI1QU3d/uoxa2+bF4bmpwyraaF/2kovNH
 N3819u77zWD0+VjWmWbEPJubbXlKwaL+aLvdEgyXmAtJDwWWldcm2xz+afFncJ97yBhdxbE8I
 gb0lwroCzymVLRr8Z7csxjXK0TqTVv1G7jX4JjpaQ6U2vppDHhvUCaz93q/T6pso7Mz9yzDID
 60ZWx5zGt2yP0pYzZfHUzKqPD4Cr7Pz99cr/vSk1WB5GMdZhJxbRK8iknmIZgGjxNBtUeZZjH
 xqn4JP72fJ85mkGPsJrp5869hAm6GPfbAQz9CwkheyCB/+wyAzyYYGUbzsO78arvJtx6I0/vt
 LbCmMaxK52i+7m1D6PAoHG3s7yoERzGHZKczJg6U6WaJd3GiqJzbj/G2CPQD2uBAT6X9pDH0w
 KjnyFjxU8tynXvef9nw4FXXIR0AV7O9NR1MMIFONZbbIufkl4NrILCf5Ax6yWhacXJ9ExCe76
 RxBS4NH518kyXhUG6QP572xBNBvrROmDZ1Y2fauoRLM1s4oF5HH14pnKm0WdEJAVQxijhHQYx
 ka2kYbp1XKQg+QLtHi83vZlFoz7oLA7TtWDKTvD1lRiCNFaxc/uYQHsOCsjSFHZGOGRpCPV3f
 C8g6xoC1YcjGvrksGy9xz+p7kGCDJ4F5LwxLZmEzqaVPuHjm1Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-415137267-1502140503=:4271
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Ren=C3=A9,

On Mon, 7 Aug 2017, Ren=C3=A9 Scharfe wrote:

> The parameter to basename(3) and dirname(3) traditionally had the type
> "char *", but on OpenBSD it's been "const char *" for years.  That
> causes (at least) Clang to throw an incompatible-pointer-types warning
> for test-path-utils, where we try to pass around pointers to these
> functions.
>=20
> Avoid this warning (which is fatal in DEVELOPER mode) by ignoring the
> promise of OpenBSD's implementations to keep input strings unmodified
> and enclosing them in POSIX-compatible wrappers.
>=20
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---

This patch is Fine By Me.

Thanks,
Dscho
--8323329-415137267-1502140503=:4271--
