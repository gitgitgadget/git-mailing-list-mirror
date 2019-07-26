Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FAAA1F462
	for <e@80x24.org>; Fri, 26 Jul 2019 14:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfGZOHz (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 10:07:55 -0400
Received: from mout.gmx.net ([212.227.17.22]:48289 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbfGZOHy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 10:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564150069;
        bh=+mMkFGXaXpTnR0ZVAblmmcdAoOGmTd+k7UXn6eFxNNE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GEvrQTdByR+q+4Ptu4UKqY0Y3LLMvDWtBcXK/uwNZGh9u443EbacHtMyQdLgD/Ifi
         1axA/45uuMlcZ81d4Opt3BIrsJwBcNFWnjriM1mU/vy3shGb5nfQRu8Ab8EGfGgp1j
         0ytaBLlfYAKtCsWbSZX5lMErU4bmsNyCh/fbnYSA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LobGI-1iJD5y45m6-00gWw3; Fri, 26
 Jul 2019 16:07:49 +0200
Date:   Fri, 26 Jul 2019 16:07:47 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 00/19] Cleanup merge API
In-Reply-To: <xmqq7e85pw3y.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1907261606570.21907@tvgsbejvaqbjf.bet>
References: <20190725174611.14802-1-newren@gmail.com>        <xmqqblxioufc.fsf@gitster-ct.c.googlers.com>        <CABPp-BGkGch-ebOrJTprw3oGgubgZyyVBCCM30VLbC24BU+MUQ@mail.gmail.com> <xmqq7e85pw3y.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:kxRp2C6UCZ6ZB9d1ECDOdSmrhnrA2E4SWed1+OohNGNpyOnktIw
 Bwh/p/x/dvGf9jSQe20xdm6HrRLuWsEbDdJpbl+vqErXZmYrg2eaJRYYtI6uSIFDujIlwQ7
 6afRa2Xh8453IMj7ByLqDYNGGObVA9JrSMinMOQmBnEfI78sVS4SUzD1ctn3McVS2lOAlkC
 dImBJEKyDHAyhxYioBDkw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P3BQmedMkdg=:frA+/3AlBsdZ4d3t6p1itQ
 eogkwlM3FOOb1olSlRR02QKCIPE0ufUfdB9aGmBwhppuUSkFe5U5hrLsic44l3nIOwrRzugTr
 0kQ0Bg7ExsuecslcKYJobJzSKHaTSHAbGS0hrER7XrMTaPGf4xDs4Og22T9D7celkSlJDKPIb
 7mer8wulu/4xjLvJoGU5iJnz1OhDIW3znLErqzY6EdDpPgPohAd4gTkwpyvERssVPTSNVaVwD
 /gvyQJcjlxhMprTelCCqThDLaYYb42YSX9jza7V2soSrv3U7piMePrPB8P5IojKm+JtZ1ik5V
 Q/iBNmv+N3ZIp813jb2HodQ7ipgOx/zdRON70GLHmPnyyQyMEMPldEvZMQ7i/ujxdHKIqmAch
 3ijN/Phpb1wXoLiOf6u4KXw7Uh/Vy+8G9EjjynfljgLHxoaBTS3EESLsBnOJLUMIeHyMjstip
 PLfjPEUkHGZRAuVkfRItZboKxHI07z3dmVrP4dnk2v9J6Mjv4fDg78tHRNwPaQwlds0iO5BQp
 vKwsCgQiguSfVdJ3hXIBrxA+NnH0RapiH0fwE736LlZIeqGX1tUGhfzjP/DD50s1ROpe8Ib3D
 g+hyBNymogaHd5+Pnpk1Z4PjL5WFoS6g7Sshal6b8tR/37+B8cIdOzqcGncitDcoaC18xgJon
 +lK9WO4FSelBbI4Uj8m8mxa0dSl61PyDG5fnBZ3wBXWU+xSnyzf9byN+g3FMXYxTsTbOpGYHC
 XEAA53McFlYGMwHHP3p0RcNIfXCkqnPFtKm3Mc/TCs4RoewHNZVMyW8lAgY627PHl0C6VgyCm
 OmvOkFfNR+HmTEBaJIq3rgJq0Hf6gG4p0OTuY7KyC28PAwFIFMsDwb8Ra0zSVuqlv8okKRF9w
 5jkNw9WT093v6lCyE1mQm+JMMn6Ao+rax3oG+dZoTmmJ12Zk8T8X7T9RJ6B1uLIZd0LJzg9j5
 Uo8LmQQWy6lGiOmwcCZhhBs8lmFiIpY9D9Qs4f4/CZUekxcERYgx5yNUtysuyoNa7wZCqBXa3
 e90Map3Mv6JOj3m7F9FReGvMPrVm2/R9H1aoF/w/b/tOU05mHMg/8qedxbCtjsaQRCn4nqaPY
 pz0KbMJn2wWiaifvomeydmRotCnZNf9l4tG
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 25 Jul 2019, Junio C Hamano wrote:

> Elijah Newren <newren@gmail.com> writes:
>
> > On Thu, Jul 25, 2019 at 11:12 AM Junio C Hamano <gitster@pobox.com> wr=
ote:
> >
> >> > Stuff I'd most welcome review on:
> >> >   * Is cache-tree.c the right place for write_tree_from_memory()?
> >> >     [see patch 7]  Should there be docs on how it differs from
> >> >     write_index_as_tree(), already found in cache-tree?  What does
> >> >     the latter even do?
> >>
> >> write_index_as_tree() is supposed to write the contents of an index
> >> state as a tree object, and return the object ID for the resulting
> >> tree.  It is the primary interface designed to be used by
> >> write-tree.
> >
> > Other than the last sentence, that also sounds like the description of
> > write_index_as_tree() -- at least as best I understood it.
>
> Yes, I didn't even know merge-recursive had its own variant.  I
> suspect that back when "merge-recursive in C" was being developed,
> it first used "git write-tree" via run_command(), and then just
> copied and pasted what was done in the write-tree implementation
> without bothering to refactor it into write_index_as_tree() and its
> own bits about the unmerged index.

FWIW that matches my understanding (i.e. one of those authors' of
"merge-recursive in C").

Thanks,
Dscho
