Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDBE01F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 18:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974AbcHOSyV (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 14:54:21 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:33506 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842AbcHOSyV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 14:54:21 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3sCl5j5lt0z3hk62;
	Mon, 15 Aug 2016 20:54:17 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3sCl5j4w52zvkDY;
	Mon, 15 Aug 2016 20:54:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id G9B7p-ue0DjZ; Mon, 15 Aug 2016 20:54:16 +0200 (CEST)
X-Auth-Info: Wllimod8ESq1MWyXXWO0szfkvzTBx8b0XJS74yiUc/jQk+/1abUKulUTEy86iGRk
Received: from igel.home (ppp-88-217-19-168.dynamic.mnet-online.de [88.217.19.168])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Mon, 15 Aug 2016 20:54:16 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 3CC6F2C3057; Mon, 15 Aug 2016 20:54:16 +0200 (CEST)
From:	Andreas Schwab <schwab@linux-m68k.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>, Eli Barzilay <eli@barzilay.org>,
	git@vger.kernel.org
Subject: Re: Minor bug: git config ignores empty sections
References: <CALO-gutdz5VMgoRmbqEa9UiaTC+L2Sy2n-3AF+zfPr-X8+1U4A@mail.gmail.com>
	<20160815120916.6iobqirqbg76exms@sigill.intra.peff.net>
	<8737m63phh.fsf@linux-m68k.org>
	<20160815180905.znnz6evufsne5wy6@sigill.intra.peff.net>
	<xmqqh9alhoor.fsf@gitster.mtv.corp.google.com>
X-Yow:	Edwin Meese made me wear CORDOVANS!!
Date:	Mon, 15 Aug 2016 20:54:16 +0200
In-Reply-To: <xmqqh9alhoor.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 15 Aug 2016 11:28:20 -0700")
Message-ID: <87y43x3lt3.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Aug 15 2016, Junio C Hamano <gitster@pobox.com> wrote:

> If we were to remove the section header at this point, we should
> be removing the comment two out of three cases.
>
>  - if it is about section.key, it should go when section.key goes.
>  - if it is about section, it should go when section goes.
>  - if it is a more generic comment about this configuration file,
>    it should stay.

The comment may not be related to the surrounding keys, but just a
commented-out config key that you want to keep around for reference.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
