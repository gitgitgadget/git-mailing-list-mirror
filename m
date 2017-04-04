Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC8AB20966
	for <e@80x24.org>; Tue,  4 Apr 2017 11:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753677AbdDDLyf (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 07:54:35 -0400
Received: from mout.gmx.net ([212.227.15.15]:55470 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753074AbdDDLyd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2017 07:54:33 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MQ2zr-1cyxoK39rn-005HHr; Tue, 04
 Apr 2017 13:54:23 +0200
Date:   Tue, 4 Apr 2017 13:54:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC] dropping support for ancient versions of curl
In-Reply-To: <CACBZZX5D2cYf0-ob_Da0EsxRtZHfegezPtCGA10-sjfi0A+AoQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1704041351350.4268@virtualbox>
References: <20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net> <CACBZZX78oKU5HuBEqb9qLy7--wcwhC_mW6x7Q+tB4suxohSCsQ@mail.gmail.com> <20170404083341.uajswm3qdzyvzxsp@sigill.intra.peff.net>
 <CACBZZX5D2cYf0-ob_Da0EsxRtZHfegezPtCGA10-sjfi0A+AoQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1002395215-1491306863=:4268"
X-Provags-ID: V03:K0:eF4MZBpmvIM4jM9aKMYp2MXnS9Xf5GrYOG54MOSMZScb1Q9WcoK
 5iCJQEzFRI1xaDmE/4eS5z7jdFG1qLtZYPDYEnKsOAkZEdnk/fdpFZiKwELftVN2PZheHTJ
 v93UtMqEzUbQfz6tYn//K4LieyH9HXg+fZ/DrlaIRhj+9vJVTWLfZ64y3YSjNEBn1CxLdne
 Y0lL8oJ6b0h+amKVQoE7g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jZbsTKiJhwo=:QeL0RshNNXovoPuNPNi1yJ
 lWUuURpaZWlnAbscQMzAiNY/dVmwBb9kzfOqqK1gHhCcBOnyQm7UfuB5rKb4LXElAwkdF/AXf
 h5w3iSqtaOZwWWRDT4dkft02RbCtLMy2bdsO7Jz/hT2xPqdtTZmEIwxSCTSgEqAvbo/fggYUL
 lOZTC+mBLdQ3dJk2Ky7IKGRz4v5Zz/uesAh/VKoQrTuUKy/4j6PVJnm1yS4YVut+jxXgikZYm
 lNcYTxnXB09AD4R4ptZxyMaocymcxVqUNo857r6fG5RYMVndI8/qhLiI8guMQXEA8G2II9xwE
 eg32NXjNJFFHVDk4AB0XCHE9Q/sog0U0eDnXrZJMOenl28HWmDLYtgwg8xaMnkVNdwRN/V3zP
 NmXTUESKo3ikHljuvzDifZTYE8FQwQ8lMMtJNz20rxf1kMoPp/G5IN6k0tz4b7pCrHv7A6BZM
 QJNd6eHANiVBn3qO0QwsmvKdxkeCtezffoKtQCYrU+QNesH6b8CZ2wSCBa6Z51UkVUZqdVmyY
 NyqdLOjCSTmVi0WxBSnb8lHOuRviRwKNvNZs9AYHOnVEZLYpP7G+PaugetS39MyVHM4Wtijbm
 igYvLUw3L2FYBCfokWmu/fYGZ9RhhiT90qeL4rgJyYRKHxHfxSQQnvGVL8NYKlyZjIfcXTYoy
 ScdIJdgGkWe4hvmAKcqWwngENASSA1LgaKJj/3KZz1h5cBiFq9lEbZeGe5H/3X1QEA0PLjhGy
 OSQoWPN0d8k8RCdfJMcjIJp+AYGtAa0SPfw2hj7/NJQHPHhYq+micmqaQBhwcrAO2iGIYIOMf
 R0kS1hZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1002395215-1491306863=:4268
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Tue, 4 Apr 2017, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> I think it's completely fine to include your patch as-is. At some
> point we need to pass the burden of dealing with these old software
> versions, saying that you should use a <10 year old library isn't
> unreasonable. Anyone packaging new git on RHEL5 or derivatives can
> just package a newer libcurl as well.

But how much maintenance burden is it, really? Is the continued use of
those #ifdef's really worth this much discussion, let alone applying a
patch that may break users who have so far been happy?

It would be a different thing if we had to have hacks to support old cURL
versions, where we need to ship entire >10kB source files that tap into
internal data structures that may, or may not have changed. Such a hack, I
would be happy to discuss when we could possibly remove it.

But a couple of #ifdef's? C'mon, man, we can carry this *without sweat*
indefinitely ;-)

Ciao,
Dscho
--8323329-1002395215-1491306863=:4268--
