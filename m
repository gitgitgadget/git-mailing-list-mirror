Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82C251F744
	for <e@80x24.org>; Sun, 10 Jul 2016 10:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbcGJK5R (ORCPT <rfc822;e@80x24.org>);
	Sun, 10 Jul 2016 06:57:17 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:42805 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbcGJK5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2016 06:57:16 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3rnQCs1Lpzz3hjTJ;
	Sun, 10 Jul 2016 12:57:13 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3rnQCs11vRzvkKK;
	Sun, 10 Jul 2016 12:57:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id 82vyxED-6u5p; Sun, 10 Jul 2016 12:57:12 +0200 (CEST)
X-Auth-Info: z+khHvAK6cy6/eRpZMKDi00XjQ2srRbW+u5OrNdR+OpMi7jOKOeGUqYpA7HbEJNF
Received: from igel.home (ppp-88-217-3-50.dynamic.mnet-online.de [88.217.3.50])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sun, 10 Jul 2016 12:57:12 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 0EF0C2C0A47; Sun, 10 Jul 2016 12:57:12 +0200 (CEST)
From:	Andreas Schwab <schwab@linux-m68k.org>
To:	Peter <peter.mx@gmail.com>
Cc:	Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: Fwd: git rm
References: <CAK8tuqiZjfrvHCoxkFUqoDx0+9=FUxfE93aMhUkYYZAAWm-u_w@mail.gmail.com>
	<CAK8tuqhMiHqPoK4gk7onT+VXsLJE5ogcpu7dc=_8am+ifL=5yQ@mail.gmail.com>
	<87a8hubtw4.fsf@linux-m68k.org>
	<20160707033538.GA7595@sigill.intra.peff.net>
	<CAK8tuqiCMUjoS_xXKSJ4qiGK8ioAjfGsQ3_WO0OQj5-5-i7rOw@mail.gmail.com>
X-Yow:	In order to make PLANS for the WEEKEND...so that we can read RESTAURANT
 REVIEWS and decide to GO to that restaurant & then NEVER GO...so we can
 meet a FRIEND after work in a BAR and COMPLAIN about Interior Sect'y
 JAMES WATT until the SUBJECT is changed to NUCLEAR BLACKMAIL...and so
 our RELATIVES can FORCE us to listen to HOCKEY STATISTICS while we
 wait for them to LEAVE on the 7:48....
Date:	Sun, 10 Jul 2016 12:57:12 +0200
In-Reply-To: <CAK8tuqiCMUjoS_xXKSJ4qiGK8ioAjfGsQ3_WO0OQj5-5-i7rOw@mail.gmail.com>
	(Peter's message of "Sun, 10 Jul 2016 10:38:32 +0200")
Message-ID: <87bn254v7b.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.95 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Peter <peter.mx@gmail.com> writes:

> So if I do:
>
> touch abc
> git add abc
>
>
> And after that I do:
>
> git rm abc
error: the following file has changes staged in the index:
    abc
(use --cached to keep the file, or -f to force removal)

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
