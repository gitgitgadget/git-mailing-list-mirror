Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1362B1F855
	for <e@80x24.org>; Mon,  1 Aug 2016 15:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754113AbcHAPYc (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 11:24:32 -0400
Received: from avon.wwwdotorg.org ([70.85.31.133]:57238 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754090AbcHAPYR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 11:24:17 -0400
Received: from [10.20.204.51] (thunderhill.nvidia.com [216.228.112.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by avon.wwwdotorg.org (Postfix) with ESMTPSA id 1D22B1C043F;
	Mon,  1 Aug 2016 09:15:00 -0600 (MDT)
X-Virus-Status:	Clean
X-Virus-Scanned: clamav-milter 0.99 at avon.wwwdotorg.org
Subject: Re: [ANNOUNCE] git-series: track changes to a patch series over time
To:	Josh Triplett <josh@joshtriplett.org>
References: <20160729064055.GB25331@x>
Cc:	git@vger.kernel.org, linux-kernel@vger.kernel.org,
	Simon Glass <sjg@chromium.org>
From:	Stephen Warren <swarren@wwwdotorg.org>
Message-ID: <b7bd1464-1412-1feb-fe10-9ecb6018e122@wwwdotorg.org>
Date:	Mon, 1 Aug 2016 09:14:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160729064055.GB25331@x>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 07/29/2016 12:40 AM, Josh Triplett wrote:
> I'd like to announce a project I've been working on for a while:
>
> git-series provides a tool for managing patch series with git, tracking
> the "history of history". git series tracks changes to the patch series
> over time, including rebases and other non-fast-forwarding changes. git
> series also tracks a cover letter for the patch series, formats the
> series for email, and prepares pull requests.

Just as an FYI, I wouldn't be surprised if there's some overlap, or 
potential for merging of tools, between this tool and the "patman" tool 
that's part of the U-Boot source tree:

http://git.denx.de/?p=u-boot.git;a=blob;f=tools/patman/README;h=e36857dedea1d0dbafa41732aaf9bf0988d63f38;hb=HEAD

