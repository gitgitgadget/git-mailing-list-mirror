Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	TVD_SUBJ_WIPE_DEBT shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F990201A9
	for <e@80x24.org>; Mon, 20 Feb 2017 12:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753146AbdBTMar (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 07:30:47 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:56761 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753317AbdBTMaq (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Feb 2017 07:30:46 -0500
X-AuditID: 1207440c-aa5ff70000002e8f-23-58aae174cec5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 20.73.11919.471EAA85; Mon, 20 Feb 2017 07:30:44 -0500 (EST)
Received: from [192.168.69.190] (p579060C0.dip0.t-ipconnect.de [87.144.96.192])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v1KCUfQJ029099
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 20 Feb 2017 07:30:42 -0500
Subject: Re: [PATCH v4 14/15] files-backend: remove submodule_allowed from
 files_downcast()
To:     Duy Nguyen <pclouds@gmail.com>
References: <20170217140436.17336-1-pclouds@gmail.com>
 <20170218133303.3682-1-pclouds@gmail.com>
 <20170218133303.3682-15-pclouds@gmail.com>
 <25fcb527-595a-7865-41e3-ee7c4c1ad668@alum.mit.edu>
 <CACsJy8AZ27O-pxTqHOzYXRBuyv8dkxdGJ_5Z0u3eaxkNdnaEYA@mail.gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <c4265faf-a04a-552b-fd72-1631a220f788@alum.mit.edu>
Date:   Mon, 20 Feb 2017 13:30:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8AZ27O-pxTqHOzYXRBuyv8dkxdGJ_5Z0u3eaxkNdnaEYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1C15uCrC4PkLU4uuK91MFg29V5gt
        +pd3sVksefia2aJ7yltGi5lXrS02b25ncWD32DnrLrvHh49xHgs2lXp0tR9h87h4Sdlj/9Jt
        bB6fN8kFsEdx2aSk5mSWpRbp2yVwZWztbGEtmClQMWnfBrYGxj7eLkZODgkBE4k7rU8ZQWwh
        gR1MEh8eyHYxcgHZ55kktn4/zwSSEBaIlTjec4UdxBYRUJJ407GNGaKoh0niwolLLCAOs8As
        JomLexexgVSxCehKLOppBuvmFbCXWLL0MAuIzSKgKrHz1mKwSaICIRJzFj5ghKgRlDg58wlY
        DadAoMTin1vB4swC6hJ/5l1ihrDlJZq3zmaewMg/C0nLLCRls5CULWBkXsUol5hTmqubm5iZ
        U5yarFucnJiXl1qka6iXm1mil5pSuokREu48Oxi/rZM5xCjAwajEw6sxc2WEEGtiWXFl7iFG
        SQ4mJVHeO0tWRQjxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4X1zGSjHm5JYWZValA+TkuZgURLn
        VV2i7ickkJ5YkpqdmlqQWgSTleHgUJLgrX0A1ChYlJqeWpGWmVOCkGbi4AQZzgM0/AJIDW9x
        QWJucWY6RP4Uo6KUOO/L+0AJAZBERmkeXC8sHb1iFAd6RZg3HaSdB5jK4LpfAQ1mAhp802Ml
        yOCSRISUVAOj49yP9/N+Oe27sERy78cza91TWjb6BBRFcx52+dt/OJizeb4Wz+602fOkeQ1f
        i70pyly+/XTzdfkHFjdy/B3ktnIru0tFnmLuPy/E/rHxc+bcBd+eRBxSCAlZ6zyD8+ehkxMU
        ztgeuFAcUjuvQHXNTZ8js/4GGWyxvtGXw/hmUWf/zbTnm6+5K7EUZyQaajEXFScCADJVsAUi
        AwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/20/2017 01:21 PM, Duy Nguyen wrote:
> On Mon, Feb 20, 2017 at 7:11 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> On 02/18/2017 02:33 PM, Nguyễn Thái Ngọc Duy wrote:
>>> Since submodule or not is irrelevant to files-backend after the last
>>> patch, remove the parameter from files_downcast() and kill
>>> files_assert_main_repository().
>>>
>>> PS. This implies that all ref operations are allowed for submodules. But
>>> we may need to look more closely to see if that's really true...
>>
>> I think you are jumping the gun here.
>>
>> Even after your changes, there is still a significant difference between
>> the main repository and submodules: we have access to the object
>> database for the main repository, but not for submodules.
>>
>> So, for example, the following don't work for submodules:
>>
>> * `parse_object()` is used to ensure that references are only pointed at
>> valid objects, and that branches are only pointed at commit objects.
>>
>> * `peel_object()` is used to write the peeled version of references in
>> `packed-refs`, and to peel references while they are being iterated
>> over. Since this doesn't work, I think you can't write `packed-refs` in
>> a submodule.
>>
>> These limitations, I think, imply that submodule references have to be
>> treated as read-only.
> 
> Behind the scene submodule does add_submodule_odb(), which basically
> makes the submodule's odb an alternate of in-core odb. So odb access
> works. I was puzzled how submodules could by pass odb access at the
> beginning only to find that out. technical/api-ref-iteration.txt also
> mentions that you need to add_submodule_odb(), so I think it's
> deliberate (albeit hacky) design.

That's interesting. I didn't know it before.

But I still don't think that means that reference writing can work
correctly. If I try to set a submodule branch to an SHA-1 and I verify
that the SHA-1 points to a valid commit, how do I know that the commit
is in the same submodule that holds the reference?

> [...]

Michael
