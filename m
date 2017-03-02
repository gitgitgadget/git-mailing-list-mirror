Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D44620133
	for <e@80x24.org>; Thu,  2 Mar 2017 08:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753967AbdCBIRg (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 03:17:36 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:45784 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750733AbdCBIRf (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 2 Mar 2017 03:17:35 -0500
X-AuditID: 12074413-f67ff700000077e1-f4-58b7d4f1b5ef
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id F2.88.30689.1F4D7B85; Thu,  2 Mar 2017 03:16:50 -0500 (EST)
Received: from [192.168.69.190] (p57907E03.dip0.t-ipconnect.de [87.144.126.3])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v228GjMu006011
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 2 Mar 2017 03:16:46 -0500
Subject: Re: [PATCH v5 24/24] t1406: new tests for submodule ref store
To:     Duy Nguyen <pclouds@gmail.com>
References: <20170218133303.3682-1-pclouds@gmail.com>
 <20170222140450.30886-1-pclouds@gmail.com>
 <20170222140450.30886-25-pclouds@gmail.com>
 <7e5ef9e7-bd90-1917-d8eb-c6310c2744ab@alum.mit.edu>
 <CACsJy8BOY8jsCrDYESJ6Gwy_p=J=c8m1qe64w18HX1Cv2AaYnA@mail.gmail.com>
 <8f4ec174-9060-0896-5135-bb50229fe149@alum.mit.edu>
 <CACsJy8DyjWC5WUE7=dWK-mi_piGZJf7L1B0t5RUROvqDS+aP5g@mail.gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <51f2ba5a-38c9-17eb-e845-3a84b65c7029@alum.mit.edu>
Date:   Thu, 2 Mar 2017 09:16:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8DyjWC5WUE7=dWK-mi_piGZJf7L1B0t5RUROvqDS+aP5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42IRYndR1P10ZXuEwZr/ShZdV7qZLBp6rzBb
        9C/vYrNY8vA1s0X3lLeMFjOvWlts3tzO4sDusXPWXXaPDx/jPBZsKvXoaj/C5nHxkrLH/qXb
        2Dw+b5ILYI/isklJzcksSy3St0vgytj/J7egi7Oie3VhA+Ns9i5GTg4JAROJex2v2EBsIYEd
        TBLLtgR0MXIB2WeZJHaseMsIkhAWcJPYue8dE4gtIqAk8aZjGzNEURezRGdvExuIwywwi0ni
        4t5FYKPYBHQlFvU0g3XwCthLvO48B2azCKhI/D5wAMwWFQiRmLPwASNEjaDEyZlPWEBsToFA
        iTMdnWBzmAXUJf7Mu8QMYctLbH87h3kCI/8sJC2zkJTNQlK2gJF5FaNcYk5prm5uYmZOcWqy
        bnFyYl5eapGuuV5uZoleakrpJkZIqAvvYNx1Uu4QowAHoxIP7wGm7RFCrIllxZW5hxglOZiU
        RHmnHAQK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuGVPAKU401JrKxKLcqHSUlzsCiJ86otUfcT
        EkhPLEnNTk0tSC2CycpwcChJ8N69DNQoWJSanlqRlplTgpBm4uAEGc4DNFzgCsjw4oLE3OLM
        dIj8KUZFKXHefJBmAZBERmkeXC8sFb1iFAd6RZj3JEgVDzCNwXW/AhrMBDT4hcpWkMEliQgp
        qQbGaaHHJyW9jamav3auDMvGBxVeTtO6NyrOy37XvNpbYcI8xm0H/xifCzLzmC3bpzv1afOu
        Kd/XF8/n3bksW+TiacdfeXHrDu/rbOpO1rMvrvgg93zn1mbBUzOf3DfLuXJp9/8vv7KOpukz
        /eDRuzj5wWW2Rw9VFv1v57XO/9T33lbt/5pFjtyhQkosxRmJhlrMRcWJADUiDOMgAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/02/2017 07:13 AM, Duy Nguyen wrote:
> On Wed, Mar 1, 2017 at 10:11 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> By trial and error, I found that the test succeeds if I comment out the
>> "for_each_reflog()" test. By having that test write its results to
>> `/tmp` where they won't be deleted, I found that the problem is that the
>> `actual` results are not sorted correctly:
>>
>>     refs/heads/new-master 0x0
>>     refs/heads/master 0x0
>>     HEAD 0x1
>>
>> I don't know why it's so Heisenbergish.
> 
> It happens consistently on my other laptop. And yes it looks like
> sorting order problem, probably because of the underlying file system.
> I did wonder about that at some point but never asked. We do not
> guarantee any sorting order in the for-each api, do we?

The for-each-ref iteration is defined to be sorted by refname, but it's
true that the for-each-reflog order is undefined. So it was wrong for me
to say that the results are not sorted correctly. The problem is that
the actual output is ordered differently than the "expected" results,
which the test incorrectly considers to be an error.

Michael

