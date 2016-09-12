Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FC79207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 12:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757526AbcILMMi (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 08:12:38 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:14340 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754615AbcILMMh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 08:12:37 -0400
Received: from [192.168.1.112] (unknown [164.177.97.114])
        (Authenticated sender: jn.avila)
        by smtp6-g21.free.fr (Postfix) with ESMTPSA id B9F0A78035D;
        Mon, 12 Sep 2016 14:12:25 +0200 (CEST)
Subject: Re: [PATCH v2 12/14] i18n: show-branch: mark error messages for
 translation
To:     Vasco Almeida <vascomalmeida@sapo.pt>, git@vger.kernel.org
References: <1473679802-31381-1-git-send-email-vascomalmeida@sapo.pt>
 <1473679802-31381-12-git-send-email-vascomalmeida@sapo.pt>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
Message-ID: <ba3430ff-9643-eddb-31e7-c1e9a399d806@free.fr>
Date:   Mon, 12 Sep 2016 14:12:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1473679802-31381-12-git-send-email-vascomalmeida@sapo.pt>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 12/09/2016 à 13:30, Vasco Almeida a écrit :
>  		if (MAX_REVS < reflog)
> -			die("Only %d entries can be shown at one time.",
> +			die("only %d entries can be shown at one time.",
>  			    MAX_REVS);

Wouldn't you i18n this one too, with plural form?


JN
