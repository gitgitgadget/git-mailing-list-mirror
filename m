Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7D672023D
	for <e@80x24.org>; Wed,  1 Mar 2017 15:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751706AbdCAPX5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 10:23:57 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:62112 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751123AbdCAPWr (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 1 Mar 2017 10:22:47 -0500
X-AuditID: 12074413-f67ff700000077e1-28-58b6e4a110f3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id CF.09.30689.1A4E6B85; Wed,  1 Mar 2017 10:11:29 -0500 (EST)
Received: from [192.168.69.190] (p57907E3C.dip0.t-ipconnect.de [87.144.126.60])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v21FBQEZ017103
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 1 Mar 2017 10:11:27 -0500
Subject: Re: [PATCH v5 24/24] t1406: new tests for submodule ref store
To:     Duy Nguyen <pclouds@gmail.com>
References: <20170218133303.3682-1-pclouds@gmail.com>
 <20170222140450.30886-1-pclouds@gmail.com>
 <20170222140450.30886-25-pclouds@gmail.com>
 <7e5ef9e7-bd90-1917-d8eb-c6310c2744ab@alum.mit.edu>
 <CACsJy8BOY8jsCrDYESJ6Gwy_p=J=c8m1qe64w18HX1Cv2AaYnA@mail.gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <8f4ec174-9060-0896-5135-bb50229fe149@alum.mit.edu>
Date:   Wed, 1 Mar 2017 16:11:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8BOY8jsCrDYESJ6Gwy_p=J=c8m1qe64w18HX1Cv2AaYnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqLvwybYIg+k9QhZdV7qZLBp6rzBb
        9C/vYrNY8vA1s0X3lLeMFjOvWlts3tzO4sDusXPWXXaPDx/jPBZsKvXoaj/C5nHxkrLH/qXb
        2Dw+b5ILYI/isklJzcksSy3St0vgymjfPZWl4C1/xcF1O9kaGC/zdDFyckgImEisX7uesYuR
        i0NIYAeTxPvL35khnHNMEgf+XWEGqRIWcJPYue8dE4gtIqAk8aZjG1RRL5PEzwMrmUAcZoFZ
        TBIX9y5iA6liE9CVWNTTDNbBK2Av8fh5J1icRUBF4va212BTRQVCJOYsfMAIUSMocXLmExYQ
        m1MgUOLR4YtgNrOAusSfeZeYIWx5ieats5knMPLPQtIyC0nZLCRlCxiZVzHKJeaU5urmJmbm
        FKcm6xYnJ+blpRbpmuvlZpbopaaUbmKEBLzwDsZdJ+UOMQpwMCrx8B7o3hohxJpYVlyZe4hR
        koNJSZR396ptEUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeB0eAeV4UxIrq1KL8mFS0hwsSuK8
        akvU/YQE0hNLUrNTUwtSi2CyMhwcShK8XY+BGgWLUtNTK9Iyc0oQ0kwcnCDDeYCG/wEbXlyQ
        mFucmQ6RP8WoKCXOuwUkIQCSyCjNg+uFJaRXjOJArwjzBoKs4AEmM7juV0CDmYAGv1DZCjK4
        JBEhJdXAuCCh+6rQrtmrTpysOLrk3YMTvuHxm0It1DVvf/209sLfGTIae6w+LwiWu3Zw7omS
        sP17XWwlH3ZxPuFN2F6x4VAD0x2tN1cqDuRGba621rAsLZj6Q+e5EfOGL7mOHHVzJH797d/Y
        6Bj71+2UF3fsBsvJ7J4/j0QskA2p5H+5L7B+s3ak/EL+DCWW4oxEQy3mouJEAHPljCsjAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/01/2017 01:34 PM, Duy Nguyen wrote:
> On Wed, Mar 1, 2017 at 12:34 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> On 02/22/2017 03:04 PM, Nguyễn Thái Ngọc Duy wrote:
>>> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
>>> ---
>>>  t/t1406-submodule-ref-store.sh (new +x) | 95 +++++++++++++++++++++++++++++++++
>>>  1 file changed, 95 insertions(+)
>>>  create mode 100755 t/t1406-submodule-ref-store.sh
>>>
>>> diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
>>> new file mode 100755
>>> index 000000000..3b30ba62f
>>> --- /dev/null
>>> +++ b/t/t1406-submodule-ref-store.sh
>>> [...]
>>
>> I haven't actually read this far in the patch series, but I noticed that
>> a test in this file fails:
>>
>>
>> t1406-submodule-ref-store.sh                     (Wstat: 256 Tests: 15
>> Failed: 1)
>>   Failed test:  10
>>   Non-zero exit status: 1
>>
>> I didn't have time to look into it more; let me know if you can't
>> reproduce it.
> 
> Fantastic. No I couldn't reproduce it, even --valgrind did not
> complain. First step maybe just pushing your branch somewhere so I can
> try out if you're applying the patches via mail (maybe there's some
> changes in the base that affect this). .Otherwise /t1406-* -v -i might
> be enough clue for me to dig in, I hope.

I'm testing c5302654930070135eec9bc1b4ef99b14e0f28ee from Junio's GitHub
fork.

Unfortunately, the test succeeds (every time) when I run just `t1406-*`
or with `-d` or `-i` options, but fails (every time) when run as part of
the whole test suite, so it's a bit tricky to dig deeper.

By trial and error, I found that the test succeeds if I comment out the
"for_each_reflog()" test. By having that test write its results to
`/tmp` where they won't be deleted, I found that the problem is that the
`actual` results are not sorted correctly:

    refs/heads/new-master 0x0
    refs/heads/master 0x0
    HEAD 0x1

I don't know why it's so Heisenbergish.

Michael

