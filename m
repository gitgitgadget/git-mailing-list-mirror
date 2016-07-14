Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE2E220195
	for <e@80x24.org>; Thu, 14 Jul 2016 08:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbcGNICC (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 04:02:02 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:54221 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217AbcGNIBw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 04:01:52 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3rqp7Z6Krsz3hjY3;
	Thu, 14 Jul 2016 10:01:46 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3rqp7Z5qxkzw63w;
	Thu, 14 Jul 2016 10:01:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id WlPgxRGN9Y24; Thu, 14 Jul 2016 10:01:45 +0200 (CEST)
X-Auth-Info: FFQit2ifKJebJ9/T2bUIipxTT5xORbkeaijJYvfy7UCyNlgQgj9RELiDZK/xzv+x
Received: from hawking.suse.de (nat.nue.novell.com [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Thu, 14 Jul 2016 10:01:44 +0200 (CEST)
From:	Andreas Schwab <schwab@linux-m68k.org>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.9.1
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com>
	<87lh17kgdy.fsf@linux-m68k.org>
	<20160711235417.GA26163@sigill.intra.peff.net>
	<xmqqy4577h0o.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607120927410.6426@virtualbox>
	<20160712073912.GA26431@sigill.intra.peff.net>
	<alpine.DEB.2.20.1607121257450.6426@virtualbox>
	<xmqqbn2267zq.fsf@gitster.mtv.corp.google.com>
	<20160713020132.GA13918@sigill.intra.peff.net>
	<xmqqh9bt34n1.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607132048370.6426@virtualbox>
	<xmqq8tx51hmx.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607140913470.6426@virtualbox>
X-Yow:	I'm having BEAUTIFUL THOUGHTS about the INSIPID WIVES
 of smug and wealthy CORPORATE LAWYERS..
Date:	Thu, 14 Jul 2016 10:01:42 +0200
In-Reply-To: <alpine.DEB.2.20.1607140913470.6426@virtualbox> (Johannes
	Schindelin's message of "Thu, 14 Jul 2016 09:45:12 +0200 (CEST)")
Message-ID: <mvmr3awbqc9.fsf@hawking.suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So I got curious and looked at the man page. It says indeed that strtoul()
> returns ULONG_MAX, which happens to translate into a date in the year
> 2038.

4294967295 would rather be 2106.

$ date -d @$((0xffffffff))
So 7. Feb 07:28:15 CET 2106

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
