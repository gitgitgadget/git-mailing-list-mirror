Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B245D1FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 16:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756062AbcKVQKM (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 11:10:12 -0500
Received: from mout.gmx.net ([212.227.17.20]:62350 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755846AbcKVQKK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 11:10:10 -0500
Received: from virtualbox ([37.24.142.46]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LtEtL-1cuGdB2JRb-012t49; Tue, 22
 Nov 2016 17:09:58 +0100
Date:   Tue, 22 Nov 2016 17:09:57 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] rebase -i: highlight problems with
 core.commentchar
In-Reply-To: <20161121190514.18574-1-gitster@pobox.com>
Message-ID: <alpine.DEB.2.20.1611221709180.3746@virtualbox>
References: <xmqq7f7wk7x9.fsf@gitster.mtv.corp.google.com> <20161121190514.18574-1-gitster@pobox.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:2VNUSRo5c2LndsrCM7zbVKKRM+nquZHteYqFCNzpdNf8tgEaCRZ
 /uy0g1VzHH4+PYiuCElrdpvgF3DXMBIo/AfrwWnraJ6FDNx5YydE3D3E12rRqeLslrkfoxv
 RKu3/qMW+Xz23/af+n1Y+3Hy5ietXAQrLc/d8qTemWRMNmr62MpAgf47NxdeO3R/WITI9kq
 dHgXs7jms3moWmmIUTeyA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:m1o+NKSUSS8=:C1Y59TkUVRqn83B7WG0g26
 EzFT4HE9Yx1+mLDPvuOGmxvpRFpBC5Tuj+GgpCZ8ra7P9tg+GAvKnrt3wtitvST89XEJi1U+D
 p+1Bj6sxxCyU7CR7xRKJwac5q8sfBa5NFtianzUWqxToDWEKiwbel0jAnVDS81bVeEZQmF0I8
 D9A1YtA5ZJ6fjN85nljPNt7yYJRPGEfrEMqsXrtSWwNayPSroQFB/GqSsUCuBhxXTaOAiBJgU
 8VEbEIKg5cZvepRiPQ8sf/mY9T7F3wiYdjedatnwtSC55LaX8wuSpYqhnIw0V3re4ztP7E+yD
 /s/WGlp17nSUc2lkD8hTlHiaXkmWu+lhDF+fUnChMxCcUIyt/Dgy3J+4aw1PdhKSBQIM/iOyG
 xQQOw7q76fsgtfO48GDoAVn7/eI1yw/YSEpiK3mELK9y3FJi4H7l1xQ+esNZWZ6bbmuhsDygz
 3ohTKZR/I3z0ijnSAabVQBKnVyoqt7bK1njv+4yrwOBIfEcnvHRmMkD4qxTu9ugOyy8Cvt84h
 lHjnAH893eD3sdtmhDROLJK8Gau35v/B3saDPCvBlWg7ohMFWMke8nZT87ptDdEXxPqVwbDz+
 NAHRCqbqzCXnWEaxaVJ6XhplPl1p5jzpI0LEveOGV8AbCYEV8o1jTlSPEMVxDbPrHhRj6AwNI
 Q7f8LfqtftGneup7XUw8XeFdX2zwqt2cgFw2EYn7AX5kx9+NXd+DPvm0vVUko61muIwAKRH3X
 ywdq8pk/zttB4i8h54W0tMJd8PnUqLfK2MoJ3/jo9vb39jbBFAhDVyO7yDGItfH3aHcVghwQq
 ALDoMu7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 21 Nov 2016, Junio C Hamano wrote:

> diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
> index 29e91d861c..c1f6411eb2 100755
> --- a/t/t0030-stripspace.sh
> +++ b/t/t0030-stripspace.sh
> @@ -432,6 +432,15 @@ test_expect_success '-c with changed comment char' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_failure '-c with comment char defined in .git/config' '
> +	test_config core.commentchar = &&
> +	printf "= foo\n" >expect &&
> +	printf "foo" | (

Could I ask you to sneak in a \n here?

Thanks,
Dscho
