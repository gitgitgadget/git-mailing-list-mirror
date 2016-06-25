Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97E221FF40
	for <e@80x24.org>; Sat, 25 Jun 2016 07:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbcFYHP6 (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 03:15:58 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:10579 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751081AbcFYHP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 03:15:58 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3rc61R4Vwbz5tl9;
	Sat, 25 Jun 2016 09:15:55 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 9587B5291;
	Sat, 25 Jun 2016 09:15:54 +0200 (CEST)
Subject: Re: [PATCH] builtin/worktree.c: add option for setting worktree name
To:	Barret Rennie <barret@brennie.ca>
References: <20160625051548.95564-1-barret@brennie.ca>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Michael Rappazzo <rappazzo@gmail.com>
Newsgroups: gmane.comp.version-control.git
From:	Johannes Sixt <j6t@kdbg.org>
Message-ID: <576E2FA9.7070008@kdbg.org>
Date:	Sat, 25 Jun 2016 09:15:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <20160625051548.95564-1-barret@brennie.ca>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 25.06.2016 um 07:15 schrieb Barret Rennie:
> +--name::
> +	Set the name for the worktree. If there is already a worktree with this

What is "the name for the worktree"? Is it the directory where it lives 
in? Is it how it is listed with 'git worktree list'?

How is --name different from the <path> argument?

-- Hannes

