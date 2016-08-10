Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A49C51FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 22:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731AbcHJWrB (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 18:47:01 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:64479 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752342AbcHJWrA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Aug 2016 18:47:00 -0400
X-AuditID: 1207440c-217ff700000008d5-c9-57abaed5b260
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id A2.56.02261.5DEABA75; Wed, 10 Aug 2016 18:46:46 -0400 (EDT)
Received: from [192.168.69.130] (p5B104255.dip0.t-ipconnect.de [91.16.66.85])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u7AMkg8s023855
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 10 Aug 2016 18:46:43 -0400
Subject: Re: Forward declaration of enum iterator_selection?
To:	Johannes Sixt <j6t@kdbg.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <933f540f-7752-cfce-5785-b67728fea987@kdbg.org>
 <0604cf0a-2b94-93b3-3a01-213ea5b9849b@ramsayjones.plus.com>
 <57A8B3BD.1000002@kdbg.org>
Cc:	Git Mailing List <git@vger.kernel.org>
From:	Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <a4f431a9-a758-a777-56c1-62bbe28f2072@alum.mit.edu>
Date:	Thu, 11 Aug 2016 00:46:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.1.0
MIME-Version: 1.0
In-Reply-To: <57A8B3BD.1000002@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsUixO6iqHtt3epwg4utzBZdV7qZLJ7Mvcts
	MfOqtQOzx8NXXewe+5duY/P4vEkugDmKyyYlNSezLLVI3y6BK2PKVP6CW3wVhxeuYWlg/Mjd
	xcjJISFgIjHjz0wWEFtIYCujxPoTWV2MXED2WSaJ6YteMXUxcnAIC9hIfPxuDFIjIuAjMXXp
	U2aImumMEvPezWMDSTALaEls/vmNHcRmE9CVWNTTzARi8wrYSzzZMJcRxGYRUJVYOfUOWI2o
	QIjEtpsNbBA1ghInZz4BO4JTQEPiTuN0doiZ6hJ/5l1ihrDlJba/ncM8gZF/FpKWWUjKZiEp
	W8DIvIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11AvN7NELzWldBMjJDx5djB+WydziFGAg1GJ
	h/dD2upwIdbEsuLK3EOMkhxMSqK8wjFAIb6k/JTKjMTijPii0pzU4kOMEhzMSiK839YC5XhT
	EiurUovyYVLSHCxK4ryqS9T9hATSE0tSs1NTC1KLYLIyHBxKErwCwDgUEixKTU+tSMvMKUFI
	M3FwggznARrODFLDW1yQmFucmQ6RP8WoKCXO+3gNUEIAJJFRmgfXC0sfrxjFgV4R5p0CchsP
	MPXAdb8CGswENDhJdQXI4JJEhJRUA6Oj0C2H7pW9AZv3eXhfE957YEIG33zn07PClayeXTp5
	p19oR7JRSVXMHBm/X2J7u0+k/d9tdKH4p0LL0yOtxy3fu50MjWUs/yt83vyL89+rkcxtx7d0
	bos/uPj/dYkJzxQOLfgZdfPoe13e/4sPMW4VCWI2EeL6KlLHNkFi+Yq7xqt+LutazamhxFKc
	kWioxVxUnAgAYVgznvoCAAA=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 08/08/2016 06:30 PM, Johannes Sixt wrote:
> Am 07.08.2016 um 22:34 schrieb Ramsay Jones:
>> [...] I would rather the 'enum iterator_selection' be defined
>> before this declaration. One solution could be to #include "iterator.h"
>> prior to _all_ #include "refs/refs-internal.h" in all compilation units
>> (Note it is in the opposite order in refs/iterator.c). Alternatively, you
>> could put the #include "../iterator.h" into refs/refs-internal.h directly
>> (some people would object to this).
> 
> I concur. Which one is the correct way to do, I do not know, either.
> It's a matter how the interface is intended to be used. Perhaps the
> typedef must be moved to iterator.h?

Thanks for noticing this problem.

The enum is meant to be available for the use of any iterator-type
module, of which there are currently only ref-iterator and dir-iterator,
and the latter doesn't happen to use this enum. I'd rather not move it
to ref-internal.h because I think keeping it in a more public place will
encourage people implementing other types of iterators to reuse it.

My understanding of the project policy is that it is OK for one header
file to include another header file iff the second header file is
necessary for the correct compilation of the first (but not only because
users of the first will usually want the second as well). So my
suggestion is to add an `#include "iterator.h"` to refs-internal.h.

I also just realized that most "*.[ch]" files that live in
subdirectories use

    #include "foo.h"

to include header files from the main directory, but some (including
refs/files-backend.c) use

    #include "../foo.h"

I suspect that this inconsistency might cause problems for make and the
automatic dependency generation that it relies on, so the latter should
probably be changed to use the shorter pattern.

Michael

