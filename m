Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22EB020179
	for <e@80x24.org>; Mon,  4 Jul 2016 13:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971AbcGDNR4 (ORCPT <rfc822;e@80x24.org>);
	Mon, 4 Jul 2016 09:17:56 -0400
Received: from smtp66.iad3a.emailsrvr.com ([173.203.187.66]:42913 "EHLO
	smtp66.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753686AbcGDNRy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jul 2016 09:17:54 -0400
Received: from smtp25.relay.iad3a.emailsrvr.com (localhost.localdomain [127.0.0.1])
	by smtp25.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id B00AF1803CD;
	Mon,  4 Jul 2016 09:17:43 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp25.relay.iad3a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 878F71803CB;
	Mon,  4 Jul 2016 09:17:43 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.5.4);
	Mon, 04 Jul 2016 09:17:43 -0400
Subject: Re: [PATCH v5 0/5] Better ref summary alignment in "git fetch"
To:	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
References: <20160626055810.26960-1-pclouds@gmail.com>
 <20160701160331.29252-1-pclouds@gmail.com>
Cc:	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
From:	Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <577A61F7.6010109@xiplink.com>
Date:	Mon, 4 Jul 2016 09:17:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <20160701160331.29252-1-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 2016-07-01 12:03 PM, Nguyễn Thái Ngọc Duy wrote:
> v5 changes the substitute symbol from '$' to '*' in compact mode and
> makes sure long lines in compact mode will not make the remote ref
> column too big (it's far from perfect but I think it's still good to
> do).

I think the first 4 patches are great.

I have no opinion on the 5th patch, as I don't expect to use the compact 
format in any of its proposed forms (and I can't come up with an 
alternative).

		M.

