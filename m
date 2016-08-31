Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59A721F859
	for <e@80x24.org>; Wed, 31 Aug 2016 15:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935574AbcHaPFq (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 11:05:46 -0400
Received: from mout.gmx.net ([212.227.15.15]:60116 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933887AbcHaPFp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 11:05:45 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M8leW-1bozUu2nYy-00C9qp; Wed, 31 Aug 2016 17:05:32
 +0200
Date:   Wed, 31 Aug 2016 17:05:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Jeff King <peff@peff.net>, Git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] t/Makefile: add a rule to re-run previously-failed
 tests
In-Reply-To: <CACBZZX6exynt_9_wVtEN19HQt_rPJdo5Ck3jujdQ-hLdMAGdmg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1608311702440.129229@virtualbox>
References: <b2d016e44fa04e8a318967c43762d6933faf7956.1467183740.git.johannes.schindelin@gmx.de> <0dfa96b17edfe84ba19c7e57fe0b017c77943e0c.1472478285.git.johannes.schindelin@gmx.de> <CACBZZX6iEmbb68tzRKNAryp5qmt=iU9FMuOe2ONV=2ojcazoEg@mail.gmail.com>
 <20160830205151.k6ufhfzl6gh4uuog@sigill.intra.peff.net> <CACBZZX4NyjkK0Nf1JVGFRhc0xnLYg2YX6ctO5OxK3Pi60r5KaA@mail.gmail.com> <alpine.DEB.2.20.1608311227150.129229@virtualbox> <CACBZZX6exynt_9_wVtEN19HQt_rPJdo5Ck3jujdQ-hLdMAGdmg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-665518694-1472655932=:129229"
X-Provags-ID: V03:K0:LkMTkKlO+g3jWtsuoW3AviHBi8bIttsGu5xqfbtB8azSvhV2JQc
 a2EclQNWzIxfHo2IDfdWQsh0vKk1h7ZkZGD6goAYShgu8eIxInbFxy6/nS2+gdHQYng4CKI
 Ah8kK7+nZ8PiSuyPZQ0x+pNUhtC/04tUm25+Qk27tMeSKfT+YuonbfU3aeGoDD8oiFu8zvX
 wo6Eg8VbUucSskBi5TO3Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PvkOiIuaMDY=:Ijimb8CT3HeHb0q7E8xhz0
 91Wi1+r+P5sZhcWDSvzxUoJvDcpfr9Qrm6c88+PgRhPQ2dOWrHo+6qfnmL73t+4W8ojz5jYxd
 gQUk0Zih+Ig2hOxbglyF5G8AL3fQXuMpcwEFQOSlCWeOhxeYyT0U/tIBMtJCDJz774SJZO+3w
 BXdDI0J28Auc8fKSZssAVvkD2wCSViB+R4NM08viTZFrxK3XG8o1/hO74JTFRjKAaluWKUYZs
 Gl07fFTlfZpqgWOFgxt/97w8ed5LINjiiLrbBHtyaD9dprGy/4FJfECTBuuP3XmiPbPC7ErzH
 wN5y1IVUPEISdsjy3ihBkdZi6F8FKhx8DAhy7L/4iJmRk5r+w7mJ0asCaGgGIAg7+iEqy0U8f
 L+VN5fPuBb3eie63yJoUJkJxsQ7namlOJwECSprCFgfoHv6epXZgk6WLm8th5f8mBox5JPTfe
 LRfGURDHay1qZWRnMZE0vgOqULvznQeUGYl1884EVEAOks8j7UqvhxNaNlWRBuTWU3L6ImR3j
 9x7ZGlqNPQdTI1JW4tAx7gWHaZW3iM1XcXJFt5PWtLa6ct2ZgAO676t78yulNlKjwCAQQQsar
 As5yJ7ie3gV5213ec9V5T5+9o8dhWG6hpaNdffK5F2hGj8DGb92tx/geZYxyyMW5s4yi4MXOg
 WfuWJg5Wbmyoy+/FZBAxTgTUCsRb+mMIvYRirgxm1uINvOdSjA1Aw+cyOTL8vQcr3MWQuKKw7
 X2gRVwRyikZOxZ04yi4fGLu2S/gF/9NZ4YAbrETJElcLC3AVXr6XfAcL54DcNze8iOHtE+Uc6
 23qFau6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-665518694-1472655932=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi =C3=86var,

On Wed, 31 Aug 2016, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> I haven't used it myself (or any Windows thing) but people say good
> things about http://strawberryperl.com

Ah yes. This comes up frequently. Many a Git for Windows user pointed me
into that direction.

The biggest problem with Strawberry Perl is that it is virtually
impossible to build the Subversion-Perl bindings using the Git for Windows
SDK when using Strawberry Perl.

Which pretty much precludes it from being used in Git for Windows.

And then there are the path issues... Git's Perl scripts are pretty
certain that they live in a POSIX-y environment. Which MSYS2 Perl
provides. Strawberry Perl not.

Ciao,
Johannes
--8323329-665518694-1472655932=:129229--
