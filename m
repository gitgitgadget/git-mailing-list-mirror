Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFEF01F453
	for <e@80x24.org>; Wed, 23 Jan 2019 20:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfAWUnY (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 15:43:24 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:12068 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbfAWUnX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 15:43:23 -0500
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:33e:2802:50eb:d77d])
        by smtp2-g21.free.fr (Postfix) with ESMTP id 322332003BE;
        Wed, 23 Jan 2019 21:43:21 +0100 (CET)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: tidy asciidoc style
Date:   Wed, 23 Jan 2019 21:43:20 +0100
Message-ID: <3206857.CYPHc56XGh@cayenne>
In-Reply-To: <xmqqk1ivb1yp.fsf@gitster-ct.c.googlers.com>
References: <20190122201635.15961-1-jn.avila@free.fr> <xmqqk1ivb1yp.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday, 23 January 2019 20:36:46 CET Junio C Hamano wrote:

> I somehow misread the title as "tiny asciidoc style (fixes)".  This
> is a huge clean-up.  Thanks for working on it.
> 

These styling fixes were raised by warning of po4a when processing 
the files. Otherwise, there's no hurry in pushing them.

> 
> Two questions.
> 
>  - Does this affect correctness in formatting?  I thought not.
> 

This does not affect the formatting of  man pages. For html pages,
the content is different but there's a rule that repeated spaces are cranked
into a single space before rendering in the browser.

>  - How are you finding these?  

Editing the intermediate po for translation, the tabs are shown as special
characters \t (in case there's some formatting  to preserve).




