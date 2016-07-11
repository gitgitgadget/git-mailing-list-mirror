Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 790692018F
	for <e@80x24.org>; Mon, 11 Jul 2016 21:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbcGKVfL (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 17:35:11 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:40880 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbcGKVfK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 17:35:10 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3rpJKR2Cm2z3hjZF;
	Mon, 11 Jul 2016 23:35:07 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3rpJKQ6wQ4zvkKZ;
	Mon, 11 Jul 2016 23:35:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id 9mClDRtJTBSf; Mon, 11 Jul 2016 23:35:06 +0200 (CEST)
X-Auth-Info: G5XcZaHXKlHBTR/d2cpBD7NOSiCEAB8sVdfTB79irgS3xC5W69nJvxOKKptkO9Wx
Received: from igel.home (ppp-88-217-22-12.dynamic.mnet-online.de [88.217.22.12])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Mon, 11 Jul 2016 23:35:06 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id D66522C4A69; Mon, 11 Jul 2016 23:35:05 +0200 (CEST)
From:	Andreas Schwab <schwab@linux-m68k.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] Git v2.9.1
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com>
X-Yow:	HOORAY, Ronald!!  Now YOU can marry LINDA RONSTADT too!!
Date:	Mon, 11 Jul 2016 23:35:05 +0200
In-Reply-To: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 11 Jul 2016 13:13:48 -0700")
Message-ID: <87lh17kgdy.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.95 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>       local_tzoffset: detect errors from tm_to_time_t

not ok 19 - show date (iso:5758122296 -0400)
#      
#                      echo "$time -> $expect" >expect &&
#                      test-date show:$format "$time" >actual &&
#                      test_cmp expect actual
#              
not ok 20 - show date (iso-local:5758122296 -0400)
#      
#                      echo "$time -> $expect" >expect &&
#                      test-date show:$format "$time" >actual &&
#                      test_cmp expect actual

This is outside the range of 32bit time_t.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
