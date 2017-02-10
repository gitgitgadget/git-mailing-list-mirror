Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF1531FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 23:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbdBJXFj (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 18:05:39 -0500
Received: from mout.web.de ([212.227.17.12]:61007 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751123AbdBJXFj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 18:05:39 -0500
Received: from [192.168.178.36] ([79.197.218.233]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LudKu-1cTd7n2UhE-00znqz; Sat, 11
 Feb 2017 00:05:27 +0100
Subject: Re: What's cooking in git.git (Feb 2017, #03; Fri, 10)
To:     Junio C Hamano <gitster@pobox.com>
References: <xmqq37flk7l4.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Vegard Nossum <vegard.nossum@oracle.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <77af28f3-7a8e-fc6a-40ae-c4203d1a3a67@web.de>
Date:   Sat, 11 Feb 2017 00:05:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <xmqq37flk7l4.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:HR2XNFozpUho3GVVTz0upXkEaC6dfNVDvokdHQwkxq44k0XKLfU
 dg3qkSO++37M6VoCHnyEZQPOlwQA5vJfuC3xA+vGA83MH2xkcxfcMeh/iaP+xM3VVyYAwX9
 Eiqc+mCgfb/rM+8Hu2os/kfc6GysC/tK80ZUlc5V3zdVorucbS6zNYP1I3ROqmHmol1FfMi
 oEp7lUL2T02S45j8B3DqA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CNlpMUOFgJA=:kQYOrp8gFFGrWjkK8BTrBW
 S+dQqtrWAIs7KYY4uyZAXU1LbCarkUOwGgjroo3BcCq7m2SfCHc0FGlX4o/uHbW0zRO7/muLO
 F2uTXnurDDgO1mWfIG0nyqhZ9kD9nIB+ncnWyIvxTYUc4Tj9FF3/rUUF46i0TgDrAL3njtCqs
 4lEC2k5LG6t1mx2SE4YmupmkzR03aa28df88eEgAdrfXWHIQpjZNm7nLHx5QVAmQ+0Ri1tWQb
 4vt1N3SQZ1Q/s7ml/4CzrHX4cqOKVSXTok9u/7Suu9iALFOXeP+96d6lIx2Wou/DYpVuB0Eud
 3zzLO8b8LvCNAnlEWiuIp4eieIEGkDgQ7OXccrBkaVNDyGY9Z0Pl9vGxL6MDgT9ljinVX3jsI
 G8h7gmncOrQ/SWJRvfJs/j3NjkVJOtkPr+1M+NmaQH73bCKr8S3/C73QzLgxpXrsfx9NXTTuN
 +DSwK/23JgUCOQIvWct6qyRWiXuml9UJnXp3gC5pJQOnOF6Yoa8EC8LQCko/63CncketSWBXs
 QEiy4qXbAfOAZ8jJmDs9BzxWmYKWSRCmpH+I5KuPpYE1sXSpWMZjkBv2dTc+IMnrzyFbNyOl1
 iFe30COdFK63xz9VZcsmh782bJ6qakU9mu+ghu6rJRskvBptalC4AFP5ktsmRfEeK6mYHowAw
 ks9Fy5b/ufjPLXs2ClX/HVWIGo7ff6dx0ZjXVK/m+UHJPBHlXmrxzJ70LUfypM75+jdNYCNPV
 X+w6ZoeIaGWQn47bv5nHI3jstG48JgjseW21oNmoL4cQ9Mbe5Hl6nnujEPPR0mF9cWxJLdJ/p
 0srErC4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.02.2017 um 23:24 schrieb Junio C Hamano:
> * vn/xdiff-func-context (2017-01-15) 1 commit
>  - xdiff -W: relax end-of-file function detection
>
>  "git diff -W" has been taught to handle the case where a new
>  function is added at the end of the file better.
>
>  Will hold.
>  Discussion on an follow-up change to go back from the line that
>  matches the funcline to show comments before the function
>  definition has not resulted in an actionable conclusion.

This one is a bug fix and can be merged already IMHO.


I have raw patches for showing comments before functions with -W, but 
they don't handle the case of a change being within such a comment. 
We'd want to show the trailing function which it is referring to in such 
a case, right?

And that's a bit tricky because it requires a more complicated model: 
Currently we distinguish only between function lines and the rest, while 
the new way would require identifying leading comment lines and probably 
also trailing function body lines in addition to that, and neither can 
be classified simply by looking at the line in question -- their type 
depends on that of neighboring lines.

René
