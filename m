Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0A9F1F859
	for <e@80x24.org>; Fri, 12 Aug 2016 23:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbcHLXZM (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 19:25:12 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:59192 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751953AbcHLXZL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Aug 2016 19:25:11 -0400
X-AuditID: 12074413-aa3ff70000000955-5b-57ae5ad4bf45
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 34.3F.02389.4DA5EA75; Fri, 12 Aug 2016 19:25:10 -0400 (EDT)
Received: from [192.168.69.130] (p5B10575C.dip0.t-ipconnect.de [91.16.87.92])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u7CNP6mN030527
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 12 Aug 2016 19:25:07 -0400
Subject: Re: [PATCH 8/8] diff: improve positioning of add/delete blocks in
 diffs
To:	Jeff King <peff@peff.net>
References: <cover.1470259583.git.mhagger@alum.mit.edu>
 <7b0680ed7a10fc13acd8d7816a75ed05a5f9e28c.1470259583.git.mhagger@alum.mit.edu>
 <20160804075631.jakbi5dbsbxsqcpr@sigill.intra.peff.net>
Cc:	git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
From:	Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <e4232cba-aae8-8426-c730-7914bb750363@alum.mit.edu>
Date:	Sat, 13 Aug 2016 01:25:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.1.0
MIME-Version: 1.0
In-Reply-To: <20160804075631.jakbi5dbsbxsqcpr@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42IRYndR1L0WtS7c4PAfJouuK91MFg29V5gt
	di/uZ7ZYcXUOs8WPlh5mi82b21kc2Dx2zrrL7rFgU6nHs949jB4XLyl7fN4kF8AaxWWTkpqT
	WZZapG+XwJUxvX03S8E9iYo7f4+zNDB+Fe5i5OSQEDCRuHv3IVsXIxeHkMBWRonpt74xQThn
	mSQWdjWwgFQJCwRJ7N60nxHEFhGQlfh+eCMjRNEhRonZp3+BdTALXGeU2DV3CVgVm4CuxKKe
	ZiYQm1fAXmLBnB1gcRYBVYljs46CxUUFQiS23Wxgg6gRlDg58wnYNk4BF4l394+A2cwC6hJ/
	5l1ihrDlJba/ncM8gZF/FpKWWUjKZiEpW8DIvIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11wv
	N7NELzWldBMjJKyFdzDuOil3iFGAg1GJh9eDZ124EGtiWXFl7iFGSQ4mJVFeHXOgEF9Sfkpl
	RmJxRnxRaU5qMdDvHMxKIrzd4UA53pTEyqrUonyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKY
	rAwHh5IEb04kUKNgUWp6akVaZk4JQpqJgxNkOA/Q8NkgNbzFBYm5xZnpEPlTjIpS4rwBIAkB
	kERGaR5cLyztvGIUB3pFmPc6SBUPMGXBdb8CGswENPiE2RqQwSWJCCmpBkaLvf80fF/fmt6s
	kWt4/6lFhtXcalXNwgpJ4ccT781n+XLIwiF9twBP+8Skdu2m/17zD9w7dFbVtJFRYO7rYOd/
	jcePtDv6cqzgXHXIWyvSk73Rpc3rRfHbd/oVEkEdKx1n5Xq41YY7Ly/Xc8w9aReZ9nCxZN2G
	uK88wt/jdkUYfdp8UTfvphJLcUaioRZzUXEiAJXYcugWAwAA
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 08/04/2016 09:56 AM, Jeff King wrote:
> On Thu, Aug 04, 2016 at 12:00:36AM +0200, Michael Haggerty wrote:
> 
>> This table shows the number of diff slider groups that were positioned
>> differently than the human-generated values, for various repositories.
>> "default" is the default "git diff" algorithm. "compaction" is Git 2.9.0
>> with the `--compaction-heuristic` option "indent" is an earlier,
> 
> s/option/&./

Thanks, will change.

>>  static int diff_detect_rename_default;
>> +static int diff_indent_heuristic; /* experimental */
>>  static int diff_compaction_heuristic; /* experimental */
> 
> These two flags are mutually exclusive in the xdiff code, so we should
> probably handle that here.
> 
> TBH, I do not care that much what:
> 
>   [diff]
>   compactionHeuristic = true
>   indentHeuristic = true
> 
> does. But right now:
> 
>   git config diff.compactionHeuristic true
>   git show --indent-heuristic
> 
> still prefers the compaction heuristic, which I think is objectively
> wrong.

I wasn't worrying about that yet, given that these two features are both
still experimental. I also have a strong inkling that at most one of
them needs to be made permanent. I propose that I repair the semantics
in the simplest way possible for now while we decide on the long-term
plan, which might conceivably be:

* keep both options permanently
* keep only one option permanently
* choose one heuristic and use it always (i.e., make it part of the new
standard one-and-only diff algorithm)
* discard both heuristics (I hope not!)

After we've decided on that, *then* let's decide on a suitable UI and
implement it before we declare either feature non-experimental.

> [...]
> Speaking of absurd amounts of work, I was curious if there was a
> noticeable performance penalty for using this heuristic [...]

I included some performance numbers in my response to Junio [1].

>> +#define START_OF_FILE_BONUS 9
>> +#define END_OF_FILE_BONUS 46
>> +#define TOTAL_BLANK_WEIGHT 4
>> +#define PRE_BLANK_WEIGHT 16
>> +#define RELATIVE_INDENT_BONUS -1
>> +#define RELATIVE_INDENT_HAS_BLANK_BONUS 15
>> +#define RELATIVE_OUTDENT_BONUS -19
>> +#define RELATIVE_OUTDENT_HAS_BLANK_BONUS 2
>> +#define RELATIVE_DEDENT_BONUS -63
>> +#define RELATIVE_DEDENT_HAS_BLANK_BONUS 50
> 
> I see there is a comment below here mentioning that these are empirical
> voodoo, but it might be worth one at the top (or just moving these below
> the comment) because the comment looks like it's just associated with
> the function (and these are sufficiently bizarre that anybody reading is
> going to double-take on them).

Good idea.

>> +        return 10 * score - bonus;
> 
> I don't mind this not "10" not being a #define constant, but after
> reading the exchange between you and Stefan, I think it would be nice to
> describe what it is in a comment. The rest of the function is commented
> so nicely that this one left me thinking "huh?" upon seeing the "10".

Done. Thanks for your review.

Michael

[1]
http://public-inbox.org/git/5fe0edbc-3659-058f-3328-639d1343fa05@alum.mit.edu/

