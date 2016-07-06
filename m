Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 399992070C
	for <e@80x24.org>; Wed,  6 Jul 2016 16:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145AbcGFQm3 (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 12:42:29 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:42615 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753917AbcGFQm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 12:42:28 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3rl63w4vW9z3hn31;
	Wed,  6 Jul 2016 18:42:20 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3rl63w4gKTzvPt9;
	Wed,  6 Jul 2016 18:42:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id ZuWYjl4ylt9m; Wed,  6 Jul 2016 18:42:19 +0200 (CEST)
X-Auth-Info: ZurjgO6227wLDFMvsk9TwScQn48BR6sFNP6rg16sHlPKPit4jHCcnm61N2zo/+0M
Received: from igel.home (ppp-88-217-15-34.dynamic.mnet-online.de [88.217.15.34])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Wed,  6 Jul 2016 18:42:19 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 8E5752C3DDA; Wed,  6 Jul 2016 18:42:19 +0200 (CEST)
From:	Andreas Schwab <schwab@linux-m68k.org>
To:	Peter <peter.mx@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: Fwd: git rm
References: <CAK8tuqiZjfrvHCoxkFUqoDx0+9=FUxfE93aMhUkYYZAAWm-u_w@mail.gmail.com>
	<CAK8tuqhMiHqPoK4gk7onT+VXsLJE5ogcpu7dc=_8am+ifL=5yQ@mail.gmail.com>
X-Yow:	TATTOOED MIDGETS are using ALFREDO in their SALAMI FACTORY!
Date:	Wed, 06 Jul 2016 18:42:19 +0200
In-Reply-To: <CAK8tuqhMiHqPoK4gk7onT+VXsLJE5ogcpu7dc=_8am+ifL=5yQ@mail.gmail.com>
	(Peter's message of "Tue, 5 Jul 2016 23:55:24 +0200")
Message-ID: <87a8hubtw4.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.95 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Peter <peter.mx@gmail.com> writes:

> I am a lightweigt git user so by all means not a reference, but I was
> wondering why exactly does "git rm" also delete the file (remove it
> from the working tree). I see it as an unintended behaviour as git is
> written in a way that it preserves the most data.

The data is still preserved.  You can restore it with "git checkout HEAD
<file>".

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
