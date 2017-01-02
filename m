Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53338205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 18:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756558AbdABSGz (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 13:06:55 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:52811 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756526AbdABSGg (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 2 Jan 2017 13:06:36 -0500
X-AuditID: 1207440c-e53ff700000009a1-b7-586a96aabae8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id E5.61.02465.AA69A685; Mon,  2 Jan 2017 13:06:35 -0500 (EST)
Received: from [192.168.69.190] (p5B10411C.dip0.t-ipconnect.de [91.16.65.28])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v02I6WBH006779
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 2 Jan 2017 13:06:33 -0500
Subject: Re: [PATCH v3 21/23] try_remove_empty_parents(): don't accommodate
 consecutive slashes
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
 <c7a89febcbf7bdffb44f8fdf63a43f11339a0289.1483153436.git.mhagger@alum.mit.edu>
 <xmqqvatz4imu.fsf@gitster.mtv.corp.google.com>
 <20170101055947.7b5jxih3wlprqcil@sigill.intra.peff.net>
Cc:     git@vger.kernel.org, David Turner <novalis@novalis.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <5051c78e-51f9-becd-e1a6-9c0b781d6912@alum.mit.edu>
Date:   Mon, 2 Jan 2017 19:06:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <20170101055947.7b5jxih3wlprqcil@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsUixO6iqLt6WlaEQeNVAYuuK91MFg29V5gt
        ljx8zWzxo6WH2YHFo6v9CJvHs949jB4XLyl7fN4kF8ASxWWTkpqTWZZapG+XwJWxYM4ltoIm
        yYrlxzwbGDtEuhg5OSQETCR+Pn3P3MXIxSEkcJlRonn+F3YI5wyTxJY3K1lBqoQFEiW6Tx1m
        BrFFBBwlLmw5wgJR9JlR4srsV2wgCWYBa4mfd96wg9hsAroSi3qamboYOTh4Bewlbq1SAwmz
        CKhILOy5ygRiiwqESFyecxSslVdAUOLkzCcsIDangItEw9Vn7BAj1SX+zLvEDGHLS2x/O4d5
        AiP/LCQts5CUzUJStoCReRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrqFebmaJXmpK6SZGSNDy
        7GD8tk7mEKMAB6MSD++DmKwIIdbEsuLK3EOMkhxMSqK8T+uAQnxJ+SmVGYnFGfFFpTmpxYcY
        JTiYlUR4J00GyvGmJFZWpRblw6SkOViUxHlVl6j7CQmkJ5akZqemFqQWwWRlODiUJHhZgNEp
        JFiUmp5akZaZU4KQZuLgBBnOAzRcHaSGt7ggMbc4Mx0if4pRUUqc98EUoIQASCKjNA+uF5ZU
        XjGKA70izKsH0s4DTEhw3a+ABjMBDf4alw4yuCQRISXVwLjgWTNj862Vqr51p5Sfnv7o9shE
        9uRNGd3zLwsb3fbsCP60ivPwrufnTHNLt53yEpJYx9h+WViePav/0IG/V5Qi7PablL073b9N
        ImRJm8ahv/89n/ouzCotvq5Q6LVHxefqDbaj21e1TD28XeFa9nfl5aLZkVmGR91n9Njb3dld
        vrV9bSPL42tKLMUZiYZazEXFiQC/I1dcBQMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/01/2017 06:59 AM, Jeff King wrote:
> On Sat, Dec 31, 2016 at 06:30:01PM -0800, Junio C Hamano wrote:
> 
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>
>>> "refname" has already been checked by check_refname_format(), so it
>>> cannot have consecutive slashes.
>>
>> In the endgame state, this has two callers.  Both use what came in
>> the transaction->updates[] array.  Presumably "has already been
>> checked by check_refname_format()" says that whoever created entries
>> in that array must have called the function, but it would be helpful
>> to be more explicit here.
> 
> Hmm, yeah. This is called when we are deleting a ref, and I thought we
> explicitly _didn't_ do check_refname_format() when deleting, so that
> funny-named refs could be deleted. It's only is_refname_safe() that we
> must pass.
> 
> So I have no idea if that's a problem in the code or not, but it is at
> least not immediately obvious who is responsible for calling
> check_refname_format() here.

My assumption was that only valid reference names should ever be allowed
to be inserted into a `ref_transaction` entry. But Peff is right that
sometimes the reference name is checked by `refname_is_safe()` rather
than `check_refname_format()`. Let's audit this more carefully...

* `ref_transaction_add_update()` relies on its caller doing the check
  (this fact is documented). Its callers are:
  * `ref_transaction_update()` (the usual codepath), which checks the
    reference itself using either check_refname_format() or
    refname_is_safe() depending on what kind of update it is.
  * `split_head_update()` passes the literal string "HEAD".
  * `split_symref_update()` picks apart reference updates that go
    through existing symbolic references. As such I don't think they
    are an attack surface. It doesn't do any checking itself (here
    we're talking about its `referent` argument). It has only one
    caller:
    * `lock_ref_for_update()`, which gets `referent` from:
      * `files_read_raw_ref()`, which gets the value either:
        * by reading a filesystem-level symlink's contents and
          checking it with `check_refname_format()`, or
        * reading a symref from the filesystem. In this case, *the
          value is not checked*.

Obviously this chain of custody is disconcertingly long and complicated.
And the gap for symrefs should probably be fixed, even though they are
hopefully trustworthy.

`refname_is_safe()` checks that its argument is either UPPER_CASE or
looks like a plausible filename under "refs/". Contrary to its
docstring, it *does not* accept strings that contain successive slashes
or "." or ".." components. It was made stricter in

    e40f355 "refname_is_safe(): insist that the refname already be
normalized", 2016-04-27

, but the docstring wasn't updated at that time. I'll fix it.

I think the best thing to do is to drop this patch from the patch
series, and address these checks in a separate series. (There are more
known problems in this area, for example that the checks in
`check_refname_format()` are not a strict superset of the checks in
`refname_is_safe()`.)

Michael

