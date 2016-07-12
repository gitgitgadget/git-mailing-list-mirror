Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAA091FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 13:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932667AbcGLNbH (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 09:31:07 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:40064 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932617AbcGLNbF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 09:31:05 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3rpjXQ0vPrz3hjQZ;
	Tue, 12 Jul 2016 15:31:02 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3rpjXQ0PWyzvkSH;
	Tue, 12 Jul 2016 15:31:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id sq_kcfU8cMUB; Tue, 12 Jul 2016 15:31:00 +0200 (CEST)
X-Auth-Info: rB/zd83vcLh9jNdQW+pRA02IMdjlfcVmn2FZUCAxOyjzwhx+dEwivk4tOdmSlCpA
Received: from hawking.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Tue, 12 Jul 2016 15:31:00 +0200 (CEST)
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
	<mvmtwfve22e.fsf@hawking.suse.de>
	<alpine.DEB.2.20.1607121249390.6426@virtualbox>
	<mvmh9bvdnae.fsf@hawking.suse.de>
	<alpine.DEB.2.20.1607121520310.6426@virtualbox>
X-Yow:	Hey, wait a minute!!  I want a divorce!!..  you're not Clint Eastwood!!
Date:	Tue, 12 Jul 2016 15:31:00 +0200
In-Reply-To: <alpine.DEB.2.20.1607121520310.6426@virtualbox> (Johannes
	Schindelin's message of "Tue, 12 Jul 2016 15:22:08 +0200 (CEST)")
Message-ID: <mvmd1mjdluz.fsf@hawking.suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Andreas,
>
> On Tue, 12 Jul 2016, Andreas Schwab wrote:
>
>> Johannes Schindelin <schindelin@wisc.edu> writes:
>> 
>> >> PRIuMAX isn't compatible with time_t.
>> >
>> > That statement is wrong.
>> 
>> No, it isn't.  PRIuMAX is for uintmax_t, and time_t is not uintmax_t
>> (even if they happen to have the same representation).
>
> Sigh.
>
> So if it is wrong, what is right?

The right thing is to add a cast, of course.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
