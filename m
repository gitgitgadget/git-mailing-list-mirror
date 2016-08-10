Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D91271FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 19:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934758AbcHJTWx (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 15:22:53 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:61743 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S940192AbcHJTBL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Aug 2016 15:01:11 -0400
X-AuditID: 12074414-ca3ff70000000931-79-57ab79f5d120
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id A5.43.02353.5F97BA75; Wed, 10 Aug 2016 15:01:09 -0400 (EDT)
Received: from [192.168.69.130] (p5B104255.dip0.t-ipconnect.de [91.16.66.85])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u7AJ166Y011909
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 10 Aug 2016 15:01:07 -0400
Subject: Re: [PATCH 8/8] diff: improve positioning of add/delete blocks in
 diffs
To:	Junio C Hamano <gitster@pobox.com>
References: <cover.1470259583.git.mhagger@alum.mit.edu>
 <7b0680ed7a10fc13acd8d7816a75ed05a5f9e28c.1470259583.git.mhagger@alum.mit.edu>
 <CA+P7+xo6q0pveVQdt1mynfsWq75DzBXsbPcgVYdd5s8rpO+97A@mail.gmail.com>
 <f7f35993-39a8-b788-d2a7-d030ac442b9b@alum.mit.edu>
 <xmqqd1lo2uj1.fsf@gitster.mtv.corp.google.com>
Cc:	Jacob Keller <jacob.keller@gmail.com>,
	Git mailing list <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
From:	Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <5fe0edbc-3659-058f-3328-639d1343fa05@alum.mit.edu>
Date:	Wed, 10 Aug 2016 21:01:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.1.0
MIME-Version: 1.0
In-Reply-To: <xmqqd1lo2uj1.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42IRYndR1P1auTrc4P0fa4uuK91MFg29V5gt
	di/uZ7ZYcXUOs8WPlh5mi82b21kc2Dx2zrrL7rFgU6nHs949jB4XLyl7fN4kF8AaxWWTkpqT
	WZZapG+XwJXxc0J8wTedio6Td9kaGHcrdzFyckgImEhsnP+JFcQWEtjKKHHjr04XIxeQfZZJ
	ovnRHkaQhLBAkMTuTfvBbBEBNYmJbYdYIIq2MUmcetXCCuIwC9xnlPgxt4MJpIpNQFdiUU8z
	mM0rYC+xvO0tM4jNIqAqMfVPHwuILSoQIrHtZgMbRI2gxMmZT8DinALWEj9uLwKzmQX0JHZc
	/8UKYctLbH87h3kCI/8sJC2zkJTNQlK2gJF5FaNcYk5prm5uYmZOcWqybnFyYl5eapGuhV5u
	ZoleakrpJkZISIvsYDxyUu4QowAHoxIPr0fm6nAh1sSy4srcQ4ySHExKorzCMUAhvqT8lMqM
	xOKM+KLSnNTiQ4wSHMxKIrwPS4ByvCmJlVWpRfkwKWkOFiVx3m+L1f2EBNITS1KzU1MLUotg
	sjIcHEoSvGLA2BUSLEpNT61Iy8wpQUgzcXCCDOcBGp4MUsNbXJCYW5yZDpE/xagoJc57oQIo
	IQCSyCjNg+uFpZxXjOJArwjzloC08wDTFVz3K6DBTECDk1RXgAwuSURISTUwOvb/Eoyemi/M
	eerKip3TQ35p7I3ZxGazK6dG3oFHu+De46/qG5jOtse8VXC5cWn/pmIX5ascbTyudVeiZ/p/
	2Vfi8iRherrjusjZrXP+eVgmqCyR31Nofs9pz/yF4v//e27J3Vvue/Lq/V5xBcFP5dbfuZpP
	/n3G/uZJR/RcsV7B8ptSR3RfKLEUZyQaajEXFScCAJyMcbgUAwAA
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 08/04/2016 09:39 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>>>> +       }
>>>> +       /*
>>>> +        * We have reached the end of the line without finding any non-space
>>>> +        * characters; i.e., the whole line consists of trailing spaces, which we
>>>> +        * are not interested in.
>>>> +        */
>>>> +       return -1;
> 
> Not related to Jacob's review, but "the whole line consists of
> trailing spaces" made me read it twice; while it is technically
> correct, "the whole line consists of spaces", or even "this is a
> blank line", would read a lot more easily, at least for me.

Hehe, yes, ETOOMANYWORDS.

>> I was implicitly assuming that such lines would have text somewhere
>> after those 200 spaces (or 25 TABs or whatever). But you're right, the
>> line could consist only of whitespace. Unfortunately, the only way to
>> distinguish these two cases is to read the rest of the line, which is
>> exactly what we *don't* want to do.
> 
> Hmm, why is it exactly what we don't want to do?  Is it a
> performance concern?  In other words, is it because this function is
> called many times to measure the same line multiple times?

Yes, performance is the reason, and especially the desire to avoid
unreasonable runtimes for pathological cases. Thanks for asking, though,
because it's worthwhile to look into this more rigorously.

Suppose there is a slider that can be shifted to any of `numshift`
positions. Then we have to call `measure_split()` `2*numshift` times
(once for the beginning and once for the end of each candidate slider
position).

Suppose there are `numblanks` blank lines in the neighborhood of the
slider. Each time we call `measure_split()`, we count the number of
blank lines before and after the proposed split position. So we end up
calling `get_indent()` `2*numshift*numblanks` times.

Finally, suppose that the blank lines each contain `numws` whitespace
characters. Then each call to `get_indent()` has to do `O(numws)` work.

So altogether, if there were no limits, then the amount of work to
position a slider would scale like

    O(numshift * numblanks * numws)

However, the total number of characters in the file might only be

    O(numblanks * numws)

So without limits, the amount of work to position sliders could scale by
numshift times the size of the file.

The worst case is pretty easy to achieve. Just create a file consisting
of a million or so LF characters, then add another LF to it. The diff
would be a slider with

    numshift = 1000000
    numblanks = 1000000
    numws = 1

so the heuristic would take O(N^2) in the size of the file.

Effectively the limits cap the effective `numblanks` at `2*MAX_BLANKS`
(which is 2*20) and the effective `numws` at `MAX_INDENT` (which is
200), meaning that the maximum effort scales like

    numshift * 2*20 * 200

which is still a big number but not absurd. Empirically, for the case
described above, `git diff` takes 104 ms and `git diff
--indent-heuristic` takes 490 ms. I think that's not prohibitive for a
pathological case.

Meanwhile, Myers's algorithm scales like O(ND), where N is the number of
lines and D is the edit distance, so I suppose that it is already
possible to find diffs that are intractable to compute.

> After
> all, somebody in this file is already scanning each and every line
> to see where it ends to split the input into records, so perhaps a
> "right" (if the "theoretical correctness" of the return value from
> this function mattered, which you wave-away below) optimization
> could be to precompute it while the lines are broken into records
> and store it in the "rec" structure?

That would certainly be possible, and would help in cases where there
are a lot of lines with lots of leading whitespace. You could get nearly
the same benefit by recording a single bit in struct rec, indicating
whether the line is blank or not.

But it wouldn't help the worst case described above, where each call to
`git_indent()` is already very cheap. And I didn't think it was worth
allocating the extra memory to optimize this heuristic

* which isn't used all that often in the first place,
* which (for normal inputs) doesn't take a significant amount of time, and
* when the optimization doesn't improve the worst-case scenario (and
thus any DoS potential)

I think the only way to ensure O(size_of_file) runtime in the above case
would be to record, along with each line, how many blank lines
immediately precede and succeed it. You could achieve something like
O(size_of_file lg(size_of_file)) by storing, e.g., the total number of
nonblank lines that precede each line and doing a binary search to find
the nearest non-blank line.

>> But I think it doesn't matter anyway. Such "text" will likely never be
>> read by a human, so it's not a big deal if the slider position is not
>> picked perfectly. And remember, this whole saga is just to improve the
>> aesthetics of the diff. The diff is *correct* (e.g., in the sense of
>> applicable) regardless of where we position the sliders.
> 
> A better argument may be "if the user is truly reading a diff output
> for such an unusual "text", it is likely that she has a very wide
> display and/or running less -S, and treating such an overindented line
> as if it were a blank line would give a result that is more consistent
> to what appears on her display", perhaps?

I don't know. It seems like a pretty contrived justification for what is
basically, "your input is too weird for us. We're not going to break our
necks trying to give you the best possible slider positioning."

Michael

