Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6F0D1F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 14:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbcIIO1i (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 10:27:38 -0400
Received: from mout.gmx.net ([212.227.17.21]:64388 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750953AbcIIO1h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 10:27:37 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M7ojs-1amypp06a0-00vMSB; Fri, 09 Sep 2016 16:27:25
 +0200
Date:   Fri, 9 Sep 2016 16:27:09 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 13/22] sequencer: remember the onelines when parsing the
 todo file
In-Reply-To: <xmqqvayftefc.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1609091626120.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>        <12bffd6ca4eb7acc00a102d13348bb96ad08371d.1472457609.git.johannes.schindelin@gmx.de>        <52d61bef-668b-fdc4-30b3-a34c11b39f81@gmail.com>        <xmqq8tvc21re.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1609011052260.129229@virtualbox>        <63004be3-04de-00c5-a94d-1b600201bc6f@gmail.com> <xmqqvayftefc.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-399724988-1473431245=:129229"
X-Provags-ID: V03:K0:t1GN00kbi5Pn8r2SAcxaGb36BsRv5X/Nt6MzUOWfAcn44sG4/kz
 XWTQexZZkJCrW37g0ZR/NLjW4N5DGDx4ouGAkEi/p4zGofrZkI1GIhUwabJHru+b36j7jjs
 IHEefQdSG/VNO6a1bJoj0mgggliBz+9eN2OM3vd8dUG5mmebCEXOWnT0J2f8pp1PL2oja+e
 lm716Ohq2F7skF+Xo/JAA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NfLL3rPT5xo=:U7YQKbxa1nyP+Iru4fE6Bu
 hEuVCfMufLU29DxlnnXHyj7+INpI1PTwWp7qeH5eCzuh0V6kR1GCBrybz3+7WRyGsxMQAvfsn
 B8Vb4TMOMAacZyZB1KgVho+P6MN6dxtMGqFoLCUxVlUgYR7Bjtp94MG5oCTTESGKlpcg9LJTS
 E+lmlIn/UJJtE4UBmfcdLykP/vpAXGXQ/r9QGcI8eNQ57a78rssI8Zu8xzYkcn9eocFOWqSBp
 RAMgk4zsS79YdeyI5eRvlym3ajig1OiDaYDwyEtaT4xJCwnrBgECOlUEyRm7/fv1p6RSJo2Ym
 vHgJ5ex1tYLi2SoxBtwLYmX/8anBReg1ftkYM5ELbKrt/V6K5Z+BGMk3E7SBOiIMCJ9jL7UDY
 2iqDhtS4kW1KUjZ58LOHZ/0zHTL9+DcEs0ZraAFcoR2Z6aqRV/vCntK1UIUbPKrJ5/gDwGhRD
 mGBj3nVNW6ER8L1byYeM2CVu84zw0vy+9tjiFSr25AaC4jbuhkxtx+pIZNudkRyF8ipcbBFrm
 2rXi8hUq2NUtqbgXZcDlnBp1WD8qzJCodQmXjIV1GgrQ+Vyrl0GDFujVRRCB1R2EeWpu7a34T
 9rDhKKj5Chi/XrKVr2aHZzIFfmfcutzZITubU8gOwOYSIozN6n7yjNgHBEAaFMcWHstWVSHcS
 ZWJz3lsOMqVSJ+e48YUXBz4EzzAjY1X9Vg9YKDMvzlIkVQicRrKXDj6/onxeeTbTSugmyoKVv
 +tmeqKNdupClNlIOBEuKz0YwDWeTXVh5unubNO7hDop9sgZ+xRsyz27JtczUhDOIxeLxvgqaZ
 mvfPyHL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-399724988-1473431245=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio,

On Thu, 1 Sep 2016, Junio C Hamano wrote:

> Jakub Nar=C4=99bski <jnareb@gmail.com> writes:
>=20
> > I wonder how probable is situation where we save instruction sheet
> > for interactive rebase, with shortened SHA-1, and during rebase
> > shortened SHA-1 stops being unambiguous...
>=20
> It is my understanding that the shortened ones are only for end-user
> consumption.  The insn sheet internally uses fully expanded form for
> this exact reason, and then abbreviated back at each step before the
> updated one is presented to the end-user.  Uniqueness guarantee is
> enforced with new objects created during each step taken into
> account by doing it this way.

Indeed, the rebase -i shortens the SHA-1s just before letting the user
edit git-rebase-todo and then expands them back.

Ciao,
Dscho
--8323329-399724988-1473431245=:129229--
