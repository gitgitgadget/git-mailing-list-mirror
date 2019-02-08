Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 861C11F453
	for <e@80x24.org>; Fri,  8 Feb 2019 05:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbfBHFb5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 00:31:57 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44205 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfBHFb4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 00:31:56 -0500
Received: by mail-pg1-f195.google.com with SMTP id y1so1065218pgk.11
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 21:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DWcjrJ+bg1BDbBtiu5zPOAFY22H1zHg4wdI9A7Dao+g=;
        b=I3asDEJIdG1CSO3NNG/IqBIoKMBuUf7lbW/9TYnNSr/EQhJ+zQCHVrP7NZTF4XESJ9
         O8pqniHB03lDPRZVNzE6XFB7BRrKlQPeldmWgT7yBkVGzZVhngnlkChEiqdPTwXrDpST
         SlX2N3CG8zdRxYAJmdk1ZYE3xT0MCBHuzqdCh6uoWEDpfQJBt+Ld6GxQVQN5gIFYbf7c
         xbSz88e3Cb07noe9QpN7t6lJcOVjNKUYseywTZLbv6S5D4Y59C4yjiAfZ7QuxDhi0GcG
         0bOBoPCgk/xAPbEB/AZsgShlfnotq/diKwMIsiGcd8fFRBLE3UOTYscv21nDqO7eT+we
         PivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DWcjrJ+bg1BDbBtiu5zPOAFY22H1zHg4wdI9A7Dao+g=;
        b=F07n4Wv1+CVVy8XWbyGYxQMRn9ELFLCloe5zhL7/wbADYIfknAFzW7BuvecqaosJ0B
         FXUD5ZxtL4vFc2xMYEFuRMSQm1EBYdrbHqfqp5kiXdfa0vyhQU+bFcFQoP6P29OfNOQq
         tZfKIx2yftwEmfzG9v6eIrowwHWe2jcM0rjZQeWVbZYDCcB0ZdU7s5lZXTFtYyf8EOX2
         bhxaME2ORBQ1a0+kaCcqOjDtlZPHyhxHYeKIMWlxHi7ndWaOHRAeubczdtXoLQPgeH88
         a6ADFy4GCkv+MMj7WhgHQ7AllcPNuh1rir6PNWRT+h1nzuoDlMIvjXHTBQl5BuK4ELkJ
         +2bQ==
X-Gm-Message-State: AHQUAuYl2QzLt34PVwFtCJCbhpq0C1bK2o5k3XJUYy2fJisvgeOnojaB
        fuNrKXnuMW4iC3kUWuMy4lDfGv/e
X-Google-Smtp-Source: AHgI3IYFO4TxqhhP4JoizQfFLFXDSiN0B1aj+y2bFdRXJFgH6gri4aPPU3aSDsXElgVOn4imPBK8yw==
X-Received: by 2002:a63:e950:: with SMTP id q16mr2904402pgj.138.1549603915683;
        Thu, 07 Feb 2019 21:31:55 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id b9sm1115162pfi.118.2019.02.07.21.31.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 21:31:54 -0800 (PST)
Date:   Thu, 7 Feb 2019 21:31:52 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Teach submodule set-branch subcommand
Message-ID: <20190208053152.GA3378@archbookpro.localdomain>
References: <cover.1549521103.git.liu.denton@gmail.com>
 <cover.1549534460.git.liu.denton@gmail.com>
 <xmqqo97npjej.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo97npjej.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 07, 2019 at 10:01:40AM -0800, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > I rebased the changes onto the latest 'next' because if this branch gets
> > merged into 'next', there'll be merge conflicts from
> > 'dl/complete-submodule-absorbgitdirs'.
> 
> Please don't do that.
> 
> A topic that depends on everything in 'next' cannot graduate to
> 'master' until everything that is cooking in 'next' does.
> 
> When
> 
>  - the "conflict" that would arise is so trivial to resolve,
> 
>  - there is no semantic crashes between the new topic and existing
>     ones, and
> 
>  - the topic is usable even before other topics graduate (or even
>    when they get discarded)
> 
> please make it a habit to avoid making your topic (i.e. this one)
> hostage to another topic (i.e. the absorbgitdirs one), and certainly
> not hostage to the whole of 'next'.  A trivial conflict resolution
> in this case, if you revert the rebasing and then attempt to merge
> the result to 'next', would look like this.

My mistake, even though I've made a few contributions already, I'm still
getting used to the git.git workflow.

Thanks so much for helping me out and please don't hesitate to let me
know if I'm doing anything else wrong.

By the way, just for the record, how would you like me to handle
patchsets that cause merge conflicts?

Thanks,

Denton
