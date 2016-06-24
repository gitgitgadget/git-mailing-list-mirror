Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98D302018A
	for <e@80x24.org>; Fri, 24 Jun 2016 17:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808AbcFXRFT (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 13:05:19 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:23395 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751784AbcFXRFS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 13:05:18 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3rbl7w2xjVz5tl9;
	Fri, 24 Jun 2016 19:05:15 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id B89875291;
	Fri, 24 Jun 2016 19:05:14 +0200 (CEST)
Subject: Re: [PATCH v3 1/4] t5000: test tar files that overflow ustar headers
To:	Jeff King <peff@peff.net>
References: <20160623231512.GA27683@sigill.intra.peff.net>
 <20160623232041.GA3668@sigill.intra.peff.net> <576D621F.1030000@kdbg.org>
 <20160624164603.GA13789@sigill.intra.peff.net>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
	"Robin H. Johnson" <robbat2@gentoo.org>
From:	Johannes Sixt <j6t@kdbg.org>
Message-ID: <576D684A.6030406@kdbg.org>
Date:	Fri, 24 Jun 2016 19:05:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <20160624164603.GA13789@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 24.06.2016 um 18:46 schrieb Jeff King:
> On Fri, Jun 24, 2016 at 06:38:55PM +0200, Johannes Sixt wrote:
>> It's going to be 269 with ksh, and who-knows-what on Windows (due to lack of
>> SIGPIPE - I haven't tested this, yet).
>
> Thanks, I meant to ask about that. We do a workaround in t0005, but we
> _don't_ do it in the new sigpipe handling for test_must_fail. Is the
> latter just broken, too?

That's well possible. It is not prepared to see ksh's exit codes for 
signals.

-- Hannes

