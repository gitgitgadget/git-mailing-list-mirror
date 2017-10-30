Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F919202DD
	for <e@80x24.org>; Mon, 30 Oct 2017 19:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932907AbdJ3TyR (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 15:54:17 -0400
Received: from siwi.pair.com ([209.68.5.199]:39439 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932087AbdJ3TyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 15:54:16 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 188BC84513;
        Mon, 30 Oct 2017 15:54:16 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 9A5988450F;
        Mon, 30 Oct 2017 15:54:15 -0400 (EDT)
Subject: Re: What's cooking in git.git (Oct 2017, #07; Mon, 30)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
References: <xmqqr2tl40pl.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1710301830210.6482@virtualbox>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <f12353b6-cfed-722b-1386-d55700f21915@jeffhostetler.com>
Date:   Mon, 30 Oct 2017 15:54:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1710301830210.6482@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/30/2017 1:31 PM, Johannes Schindelin wrote:
> Hi Junio,
> 
> On Mon, 30 Oct 2017, Junio C Hamano wrote:
> 
>> * jt/partial-clone-lazy-fetch (2017-10-02) 18 commits
>>   - fetch-pack: restore save_commit_buffer after use
>>   - unpack-trees: batch fetching of missing blobs
>>   - clone: configure blobmaxbytes in created repos
>>   - clone: support excluding large blobs
>>   - fetch: support excluding large blobs
>>   - fetch: refactor calculation of remote list
>>   - fetch-pack: support excluding large blobs
>>   - pack-objects: support --blob-max-bytes
>>   - pack-objects: rename want_.* to ignore_.*
>>   - gc: do not repack promisor packfiles
>>   - rev-list: support termination at promisor objects
>>   - sha1_file: support lazily fetching missing objects
>>   - introduce fetch-object: fetch one promisor object
>>   - index-pack: refactor writing of .keep files
>>   - fsck: support promisor objects as CLI argument
>>   - fsck: support referenced promisor objects
>>   - fsck: support refs pointing to promisor objects
>>   - fsck: introduce partialclone extension
>>
>>   A journey for "git clone" and "git fetch" to become "lazier" by
>>   depending more on its remote repository---this is the beginning of
>>   it.
>>
>>   Expecting a reroll.
>>   cf. <CAGf8dgLu-TeK8KbHv-U+18O+L2TxKcGv5vFFHy38J6a_YXRfew@mail.gmail.com>
> 
> It was my understanding that Jeff's heavy-lifting produced a shorter,
> initial patch series with parts of this, that was already reviewed
> internally by Jonathan.
> 
> Am I mistaken?
> 
> Ciao,
> Dscho
> 

Right.  I posted a "part 1" of this last week and am currently
rerolling that.  I should also have a followup "part 2" patch
series shortly.

https://public-inbox.org/git/20171024185332.57261-1-git@jeffhostetler.com/

I've been assuming that the jt/partial-clone-lazy-fetch is a
placeholder for our next combined patch series.

Jeff
