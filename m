Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B3DE1FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 18:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932113AbdBISQA (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 13:16:00 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:42430 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751625AbdBISPE (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Feb 2017 13:15:04 -0500
X-AuditID: 1207440c-095ff70000000a44-aa-589cb16da790
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 18.96.02628.D61BC985; Thu,  9 Feb 2017 13:14:06 -0500 (EST)
Received: from [192.168.69.190] (p4FEDF6A1.dip0.t-ipconnect.de [79.237.246.161])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v19IE2XM006189
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 9 Feb 2017 13:14:04 -0500
Subject: Re: [PATCH 3/5] register_ref_store(): new function
To:     Stefan Beller <sbeller@google.com>
References: <cover.1486629195.git.mhagger@alum.mit.edu>
 <ce326e17822184eff434b957d28f2233795162db.1486629195.git.mhagger@alum.mit.edu>
 <CAGZ79kYrqfmNGE0A63iYaW=MSFwANRXnn3kkxHE8kpOtF2KeLA@mail.gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <61f100b7-a663-512c-762f-3293a1c56711@alum.mit.edu>
Date:   Thu, 9 Feb 2017 19:14:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYrqfmNGE0A63iYaW=MSFwANRXnn3kkxHE8kpOtF2KeLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42IRYndR1M3bOCfC4NckQYuuK91MFg29V5gt
        +pd3sVksefia2aJ7yltGi82b21kc2Dx2zrrL7vHhY5zHgk2lHl3tR9g8Ll5S9vi8SS6ALYrL
        JiU1J7MstUjfLoEr48se24J7ohUL7nawNjDuFuhi5OSQEDCRONy1jhHEFhK4zCjRODOni5EL
        yD7PJPHn3zcmkISwgLXE3sNXWUBsEQE1iZmrZrNBNJxnlHh3zBGkgVlgKpPE/CUzwYrYBHQl
        FvU0gzXzCthLLOmfChZnEVCRmDP/E9g2UYEQiTkLHzBC1AhKnJz5BKyGUyBQ4nzDbXYQm1lA
        XeLPvEvMELa8xPa3c5gnMPLPQtIyC0nZLCRlCxiZVzHKJeaU5urmJmbmFKcm6xYnJ+blpRbp
        GurlZpbopaaUbmKEBDbPDsZv62QOMQpwMCrx8E6omhMhxJpYVlyZe4hRkoNJSZRXtgAoxJeU
        n1KZkVicEV9UmpNafIhRgoNZSYT33mKgHG9KYmVValE+TEqag0VJnFd1ibqfkEB6Yklqdmpq
        QWoRTFaGg0NJgnfveqBGwaLU9NSKtMycEoQ0EwcnyHAeoOFcG0CGFxck5hZnpkPkTzEqSonz
        RoAkBEASGaV5cL2wxPOKURzoFWFeA5AqHmDSgut+BTSYCWjw9dOzQAaXJCKkpBoYdSJ+TAg9
        prjgZsKxiUHfdC7LzzXn+n86u3tOxI+IlSdcr55k3ORnsnwHf3R6vaxr0XntP5GLjjp/lZQ4
        evbBRb87nUF68/ntNeJ+Hdsnf9d6y+3tFlm6Stmbs6w8jkSLHlivJ/VS3aJ8HbvIXSG+h08e
        cDybkucfFf7X9oSSwbrTWqL/a53uK7EUZyQaajEXFScCAALKh9sXAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/09/2017 06:20 PM, Stefan Beller wrote:
> On Thu, Feb 9, 2017 at 5:27 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> Move the responsibility for registering the ref_store for a submodule
>> from base_ref_store_init() to a new function, register_ref_store(). Call
>> the latter from ref_store_init().
>>
>> This means that base_ref_store_init() can lose its submodule argument,
>> further weakening the 1:1 relationship between ref_stores and
>> submodules.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
> 
> 
> 
> 
>> +
>>  struct ref_store *ref_store_init(const char *submodule)
>>  {
>>         const char *be_name = "files";
>>         struct ref_storage_be *be = find_ref_storage_backend(be_name);
>> +       struct ref_store *refs;
>>
>>         if (!be)
>>                 die("BUG: reference backend %s is unknown", be_name);
>>
>>         if (!submodule || !*submodule)
>> -               return be->init(NULL);
>> +               refs = be->init(NULL);
>>         else
>> -               return be->init(submodule);
>> +               refs = be->init(submodule);
>> +
>> +       register_ref_store(refs, submodule);
>> +       return refs;
>>  }
> 
> This function is already very readable, though maybe it would be
> more readable like so:
> 
> {
>     const char *be_name = "files";
>     struct ref_storage_be *be = find_ref_storage_backend(be_name);
> 
>     if (!be)
>         die("BUG: reference backend %s is unknown", be_name);
> 
>     /* replace empty string by NULL */
>     if (submodule && !*submodule)
>         submodule = NULL;
> 
>     register_ref_store(be->init(submodule), submodule);
>     return refs;
> }
> 
> Well, I dunno; the function inside the arguments to register seems ugly, though.

Nit: you forgot to define and initialize `refs` (for returning to the
caller).

Actually, there is an inconsistency between the docstring for this
function and its behavior. The docstring claims that it can handle
`submodule == ""`, and it tries to do so, but incorrectly. The problem
is that it passes an un-cleaned-up `submodule` to
`register_ref_store()`, which is expecting a cleaned-up one.

But this function is only called by get_ref_store(), which has already
arranged for the empty string to be passed along as NULL.

In fact, the only external entry point into these functions is
`get_ref_store()`. I think what I should do is make the other functions
private, and remove their attempts to handle `submodule == ""`. I'll fix
this up in a re-roll.

(I wonder whether anybody really passes the empty string into this
method. It never happens in the test suite. I doubt I can muster the
energy to audit all of the call paths.)

Michael

