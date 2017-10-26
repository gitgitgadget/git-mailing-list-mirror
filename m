Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2512F1FAED
	for <e@80x24.org>; Thu, 26 Oct 2017 08:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751251AbdJZIsF (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 04:48:05 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:54824 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751027AbdJZIsC (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2017 04:48:02 -0400
X-AuditID: 1207440e-bf9ff70000007085-73-59f1a13f19b6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id AF.01.28805.041A1F95; Thu, 26 Oct 2017 04:48:00 -0400 (EDT)
Received: from [192.168.69.190] (p57BCCA47.dip0.t-ipconnect.de [87.188.202.71])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v9Q8luZp031708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 26 Oct 2017 04:47:58 -0400
Subject: Re: [PATCH] t0000: check whether the shell supports the "local"
 keyword
To:     Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>
References: <6ecab31e7ed05f5e79ecd454b133a2bfa6ac9ab7.1509005669.git.mhagger@alum.mit.edu>
 <CAPig+cTv4YW0m0PLH+UucEHjgQkbCsOunPrkKVDrPQXNkd=GAg@mail.gmail.com>
 <CA+P7+xoCKTaG9kV2T9YUHvagHVzD6v7A=neLzF3Qj1q8Fi0u-w@mail.gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <9a900b29-0974-9ec8-d15b-73c22c197327@alum.mit.edu>
Date:   Thu, 26 Oct 2017 10:47:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CA+P7+xoCKTaG9kV2T9YUHvagHVzD6v7A=neLzF3Qj1q8Fi0u-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsUixO6iqOu48GOkwY42JouuK91MFg29V5gt
        di/uZ7b40dLDbHHmTSOjA6vHzll32T2e9e5h9Lh4Sdlj8QMvj8+b5AJYo7hsUlJzMstSi/Tt
        ErgyXj/ZwliwQ6Di1qfdbA2MzbxdjJwcEgImEhPmPGcFsYUEdjBJPP8p3sXIBWSfZ5JY/ug2
        C0hCWCBIYsriLkYQW0QgWuLljilgDcwCWRLv/8xnhGh4wSix+8RTsCI2AV2JRT3NTCA2r4C9
        xO8989lAbBYBVYm1q6YBNXNwiApESGzYyA9RIihxcuYTsF2cAoES99s3sEPMV5f4M+8SM4Qt
        LnHryXwmCFteYvvbOcwTGAVmIWmfhaRlFpKWWUhaFjCyrGKUS8wpzdXNTczMKU5N1i1OTszL
        Sy3SNdbLzSzRS00p3cQICXu+HYzt62UOMQpwMCrx8H74+CFSiDWxrLgy9xCjJAeTkigvwx6g
        EF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHeOzM+RgrxpiRWVqUW5cOkpDlYlMR51Zao+wkJpCeW
        pGanphakFsFkZTg4lCR4ZRcANQoWpaanVqRl5pQgpJk4OEGG8wAN3zAfZHhxQWJucWY6RP4U
        oy7Hs5mvG5iFWPLy81KlxHlngRQJgBRllObBzYGlq1eM4kBvCfM6gKzjAaY6uEmvgJYwAS1p
        Uv0AsqQkESEl1cAYNe9HVmmsoXPpjv16mY8cTofPUjt764envxvXvTUhc7kTT514PMksavGG
        nyqqMnV9ipb88wKLLtY4rIsW+CRs3c9Y3tjfvklP4MtlM0FFu72vJbN6dtsdFkmRLb4dG/h1
        vWDw3Z+fudV92l1fLU42OBUnoW81rf3a9xiPrK6qJWJL4rY//q7EUpyRaKjFXFScCADcMj3l
        MgMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/26/2017 10:40 AM, Jacob Keller wrote:
> On Thu, Oct 26, 2017 at 1:28 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Thu, Oct 26, 2017 at 4:18 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>> Add a test balloon to see if we get complaints from anybody who is
>>> using a shell that doesn't support the "local" keyword. If so, this
>>> test can be reverted. If not, we might want to consider using "local"
>>> in shell code throughout the git code base.
>>
>> I would guess that the number of people who actually run the Git test
>> suite is microscopic compared to the number of people who use Git
>> itself. It is not clear, therefore, that lack of reports of failure of
>> the new test would imply that "local" can safely be used throughout
>> the Git code base. At best, it might indicate that "local" can be used
>> in the tests.
>>
>> Or, am I missing something?
>>
> 
> I don't think you're missing anything. I think the idea here is: "do
> any users who actively run the test suite care if we start using
> local". I don't think the goal is to allow use of local in non-test
> suite code. At least, that's not how I interpreted it.
> 
> Thus it's fine to be only as part of a test and see if anyone
> complains, since the only people affected would be those which
> actually run the test suite...
> 
> Changing our requirement for regular shell scripts we ship seems a lot
> trickier to gauge.

Actually, I would hope that if this experiment is successful that we can
use "local" in production code, too.

The proper question isn't "what fraction of Git users run the test
suite?", because I agree with Eric that that is microscopic. The correct
question is "on what fraction of platforms where Git will be run has the
test suite been run by *somebody*?", and I think (I hope!) that that
fraction is quite high.

Really...if you are compiling Git on a platform that is so deviant or
archaic that it doesn't have a reasonable Shell, and you don't even
bother running the test suite, you kindof deserve your fate, don't you?

Michael
