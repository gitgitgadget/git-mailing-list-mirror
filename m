Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF84220248
	for <e@80x24.org>; Sat,  2 Mar 2019 19:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfCBT6D (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Mar 2019 14:58:03 -0500
Received: from mout.gmx.net ([212.227.15.19]:56989 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbfCBT6D (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Mar 2019 14:58:03 -0500
Received: from [192.168.0.171] ([37.201.195.16]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LxPNC-1h1buC2yL4-0170QE; Sat, 02
 Mar 2019 20:57:54 +0100
Date:   Sat, 2 Mar 2019 20:57:57 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Makefile: use `git ls-files` to list header files,
 if possible
In-Reply-To: <20190301215414.GB1518@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1903022056500.45@tvgsbejvaqbjf.bet>
References: <pull.130.git.gitgitgadget@gmail.com> <0b5529406b9458d37f3f5cdf38baa2d6a0a70a65.1551470265.git.gitgitgadget@gmail.com> <20190301213619.GA1518@sigill.intra.peff.net> <20190301215414.GB1518@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NAA/IypNbLKzc5t1lZbggcjZk3b++LIeUuwBTUFXBzHExeB5ntM
 AdwSbuxpOut5AYZVjJIivChlJubn/CbgUWlCNUlL7iKQ5DQlMbB7CsgLAxqeYh//0wxq7Jb
 uK0IigFxNfeGPIVObkB9ZpBNCFGueJDe5gcuKy22gPAtqav4j0IBguY8BvO2CRDDwiEEiLZ
 Zp+wENDB5fVjjigFhozdw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EGpi2zTS4cc=:gjGPeRX3xROPf2X4y756Cr
 L7BcQ7xXRt43jbb3QYg1EzNHAwSTGcR8aJVcn3vujNylQJfE8l4pqn2xgq178QVwaZccxR4+w
 CWBR8GlcOnHRdI+O+cxfyMPFrzphjMOS7Rn/DaOwExkSNewwHg/QHVgtlCI07oY9GDbOV88Av
 ZTmc1byx0O4lV6jB1SXtqx3weeM7tE/gRAS1rgLQfZfmAJT72lHoRULLtcKyfoLxj5E8cSbW2
 sQzcqlTbzYRDqHc1N21hFtOVdJrW70ffW9bM2r5dUciBw7i9B8dBDD82CbkWWECHvBxvmoZXV
 c9ts2UXj4LETffdYp4J/t9QLRV4yjDUopVAQL9cN4YpwiSTZiogCvk1jkFMvs8voqd/G/Z6mj
 njRyTLrvFLdLXciS82bOIGtcyvjmdCr4QDEmPXekChobaYFi/uvLXM+uFOIBwoorvFdKEsoPK
 025KdIPELjDPZQCN3lxfeSruSVhD5XRg8OZKxyrTcP0amiD5WsipIiTvFPvKO9HVXpE/0V3U8
 DF9vkjJMWPEUrTuWBi0t5AKnEvYPHWL2qBNJdu2n/n3aEUVE9+dEzEYO3rJKdXrf7QEktdXoI
 +07wPU7oHaBB7T4iNPG1LnvNZDD2HOy192gDsshIk9aJkUundKprruAlD2VFQHja91K+VHMT4
 Hh6nQ5Hd3qOus78kjBBTASnjo/LD9vWKJK7QqvDsCUJJbzneZoeFdSUUBb2MCDvJv48Vn1LlK
 ElEkmdcI3SH17yj/5iyGtOGhFR1qZnAorxhTb7SqspVwGflFMk2058scUvirxQSFcwrwsT/34
 HAohWoXVaIjTgOgLHVBm4iPF1J5rs8Dg3y2PAEVO1R8p1vR1mQly7w11LeOLI7Y97TVUDMoh2
 ba6eAN2kcVmzsLSeer7buneIdTe1zLo44Qn69+GjYtO0gMfXtttnjZImhX8NOEw26Pxyz+OSy
 FyHAduaTmpQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 1 Mar 2019, Jeff King wrote:

> On Fri, Mar 01, 2019 at 04:36:19PM -0500, Jeff King wrote:
> 
> > > This has one notable consequence: we no longer include
> > > `command-list.h` in `LIB_H`, as it is a generated file, not a
> > > tracked one.
> > 
> > We should be able to add back $(GENERATED_H) as appropriate. I see you
> > did it for the non-computed-dependencies case. Couldn't we do the same
> > for $(LOCALIZED_C) and $(CHK_HDRS)?
> 
> Answering my own question somewhat: $(CHK_HDRS) explicitly ignores the
> generated headers, so we wouldn't want to bother re-adding it there
> anyway. Possibly $(LOCALIZED_C) would care, though. The generated file
> does have translatable strings in it.

Yes, and it is defined thusly:

	LOCALIZED_C = $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)

So it does include the generated headers explictly anyway, with or without
my patch.

Ciao,
Dscho
