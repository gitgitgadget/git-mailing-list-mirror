Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D477F1F859
	for <e@80x24.org>; Sat, 13 Aug 2016 00:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596AbcHMALg (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 20:11:36 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:52300 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752248AbcHMALf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Aug 2016 20:11:35 -0400
X-AuditID: 1207440e-dc3ff70000000931-18-57ae65ae68ea
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 8A.1A.02353.EA56EA75; Fri, 12 Aug 2016 20:11:28 -0400 (EDT)
Received: from [192.168.69.130] (p5B10575C.dip0.t-ipconnect.de [91.16.87.92])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u7D0BOZa032562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 12 Aug 2016 20:11:25 -0400
Subject: Re: [PATCH 8/8] diff: improve positioning of add/delete blocks in
 diffs
To:	Junio C Hamano <gitster@pobox.com>
References: <cover.1470259583.git.mhagger@alum.mit.edu>
 <7b0680ed7a10fc13acd8d7816a75ed05a5f9e28c.1470259583.git.mhagger@alum.mit.edu>
 <xmqq37mk2txa.fsf@gitster.mtv.corp.google.com>
Cc:	git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
From:	Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <f8c18c0b-b0e2-b67c-2a77-b3af3083161a@alum.mit.edu>
Date:	Sat, 13 Aug 2016 02:11:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.1.0
MIME-Version: 1.0
In-Reply-To: <xmqq37mk2txa.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42IRYndR1N2Qui7coHeZiEXXlW4mi4beK8wW
	uxf3M1usuDqH2eJHSw+zxebN7SwObB47Z91l91iwqdTjWe8eRo+Ll5Q9Pm+SC2CN4rJJSc3J
	LEst0rdL4MpY/+gqa8Fxnor27glsDYzfOLsYOTkkBEwkuk6cYuti5OIQEtjKKDGh+xMjhHOW
	SeLFg1WMIFXCAkESuzftB7NFBNQkJrYdYgGxhQR2MkocbHMCsZkFzjFKfJ+iDWKzCehKLOpp
	ZgKxeQXsJaZ2LgarZxFQlVgx/wI7iC0qECKx7WYDG0SNoMTJmU/AajgFrCU6Pn5lhJipJ7Hj
	+i9WCFteYvvbOcwTGPlnIWmZhaRsFpKyBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0jfVy
	M0v0UlNKNzFCQppvB2P7eplDjAIcjEo8vB8414ULsSaWFVfmHmKU5GBSEuXVMQcK8SXlp1Rm
	JBZnxBeV5qQWH2KU4GBWEuFlSwTK8aYkVlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbB
	ZGU4OJQkeMNSgBoFi1LTUyvSMnNKENJMHJwgw3mAhq8CqeEtLkjMLc5Mh8ifYlSUEud1BkkI
	gCQySvPgemEp5xWjONArwrzTQKp4gOkKrvsV0GAmoMEnzNaADC5JREhJNTAmmNpK66y4si7z
	rfzd6UtuZqb9mNf6Xrsz4b+y3ASfONHGeXMOfXJNny+gaPsmd5U1l9Q0tv2hcn2KH4s1D8le
	O8DKpTlLjPHdvCczFI4U6e4W1k23bV90U5bndMaRCZ8dvp86PTMt81Jz5MPoav99wXueb2ec
	UzE9SiBUjHWCnLf6hg8BPY+UWIozEg21mIuKEwG/4zlxFAMAAA==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 08/04/2016 09:52 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> +#define START_OF_FILE_BONUS 9
>> +#define END_OF_FILE_BONUS 46
>> +#define TOTAL_BLANK_WEIGHT 4
>> +#define PRE_BLANK_WEIGHT 16
>> +#define RELATIVE_INDENT_BONUS -1
>> +#define RELATIVE_INDENT_HAS_BLANK_BONUS 15
>> +#define RELATIVE_OUTDENT_BONUS -19
>> +#define RELATIVE_OUTDENT_HAS_BLANK_BONUS 2
> 
> When I read up to here, I thought "Heh, isn't the opposite of INdent
> DEdent?" and then saw this:
> 
>> +#define RELATIVE_DEDENT_BONUS -63
>> +#define RELATIVE_DEDENT_HAS_BLANK_BONUS 50
> 
> It turns out that you mean by OUTdent a line that indents further
> (if I am reading the code correctly).  Is that obvious to everybody?

I'll comment it better.

>> +	/* Bonuses based on the location of blank lines: */
>> +        bonus += TOTAL_BLANK_WEIGHT * total_blanks;
>> +	bonus += PRE_BLANK_WEIGHT * m->pre_blank;
> 
> This and ...
> 
>> +        } else if (indent > m->pre_indent) {
>> +		/*
>> +		 * The line is indented more than its predecessor. Score it based
>> +		 * on the larger indent:
>> +		 */
>> +		score = indent;
>> +		bonus += RELATIVE_INDENT_BONUS;
>> +		bonus += RELATIVE_INDENT_HAS_BLANK_BONUS * any_blanks;
>> +	} else if (indent < m->pre_indent) {
> 
> ... this seems to be indented correctly even after getting quoted,
> which in turn means most of the lines in the added code share
> indent-with-non-tab badness.

The code was copy-pasted from a Python prototype then converted to C :-)

I'll fix the whitespace.

Thanks,
Michael

