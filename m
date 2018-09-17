Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D28D1F404
	for <e@80x24.org>; Mon, 17 Sep 2018 15:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbeIQV0M (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 17:26:12 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:34082 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbeIQV0L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 17:26:11 -0400
Received: by mail-pf1-f172.google.com with SMTP id k19-v6so7779191pfi.1
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 08:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lZlO1EM1nn0USoEh4KXMXi90545rmnVCGSWTbNtQk8s=;
        b=QbgLRN9psXgeBNjSJVZK/5Q5sjTqvMqDtHMdnuvpOYd90Kt2TmtVs2ROh7F5apy4jI
         vkTOQWu//F7RDhMsQ107XNNfFprLiesO8QC8VY4lkKcnv4xDLC8TKG+oePboougiuD3/
         OFo/ejqQRyX94oUPTVPOzjL9HXxjgfcDkgozqwR8N1/p8N+Dh36C4hEllKaKPbmCwdW6
         SjoGPU9Q64lnp5t8HuslaTouOUJibyPOOqtLnAe2aT8jvvfYeVJgTOPFA74InTE5RYY8
         wKfiW6e9QHHDehU2NFlqTeneO9t0oGOk0/FfEaT1qOBImChq/KWlglfdw7LCcah9f6pj
         NcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lZlO1EM1nn0USoEh4KXMXi90545rmnVCGSWTbNtQk8s=;
        b=TE6xqkatMAAcJRoTQKyCMLycdoX049QCOaRqY3jx+3uo3XYuysPOwlGAjdrkdjtYNd
         h1FDyo9Xse1/Vdjk64RpO2FqBYeLJWL4eiJV5Q1k7iacwUwLVA0i7VspOz1naBieJQwn
         pG+0f32ublbmjRY40aTmeX9xrYuXUYe4ZqZYbAUg02bcVNbC1mApnTsRSJ0xOsYO3WvB
         7sLEVZKA72KzBcjfYGI6K3BpRYvzAse5/K23+wgKL4+4+yR2OdINzkkYUItFaipJs7i1
         vNngUG+5+4v2EU29M00GIpauslo4iVTxx5zfJNwHnO+chB5+W4qMVqhoGXJJnuIBxBs3
         II9w==
X-Gm-Message-State: APzg51Bz/sLvMSlkeSt0PXJ5e/c31Rf8yqL9kQplUnUK9bP01BPXIC2/
        FQZyiMlRZQJQyDgMQsDKcG8AwpWe
X-Google-Smtp-Source: ANB0VdZWidlR/+HhqnZxoxXzsKqPsMThhWspRg6KAdVWOuTkqvR9VE1II1yDor2I9H/ztuOe6UXmqA==
X-Received: by 2002:a62:2646:: with SMTP id m67-v6mr26830196pfm.254.1537199893007;
        Mon, 17 Sep 2018 08:58:13 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 22-v6sm22089639pfl.126.2018.09.17.08.58.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 08:58:12 -0700 (PDT)
Date:   Mon, 17 Sep 2018 08:58:10 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     John Austin <john@astrangergravity.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: Git for games working group
Message-ID: <20180917155810.GA89942@aiede.svl.corp.google.com>
References: <CA+AhR6fWpzL1ozt2H=y8TaQrgT-6dvkkK_K_P-pXniXT+xcMuQ@mail.gmail.com>
 <87bm8zlqrh.fsf@evledraar.gmail.com>
 <CA+AhR6d4p2N06t-w62A2=wTH0x1ipt3x3hN2mQKK-Cwj0rMX1g@mail.gmail.com>
 <20180915164217.GB88932@syl>
 <CA+AhR6fjtzWyRtcgRkedK=RWua8_rmiqkDR+my8u9BHLfjhRMA@mail.gmail.com>
 <20180916220548.GA154643@aiede.svl.corp.google.com>
 <20180917135846.GG71477@syl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917135846.GG71477@syl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau wrote:
> On Sun, Sep 16, 2018 at 03:05:48PM -0700, Jonathan Nieder wrote:
> > On Sun, Sep 16, 2018 at 11:17:27AM -0700, John Austin wrote:
> > > Taylor Blau wrote:

>>>> Right, though this still subjects the remote copy to all of the
>>>> difficulty of packing large objects (though Christian's work to support
>>>> other object database implementations would go a long way to help this).
>>>
>>> Ah, interesting -- I didn't realize this step was part of the
>>> bottleneck. I presumed git didn't do much more than perhaps gzip'ing
>>> binary files when it packed them up. Or do you mean the growing cost
>>> of storing the objects locally as you work? Perhaps that could be
>>> solved by allowing the client more control (ie. delete the oldest
>>> blobs that exist on the server).
>>
>> John, I believe you are correct.  Taylor, can you elaborate about what
>> packing overhead you are referring to?
>
> Jonathan, you are right. I was also referring about the increased time
> that Git would spend trying to find good packfile chains with larger,
> non-textual objects. I haven't done any hard benchmarking work on this,
> so it may be a moot point.

Ah, thanks.  See git-config(1):

	core.bigFileThreshold
		Files larger than this size are stored deflated,
		without attempting delta compression.

		Default is 512 MiB on all platforms.

If that's failing on your machine then it would be a bug, so we'd
definitely want to know.

Jonathan
