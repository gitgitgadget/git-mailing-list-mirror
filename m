Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5B631F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 20:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752175AbdCBUEb (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 15:04:31 -0500
Received: from mout.web.de ([212.227.15.3]:64802 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752148AbdCBUE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 15:04:28 -0500
Received: from [192.168.178.36] ([79.213.126.222]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MMmwZ-1cepik41Lb-008byV; Thu, 02
 Mar 2017 21:04:14 +0100
Subject: Re: git status --> Out of memory, realloc failed
To:     Carsten Fuchs <carsten.fuchs@cafu.de>
References: <84c02ca1-269e-2f26-c625-476d7f087f5c@cafu.de>
 <ea0722e2-c2bd-bd80-a233-50676efcafda@web.de>
 <cbd281fc-3a4b-b4dc-5dff-145c97cd68d6@cafu.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org
Message-ID: <6ba86c1a-87a9-f886-273b-7f94c30c4a95@web.de>
Date:   Thu, 2 Mar 2017 21:04:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <cbd281fc-3a4b-b4dc-5dff-145c97cd68d6@cafu.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:vDY61DcljrVv2n8ontv0As+7PS8kz4XoEqOjHQNeoEl30PKQ+ZI
 odX92RqtRWNYCEVxqYzNRPyP4wbx2JW0ADXa/3nCrhsqwmevL35B02Y6lng9Aitj6mQIlE0
 OW2CsO+3+eRTKytLV0QEAZa79xUBUN6AMCRJKI4r2KDF9k8wFwXoIWA4GZRHOWNpCf7jTsM
 oHYf1nqyIW7Kgid9ljaRQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZVMJXBVeWYc=:EAMl2iyC6Pna+gfQiTkXUj
 5Bo9YVn1qL074gT7Xc30DHfyo3mHFZss+K+55jgH5iUMnEg1byRUSc6qe2h8q7k2Q7QiPLMWv
 Et3/pcf6biMw+N3kgVJB5CVVOc/uFKYi019ir6klB2zSytKtlxO3Zc7C7ONI7WjiIOELzM2E6
 algYKgRFGQKKS/fp8mxE/t4wfd7HKZbf4GdEO1xgfA4IwTB3IVJrWWgAsvGOKQJrEELaEeuRj
 slisTfwS2aZa68RLh425iZPHJRzPZLnFCulp+RauCuL+4RaRz88AJNAiBQHN7Bebl6qAmnBzQ
 0CGG0vRcQB2P7OPKhVQZ/r8wKyul7hcQ0ncSe7DZZiC6azGL2A/wNzEPhBPWSUKhOGRmpGOFy
 UOewrXMqeB5Zazts85XDxAV6Q3kfjtrz4zfP4s67FgLjXKKGA7YWzq0TRtEU85fj8fJLDPlkc
 eo/2B1pZOK7HisAcdQti5X2tEawagIlrIQLbiGMXFTS4NMRUOlKZldsWJ5NZ6fZ0n504tldRX
 0hgaP68yq1Rse6p+GDxwM2RtgECgBuFxo8Vf2q+V/TBcuGgK6W/GoqOHDNsN56J/H8LMfF9qf
 n62vfXmKfVxvFdlK6SxkGl0e4rCPQjpS1RUj/z60N+xmtUMVcIem2wIwMD4f8sH4gfGxNOa9q
 JFh9aebNKVdiEzs2uDzF6xQ7eKxbGaU3xxNvHqlAgvjC1/uJXHOXAZbQN0DdbMfGP9iBictnU
 DiISP9shfS80CuVh8b0sdVAXZISL6sLNelrCOqPp2ZSPXy9SCJg6kg94GkVGDlxFZfkNYVp1+
 wF5rrkF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.03.2017 um 21:12 schrieb Carsten Fuchs:
> Hi René,
>
> Am 01.03.2017 um 11:02 schrieb René Scharfe:
>>> I use Git at a web hosting service, where my user account has a memory
>>> limit of 768 MB:
>>>
>>> (uiserver):p7715773:~$ uname -a
>>> Linux infongp-de15 3.14.0-ui16322-uiabi1-infong-amd64 #1 SMP Debian
>>> 3.14.79-2~ui80+4 (2016-11-17) x86_64 GNU/Linux
>>
>> What's the output of "ulimit -a"?
>
> (uiserver):p7715773:~$ ulimit -a
> core file size          (blocks, -c) 0
> data seg size           (kbytes, -d) unlimited
> scheduling priority             (-e) 1
> file size               (blocks, -f) unlimited
> pending signals                 (-i) 16382
> max locked memory       (kbytes, -l) 64
> max memory size         (kbytes, -m) unlimited
> open files                      (-n) 512
> pipe size            (512 bytes, -p) 8
> POSIX message queues     (bytes, -q) 819200
> real-time priority              (-r) 0
> stack size              (kbytes, -s) 8192
> cpu time               (seconds, -t) 1800
> max user processes              (-u) 42
> virtual memory          (kbytes, -v) 786432
> file locks                      (-x) unlimited

When I use ulimit -v with lower and lower numbers I can provoke mmap 
failures on bigger pack files, but not the realloc failures that you're 
seeing.  And your packs should be only up to 20MB anyway (you can check 
that with "ls -l .git/objects/pack/*.pack").

>>> The repository is tracking about 19000 files which together take 260 MB.
>>> The git server version is 2.7.4.1.g5468f9e (Bitbucket)
>>
>> Is your repository publicly accessible?
>
> Unfortunately, no. There are no big secrets in there, but just a couple
> of database details so that I cannot make it universally available. I
> can gladly give you access though. (E.g. by adding your public SSH key?)

I'd rather not look at semi-confidential data, and you probably 
shouldn't hand it to a stranger on the internet anyway. ;)

So a shot in the dark: Do you have a lot of untracked files?  You could 
check by cloning your repository locally (which copies only tracked 
contents).  Does "git status" work on the clone?

Another one, darker yet: Does "git config core.preloadIndex 0" help?

René
