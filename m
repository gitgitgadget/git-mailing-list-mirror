Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6B9E1F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 17:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909AbcHORez (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 13:34:55 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:38965 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824AbcHORey (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 13:34:54 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3sCjL343v8z3hkN8;
	Mon, 15 Aug 2016 19:34:51 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3sCjL33WzFzvkRH;
	Mon, 15 Aug 2016 19:34:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id MLuegoTBEmEc; Mon, 15 Aug 2016 19:34:50 +0200 (CEST)
X-Auth-Info: mPTlqEgMNLpoDJCJkv74U4jlL4JwdiVRqxnoccKwGh60R1Nn6oprTaeAqORP+mvx
Received: from igel.home (ppp-88-217-19-168.dynamic.mnet-online.de [88.217.19.168])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Mon, 15 Aug 2016 19:34:50 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 46DD12C37FC; Mon, 15 Aug 2016 19:34:50 +0200 (CEST)
From:	Andreas Schwab <schwab@linux-m68k.org>
To:	Jeff King <peff@peff.net>
Cc:	Eli Barzilay <eli@barzilay.org>, git@vger.kernel.org
Subject: Re: Minor bug: git config ignores empty sections
References: <CALO-gutdz5VMgoRmbqEa9UiaTC+L2Sy2n-3AF+zfPr-X8+1U4A@mail.gmail.com>
	<20160815120916.6iobqirqbg76exms@sigill.intra.peff.net>
X-Yow:	Hey, I LIKE that POINT!!
Date:	Mon, 15 Aug 2016 19:34:50 +0200
In-Reply-To: <20160815120916.6iobqirqbg76exms@sigill.intra.peff.net> (Jeff
	King's message of "Mon, 15 Aug 2016 08:09:16 -0400")
Message-ID: <8737m63phh.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Aug 15 2016, Jeff King <peff@peff.net> wrote:

> And implicit in your test is the other bug, which is that deleting the
> last key in a section leaves the empty header. I think it's related to
> the same issue.

Indiscriminately removing empty section headers may break comments that
have been put there on purpose.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
