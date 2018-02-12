Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB2431F404
	for <e@80x24.org>; Mon, 12 Feb 2018 20:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932109AbeBLUVN (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 15:21:13 -0500
Received: from mout.gmx.net ([212.227.17.21]:57673 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752319AbeBLUVM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 15:21:12 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx103 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 0LrNoG-1efb0o3V6K-0134BB; Mon, 12 Feb 2018 21:21:06 +0100
Date:   Mon, 12 Feb 2018 21:21:05 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Sergey Organov <sorganov@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 5/8] rebase: introduce the --recreate-merges option
In-Reply-To: <874lmmerdu.fsf@javad.com>
Message-ID: <nycvar.QRO.7.76.6.1802122118420.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de> <874lmqirma.fsf@javad.com> <nycvar.QRO.7.76.6.1802102357510.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <874lmmerdu.fsf@javad.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Vkk6g3eTXWCSnbtdkQexac4rF6T0Bsg+evbXgHlatyMxqR2kQnn
 EDFtwpRwUvWQsqHHG1SzXqFuc/yCqeBX1jAHXrT7bwaP5BLW/2F1BQRh9RfmADtkUGoqRco
 E64kRgCdDYFMYndcfd7o7SPuh8RBl8X/xkXv0U1fC3z/hqWEraJDR6gaEJ62kWhr+U8AJYW
 Q9sUgpuOxWFWXBHziR+Mg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mVqqS/skkUc=:AU96b4AlYW8wvLTICmpnf6
 oygA7VcI+PH0r9YJQqlHyY1HgohS3ccRvFEktb1k5C+4LgJjM7jOEhG1oy6K8h2Vejp8nPRLq
 5Ts3zUhZKqnulRsK2oVM4zkYEoGWC40CRM4HIACu7QzaCvZmz50EIQc+fGfpKL9sKC9UGBlP4
 22+kRMby85/If22wF3TDLt5Fxuqa5NL5LDga9Tv1/T/aTQny7zPcHhi9wAI4j0wDgIanZ+9Gc
 rauHkHfk/OFia3/jwB6pEsltqqu7r/s/MVdyjaSdZustV0l7rk73llXBCa09RWcLEYCKB37Rr
 OXnhv7m/udkJbku8pIPNy8e+OE6vcRP7z+z+pdwxJ9wVhyu/WOb14tx0iAnD3MHjCQv8YEm0T
 8jPTvSjeULSx4+Erly+4uv3sAxZZ1De+8TGSOXm8BblJR2cn+Cyqf2OMOy0LZR4gBtltprUNL
 O0NWIcqFknFLFwi11MxtcUI+ItZ89xkJirGvISpm6TW4hGxy4za70cfQE7pbjV8iJo8Q4iGSM
 R5rGKz8hf6j8wjoqvVN9h9Ej5ah++VLf5uSMx4q9GpikssAQkGU5mkRumC5yew2vB3dlD63PV
 gmDRUBlARQl0ZdY3iqfmSprM6ZKJWBQ80cDn+F+UkEyr3NDuprUqqEZqlcZ2Pzw/JPNNUUKCA
 +c/zTmWZM2zx9pQgS14GeDzKpiEYgSzfr5wOo1zL27MffSbn6p85YZ8HFh9NF1y4bFE4kZdHA
 uE1JE+5O8U9GESkNNEjEHyWNqzgn/expldrJ2aqYNCLushk6hBDyKtjal1twBiM6g9Ay9mulI
 Ls1iTm3dU9Uub9v4rJ4HozhaS/OnykoFkiNFqHrzq+qOQf0ScI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On Mon, 12 Feb 2018, Sergey Organov wrote:

> Thanks for explanations, and could you please answer this one:
> 
> [...]
> 
> >> I also have trouble making sense of "Recreate merge commits instead of
> >> flattening the history by replaying merges." Is it "<Recreate merge
> >> commits by replaying merges> instead of <flattening the history>" or is it
> >> rather "<Recreate merge commits> instead of <flattening the history by
> >> replaying merges>?

I thought I had answered that one.

Flattening the history is what happens in regular rebase (i.e. without
--recreate-merges and without --preserve-merges).

The idea to recreate merges is of course to *not* flatten the history.

Maybe there should have been a comma after "history" to clarify what the
sentence means.

The wording is poor either way, but you are also not a native speaker so
we have to rely on, say, Eric to help us out here.

Ciao,
Johannes
