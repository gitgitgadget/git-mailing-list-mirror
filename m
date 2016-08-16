Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CEBD1F859
	for <e@80x24.org>; Tue, 16 Aug 2016 15:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753757AbcHPPK1 convert rfc822-to-8bit (ORCPT
	<rfc822;e@80x24.org>); Tue, 16 Aug 2016 11:10:27 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:55322 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752809AbcHPPJw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2016 11:09:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id EB26C269C;
	Tue, 16 Aug 2016 17:08:21 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tHpbc85ebhge; Tue, 16 Aug 2016 17:08:21 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id D4C94268B;
	Tue, 16 Aug 2016 17:08:21 +0200 (CEST)
Date:	Tue, 16 Aug 2016 17:29:24 +0200 (CEST)
From:	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	ryenus <ryenus@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jeff King <peff@peff.net>
Message-ID: <1134106438.1228353.1471361364992.JavaMail.zimbra@ensimag.grenoble-inp.fr>
In-Reply-To: <ce8891377cec31cada49208f2d192dda86658e40.1471353054.git.johannes.schindelin@gmx.de>
References: <520a941f7472ac1cb4fa41e6bba33a0afc2f5999.1471264971.git.johannes.schindelin@gmx.de> <ce8891377cec31cada49208f2d192dda86658e40.1471353054.git.johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] rev-parse: respect core.hooksPath in --git-path
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF39 (Linux)/8.0.9_GA_6191)
Thread-Topic: rev-parse: respect core.hooksPath in --git-path
Thread-Index: 7SdkSpNAuvoKJVFC1HCxYwMviGKTPg==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Johannes,

Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> diff --git a/t/t1350-config-hooks-path.sh b/t/t1350-config-hooks-path.sh
> index 5e3fb3a..f1f9aee 100755
> --- a/t/t1350-config-hooks-path.sh
> +++ b/t/t1350-config-hooks-path.sh
> @@ -34,4 +34,10 @@ test_expect_success 'Check that various forms of specifying core.hooksPath work'
>          test_cmp expect actual
>  '
>  
> +test_expect_success 'git rev-parse --git-path hooks' '
> +        git config core.hooksPath .git/custom-hooks &&

Any reason to not use 'test_config' here?

Thanks,
Rémi
