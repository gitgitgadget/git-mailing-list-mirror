Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A5CD21841
	for <e@80x24.org>; Mon, 30 Apr 2018 08:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751729AbeD3I4A (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 04:56:00 -0400
Received: from mout.web.de ([212.227.15.4]:57959 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751234AbeD3I4A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 04:56:00 -0400
Received: from [192.168.209.20] ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Mbhiv-1euaPW2POX-00J0Ft; Mon, 30
 Apr 2018 10:55:55 +0200
Subject: Re: [PATCH v1 1/1] test: Correct detection of UTF8_NFD_TO_NFC for
 APFS
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, newren@gmail.com
References: <CABPp-BHitvta8we8di-tFiNdVV7vXnMNAhiAs2=CrQc-gGuSJw@mail.gmail.com>
 <20180430063519.27122-1-tboegi@web.de>
 <xmqqvac9xh4d.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <255708be-3cf2-0285-b5e7-4fbc9e0e8ddd@web.de>
Date:   Mon, 30 Apr 2018 10:55:50 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqvac9xh4d.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jwofcngA0PReGWjzf+ivf7PHKumrWaXgaQLe9iEmmqUEmL+oJA7
 hVd++GWYvV5ntrkGpuyPRW6YBAUYJbhU9pTmgRUOe2QKjl6jIVs5tpQWEXBo4eI03lF6FhJ
 MGqqqNnZStk50m2lSC5NU/req5dCU+rudY9imX4UELn+9RMiJMIVdm7oeiveMpIR5X+/ZJg
 00H+tnECOiEMTtBsM6lJw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oHuUfU9QoCg=:iBE5Fbvrv739bGLg+Hoxlq
 owK3/YEZysgGdtfDMxrEbb246B8JATgx6lhMlqrjUU2K1AJJR91aL+K9sR/KC2RKc4l4f3pE+
 hLZG5vUVmG7w+6DfrI5YUVg+n6gVTPj88e4Jfp5ynKlAcECuYT2vbPUZkpH3L5BvV41ZjnGlq
 f7snNrSnR7jy++lZdGdRO9pxZxmsD5Wi9ciDdWuUa5qvG6Swvjr4nuItC00rqHZL5WwHY677f
 La14GiXCSz8LGYsQhg7zzwInkU3pMxtT2EF61Cj+Nesb6IUzGlRF0et2NXN+wFPCS7nN9+82D
 2pH/hO37WF+PVStuTCaBt5C++LHMN8k0Wr9mzecao2EY95QYflELiXmuE1ZotApuwAV5YAcHF
 czxMfQ5lonyAAmJjqau/KQ0g3SgQC0decJaLLEs9YbhJYYbFiByC30RWd9f26qsMAD3G04XsC
 fc8rfzQcDjc+UjODvPUFdLZhRMPgDpSOlQV7Z0TfflrQN8tBe0/6Enz8VNRjUcBXj2BfIzyx/
 GrQIWWbLJfC3DV8fqygx01e4ojIuApQ2LPdVHnZ6bIk2EJc9OlgRS6txz8RgE/C22BNbiIMlU
 e8Eeh5mwEK3My9+2Hlqzx0jEzcyqhyvVqJzB81bECpAk1CK3dJN2qCt4SU9rlmTt8fXToCvkx
 UR2Hdw19nBeY1qssh1ctyjSgE7laUh/nbBR9j0YGGPNSzMvioLzIH+3iQxA0rIzLKUOAOJ5Vk
 NeOzVBI9O4QOAlzbBi9pm72utoRYBbYHbhnaLmdNHwPs1v8rXXCHr4LHP1My0RAzTHPXWGW8+
 xvtnMS6Xq4hSAn8J4HJ76udtv9kW9+05dwXpCj5VYgmaqMVXw0f4DOT3csojjsPPEFgimFz0H
 NSMKCpm8TBRGPiFrqaOQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30.04.18 09:56, Junio C Hamano wrote:
> tboegi@web.de writes:
> 
>> From: Torsten Bögershausen <tboegi@web.de>
>>
>> On HFS (which is the default Mac filesystem prior to High Sierra),
>> unicode names are "decomposed" before recording.
>> On APFS, which appears to be the new default filesystem in Mac OS High
>> Sierra, filenames are recorded as specified by the user.
>>
>> APFS continues to allow the user to access it via any name
>> that normalizes to the same thing.
>>
>> This difference causes t0050-filesystem.sh to fail two tests.
>>
>> Improve the test for a NFD/NFC in test-lib.sh:
>> Test if the same file can be reached in pre- and decomposed unicode.
>>
>> Reported-By: Elijah Newren <newren@gmail.com>
>> Signed-off-by: Torsten Bögershausen <tboegi@web.de>
>> ---
>>  t/test-lib.sh | 7 +------
>>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> Thanks.  
> 
> Wouldn't it logically make more sense to check for the target being
> an existing file with "-f"?  It is not an essential part of the test
> for the target to be "readable", but "can be stat(2)ed with the
> other UTF-8 representation" is.

That make sense.
Would you like to amend the patch ?


