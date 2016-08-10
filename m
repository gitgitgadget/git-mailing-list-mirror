Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 812C91FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 18:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbcHJSr1 (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 14:47:27 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:63519 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S938773AbcHJSr0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Aug 2016 14:47:26 -0400
X-AuditID: 12074411-a07ff70000000932-e5-57ab58d623b8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 7A.A0.02354.6D85BA75; Wed, 10 Aug 2016 12:39:50 -0400 (EDT)
Received: from [192.168.69.130] (p5B104255.dip0.t-ipconnect.de [91.16.66.85])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u7AGdl5W003959
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 10 Aug 2016 12:39:48 -0400
Subject: Re: [PATCH 2/8] xdl_change_compact(): clarify code
To:	Stefan Beller <sbeller@google.com>
References: <cover.1470259583.git.mhagger@alum.mit.edu>
 <f4ce27f389b64c9ae503152c66d183c4a4a970f1.1470259583.git.mhagger@alum.mit.edu>
 <CAGZ79kZk+XW+Bwcx_fvOLVBDse_iUSjEa_K=eJqm4PpTsTAcPA@mail.gmail.com>
 <57715dee-ca73-c1bb-ee79-2813d7873649@alum.mit.edu>
 <CAGZ79kbyCRDTt4u+Fje819mNZZf3GkZtYVurwOMPXRfXqO-YEw@mail.gmail.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
From:	Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <48ca79e2-418b-3c73-e075-808d39a4da9a@alum.mit.edu>
Date:	Wed, 10 Aug 2016 18:39:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.1.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kbyCRDTt4u+Fje819mNZZf3GkZtYVurwOMPXRfXqO-YEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42IRYndR1L0WsTrc4NcjdYuuK91MFg29V5gt
	di/uZ7ZYcXUOs8WPlh5mi82b21kc2Dx2zrrL7rFgU6nHs949jB4XLyl7fN4kF8AaxWWTkpqT
	WZZapG+XwJXRuaiNrWC7aMWNgxdYGhjP8HYxcnBICJhIXN6Z0sXIxSEksJVRYsrlfWwQzlkm
	ialvtrJ2MXJyCAtYS7zfeJsdxBYRUJOYuWo2VNEZJokL91pYQRxmgSeMEvf6b7KBVLEJ6Eos
	6mlmArF5BewlZl1azAxiswioSiz4v4gFxBYVCJHYdrOBDaJGUOLkzCdgcU6BQIlz01cygtjM
	AuoSf+ZdYoaw5SW2v53DPIGRfxaSlllIymYhKVvAyLyKUS4xpzRXNzcxM6c4NVm3ODkxLy+1
	SNdULzezRC81pXQTIySoBXcwzjgpd4hRgINRiYd3A9OqcCHWxLLiytxDjJIcTEqivN6qq8OF
	+JLyUyozEosz4otKc1KLDzFKcDArifCeDwbK8aYkVlalFuXDpKQ5WJTEefmWqPsJCaQnlqRm
	p6YWpBbBZGU4OJQkePvCgRoFi1LTUyvSMnNKENJMHJwgw3mAhm8HqeEtLkjMLc5Mh8ifYlSU
	EuedFAaUEABJZJTmwfXCks4rRnGgV4R5r4K08wATFlz3K6DBTECDk1RXgAwuSURISTUwTn20
	4+bEAz+0vnIvVZsXITrXN4OH+XWy4SylH+/3TKwL+iC3V6Qlcqruroj5f96IcDZuMGDZuOjP
	1+1v36z4rm6xrl40rlTMXPhe/Gm9uz/vHXfwy55Uo/SlYWtj9BQZTnP3mD1iSXzrb91fN1/v
	47FTiqty1aV4PeZ8816Q57v29Xem6ft26yuxFGckGmoxFxUnAgCyegxVFQMAAA==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 08/04/2016 01:50 AM, Stefan Beller wrote:
> On Wed, Aug 3, 2016 at 4:14 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> On 08/04/2016 12:11 AM, Stefan Beller wrote:
>>> On Wed, Aug 3, 2016 at 3:00 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>>> [...]
>>>> +
>>>> +                       /*
>>>> +                        * Are there any blank lines that could appear as the last
>>>> +                        * line of this group?
>>>> +                        */
>>>
>>> IIRC this comment is not quite correct as this 'only' counts the number of
>>> blank lines within the forward shifting section, i.e. in the movable space.
>>>
>>> Later we use it as a boolean indicator (whether or not it is equal to 0)
>>> to see if we can do better.
>>> [...]

Thanks for your comments, Stefan.

I realized that the main thing that took me a while to grok when I was
reading this code was that blank_lines was really only used as a boolean
value, even though it was updated with "+=". That's the main information
that I'd like to convey to the reader.

So I decided to change the comment to emphasize this fact (and change it
from a question to a statement), and also changed the place that
blank_lines is updated to treat it more like a boolean. The latter
change also has the advantage of not calling is_blank_line()
unnecessarily when blank_lines is already true.

If you have no objections, that is what I will put in v2 of this patch
series:

> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> index de15de2..fde0433 100644
> --- a/xdiff/xdiffi.c
> +++ b/xdiff/xdiffi.c
> @@ -460,6 +460,12 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>  
>                 do {
>                         groupsize = i - start;
> +
> +                       /*
> +                        * Boolean value that records whether there are any blank
> +                        * lines that could be made to be the last line of this
> +                        * group.
> +                        */
>                         blank_lines = 0;
>  
>                         /*
> @@ -511,7 +517,8 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>                          * the current change group.
>                          */
>                         while (i < nrec && recs_match(recs, start, i, flags)) {
> -                               blank_lines += is_blank_line(recs, i, flags);
> +                               if (!blank_lines)
> +                                       blank_lines = is_blank_line(recs, i, flags);
>  
>                                 rchg[start++] = 0;
>                                 rchg[i++] = 1;

Michael

