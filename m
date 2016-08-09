Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97E0B1F859
	for <e@80x24.org>; Tue,  9 Aug 2016 14:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829AbcHIOZb (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 10:25:31 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:63140 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752522AbcHIOZb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 10:25:31 -0400
Received: from [77.117.29.131] (smtpout1.drei.com [109.126.64.1])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3s7xQJ4fkCz5tlf;
	Tue,  9 Aug 2016 16:25:28 +0200 (CEST)
Subject: Re: [PATCH 2/2] commit-slab.h: avoid duplicated global static
 variables
To:	Git Mailing List <git@vger.kernel.org>
References: <57A9E5C1.3030205@kdbg.org> <57A9E614.6050601@kdbg.org>
From:	Johannes Sixt <j6t@kdbg.org>
Message-ID: <57A9E7D7.8030704@kdbg.org>
Date:	Tue, 9 Aug 2016 16:25:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <57A9E614.6050601@kdbg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

BTW, these are all instances of duplicated global static variables that 
can be found in a standard Linux build.

How I found them? I waded through the error messages produced by compiling 
the code base as C++ code for the fun of it (basically CFLAGS='-x c++ 
-fpermissive').

-- Hannes

