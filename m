Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB5632021E
	for <e@80x24.org>; Wed,  9 Nov 2016 13:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932466AbcKINzE (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 08:55:04 -0500
Received: from mout.gmx.net ([212.227.17.21]:57686 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932219AbcKINzE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 08:55:04 -0500
Received: from virtualbox ([37.24.142.46]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Meutp-1cSTTG1Tj7-00OaKn; Wed, 09 Nov 2016 14:54:59
 +0100
Date:   Wed, 9 Nov 2016 14:54:58 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] sequencer: silence
 -Wtautological-constant-out-of-range-compare
In-Reply-To: <20161109035728.v2mqvtj4ep4dj74j@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1611091453580.72596@virtualbox>
References: <20161109035728.v2mqvtj4ep4dj74j@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:LC0O/5FXzKQrBvMKsaR75L7q4IVHGZnKGj3bEpTZUYD17gEzzii
 gq3Vm8OyqakB4DcTqz+oubOBrT7TNiKrMAPthBtjRykyfIi0dLtYZvRCZRqa6ienqneTZOy
 W7SW9rWYXNVEjxBodaYHHeTDimedcEMCtKlgGct8p/GBWJ+loZZYdp8Jf14SNO6RCB9fA5l
 6odv/LOzN8gJqi8czX5rg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:43oUo1AGCeE=:9aOflKtM0/yvmTQ9Hw0bF9
 5/AggoUImtoqPHR4CpBva/bOS+zQesWmk1RkSxb+shze41BXgp+hIWigZhzyvh3i8I/hZpKMR
 v9i+swscAhWwgyXgBYttYz3V8JF/T8DDfGsMBlPPHjVv3uNKzhMjGIbOyuvY/y9V7Rnw782do
 GNauJr6kfWTRzjffvIq7fZ/serk0FdT22rupOidiLaEKhY3BmGQlgiKvnSp2uG3Xvcvl4bgJ/
 ZRRBAWglKq/Qxetv7+EUnAvKI0IM7n1O98CTpNFiIMG6sOXEsKNlBxMe0kRKwBWguA/O7Y7FI
 ARQQcVIqgvktX1Sklixf5J4WG8/Jpkw8uALx/OGxstrUBV/cycDF2fnyHqr1jNOFXbvJqmHKb
 s5DviT7Q0kDZfTg2/1CUGGQ8wswOwUQc8m12qDPLEEw56YxyECRH6INHhDxv4Zju19eQniOFQ
 aBegjP0P7oPq8SGIEMbYVJafWYlbL7AttYA+K3LiRvCVSE+dFoJey/Wp6BBqYSH70h9Z3bCJ6
 uNr3++fjAQKGMrmm0CbgOVs7j+uXtQpEyyAf/qyA32OHqrK8DhlepXQauYjbFr2jGMpb/o8fw
 7LQYUCmJhN7NxWiYZDv3jp97qGEBVpw+RKz/G/ppmXdwp9NOzT3JiL6HBh8KCznUXa/+tR8JZ
 FgXeWmmmCS8c+YRyG027J76oKi8BU+0r5xBlk/yii4xg5d6IDOw30t3okHNsHbTBwHFRjg1ct
 pyYKM8Cl2C1odvDwdi0rYl2ogvA+p90MUVRkrlPDAX9P27OGMrWX2m+SPbVhcxzBWFD1h1uzZ
 BCmsxKl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 8 Nov 2016, Jeff King wrote:

> diff --git a/sequencer.c b/sequencer.c
> index 5fd75f30d..6f0ff9e41 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -629,7 +629,7 @@ static const char *todo_command_strings[] = {
>  
>  static const char *command_to_string(const enum todo_command command)
>  {
> -	if (command < ARRAY_SIZE(todo_command_strings))
> +	if ((size_t)command < ARRAY_SIZE(todo_command_strings))
>  		return todo_command_strings[command];
>  	die("Unknown command: %d", command);

I have come to prefer a slightly different approach. Will send it out in a
moment.

Ciao,
Dscho
