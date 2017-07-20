Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 540251F600
	for <e@80x24.org>; Thu, 20 Jul 2017 20:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934949AbdGTUdM (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 16:33:12 -0400
Received: from mout.web.de ([212.227.15.3]:51651 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933966AbdGTUdK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 16:33:10 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MVGow-1d7RIb3Cco-00YhLu; Thu, 20
 Jul 2017 22:32:59 +0200
Subject: Re: Fwd: New Defects reported by Coverity Scan for git
To:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <596ddaa620821_77f83e7330107c4@ss1435.mail>
 <CAGZ79kaPFDMn2K0f529-Crzv+vhU3XUMsSM6w3QV4RXKBv5s_g@mail.gmail.com>
 <xmqqa841fylf.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <0110b370-a515-df44-8d46-9a72ac336ee7@web.de>
Date:   Thu, 20 Jul 2017 22:32:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqa841fylf.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:2xwywaVrgPDPDvA60Qr8Jgcxt+DtTxawortDj6TVdbOM1K0+xEZ
 HPwRzUOzc0+GJBLlxXTUKnkX1EATcWKvgf7OKd/k8IDb3iPpYCMM0UpdpxaSSwMfDtixrZa
 uGFSqZ7bH53CWfxFVI1bzRyBn7johjjedX6igkTw2j+k3GZTmKh7ewONjx01EF3Abj2IwAO
 vX6J6owc9dZ8zM9by5Sng==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fDcBKo6L6zo=:sEGpw1Z78n0Y2leu/riRoJ
 jAoZJUMpLc8DFKO8OwRvWRXTJUc+D+ecK9U2v15N7AGw0F/4XhHt8NLiJ6lVZS7FAkkLkxWet
 +Y7xbjroW1gdo6vaiGehuodsyFZCzrg32Ibyp+DWVqo25vhURAfLnvUE1/IrjnCeq2ZjwXXhk
 vVk10P50S3KVW8if0aoaIb6ERwLWQ0ZoHl+gsM/XIrRfrC5u0XUxMN7O9aKMxZmlvTpfkei/o
 1LrhJY5Il0oo8TPWnDT4haKk05YCL2pJ3LRuwbIj4pLWgvH+wZzWKkhr08qJ2qlbVFfipVV1l
 J+iMvJGA1b6T6zDKc4Cih5jZQyHNdcCa2jnhlKdNCKkTe7r3csuiOzIPQ1+HArUOXF8UDU6Sy
 v4G2JVY2hMCacogex66eecQZ7oJlrw4uA3Z4gEqgSYDKpByHvVUedjl2uK161qf9earLlxZwU
 UW9AmnFyhqFJ1CnTuThTAGf419tAcSQ47mzJFp/0u+6u67EeWJzxw15tbhcuPO5v/2WEbsRUI
 8hUBzNglNZFeigMXxbD2OJ7im/pYwkZ2mn635lG3kwHn12Oyck+KkIzFCMXbHKiSiGK4r1mPA
 AYDo/JUVEScGu782//QtpZKx22AhIZb88R+rsc625QNzO5CGNqRGVPzlA603+kOK4/47ND8Dl
 Qk4OioZ/oCPiKeOKG3i1UK+BjXqfa2XW6oj1OKfs3Tg3W39nWPT5948uGI4cj2YFrwL0WoWpK
 dQcGbZDFuOzbGrW9pavn1bGdailTvbDXBWbRmvZMcMgYBJWR6peKIdrGNdU2Oig9s6EikFKzp
 oM8HNLmEboet9iD99MO9I6Zs0sYfeNZ9HTDfU7O5yoyI0h07LE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.07.2017 um 19:23 schrieb Junio C Hamano:
> Stefan Beller <sbeller@google.com> writes:
> 
>> I looked at this report for a while. My current understanding:
>> * its detection was triggered by including rs/move-array,
>>    f331ab9d4c (use MOVE_ARRAY, 2017-07-15)
>> * But it is harmless, because the scan logic does not understand
>>    how ALLOC_GROW works. It assumes that
>>    done_pbase_paths_alloc can be larger
>>    than done_pbase_paths_num + 1, while done_pbase_paths
>>    is NULL, such that the memory allocation is not triggered.
>>    If that were the case, then we have 2 subsequent dereferences
>>    of a NULL pointer right after that. But by inspecting the use
>>    of _alloc and _num the initial assumption does not seem possible.
> 
> Yes, it does appear that way.  ALLOC_GROW() calls REALLOC_ARRAY()
> which safely can realloc NULL to specified size via xrealloc().

MOVE_ARRAY is passing its pointer arguments to memmove(); all it adds
is a check for (done_pbase_paths_num - pos - 1) being zero.  I don't
understand how that change can make it more likely for one of the
pointers to be NULL.

I guess the first message ('Comparing "done_pbase_paths" to null
implies that "done_pbase_paths" might be null.') has to be understood
as an explanation of how the checker arrived at the second one?

We could remove that NULL check -- it's effectively just a shortcut.
But how would that improve safety?  Well, if the array is unallocated
(NULL) and _num is greater than zero we'd get a segfault without it,
and thus would notice it.  That check currently papers over such a
hypothetical bug.  Makes sense?

-- >8 --
Subject: [PATCH] pack-objects: remove unnecessary NULL check

If done_pbase_paths is NULL then done_pbase_paths_num must be zero and
done_pbase_path_pos() returns -1 without accessing the array, so the
check is not necessary.

If the invariant was violated then the check would make sure we keep
on going and allocate the necessary amount of memory in the next
ALLOC_GROW call.  That sounds nice, but all array entries except for
one would contain garbage data.

If the invariant was violated without the check we'd get a segfault in
done_pbase_path_pos(), i.e. an observable crash, alerting us of the
presence of a bug.

Currently there is no such bug: Only the functions check_pbase_path()
and cleanup_preferred_base() change pointer and counter, and both make
sure to keep them in sync.  Get rid of the check anyway to allow us to
see if later changes introduce such a defect, and to simplify the code.

Detected by Coverity Scan.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/pack-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e730b415bf..c753e9237a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1289,7 +1289,7 @@ static int done_pbase_path_pos(unsigned hash)
 
 static int check_pbase_path(unsigned hash)
 {
-	int pos = (!done_pbase_paths) ? -1 : done_pbase_path_pos(hash);
+	int pos = done_pbase_path_pos(hash);
 	if (0 <= pos)
 		return 1;
 	pos = -pos - 1;
-- 
2.13.3
