Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCE311FE90
	for <e@80x24.org>; Fri, 21 Apr 2017 06:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1035771AbdDUGdF (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 02:33:05 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:59463 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1035740AbdDUGdD (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 21 Apr 2017 02:33:03 -0400
X-AuditID: 12074411-cc7ff70000003efd-36-58f9a79c5a97
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 9B.B4.16125.C97A9F85; Fri, 21 Apr 2017 02:33:01 -0400 (EDT)
Received: from [192.168.69.190] (p57906886.dip0.t-ipconnect.de [87.144.104.134])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3L6WvM5024554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Fri, 21 Apr 2017 02:32:58 -0400
Subject: Re: [PATCH] refs.h: rename submodule arguments to submodule_path
To:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
References: <20170412200037.18752-1-sbeller@google.com>
 <CAGZ79kYTqh=Qa+Pt1+MojrcYFr05HQgbPRcc=DvjCkUWsjP5Uw@mail.gmail.com>
 <xmqqy3uu7ee3.fsf@gitster.mtv.corp.google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <cb1dd8b6-3357-57ff-650d-c55a7eb38d34@alum.mit.edu>
Date:   Fri, 21 Apr 2017 08:32:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqy3uu7ee3.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqDtv+c8Igyen2Cy6rnQzWTT0XmG2
        6J7yltFi8+Z2FgcWj52z7rJ7LNhU6nHxkrLH501yASxRXDYpqTmZZalF+nYJXBnTZuxiKZgl
        UPF1+S3WBsbXPF2MnBwSAiYSvy/NYQKxhQR2MEnsPmjbxcgFZF9gkjj1fRp7FyMHh7CAp8SJ
        D3YgpoiAl0TbzGKIkvWMEktu7AfrZRZIktj3/gQriM0moCuxqKcZLM4rYC/RseMWO4jNIqAq
        MX/5AbC4qECIxJyFDxghagQlTs58wgJicwpYS1zYuJEdYqaexI7rv1ghbHmJ7W/nME9g5J+F
        pGUWkrJZSMoWMDKvYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI11cvNLNFLTSndxAgJWMEdjDNO
        yh1iFOBgVOLhPbHyR4QQa2JZcWXuIUZJDiYlUd6rHT8jhPiS8lMqMxKLM+KLSnNSiw8xSnAw
        K4nw1s0FyvGmJFZWpRblw6SkOViUxHn5lqj7CQmkJ5akZqemFqQWwWRlODiUJHgLlwE1Chal
        pqdWpGXmlCCkmTg4QYbzAA1/C1LDW1yQmFucmQ6RP8WoKCXO27UUKCEAksgozYPrhSWUV4zi
        QK8I83KCtPMAkxFc9yugwUxAg8/6/QAZXJKIkJJqYPTsWai4XaFFST/vnGJp1yvNILFO62OL
        4ldtrplU/4hv/+YIcyFe+1dq7cEcfL7ZNcGckyPf35PgmvjPgcdp7ayo1+JPY2bN+7opbbti
        1icZp2gJg3zJ/Z/mBVp+zOKoLF892SH5MP+NwKq7ixlz/3Pv311rvVdx9sYDU3n0r2+yrrrI
        I5lkqcRSnJFoqMVcVJwIAMQK+gcDAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/21/2017 03:12 AM, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
> 
>> + Junio
> 
> Just like Michael, I do not have strong enough opinion for or
> against this patch to comment on it.
> 
> I do agree with you that it would be a good longer-term direction to
> use "submodule" for a "struct submodule" (i.e. submodule object),
> and call a string that names a submodule either "submodule_name" or
> "submodule_path" depending on how it names one, for maintainability
> of the code.  
> 
> However I am not convinced that this patch is an improvement.  Even
> though parameter names in decls only serve documentation purpose and
> it is even OK to only have type without name there, if we are going
> to _have_ names, it would make sense to match them to the parameter
> names actually used in the implementation.  
> 
> Updating these names used in refs.c would make a very noisy patch,
> of course.  But I am not sure if it is a good middle ground to avoid
> that and to update only refs.h.

One should never infer too much from my silence. As often as not it's
because I'm simply busy with other things.

But in this case Junio's right. I think it is a good idea to use
argument names in declarations as documentation, and I also agree that
it is a minus for the names in the declarations not to agree with the
names in the definition. But the code that would have to be touched
already has a lot of work going on in it, so conflicts would be likely.

I've CCed Duy because I don't know whether he has more plans regarding
submodule references. A natural followup to his recent work would be to
add a feature to the `submodule` module that allows a caller to look up
the `ref_store` object for the submodule. Then client code could use the
`refs_for_each_ref(struct ref_store *, ...)` family of functions to
access such references, and we could get rid of the
`for_each_ref_submodule()` family of functions entirely.

So perhaps the code that this patch touches won't be around long anyway.

Michael

