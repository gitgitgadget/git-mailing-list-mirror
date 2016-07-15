Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4350B20195
	for <e@80x24.org>; Fri, 15 Jul 2016 18:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbcGOScS (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 14:32:18 -0400
Received: from mailrelay4.public.one.com ([195.47.247.71]:58989 "EHLO
	mailrelay4.public.one.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbcGOScQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 14:32:16 -0400
X-Greylist: delayed 964 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Jul 2016 14:32:16 EDT
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple;
	d=winkler.dk; s=20140924;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wAkehiBphLBOicDhfT0u/7xijq12IPSd+CNbJqGT0so=;
	b=isxTDePCqvkrYqYMJtVx9vuHr45gq9AqvZ1hwS5urLSw/PxHVj0xR7Z+2HoPHKv+jXgfD8diPIc/2
	 TFCcqBVu36x83L90d0aDOlEYGxYn17A2xG7sbd5nSoeQ5Mv6T/F95FZDsHoVJv3Kb8V8PJ95X0lckW
	 0lIenpqaxdU7etgk=
X-HalOne-Cookie: 6861014b1720d5d5106f375bd597bd958b46b07a
X-HalOne-ID: 3401efe9-4ab8-11e6-bffc-b8ca3afa9d73
Received: from t430.localnet (unknown [5.186.121.171])
	by smtpfilter1.public.one.com (Halon Mail Gateway) with ESMTPSA;
	Fri, 15 Jul 2016 18:16:08 +0000 (UTC)
From:	"Morten W. J." <morten@winkler.dk>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org
Subject: [SOLVED] Re: Two consecutive clones of a remote produces different files
Date:	Fri, 15 Jul 2016 20:16:00 +0200
Message-ID: <3779136.PWlxYSPs5e@t430>
User-Agent: KMail/5.0.2 (Linux/4.2.0-38-generic; KDE/5.15.0; x86_64; ; )
In-Reply-To: <20160715094200.GA17917@sigill.intra.peff.net>
References: <2183637.OVprKRVBmt@t430> <20160715094200.GA17917@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Jeff.

Hmmm. You are the master of blind guessing - spot on.
Also, that is kind of embaressing to me. However, should your way cross mine, 
you hereby have a voucer for a drink after your choice as long as it is beer.

Thanks,
   Morten.

> Just a blind guess, but might you have two files with names that differ
> only in case, and on Windows one is overwriting the other because you
> have a case-insensitive filesystem?
> 
> Try:
> 
>   git ls-files -s | grep -i src/LogEventSubscriber.h
> 
> to see what is in the index (which is case-sensitive, and is the source
> from which git checks the files out into the working tree).
> 
> -Peff

