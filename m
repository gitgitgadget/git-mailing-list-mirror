Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A05541F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 10:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932244AbcH2Kyv (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 06:54:51 -0400
Received: from mout.gmx.net ([212.227.15.18]:64950 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932675AbcH2Kyt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 06:54:49 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MRoyH-1bY73d2dr7-00SvzN; Mon, 29 Aug 2016 12:54:44
 +0200
Date:   Mon, 29 Aug 2016 12:54:43 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/22] sequencer: use static initializers for
 replay_opts
In-Reply-To: <1472462360.4265.21.camel@kaarsemaker.net>
Message-ID: <alpine.DEB.2.20.1608291254240.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>  <66d69469a64bd80d3bf2b99a250ae04a649d94d1.1472457609.git.johannes.schindelin@gmx.de> <1472462360.4265.21.camel@kaarsemaker.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:dtTXCiSol/JWUKq9y5O0Ex+Tlh1Vg7DXrlRAYKstvNTokbGDE/o
 vd3jm48hCKRHrQz8ZMr9Wn3lRjQCyEmfiH8GpBZ78fK3TbHkwWX5ue0Oo20BUm2UAoJ+UkM
 yUyjxKkT7iTvbhoVQQY3i4NIfaOdEuNgiE9bVje19Cm7LC9gsUY1dbLAyui8DXsNDfDQjLX
 JtZDkn82qpPw5SP0Xgsyw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:U5YdZxHL/gE=:XptCPIE4GUZ5gKcND4Aa0i
 QTQCY6s/RBZiSlEq0awZqELiZYpaqoApGXfr+ih1dPuYlV7+8nT8rtMJH607oMH5iocjYw7cW
 Faic4fYP9wswDucdNfJqT4HPrQKsjSQoiyXchVYiSxXAUDW1KXZw6ML0eU6LrAJeGp3ZkhhAa
 hQ8XuEfTwuRG/LydOk80VRW0YDXAZpzSi00F/Q3qtCF/SyjaYCRxnwZ2D9gcH/dskNyYfhS5Q
 G/A12C98EyYmX039NeZclH5ad4aEPXGEgmY1OlG6Soo55Hp7zMFtWQodR3t42xbDWupbohU5j
 YBOY/Ya+3xkG95CzO/Xo39XYH3fHaNCstZp7DeIr0ssh6+j/TP8V1IyiSpWV7VV/rBbJ8/3RH
 vkv989R/bnHi0mVUjdOw4D46mXyg10VDm7xXiro7hramvmUpxIDAG0rOcS1V9HTP34rjnNzLf
 o8oJHrUvC3nGvwz10j41JKXzeetOaQEZBXdWKjPzBy9N+9JZGpuiMqGwW0Ts8igjQvN0gPIvH
 KmMjRNroO9vEu9sttMN76cD3iiS08Zsw1TRuXnT46Pa6oJPXjl7FhQIDBnoCrNO9ucWDd82yF
 /nmoHLVAbPt/zl9tCdNANFHY4+UcIDO8PT9ZkpPmj0Icaj4+xSpOu1xsJstY5TAAowsvaf27E
 T28ngaA4M5BjZWRRNuWX7NKC/0SSzN+w8wznXZugmkWxg07ALEgKD92ZsZR/Q1UHqh1lN61zJ
 TiQo4M39MAT4Ojlw34orWQmMPdgDqI6citVuVr6r0/ZBa9ifpsnnJZsl9t3vcNs7AcdLdblSF
 +/6QxXo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dennis,

On Mon, 29 Aug 2016, Dennis Kaarsemaker wrote:

> On ma, 2016-08-29 at 10:03 +0200, Johannes Schindelin wrote:
> 
> > +#define REPLAY_OPTS_INIT { -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 0, 0, NULL }
> 
> This looked off to me, as it replaces memset(..., 0, ...) so is not
> 100% equivalent. But the changed functions both set opts.action and
> call parse_args which sets opts.subcommand.

Okay... Do you want me to change anything?

Ciao,
Dscho
