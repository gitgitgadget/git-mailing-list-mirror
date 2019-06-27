Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD4311F461
	for <e@80x24.org>; Thu, 27 Jun 2019 22:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfF0W46 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 18:56:58 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40789 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfF0W46 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 18:56:58 -0400
Received: by mail-pl1-f196.google.com with SMTP id a93so2076034pla.7
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 15:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ii33cAb8s6TfRz9biFgQFRvEV73uLRdKqu38uoBK+Xk=;
        b=V++nbbR7AfWnZTtU4UPd+284k1y/IOhWzu1dADrhEG0bAFm6jJ+Fw8JAqja36t2/dJ
         Xi/+VXbgumWWmEjni2omqMQtooV+J3Os3HY/LqKmE/Y4V2P2/mVEFY5BTZmoY6DWp1UJ
         clD/0HFLBghMZCC/EvZgYl9nSGenIUjo43SEmcpBod2pvyv6plwGxRlhW2Ti76XIBYau
         N3RlaQpeOGrqKhp4zkbq6OIM1n6W9On9JwlXhtoDzSoPYKOSa3DVcmKIeeQEZjjsd+s/
         8wcStu34PpAPlFbvzFHxdkmwI2RO6Q/v7XNp7xXVdA0V74e/HIJVo6OE9ZmonEe+v2Mz
         25Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ii33cAb8s6TfRz9biFgQFRvEV73uLRdKqu38uoBK+Xk=;
        b=C9nQ9NcFtlzTtSFWSwFWJBMdjEtQ46G6ioofRHcc9GVu/mP8VjjxN64zmYGPri6c6X
         upPSBTAngOqMv8HkuiIXD/JSXN2cx678ZY/sjC1kgmQfVCoJjOog1ARtRvdXasEjrWo5
         8SaOp4dO5/BPW7TuTsqADbqNnveLSJrg5IIuflh2l7Ja9WniWmJfMB+ASd/Lkm4QeP+l
         H/Pex9DPpQ50zAXjHvR/pepkKxKOm1v4CpzQjUjGBPTd+0JQILBze8xTFokbWIOjI8B6
         VjPuXB0GwAysbghvqdGHOpxruj9ziwmvewO5DrnUEP4QkytMTQ46MO0hFtvaMR/p+gR2
         /7pA==
X-Gm-Message-State: APjAAAXzR7GjRHsxdHW5dKZmA6l2l7kCb+NLtXVG1V5iwCs5l/bz9cIA
        GCZ1MYcNRSOO/ashAg7X5WesS67RCJU=
X-Google-Smtp-Source: APXvYqxPokQdQPplOO206M4SJSoFI3+fq4bmLpSqV25jO7hr/kRpJiIO44VMYhj9oNnlDgs3LbW0qA==
X-Received: by 2002:a17:902:e582:: with SMTP id cl2mr7650980plb.60.1561676217282;
        Thu, 27 Jun 2019 15:56:57 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id k2sm233427pjl.23.2019.06.27.15.56.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 15:56:56 -0700 (PDT)
Date:   Thu, 27 Jun 2019 15:56:52 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [RFC PATCH v2 00/13] example implementation of revwalk tutorial
Message-ID: <20190627225652.GJ245941@google.com>
References: <20190626234915.171658-1-emilyshaffer@google.com>
 <20190626235032.177551-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626235032.177551-1-emilyshaffer@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 26, 2019 at 04:50:19PM -0700, Emily Shaffer wrote:
> Since r1, made some significant changes.
> 
>  - Added a commit for counting the 'omitted' list, to match the new
>    section added to the tutorial.
>  - Added significant comments to allow the sample to better stand on its
>    own.
>  - Fixed style issues (die() formatting, etc)
>  - Distinguished between human- and machine-readable output with
>    trace_printf() and printf(), to turn the command into plumbing.
>  - More changes as mentioned in the tutorial patch.
> 
> Thanks.
>  - Emily

I have a v3 ready with changes based on Eric's suggestions. However,
since they're almost all verbatim changes, I'm going to hold off on
sending it for a couple days to see if anybody else wants to peek
though. I'll likely be sending v3 on Monday.

 - Emily
