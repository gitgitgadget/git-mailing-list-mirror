Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B62E31FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 18:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbcGLSPP (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 14:15:15 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:51791 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbcGLSPN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 14:15:13 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3rpqrG5M0qz3hjSL;
	Tue, 12 Jul 2016 20:15:10 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3rpqrG4qRwzvkjt;
	Tue, 12 Jul 2016 20:15:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id r3xyeIfIy36S; Tue, 12 Jul 2016 20:15:09 +0200 (CEST)
X-Auth-Info: B+B1k4hgIb/zmFjxN6uHwxo1CbX9JK2Dh0xtCZ7+3w7RTyGUnKefZiGygo2c/Y7Z
Received: from igel.home (ppp-88-217-10-60.dynamic.mnet-online.de [88.217.10.60])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Tue, 12 Jul 2016 20:15:09 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 06F5C2C2DCA; Tue, 12 Jul 2016 20:15:09 +0200 (CEST)
From:	Andreas Schwab <schwab@linux-m68k.org>
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.9.1
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com>
	<87lh17kgdy.fsf@linux-m68k.org>
	<20160711235417.GA26163@sigill.intra.peff.net>
	<xmqqy4577h0o.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607120927410.6426@virtualbox>
	<xmqqpoqj6i3d.fsf@gitster.mtv.corp.google.com>
	<20160712151630.GE613@sigill.intra.peff.net>
	<CAPc5daWcb5bfgsxMP0vCrQ7gBdeYBgefzPNHztaaCKzqbCv2aQ@mail.gmail.com>
	<20160712153520.GG613@sigill.intra.peff.net>
	<xmqqlh167tjd.fsf@gitster.mtv.corp.google.com>
	<20160712160921.GA2965@sigill.intra.peff.net>
X-Yow:	What's the MATTER Sid?..  Is your BEVERAGE unsatisfactory?
Date:	Tue, 12 Jul 2016 20:15:09 +0200
In-Reply-To: <20160712160921.GA2965@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 12 Jul 2016 12:09:21 -0400")
Message-ID: <87a8hmpvte.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.95 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> In case it wasn't clear, I was mostly guessing there. So I dug a bit
> further, and indeed, I am wrong. Linux never bumped to a 64-bit time_t
> on i386 because of the ABI headaches.

This is being worked on.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
