Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A58E8207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 17:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756122AbcILRUF convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 12 Sep 2016 13:20:05 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:25921 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755687AbcILRUC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 13:20:02 -0400
Received: from cayenne.localnet (unknown [IPv6:2a01:e35:2ef1:f910:86a6:c8ff:fe05:d3e0])
        by smtp1-g21.free.fr (Postfix) with ESMTPS id 5A9FDB0052C;
        Mon, 12 Sep 2016 19:19:56 +0200 (CEST)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>, git@vger.kernel.org,
        Jiang Xin <worldhello.net@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 12/14] i18n: show-branch: mark error messages for translation
Date:   Mon, 12 Sep 2016 19:19:55 +0200
Message-ID: <17140652.xHVhzLXte8@cayenne>
User-Agent: KMail/5.2.3 (Linux/4.6.0-1-amd64; KDE/5.25.0; x86_64; ; )
In-Reply-To: <xmqqa8fd3vb5.fsf@gitster.mtv.corp.google.com>
References: <1473679802-31381-1-git-send-email-vascomalmeida@sapo.pt> <ba3430ff-9643-eddb-31e7-c1e9a399d806@free.fr> <xmqqa8fd3vb5.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On lundi 12 septembre 2016 10:02:54 CEST Junio C Hamano wrote:
> Jean-Noël Avila <jn.avila@free.fr> writes:
> > Le 12/09/2016 à 13:30, Vasco Almeida a écrit :
> >>  		if (MAX_REVS < reflog)
> >> 
> >> -			die("Only %d entries can be shown at one time.",
> >> +			die("only %d entries can be shown at one time.",
> >> 
> >>  			    MAX_REVS);
> > 
> > Wouldn't you i18n this one too, with plural form?
> 
> I would think this one is OK in practice for the same reason as 7/14

I would think the contrary for the same reason as 14/14 

We don't know the actual value of MAX_REVS at the time we translate, and 
plural forms can be quite different depending on its value. See for instance 
polish:

https://www.gnu.org/software/gettext/manual/html_node/Plural-forms.html

Of course, too bad, we only use one of the forms but I don't see any 
alternative.

Thanks,

JN

