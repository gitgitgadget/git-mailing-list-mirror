Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1DCB20705
	for <e@80x24.org>; Sat,  9 Jul 2016 06:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756594AbcGIG5u (ORCPT <rfc822;e@80x24.org>);
	Sat, 9 Jul 2016 02:57:50 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:15852 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756589AbcGIG5t (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2016 02:57:49 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3rmhy267Z8z5tlC;
	Sat,  9 Jul 2016 08:57:46 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 43C785137;
	Sat,  9 Jul 2016 08:57:46 +0200 (CEST)
Subject: Re: Git GUI Guesses Incorrect Language
To:	Sunjay Varma <varma.sunjay@gmail.com>
References: <CAJaQC31Su7NKd46cD81HE2OvC=O09aon12k8HFV29def4BAYfw@mail.gmail.com>
Cc:	git@vger.kernel.org
From:	Johannes Sixt <j6t@kdbg.org>
Message-ID: <5780A06A.8030901@kdbg.org>
Date:	Sat, 9 Jul 2016 08:57:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <CAJaQC31Su7NKd46cD81HE2OvC=O09aon12k8HFV29def4BAYfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 09.07.2016 um 06:57 schrieb Sunjay Varma:
> Just before the first line of my code, it says "C++ source, ASCII text".
> That file is a JavaScript/ES6 file. The ".jsx" file extension
> signifies that it may also contain Facebook's special JSX syntax
> (HTML-like syntax in JavaScript).

Git-gui just delegates to the 'file' command. What does

   file src/models/pathPlan.jsx src/services/ai.jsx

report? If that guesses wrongly in the same way, then the authors of the 
file command are the right address for your complaint.

-- Hannes

