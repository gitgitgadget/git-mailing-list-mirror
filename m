Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80FA5201B0
	for <e@80x24.org>; Fri, 17 Feb 2017 23:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964985AbdBQXcx (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 18:32:53 -0500
Received: from smtp26.services.sfr.fr ([93.17.128.20]:56197 "EHLO
        smtp26.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964850AbdBQXcv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 18:32:51 -0500
Received: from [192.168.1.57] (220.208.99.84.rev.sfr.net [84.99.208.220])
        by msfrf2635.sfr.fr (SMTP Server) with ESMTP id 8C0711C000431;
        Sat, 18 Feb 2017 00:32:44 +0100 (CET)
Received: from [192.168.1.57] (220.208.99.84.rev.sfr.net [84.99.208.220])       (using TLSv1
        with cipher ECDHE-RSA-AES128-SHA (128/128 bits))        (No client certificate requested)
        by msfrf2635.sfr.fr (SMTP Server) with ESMTPS;
        Sat, 18 Feb 2017 00:32:44 +0100 (CET)
Subject: Re: [PATCH] Document dotfiles exclusion on template copy
To:     =?iso-8859-1?q?Gr=E9goire?= Paris 
        <gregoire.paris.greg0ire@gmail.com>, git@vger.kernel.org
References: <20170217232748.13164-1-postmaster@greg0ire.fr>
From:   =?iso-8859-1?q?Gr=E9goire?= PARIS <postmaster@greg0ire.fr>
Message-ID: <e5e55478-af1a-5886-519a-2e11f60950b6@greg0ire.fr>
Date:   Sat, 18 Feb 2017 00:32:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170217232748.13164-1-postmaster@greg0ire.fr>
X-sfr-mailing: LEGIT
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



>   
> -The template directory contains files and directories that will be copied to
> -the `$GIT_DIR` after it is created.
> +The template directory contains files and directories whose name do not start
> +with a dot will be copied to the `$GIT_DIR` after it is created.
>   
>   The template directory will be one of the following (in order):
>   
This sentence does not make any sense, I realize that now.
