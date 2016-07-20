Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3158320195
	for <e@80x24.org>; Wed, 20 Jul 2016 02:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834AbcGTCel (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 22:34:41 -0400
Received: from mout.web.de ([217.72.192.78]:58304 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752517AbcGTCeh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 22:34:37 -0400
Received: from [10.140.232.72] ([74.58.240.9]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0Leca2-1azhqK0rj4-00qQ4M; Wed, 20 Jul 2016 04:34:22
 +0200
Subject: Re: Looking for help to understand external filter driver code
To:	Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
References: <67D9AC88-550E-4549-9AFD-2401B70B363B@gmail.com>
 <xmqqbn1th5qn.fsf@gitster.mtv.corp.google.com>
 <xmqqlh0xfoho.fsf@gitster.mtv.corp.google.com>
 <7B44C694-7CB2-411D-9CC6-7334CCBAD20B@gmail.com>
 <xmqqr3ape2ju.fsf@gitster.mtv.corp.google.com>
 <BDD74384-AA02-4B60-A246-504B4C6DDF02@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
From:	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <cdb8005a-2ed9-04da-fdbf-600accfac38f@web.de>
Date:	Wed, 20 Jul 2016 04:33:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.1.0
MIME-Version: 1.0
In-Reply-To: <BDD74384-AA02-4B60-A246-504B4C6DDF02@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:yLnlEUe1CZBQsL20D9K7o8XWiClkrfEh+V6gKMSKvUqSZowbeWo
 +9dYNRcRWvLeIf+SwQCYQQm9w5c1hQXsdmyN54z6Q8Y+tkZD9SzsTPxis2Fo2JaKakFCgSz
 Wg5GDBVzDehINW+/QBVFH3hg3jVUZ3lcDSC26pJBl1W8KgW4EY+yMyqlG2QuHv+ugYQBDhS
 knqIK61HqhEaSbYhnj9Ww==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:BvvPQrt7lFA=:Qv7aqSXJl13HQlCwvvDtzB
 KEaNT8Af7zO5DskGjljiPTnKIH3vZi3++exeTqny+xM0RXsNgvWcon0DpwCEVWAM9gTFUxVen
 jS8ovaRW5c5JReI2lv4IWgHb4SkNqJkBeGrD7XmdkbHRjlGSEeDk85Ii97Wi+JBl0jQJ3FzlJ
 j0pxqMEE3r3M0RTpI2YtoPJigBHJEWbpdTJNEr+6HgIK2hGVFfWs3vorHtTr+IB31YBnfPPnl
 5JjAHhV0nXHHZGZBZQHUqHF441+LcF0VPveTfrhU5Co5CDEVAfe+l8M9caOXw2ERjmAnefESS
 tLdoq3CaeDJJN76r+zWeBrKXnSQOOwGqt2XRBW/7szWvxnF5eum7An2ygTxSjzLexwuJhwXW/
 y6pg4QXMDEUFiCr3XOMGrYg02S5PG4XmoDuDBXXrZDBK0yJHSFW/YiDePJ3eQdXiNqkXCi7h4
 efrum5MY2rZt4Xat/sdq08gXG7qmCCVKlaIQ/CnvcXXPA1CbPRep+U2l7Q/QfMZ/etB1cGx3Y
 7WaFK8d3LLTCAYCddLGSd/KhTZY6GAlYxgprOR53E0G0YfYkQ0H/O8gcNcRVVDkQXrxltDGI1
 x2nlxbo1QAfD5qCREHg9KTGtO9GFQiWyjWs/fvSDztsY/np+/OVw2MgznJFHiZlz5w7dla4CV
 k/+NPrnFR3khjuW+g60obaDgrbtZ/aDE6vV0iEZfzu+/oF/3+94kEIuPDjYV+04tZQ9nV3In+
 WqDySUTULv8B8gXTkMVnb48PIMLXhz2aZSOWGSBZLzkQ+GjS69ZW4gJUqGwCgRCR5djEjYgaR
 rJ9hUvn
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 07/20/2016 12:01 AM, Lars Schneider wrote:
>
> On 19 Jul 2016, at 23:33, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Lars Schneider <larsxschneider@gmail.com> writes:
>>
>>> Git writes --> 4 byte filename length
>>> Git writes --> filename string
>>
>> Why limit to 32GB?  Perhaps NUL termination is more appropriate
>> here?
> OK, I will use NUL termination for the filename.
> You're also right about the limit - I will use 8 byte to encode the
> content length.
Is there any reason to encode the file length in binary format?
With all the discussions about big endianess, little endianess, 4GiB or 
32 GiB.
How about simply writing the length as ASCII ?

Unless we don't want to have a "spare" field for future extensions,
it could be good to add an option field, which may be empty.
On top of that, do we want a field separator different from the line
separator ?

How about this:
<options><TAB><length><TAB><filename><NUL>

<options> may be "var=value;var2=value2" or simply ""
