Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36A2B203EA
	for <e@80x24.org>; Tue, 20 Dec 2016 14:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934520AbcLTOM5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 09:12:57 -0500
Received: from mout.gmx.net ([212.227.17.20]:50286 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934218AbcLTOMz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 09:12:55 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MJWAZ-1cHPTx2XVL-0033ee; Tue, 20
 Dec 2016 15:12:38 +0100
Date:   Tue, 20 Dec 2016 15:12:35 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     "Kyle J. McKay" <mackyle@gmail.com>
cc:     Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] mailinfo.c: move side-effects outside of assert
In-Reply-To: <A916CED6-C49D-41D8-A7EE-A5FEDA641F4A@gmail.com>
Message-ID: <alpine.DEB.2.20.1612201511480.54750@virtualbox>
References: <900a55073f78a9f19daca67e468d334@3c843fe6ba8f3c586a21345a2783aa0> <20161219200259.nqqyvk6c72bcoaui@sigill.intra.peff.net> <A916CED6-C49D-41D8-A7EE-A5FEDA641F4A@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:3ZcY0arso/72WDp/lwyxMcFSd4EAKeNH+NNhQ1+qjvx8AaiVLgq
 Uv/JFGnmkQ/zysDDBnFi8TS5mDbpXD2m8Zd16gWojmWObbE5rIScjk9509dBNxWL16+n34A
 Kr4iqiD0rSF1Zu45V3aVk0R9yx2Vs5a4YwhZPYf31ByAc9lNl3uaC+Bpy/iwLOWO94QgUHG
 aSs5m9ASVVIO7cUON51Aw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kdxW6GdqiEk=:x7XJEseTKocBR1bGFWesHC
 KnJCdMiT+ox0atmz+Ty5dBMG+PHIBD0L3LvFiX2kcJ7mZ5UBvQgvXouO+r39nSobZV8YuyU8N
 1tH3VAx8UWwt83MFpSM7xpr+bL96OUPoTA0Dr8IzOMojB8xPbmNbcTzLNOppdFWx3rSuIHOZw
 /qtdv2Lwq5nuxGRycxq11Fe6D+UP4f3kKpFWUr60MqbBYPCTYQdyh1V3U4OHs8IgFa1uknBTA
 QIjJrMtV5Hx83JDSBll748m1M264sFCccMroB4DADvkVS0wRUOOpr/551MK6u9fDdGne2pPTu
 Bt/gp/0GA1qh3toQ8v0Rlqgwq6scmhP2nVMcafLTOIrx6jUfIf5kAgHd4yPr4yMhl5fT5tsjH
 JNXIfGLscRMA4V+c2nZX4pyKrQf5pFFDCN3RtXDykiTJssFKtJ8aYRh0Sc+W8fyPBLJMAdY2e
 zywgZivz/OtqG/OBWLZeA3D3D1mnFa1vDSAfR/wrvD90emCQMcl9HjmJCspe4CULJRlqYa6zF
 55OYyyWS92gtbwyRlDnrdhGkGFVK+MWb1VFEiCPHd04VhaaHXKx2prHtfBKSV1c058pVp3zSX
 tu2mQfNogiJcTY/yl5fvuqoAcilC3RUXZTNtHaLX9Aoovjq5dbrKPWxRiAh4bNPHYrPkhgRi5
 Iv+LD63He9esLOdYerh1SqpEJp/6Fa0x8bpiGhpW6D9twNFE4VWHdgf6Ns1N6IC7XQv6bKD5f
 1WKD+l+I/JLqJ7ekiVHC3vLzA81miyKfRh8mF3SBNnvW6eDkWNhbB56cQ81NMCfLSAeI3+F7Y
 stJ12st
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kyle,

On Mon, 19 Dec 2016, Kyle J. McKay wrote:

> On Dec 19, 2016, at 09:45, Johannes Schindelin wrote:
> 
> >ACK. I noticed this problem (and fixed it independently as a part of a
> >huge patch series I did not get around to submit yet) while trying to
> >get Git to build correctly with Visual C.
> 
> Does this mean that Dscho and I are the only ones who add -DNDEBUG for
> release builds?  Or are we just the only ones who actually run the test
> suite on such builds?

It seems you and I are for the moment the only ones bothering with running
the test suite on release builds.

Ciao,
Johannes
