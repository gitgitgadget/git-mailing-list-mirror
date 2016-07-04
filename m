Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA1F320179
	for <e@80x24.org>; Mon,  4 Jul 2016 22:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753803AbcGDWKL (ORCPT <rfc822;e@80x24.org>);
	Mon, 4 Jul 2016 18:10:11 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:59292 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbcGDWKK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2016 18:10:10 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3rk1R40kxgz3hjGp;
	Tue,  5 Jul 2016 00:10:07 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3rk1R36hJRzvdWw;
	Tue,  5 Jul 2016 00:10:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id 3dX1EU9FVHDW; Tue,  5 Jul 2016 00:10:06 +0200 (CEST)
X-Auth-Info: WIffJ8vKj0EPmIv6kd5u8icTf2XL0cqsbvTw14GGST+XsqF4FdF+rEoSYkj12QGk
Received: from igel.home (ppp-88-217-2-79.dynamic.mnet-online.de [88.217.2.79])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Tue,  5 Jul 2016 00:10:06 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 3AFEE2C3448; Tue,  5 Jul 2016 00:10:06 +0200 (CEST)
From:	Andreas Schwab <schwab@linux-m68k.org>
To:	shawn wilson <ag4ve.us@gmail.com>
Cc:	Konstantin Khomoutov <kostix+git@007spb.ru>,
	Git List <git@vger.kernel.org>
Subject: Re: split directories into branches
References: <CAH_OBieCcx0_=vuZgoJ8GrZhhReEAhnjrz2pQwbwGgPFww4JmQ@mail.gmail.com>
	<20160704203946.3ac8d3205c08bfaee9a93a46@domain007.com>
	<CAH_OBie4dUB8WXfmKhLaezVKi0=LhnFw=wKJO1c3oUMA7VkYdw@mail.gmail.com>
	<20160704212926.919a267706a6fa5791c47726@domain007.com>
	<CAH_OBieUYZTi+8W-m1TVVDstzF2vg1VuYQsd9Ka_uDoRYRY5rg@mail.gmail.com>
X-Yow:	Darling, my ELBOW is FLYING over FRANKFURT, Germany..
Date:	Tue, 05 Jul 2016 00:10:06 +0200
In-Reply-To: <CAH_OBieUYZTi+8W-m1TVVDstzF2vg1VuYQsd9Ka_uDoRYRY5rg@mail.gmail.com>
	(shawn wilson's message of "Mon, 4 Jul 2016 17:03:46 -0400")
Message-ID: <87eg79qcld.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.95 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

shawn wilson <ag4ve.us@gmail.com> writes:

> $ git filter-branch --tree-filter "shopt -s extglob && mkdir -p
> cookbooks/base_sys && mv !(cookbooks) cookbooks/base_sys"

extglob changes the parser, you need to set that on a separate line.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
