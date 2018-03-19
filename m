Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B63CF1F404
	for <e@80x24.org>; Mon, 19 Mar 2018 21:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965308AbeCSVQU (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 17:16:20 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34295 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935474AbeCSVQN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 17:16:13 -0400
Received: by mail-qt0-f194.google.com with SMTP id l25so19611014qtj.1
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 14:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=spIRLrYzEAED4BtuRcZN1wqaKDfxvR1mw7SGtL5rFwM=;
        b=MGbjAwLzIqPqESvqlUFCF0lr/L5q/Lq1JNhXiWtXEo/BbAHc8jKzg0dqLocG46ne41
         FuBO3y0xzedS8TKvRUWMwtEO25utovpMg+OxowrNo/XVCyCV3ukMF16By9v0Sh8n//O0
         ozr6uYcoA94xLi7TomxtjzByMRry1FFLpDMHSMSj/09Znr/kOxgOto/xQ84JRnH2TYuX
         4tHMrZYcN0wbtGn9nDnh6JIG3tbhY8vkNQ45CtuYvLFiX4NJA2oVErCFOUA3TbNGXP1i
         66iF8TQCu6Q92dDZ/wyke5CD0J6iwEK8Bfz2P28HO6oq8KI8EgtEFK+gB0XVMTcrO925
         tkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=spIRLrYzEAED4BtuRcZN1wqaKDfxvR1mw7SGtL5rFwM=;
        b=UOgEnkXRwIsX3TwdANkD/P6v54ZnmIgPJE66qJdm5yOkRLisx/plRHUCmbZE5lkNR5
         JLvmt8ZnLSHDctyx6nh9IyokJcp99jVe4Ls8siUlRJn10cmCag+jmhkyVo7qlxc3fmoW
         T95oeJDPB0x4Nv4ZPJvg8IWlnvfQgDwfJ/NjZKYEuwnJhHt5Om7LH8aagc2hA1e1GM3p
         noXaJ2bsEQ4TT/jH0y9+/nXy80KCv3rUlHBiLiqBTCpeOofEFW5aHEVtnIkDA5Zf+SjU
         gaDG6dWKiDnxTGDGZbZ2yiiaGNyD5pdaoTVigz9xF40BOdzEuTJNDXf+hVByIsxPVzbF
         6QpA==
X-Gm-Message-State: AElRT7EA4L97lFsb75vMQCLlk0Scjl881mW/BEUhFTGTE82uAQUu0HsB
        go1IW+i0d0goY1TUZSnaizM=
X-Google-Smtp-Source: AG47ELsddtosAxuf8RfLPmFhdsFl+ne6ddDeOBx4l6pr+x8cynwmRsYv3BQRVv/uQ7y2w9zisWWxyA==
X-Received: by 10.200.68.15 with SMTP id j15mr20639720qtn.323.1521494171638;
        Mon, 19 Mar 2018 14:16:11 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id t82sm645504qke.52.2018.03.19.14.16.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 14:16:10 -0700 (PDT)
Subject: Re: What's cooking in git.git (Mar 2018, #03; Wed, 14)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Takuto Ikuta <tikuta@chromium.org>, git@jeffhostetler.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Ben Peart <benpeart@microsoft.com>
References: <xmqqefkm6s06.fsf@gitster-ct.c.googlers.com>
 <87r2olenw9.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <94484ca0-6331-90a7-41cb-dd44200d8d20@gmail.com>
Date:   Mon, 19 Mar 2018 17:16:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87r2olenw9.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/15/2018 4:36 AM, Ævar Arnfjörð Bjarmason wrote:
> On Thu, Mar 15 2018, Junio C. Hamano jotted:
>
>> * nd/repack-keep-pack (2018-03-07) 6 commits
>>   - SQUASH???
>>   - pack-objects: display progress in get_object_details()
>>   - pack-objects: show some progress when counting kept objects
>>   - gc --auto: exclude base pack if not enough mem to "repack -ad"
>>   - repack: add --keep-pack option
>>   - t7700: have closing quote of a test at the beginning of line
>>
>>   "git gc" in a large repository takes a lot of time as it considers
>>   to repack all objects into one pack by default.  The command has
>>   been taught to pretend as if the largest existing packfile is
>>   marked with ".keep" so that it is left untouched while objects in
>>   other packs and loose ones are repacked.
>>
>>   Expecting a reroll.
>>   cf. <CACsJy8BW_EtxQvgL=YrCXCQY7cEWCQxgfkeH=Gd=X=uVYhPJcw@mail.gmail.com>
>>   Except for final finishing touches, this looked more-or-less ready
>>   for 'next'.
>>
>>
> As I noted in 87a7vdqegi.fsf@evledraar.gmail.com and
> 877eqhq7ha.fsf@evledraar.gmail.com (both at:
> https://public-inbox.org/git/?q=87a7vdqegi.fsf%40evledraar.gmail.com) I
> think we should change the too-specific behavior here to be more generic
> (and am happy to do the work pending feedback from Duy on what he thinks
> about it).
>
> I'm also interested to know from those at Microsoft (CC'd some) if the
> mechanism I've proposed is something closer to what they could
> eventually use to gc windows.git.

Sorry that I couldn't get to this message sooner, I was traveling. While 
I was gone, the others who you CC'd volunteered me as the best person to 
respond ;)

In the interest of full disclosure and hopefully starting an interesting 
discussion, I want to share as much detail as possible as well as a few 
future directions that can inform our actions now. Here are some rough 
ideas that we are thinking about in this space:

   I. Use the multi-pack index (MIDX) [1] to track "packfile state" so 
we can do GC/repack incrementally.
  II. Replace our prefetch packs model with partial clone [2].
III. Stop including all trees and focus the fetch down a cone of the 
working directory.
  IV. Provide a way to defer certain read-only commands to a remote when 
the local repo doesn't have sufficient data.

> I know that now it doesn't GC now, and they have some side-channel
> mechanism for pre-deploying large (daily?) packs to clients, if it's
> adjusted as I suggest gc could be told not to touch packs of that size,
> leaving only stray small packs from "git pull" and loose objects to GC.
>
> I may also have entirely misunderstood how it works, this is from brief
> in-person conversations at Git Merge.
>
> But as far as mainlining some of that eventually I think it would be
> good to get feedback on whether the mechanism I proposed would get in
> their way more or less than what Duy has, or be entirely irrelevant
> because they need something else.
>
> Thanks!

The GVFS cache servers pre-compute daily packfiles filled with every 
commit and tree introduced that day. When a client calls 'git fetch' the 
GVFS hook runs a "prefetch" command to get these daily packs from the 
cache servers and place them in an alternate we call the "shared object 
cache". GVFS also disables the "receive-pack" portion of the fetch. The 
MIDX is updated to cover the new packs.

Something we are going to enable soon is the addition of "hourly packs" 
where the cache servers keep a list of up to 24 hourly packs and on 
prefetch the client receives an extra pack that concatenates that day's 
pack up to that point. We are doing this because the refs they are 
fetching are far enough ahead of the daily snapshots, which triggers a 
decent amount of loose object downloads when those refs are checked out. 
Since the next day will create a new daily pack, we can delete that 
hourly pack (I don't think we do this currently). At the very least the 
MIDX prefers the duplicates in the new packfile.

We do not GC in GVFS-enabled repos. This doesn't destroy clients' disks 
so far because the prefetch packs do not contain blobs -- blobs are a 
large portion of the full repo size. As the repo grows, we are 
re-examining how to make GC and repack work in this environment. An 
important part of any solution will be to make it incremental: we cannot 
afford to create a second copy of the repo and we can't take the repo 
offline for a significant portion of time.

I'm not sure that we can use Duy's solution out-of-the-box, in 
particular because we haven't integrated our prefetch packs with the 
"promisor" concept from partial clone. Hence, GC will fail with missing 
objects. I think the core idea is good: perform GC incrementally and 
don't touch previously-GC'd packs. Since it is rare for an object to be 
reachable for a long time and then become unreachable, performing GC and 
then keeping the resulting pack forever is a good idea. Especially when 
paired with the MIDX so you care less about the number of packfiles.

I.

One of our thoughts is to use the MIDX to mark the packfiles with 
metadata. For instance, we could mark new packfiles as "raw" and after 
enough time we could run a GC on just one packfile (or a batch of 
packfiles) to remove unreachable objects and mark it as "clean". In our 
situation, we don't want to immediately GC the daily prefetch pack 
because a large portion of those objects will be reachable in a few days 
due to branch integrations.

II.

Our long-term plan is to remove these GVFS-specific fetch patterns and 
replace them with partial clone logic. We still see the cache servers as 
an important part of this process, but they are essentially read-only 
copies of the main server object database (no refs). We haven't done the 
work to see how expensive it will be to replace the precomputed prefetch 
packs with a partial clone negotiation. Then we will need to see how to 
make the shared object cache be transparent to the user.

An aside: it would be good to investigate how Git could provide 
replication like a cache server with minimal setup, including client 
configuration. The GVFS protocol has a "gvfs/config" endpoint that can 
provide a list of cache server URLs, including a default. (For the 
Windows repo, these URLs point to load balancers that pass-through to an 
array of machines. I imagine most users will only need one server per 
location.) Does Git already have a way to redirect the call to upload-pack?

III.

Partial clone has options for filtering trees by paths [3]. We want to 
take advantage of this functionality to reduce the number of objects 
stored on disk. In a perfect world, we would use the virtualization 
layer in GVFS to auto-detect the paths that are important to the user 
and create a sparse filter for them that way. Partial clone doesn't have 
a mechanism for that right now (we require a sparse-checkout 
specification to be present on the remote) but perhaps it could be part 
of a verb in protocol v2. We are working to collect sparse-checkout 
files from our users to see if it is possible to cluster their usage 
patterns into a reasonably small list of sparse-checkout specifications. 
Alternatively, how large would it be to dynamically send a list of paths 
based on the current virtual projection? In either case, we expect some 
extra trees by including some amount of sibling paths as we expect users 
to be interested in reading nearby files or inspecting history for those 
paths.

IV.

One big reason we started computing daily prefetch packs for GVFS is 
that certain important Git commands became too slow if all objects were 
obtained from the loose-object download. Simple commands like "git log" 
would take forever. With all commits and trees, we can run "git log -- 
path" at the same speed as a vanilla repo. "git diff" can still be slow 
because it needs blob contents, but hopefully the diff was for a single 
commit and there are not too many calls. "git grep" could be a disaster.

When we start restricting to sparse-checkout specifications, not all 
"git log -- deep/paths/in/particular" commands will have enough data 
locally to run successfully.

One approach is to have a way to pass-through to a remote. Certain 
commands could be requested (via a protocol v2 verb) to the server. The 
server can compute the answer and send a (paged) response faster than 
the client can download objects and then compute locally. This also 
prevents users from getting a bloated object database full of loose 
blobs they don't need.

At the very least, we will want to detect that we are missing many 
objects and ask the user something like "Did you really want to do that? 
It will cause 1000+ objects to be downloaded. [Y/n]"


I hope this combo of information and half-baked ideas is helpful. We are 
definitely approaching a lot of interesting scale limits with many 
different possible solutions.

Thanks,
-Stolee

[1] 
https://public-inbox.org/git/20180107181459.222909-1-dstolee@microsoft.com/T/#u
     [RFC PATCH 00/18] Multi-pack index (MIDX)

[2] 
https://public-inbox.org/git/20171214152404.35708-1-git@jeffhostetler.com/T/#u
     [PATCH v2] Partial clone design document

[3] 
https://github.com/git/git/blob/0afbf6caa5b16dcfa3074982e5b48e27d452dbbb/Documentation/rev-list-options.txt#L727-L733
     rev-list-options.txt Documentation for "--filter=sparse:*"
