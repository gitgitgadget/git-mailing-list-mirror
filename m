Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98E6F1F859
	for <e@80x24.org>; Fri, 26 Aug 2016 00:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756626AbcHZAJJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 20:09:09 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:48782 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755472AbcHZAJI (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 25 Aug 2016 20:09:08 -0400
X-AuditID: 1207440f-e2bff70000000955-da-57bf8815481f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 4D.09.02389.5188FB75; Thu, 25 Aug 2016 20:06:46 -0400 (EDT)
Received: from [192.168.69.190] (p57907590.dip0.t-ipconnect.de [87.144.117.144])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u7Q06huQ024134
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 25 Aug 2016 20:06:44 -0400
Subject: Re: on Amazon EFS (NFS): "Reference directory conflict: refs/heads/"
 with status code 128
To:     Alex Nauda <alex@alexnauda.com>
References: <CAMQLHmAraXPL=8SmMG4X_424FAzx4q2Byk8pva5wEOg7vNSqLw@mail.gmail.com>
 <20160824213900.gcnwxu46zvgpjr5a@sigill.intra.peff.net>
 <67cde0aa-89fc-b574-d5f5-7e754d77b5bb@alum.mit.edu>
 <CAMQLHmA=b0HMO9s0nt3VTdOYe51oE3UrrrCDH3Z_Tq0Nuhe-kQ@mail.gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <1d783e10-c1ce-4f17-4a54-8798b16697b2@alum.mit.edu>
Date:   Fri, 26 Aug 2016 02:06:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAMQLHmA=b0HMO9s0nt3VTdOYe51oE3UrrrCDH3Z_Tq0Nuhe-kQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsUixO6iqCvWsT/cYM8LTos796cxW3Rd6Way
        +NHSw+zA7PGn8SGTx7PePYwenzfJBTBHcdmkpOZklqUW6dslcGVsebeVpWCffkVL9xf2BsYj
        ql2MHBwSAiYSc265dTFycQgJbGWU2H9iJyOEc4FJYv+5RSxdjJwcwgIpElff/GMDaRARUJa4
        ea0KoqadSWLLnN+sIDXMAkYSd2ZuYAKx2QR0JRb1NDOB1PMK2EssPpsHEmYRUJXYPvsJG4gt
        KhAi0b5sPVg5r4CgxMmZT8BWcQoESuxsWwE1Ul3iz7xLzBC2vMT2t3OYJzDyz0LSMgtJ2Swk
        ZQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zro5WaW6KWmlG5ihAQo/w7GrvUyhxgFOBiV
        eHhnsO4PF2JNLCuuzD3EKMnBpCTK2+EBFOJLyk+pzEgszogvKs1JLT7EKMHBrCTCq1gPlONN
        SaysSi3Kh0lJc7AoifOqL1H3ExJITyxJzU5NLUgtgslqcHAIXDl4ZDajFEtefl6qkgRvQhvQ
        EMGi1PTUirTMnBKEUiYOTpBFPECLPFpBFhUXJOYWZ6ZD5E8xKkqJ80aBJARAEhmleXC9sMTy
        ilEc6C1h3h8gK3iASQmu+xXQYCagwS33d4MMLklESEk1MDIt7j/ww/Lb3xlbAp7uMFm48wBL
        wp5F3nNmbVt5eO9iEU9Ozj/nd6k1r1S7Wvx65jNl7n23/3GX7VjLE9z4WlG0fu5E1pTW6Otz
        Fn2Z3ces01Kyf4twxu7z+iKSbmzunkdFTHfbTfgk/yDlnWLh0o/CAcaljPq7pHs8501dxiRe
        XO4/ffqe5beUWIozEg21mIuKEwEN+oYSBwMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/25/2016 06:01 PM, Alex Nauda wrote:
> On Thu, Aug 25, 2016 at 2:28 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> On 08/24/2016 11:39 PM, Jeff King wrote:
>>> On Wed, Aug 24, 2016 at 04:52:33PM -0400, Alex Nauda wrote:
>>>
>>>> Elastic File System (EFS) is Amazon's scalable filesystem product that
>>>> is exposed to the OS as an NFS mount. We're using EFS to host the
>>>> filesystem used by a Jenkins CI server. Sometimes when Jenkins tries
>>>> to git fetch, we get this error:
>>>> $ git -c core.askpass=true fetch --tags --progress
>>>> git@github.com:mediasilo/dodo.git
>>>> +refs/pull/*:refs/remotes/origin/pr/*
>>>> fatal: Reference directory conflict: refs/heads/
>>>> $ echo $? 128
>>>>
>>>> Has anyone seen anything like this before? Any tips on how to troubleshoot it?
>>>
>>> No, I haven't seen it before. That's an internal assertion in the refs
>>> code that shouldn't ever happen. It looks like it happens when the loose
>>> refs end up with duplicate directory entries. While a bug in git is an
>>> obvious culprit, I wonder if it's possible that your filesystem might
>>> expose the same name twice in one set of readdir() results.
>>>
>>> +cc Michael, who added this assertion long ago (and since this is the
>>> first report in all these years, it does make me suspect that the
>>> filesystem is a critical part of reproducing).
>>
>> Thanks for the CC.
>>
>> I've never heard of this problem before.
>>
>> What Git version are you using?
> Git client 2.7.4 against GitHub (Git 2.6.5)
> 
>>
>> I tried to provoke the problem by hand-corrupting the packed-refs file,
>> but wasn't successful.
>>
>> So Peff's suggestion that the problem originates in your filesystem
>> seems to be to be the most likely cause. A quick Google search found,
>> for example,
>>
>>     https://bugzilla.redhat.com/show_bug.cgi?id=739222
>>
>> http://superuser.com/questions/640419/how-can-i-have-two-files-with-the-same-name-in-a-directory-when-mounted-with-nfs
>>
>> though these reports seem connected with having lots of files in the
>> directory, which seems unlikely for `$GIT_DIR/refs/`. But I didn't do a
>> more careful search, and it is easily possible that there are other bugs
>> in NFS (or EFS) that could be affecting you.
>>
>> If this were repeatable, you could run Git under strace to test Peff's
>> hypothesis. But I suppose it only happens rarely, right?
> Actually it seems to be reproducible. Here's the last portion of an strace:
> 
> [...]
> stat(".git/refs/remotes/origin/pr/7/head", {st_mode=S_IFREG|0644,
> st_size=41, ...}) = 0
> lstat(".git/refs/remotes/origin/pr/7/head", {st_mode=S_IFREG|0644,
> st_size=41, ...}) = 0
> open(".git/refs/remotes/origin/pr/7/head", O_RDONLY) = 4
> read(4, "5d82811a248900efd8e201c6d9232de5"..., 256) = 41
> read(4, "", 215)                        = 0
> close(4)                                = 0
> getdents(3, /* 0 entries */, 32768)     = 0
> close(3)                                = 0
> open(".git/refs/remotes/origin/pr/16/",
> O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = 3
> fstat(3, {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
> getdents(3, /* 3 entries */, 32768)     = 72
> stat(".git/refs/remotes/origin/pr/16/head", {st_mode=S_IFREG|0644,
> st_size=41, ...}) = 0
> lstat(".git/refs/remotes/origin/pr/16/head", {st_mode=S_IFREG|0644,
> st_size=41, ...}) = 0
> open(".git/refs/remotes/origin/pr/16/head", O_RDONLY) = 4
> read(4, "2886c4f3ba8c3b5c2306029f6e39498d"..., 256) = 41
> read(4, "", 215)                        = 0
> close(4)                                = 0
> getdents(3, /* 0 entries */, 32768)     = 0
> close(3)                                = 0
> open(".git/refs/tags/", O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = 3
> fstat(3, {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
> getdents(3, /* 2 entries */, 32768)     = 48
> getdents(3, /* 0 entries */, 32768)     = 0
> close(3)                                = 0
> open(".git/refs/bisect/", O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) =
> -1 ENOENT (No such file or directory)
> open(".git/packed-refs", O_RDONLY)      = -1 ENOENT (No such file or directory)
> fstat(2, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 3), ...}) = 0
> write(2, "fatal: Reference directory confl"..., 58fatal: Reference
> directory conflict: refs/remotes/origin/
> ) = 58
> exit_group(128)                         = ?
> +++ exited with 128 +++

Thanks for the additional information.

From the strace output it is clear that there is no packed-refs file at
the time of the problem, so the problem must be among the loose refs.

The error is a "Reference directory conflict", which suggests that
"refs/remotes/origin/" appears in two entries; once as a reference
directory and once as a reference. But in fact it could also mean that
"refs/remotes/origin/" appears twice, both as directories. Neither one
should happen in normal operation.

Unfortunately there is not enough strace output to see whether (in this
case) path `refs/remotes/origin` was reported twice by `getdents()`. I
think that is still the most likely hypothesis, especially since the
reports of this problem all seem to be on NFS + EBS.

One other long shot:

I see that you are fetching into refs/remotes/origin/pr/*. What is the
full refspec configuration for origin?

I know it used to be recommended to set up *two* refspecs when fetching
from GitHub:

    +refs/heads/*:refs/remotes/origin/*
    +refs/pull/*:refs/remotes/origin/pr/*

This is not such a good idea (and I think it is no longer recommended)
because, for example, a remote reference named `refs/heads/pr/5/head`
would want to end up at the same path as a remote PR branch
`refs/pull/5/head`, namely `refs/remotes/origin/pr/5/head`. That
shouldn't be allowed by Git, but since this sounds a little bit similar
to your problem I thought I'd ask anyway.

Are you using such a configuration? If so, can you reproduce the problem
with the `refs/pull/*` refspec disabled?

Michael

