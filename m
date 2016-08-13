Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3CA01F6C1
	for <e@80x24.org>; Sun, 14 Aug 2016 11:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933367AbcHNLKg (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 07:10:36 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:59847 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933231AbcHNLKe (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Aug 2016 07:10:34 -0400
X-AuditID: 12074412-1c3ff70000000931-db-57af773c79a0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id EA.80.02353.C377FA75; Sat, 13 Aug 2016 15:38:37 -0400 (EDT)
Received: from [192.168.69.130] (p57907F6F.dip0.t-ipconnect.de [87.144.127.111])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u7DJcXIf016576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 13 Aug 2016 15:38:34 -0400
Subject: Re: [PATCH 1/8] xdl_change_compact(): rename some local variables for
 clarity
To:	Jeff King <peff@peff.net>
References: <cover.1470259583.git.mhagger@alum.mit.edu>
 <ea7d76b1a97f3ab8d83ed8ba7570c2bec1195501.1470259583.git.mhagger@alum.mit.edu>
 <20160804070604.ggxjqibryqtrwntn@sigill.intra.peff.net>
Cc:	git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
From:	Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <2a36b020-76a5-1ecd-de5c-1d2536847e07@alum.mit.edu>
Date:	Sat, 13 Aug 2016 21:38:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.1.0
MIME-Version: 1.0
In-Reply-To: <20160804070604.ggxjqibryqtrwntn@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42IRYndR1LUtXx9u8OGemEXXlW4mi4beK8wW
	uxf3M1usuDqH2eJHSw+zxebN7SwObB47Z91l91iwqdTjWe8eRo+Ll5Q9Pm+SC2CN4rJJSc3J
	LEst0rdL4MpYvvAlW8FEroqdF7cyNTA+Ye9i5OSQEDCReDzxHEsXIxeHkMBWRonnO46yQTgX
	mCTm3fzJCFIlLBAhsezxWiYQW0RAVuL74Y2MEEWHGCWu3t7DDOIwC1xnlNg1dwlYB5uArsSi
	nmawDl4Be4k1ncuAijg4WARUJc5crwcJiwqESGy72cAGUSIocXLmExYQm1PAReLY4Q1gY5gF
	1CX+zLvEDGHLS2x/O4d5AiP/LCQts5CUzUJStoCReRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqR
	rplebmaJXmpK6SZGSFAL7WBcf1LuEKMAB6MSD+8HznXhQqyJZcWVuYcYJTmYlER5dcyBQnxJ
	+SmVGYnFGfFFpTmpxUCvczArifCeLFkfLsSbklhZlVqUD5OS5mBREuf9uVjdT0ggPbEkNTs1
	tSC1CCYrw8GhJMG7txSoUbAoNT21Ii0zpwQhzcTBCTKcB2i4ThnI8OKCxNzizHSI/ClGRSlx
	XgmQZgGQREZpHlwvLOm8YhQHekWYNxGknQeYsOC6XwENZgIafMJsDcjgkkSElFQDY/HrOeWx
	+9/65iq/efGZ5adz4bTXPzoSl8bMyfrOFC8fde0ik73B1uhnTbcDeoQWq8falpRkOycw/Pyr
	+ftdOFfRikMLfmmuutXOPFHV+qS6392eY9eDhAUOvJRJSbt8rHvpz4WPTKVnBletUOasir50
	cM6bhBUXeuQfBOTIpLhu3NzjpqAeo8RSnJFoqMVcVJwIACOAPu8VAwAA
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 08/04/2016 09:06 AM, Jeff King wrote:
> On Thu, Aug 04, 2016 at 12:00:29AM +0200, Michael Haggerty wrote:
> 
>> * ix -> i
>> * ixo -> io
>> * ixs -> start
>> * grpsiz -> groupsize
> 
> After your change, I immediately understand three of them. But what is
> "io"?

The (pre-existing) convention in this function is that variable names
dealing with the "other" file have a trailing "o"; e.g., (xdf, xdfo),
(rchg, rchgo). There used to also be (i, io), the indexes tracking the
current line number in the file and the other file. But I renamed "i".

At first I was just going to add a comment for variable "io", but in
trying to figure out its exact semantics I realized that this code is
still pretty hard to follow. Part of the problem is that "the line in
the other file corresponding to a line in the to-be-compacted file" is
not a well-defined concept. In fact it is *groups of lines* that
correlate with each other. So I totally refactored the function, using a

    struct group {
            long start, end;
    };

as a kind of a cursor used to iterate through the groups on both sides.
I think the result is a lot easier to read, and while refactoring I
found and fixed another bug in the pre-existing code :-O

I hope to have v2 out soon.

Michael

