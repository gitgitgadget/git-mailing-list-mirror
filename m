Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2EB01F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 18:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbfDVSdU (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 14:33:20 -0400
Received: from avasout03.plus.net ([84.93.230.244]:47351 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfDVSdU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 14:33:20 -0400
Received: from [10.0.2.15] ([80.189.70.228])
        by smtp with ESMTPA
        id Idkkh7KdwR9LaIdklhHAyb; Mon, 22 Apr 2019 19:33:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1555957999; bh=05wUgU+8LfKYBxmbD9SeFs2E5Sz22vVKeNGKDD9k9Hk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SWNUiWx84ZLCaLZOjnFHou7jeRMIaexbjiUofiFN4Ut18pnlM8Xr3K6aOVB/gcOLa
         qWQ6gaviUEDxtQdaXzB6sbSuPDJirRAGWEvjh5iDu/8eq81P0aw9NSjDpgSQOGOl/O
         RX3fw0WyVRaH/BURIfg256zwD6s+90S/+FD8Hbc7rHZDUy+LDHlS5iCZmahdVH3bFQ
         KMDkJ68rr8dUbojASsikHAK9k83m61DZTT2FDLb9pVSH2BsjQeQq+7viP26LqCz+Sn
         XUHIt8Ji56pL/WIBKt1XJ7GSKOah+MiW2hyfZxhL366s6IkduQm1yIKp6DtgmNYbpp
         oMErju1tDWbzw==
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Qa0YQfTv c=1 sm=1 tr=0
 a=5/rI1lTgw+ttA0Fwm4j1LQ==:117 a=5/rI1lTgw+ttA0Fwm4j1LQ==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=5rxgeBVgAAAA:8
 a=EBOSESyhAAAA:8 a=bsd20PeyeYF7KUxIzJoA:9 a=QEXdDO2ut3YA:10
 a=PwKx63F5tFurRwaNxrlG:22 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: jt/fetch-cdn-offload (was What's cooking in git.git (Apr 2019,
 #04; Mon, 22))
To:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Cc:     git@vger.kernel.org, avarab@gmail.com
References: <xmqqd0le8t9l.fsf@gitster-ct.c.googlers.com>
 <20190422175104.15471-1-jonathantanmy@google.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <6de01c91-2dbb-61b2-973a-22ba71302bbb@ramsayjones.plus.com>
Date:   Mon, 22 Apr 2019 19:33:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422175104.15471-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfEYkNP4n1lDymaE3CV3QTQgMnIOPRIfNwNtut8I4pHKVvU6lbSb9EllCK+4M22YmLFDRWU1o+bGbCZrSW4waR3nfFlI7NS7J/e8XVtk9z5erayFiZvIo
 zhNLQCSfGh9/eJ0EziyEByI7qc0wtR4xJOmZJNfpA+i5umTbS+jtjXSromTHa5kCwlQqmwwB8/VxYA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 22/04/2019 18:51, Jonathan Tan wrote:
>> * jt/fetch-cdn-offload (2019-03-12) 9 commits
>>  - SQUASH???
>>  - upload-pack: send part of packfile response as uri
>>  - fetch-pack: support more than one pack lockfile
>>  - upload-pack: refactor reading of pack-objects out
>>  - Documentation: add Packfile URIs design doc
>>  - Documentation: order protocol v2 sections
>>  - http-fetch: support fetching packfiles by URL
>>  - http: improve documentation of http_pack_request
>>  - http: use --stdin when getting dumb HTTP pack
>>
>>  WIP for allowing a response to "git fetch" to instruct the bulk of
>>  the pack contents to be instead taken from elsewhere (aka CDN).
>>
>>  Waiting for the final version.
> 
> Sorry for getting back to you late on this. The current status is that
> v2 (this version) looks good to me, except that not many people seems to
> be interested in this - I sent out v2 [1] with a relatively significant
> protocol change to v1 (requiring the server to also send the packfile's
> hash, meaning that a workflow that Ævar has described will no longer
> work), but nobody replied to it except for Josh Steadmon (who did give
> his Reviewed-By).
> 
> In the meantime, I have been working on a server-side JGit
> implementation [2], but not all parts are done (and it will take some
> time).
> 
> If this version is good with everyone, then this is the final version. I
> know it has been some time, but if I squash "SQUASH???" onto
> "upload-pack: refactor reading of pack-objects out" and then rebase onto
> latest master (14c0f8d3ab ("The sixth batch", 2019-04-22)), there's only
> one small merge conflict.

... not forgetting the second hunk of [1], of course. ;-)

[1] https://public-inbox.org/git/5f0c12d5-6714-1516-3579-33d839ad7b7e@ramsayjones.plus.com/

ATB,
Ramsay Jones

