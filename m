Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C617C1F858
	for <e@80x24.org>; Mon, 14 Nov 2016 16:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932607AbcKNQk6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 11:40:58 -0500
Received: from mout.gmx.net ([212.227.15.19]:62085 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754013AbcKNQk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 11:40:58 -0500
Received: from virtualbox ([37.24.142.46]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lp3sy-1ckuO41i3o-00evBb; Mon, 14
 Nov 2016 17:40:48 +0100
Date:   Mon, 14 Nov 2016 17:40:46 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Michael J Gruber <git@drmicha.warpmail.net>
cc:     Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [RFC/PATCH 0/2] git diff <(command1) <(command2)
In-Reply-To: <0c39be16-76f8-0800-41a2-b7b1dccdd652@drmicha.warpmail.net>
Message-ID: <alpine.DEB.2.20.1611141739560.3746@virtualbox>
References: <20161111201958.2175-1-dennis@kaarsemaker.net> <xmqqinrt1zcx.fsf@gitster.mtv.corp.google.com> <CA+P7+xrFYj7sepdz1xrEEaqmXQWfRkBz3CsWjYK6OZsZRMLbUA@mail.gmail.com> <alpine.DEB.2.20.1611121106110.3746@virtualbox>
 <0c39be16-76f8-0800-41a2-b7b1dccdd652@drmicha.warpmail.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:IRxNSXqI906v012k+up0rCUhuLKRJRd80GvxOK7twh4K+Ch9xHM
 lLXKGI4Yo8ZqeE9m+g7Z8d8nLEQjM5o1bHRk1GB4w4oHvEM8cbN2ewwF8JNIX7XBrHDPG4r
 0Hg/jRkNsw9dplIgeR8Eq4qkzITnQUk8q60sLJFl2/YZEcmQhA5TPqDYGKvSVoE7r2J2J9u
 cooodNQ+duFQQ0eeFeQZA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Zl+9hvKPSjk=:qqiD4GtznUDRFbTPgV/PLQ
 PP2N7c4Vm/kaAmZlqE/NrctfDZ226ufw35U4iB1Vpd7VpPxxJ75kV8yx7pZvh+6NXYwi9ZeM7
 d9uKa8rLeMVgybPqcyHxsRJKoY7fF7+nr1bTUzfluZBt03QFnGgcX+OpdNaV9kl+yQTORG+4h
 4owJFQmrRD+qAumUbtDJP+IwOkbCPK+3W02iCWN64dyUPqu0moGbmKvaf0i7QODZv/V9GFgz7
 iRMB5xTfEsQLrbCjxZz2+JYRexZvIa4c40D6g49onFyA+HxcFURtDMey/jzQ6W/+/I3nEnL+v
 GI2sh1k4qsv5jMbGNVi+d99BA2PRiDSFucWfloJIqu4rIz5+Zx/lzkoNR5/3By/SL67gyZLpf
 y5LjzUGpSjJLiHgHxnYCqfoSoiv9HbeZigOrMz4YKknT7KtDvZP/6FBnEtZitGdaXGXnJBENa
 GI0idqLYO2o2F9M+LET2hFHx3FTaRScaVOfLaRfSKFhGBHAL4NWsOxtpIAV49lH3TX5mSoWrp
 BVp3zPSSxzf9qvEfShDt6okKfTbr+3VjrsTRKXqfqguzLx4gYpvRUXnMg8zw+a+OGoYcovTvM
 ZCt8rE3W8bQbE/QXYsIB3UEohjUmYIDVGkYB9Cr2KgIOpq8kgYp66hjFCUxdY6MWHGadEem7U
 U450wk1TFTS6CzIyPxfryxwgIdR0JM2NZjM9kMclsXP6T5cdlS0wPh578dJdAJ9VrMQ1WVbel
 w7VnAPfIQ4A63Z0VP7uI5o1v6zQKQcgeMSWScCC26lDfiVCP8CnJqwAPzoCkg1qIoOf+BBJEn
 ITjKr95x95xqRFurljdS/NevvVujiIJlRyhdAovULNUUGBUXgc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

On Mon, 14 Nov 2016, Michael J Gruber wrote:

> why should a *file* argument (which is not a pathspec in --no-index
> mode) not be treated in the same way in which every other command treats
> a file argument?

We are talking about `<(command)` here, which is most distinctly not a
file argument at all.

Ciao,
Johannes
