Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9705C1F4DD
	for <e@80x24.org>; Mon, 28 Aug 2017 09:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751641AbdH1IHG convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 28 Aug 2017 04:07:06 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:43289 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751566AbdH1IHA (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 28 Aug 2017 04:07:00 -0400
X-AuditID: 1207440f-a5bff70000007960-c3-59a3cf239d01
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 02.AA.31072.32FC3A95; Mon, 28 Aug 2017 04:06:59 -0400 (EDT)
Received: from mail-it0-f53.google.com (mail-it0-f53.google.com [209.85.214.53])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7S86w3c026585
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Mon, 28 Aug 2017 04:06:58 -0400
Received: by mail-it0-f53.google.com with SMTP id 77so23684225itj.0
        for <git@vger.kernel.org>; Mon, 28 Aug 2017 01:06:58 -0700 (PDT)
X-Gm-Message-State: AHYfb5gs8404rIaUHW5n6zG6DiwbLM1F/KaGO5DZ8B37SoPU8IUEHo8f
        ndSgi3AQUb+0eV1Ln4gWeS5ve1+/7A==
X-Received: by 10.36.80.207 with SMTP id m198mr5210657itb.133.1503907618278;
 Mon, 28 Aug 2017 01:06:58 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mhagger@alum.mit.edu
Received: by 10.79.15.14 with HTTP; Mon, 28 Aug 2017 01:06:57 -0700 (PDT)
In-Reply-To: <CAN0heSq8RdH5vWFgq1UvJOfWerMJSZwhV4FMCjvA=XUqu2OQQQ@mail.gmail.com>
References: <40c5e954dd84ff42552bccfea00144eecdbd1c7e.1503496797.git.martin.agren@gmail.com>
 <xmqq8ti7s6ph.fsf@gitster.mtv.corp.google.com> <CAN0heSq8RdH5vWFgq1UvJOfWerMJSZwhV4FMCjvA=XUqu2OQQQ@mail.gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Mon, 28 Aug 2017 10:06:57 +0200
X-Gmail-Original-Message-ID: <CAMy9T_FUGehTbfVfVfi877Gi3DOR5Z45A-H-v92s7g=m7RVnSw@mail.gmail.com>
Message-ID: <CAMy9T_FUGehTbfVfVfi877Gi3DOR5Z45A-H-v92s7g=m7RVnSw@mail.gmail.com>
Subject: Re: [PATCH 1/2] refs/files-backend: duplicate strings added to affected_refnames
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsUixO6iqKt8fnGkwYPLihZdV7qZHBg9Pm+S
        C2CM4rJJSc3JLEst0rdL4MrYs+gYY8FcqYpXl34xNjAeE+1i5OSQEDCRuPr2LlsXIxeHkMAO
        JonfcxtZQBJCAo+YJE4+zodI9DJK9H9czQbRkS/xu30aI4RdIvFt7wQmEJtXQFDi5MwnUM1y
        Eq823GCEsD0l5nVsBItzCgRKbDkyhxVi6CVGie8LGsCa2QR0JRb1NIPZLAKqEgsWrGaHWJAo
        8e3mQlaIBQESF57fBLI5OIQFIiX2PM4ACYsIWEls6vzIDGIzC/hJ3J5wkgXC1pRo3f6bHcLW
        lli28DXzBEaRWUhOnYWkbBaSsgWMzKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdE30cjNL9FJT
        SjcxQoKefwdj13qZQ4wCHIxKPLw3LBdHCrEmlhVX5h5ilORgUhLl3VkBFOJLyk+pzEgszogv
        Ks1JLT7EKMHBrCTCm3gWKMebklhZlVqUD5OS5mBREudVX6LuJySQnliSmp2aWpBaBJPV4OAQ
        mHFu7nQmKZa8/LxUJQleu3NAQwSLUtNTK9Iyc0oQSpk4OEEW8QAt+gi2qLggMbc4Mx0if4rR
        mOPKlXVfmDimHNj+hUkIbJyUOC8byDgBkNKM0jy4abCE9opRHOhRYV4NkCoeYDKEm/cKaBUT
        0CpFwYUgq0oSEVJSDYwrVA0UJnkJXD64rGCZ3fI0DqbHjs+CfO58fy3gyCh3+MbjeSZrOS/a
        H2Pq+cxdFJL8rz6b3UL3+aL4PradiaXrtz/pKDqaXXFlZUfamh8BobukGr+cvCceLcgbGXeg
        ft+HitQ/mr55/w7PL82qXucjemV3i0YVx+X2l+Vid1z4LnJPvZB/bIsSS3FGoqEWc1FxIgBU
        10pPQwMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 26, 2017 at 12:16 PM, Martin Ågren <martin.agren@gmail.com> wrote:
> On 25 August 2017 at 23:00, Junio C Hamano <gitster@pobox.com> wrote:
>> Martin Ågren <martin.agren@gmail.com> writes:
>>
>>> files_transaction_prepare() and the functions it calls add strings to a
>>> string list without duplicating them, i.e., we keep the original raw
>>> pointers we were given. That is "ok", since we keep them only for a
>>> short-enough time, but we end up leaking some of them.
>>
>> [...]

Good find, Martin.

First of all, you are right that we don't want any memory leaks here.
Nobody promises that the program will end soon if a reference update
fails. (In fact, there are invocations of `git` that trigger multiple
reference updates.) This is a small leak, but we should fix it.

The problem (if I may take a stab at explaining it in my own words) is
that `files_transaction_prepare()` uses a `string_list` called
`affected_refnames` to ensure that the same reference name is not
modified more than once in a single reference transaction. Currently,
`affected_refnames` is configured *not* to duplicate the refnames that
are fed to it, which also means that it doesn't free the refnames when
it is cleared.

This is correct for most refnames, which are owned by entries in the
`ref_transaction`, and therefore have a longer lifetime than
`affected_refnames`.

But there is one code path that can add a refname to
`affected_refnames` without making a provision for the refname ever to
be freed:

* files_transaction_prepare()
  * lock_ref_for_update()
    * split_symref_update()
      * item = string_list_insert(affected_refnames, referent)

The `referent` in the last statement comes from a `strbuf` that is
created in `lock_ref_for_update()` then passed to `lock_raw_ref()`,
which fills it.

It would be a serious bug if `lock_ref_for_update()` would dispose of
`referent`, because the pointer in `affected_refnames` would point at
freed memory. But in fact we have the opposite problem;
`lock_ref_for_update()` never frees the memory (it doesn't even
`strbuf_detach()` it). So that memory is leaked.

Your proposed solution is to change `affected_refnames` to duplicate
the strings that are stored in it, in which case
`lock_ref_for_update()` can properly dispose of `referent`, fixing the
leak. This works, but at the price of having to allocate memory for
*all* references in the update, even though most of them are already
fine.

But note that `split_symref_update()` *also* passes a copy of
`referent` to `ref_transaction_add_update()`, which *already* makes a
copy of the reference name and adds an entry containing the name to
the `ref_transaction`. If we would store *that* copy to
`affected_refnames`, then it would get freed when the
`ref_transaction` is cleaned up, and we could fix the memory leak
without allocating any new memory. This requires a little reorg of
`split_symref_update()` but it's not too bad:

* Do the initial check using `string_list_has_string()` rather than
calling `string_list_insert()` already.
* After `new_update` has been created, call `string_list_insert()`,
passing it `new_update->refname` as the string.

If this is done in place of your first commit, then your second commit
could be left unchanged.

Michael
