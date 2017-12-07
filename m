Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 107B620C33
	for <e@80x24.org>; Thu,  7 Dec 2017 20:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752430AbdLGUWJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 15:22:09 -0500
Received: from mail-qt0-f181.google.com ([209.85.216.181]:34037 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751741AbdLGUWH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 15:22:07 -0500
Received: by mail-qt0-f181.google.com with SMTP id 33so20914011qtv.1
        for <git@vger.kernel.org>; Thu, 07 Dec 2017 12:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qH9Eo8dRM5n7CLvViUbbGaNEmhJG+vlcyr2aQcAArmw=;
        b=Lfo4O3lvZsxP96jPTgPjWFcntMUaojxW8lqLbTms0Rw5dzeCF7WuMBkxdhQQb87Rez
         Np9MxiseKkkDLTAADf0nmq991cku8/9msGW9hQD57utu0ciAyXa2OBHHjoX/gx1PXjUk
         qo0iI+tL3nMXBC5TJk2m8k32uFHzuMAueH4BNxxRHhcYpPaMb/BEIGqBEKbnkkHNc2Li
         WBiy6O3nYdpQ7U257zdv5yuQ7zVRkxTZcL14yJv3B4BekA0SNQ+WZVPqZY5Rj/xOs0li
         Zs+dtjUdn/wckwn+Q/j4jsSARYK/rmzSIKFQs8mCNPgFzoNWmfEjgs9QLtykYKKgs1IJ
         9wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qH9Eo8dRM5n7CLvViUbbGaNEmhJG+vlcyr2aQcAArmw=;
        b=sGUj9cc+adiDVNPRJbZK9WBznljM6hPlYJU3qXl6areNVn11JZ6gimqMFHd0CUUv2P
         +mHFzC5hesxvJXK+scR4DiIJtWScv1fexN3C/5UETNP5Ls9F7veLSqMa5lpN7MHU6ksm
         MBCFj3fbt9DtwhmEzgvkZzbOCUdVy0+KyfXAn5ncRLhS9Yk/h1C63TGBzGWwrxZfEUOK
         MokKbwB6aT7XbBFg7Ucjr8yUKXgRv3yp8Tll4eGnZ8J+ueNjWQ4jo1T7PtjXOHTGhvsu
         pQdJQIPb6fWHLHPHKKznH0riFOPdRmdr7fi8/w+rVow5N/9JEbQ5T/My21dQpJKbwbeZ
         ac3w==
X-Gm-Message-State: AKGB3mIkOLtmAdlW33/hXV9iCTlrZvmHDnUC+rwXWvk+AWxwWRtp8jgQ
        REdBQAuuutZyWaxfTYZ9QsGrbZS0
X-Google-Smtp-Source: AGs4zMY8SbfbvCMytp0ld6WE0IqPk4bo+JPVHU2DdDbbaIefp2NnjVp9FOpNSAOSwcW43U3PDx1CdA==
X-Received: by 10.200.4.7 with SMTP id v7mr12094682qtg.129.1512678126165;
        Thu, 07 Dec 2017 12:22:06 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id x7sm4003706qtx.51.2017.12.07.12.22.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 07 Dec 2017 12:22:04 -0800 (PST)
Date:   Thu, 7 Dec 2017 15:22:02 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2017, #01; Mon, 4)
Message-ID: <20171207202201.GA3693@zaya.teonanacatl.net>
References: <xmqqmv2ykvy4.fsf@gitster.mtv.corp.google.com>
 <DA960DCE-0635-47CF-B3C4-8133021799F1@gmail.com>
 <alpine.DEB.2.21.1.1712071643410.4318@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1712071643410.4318@virtualbox>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin wrote:
> That is not the only thing going wrong:
>
> 	https://travis-ci.org/git/git/builds/312551566
>
> It would seem that t9001 is broken on Linux32, t5616 is broken on macOS,
> and something really kinky is going on with the GETTEXT_POISON text, as it
> seems to just abort while trying to run t6120.

I thought the verbose logs from the test might be useful, but looking
at the travis output for that job[1], there's an unrelated problem
preventing the ci/print-test-failures.sh script from running properly:

    $ ci/print-test-failures.sh
    cat: t/test-results/t1304-default-acl.exit: Permission denied
    ------------------------------------------------------------------------
    t/test-results/t1304-default-acl.out...
    ------------------------------------------------------------------------
    cat: t/test-results/t1304-default-acl.out: Permission denied

[1] https://travis-ci.org/git/git/jobs/312551595#L2185

I didn't see the same failure for other build targets at a glance, so
the permission issue might only be a problem for the linux32 builds.

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
A diplomat is a person who can tell you to go to Hell in such a way
that you actually look forward to the trip.
    -- Anonymous

