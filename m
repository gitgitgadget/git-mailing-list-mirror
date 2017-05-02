Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77756207D6
	for <e@80x24.org>; Tue,  2 May 2017 01:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751497AbdEBBJN (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 21:09:13 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:35938 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751136AbdEBBJM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 21:09:12 -0400
Received: by mail-io0-f177.google.com with SMTP id p80so139197424iop.3
        for <git@vger.kernel.org>; Mon, 01 May 2017 18:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QlphGV8GVdSOQylhUrbA5TkmcCjxlQUK0iBSUUK6JcM=;
        b=LGC9aes7BM9mh36fsi1VicHYmkw2ih7EC6L8VuK062AD2QfsXplPJmOtJlJ/k5gF5J
         8LTPb10VWm4XJ784EyaCGneRAJ8QmL7yWngvPO8hcAoskuwqjDLenBUvpo/pxg3HUc1m
         K2PEq8HQsZjMsDK6rWlYumCIGH7sxjbGvo6ZuEXL2aEgv7hJ3Qq/9nFIDwhcUYtTQww+
         w2siKsVGOWdemTJFkRSpPhQkBaHryTiPnevn9Yzx8yrMiw/1PGPKMZ+6MiwAMr3eIgmx
         X61HhFHevXUpvgoUMRzF5WSvs/ILGJO0QUoxs1r+pGkTm0mZMHKTft1jp13BabS+rkl2
         BdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QlphGV8GVdSOQylhUrbA5TkmcCjxlQUK0iBSUUK6JcM=;
        b=IKOOCBy/8PsWgT2ktnjLGA/c9BUJUgU2z25HIM9Gx0yMl9c944AJd46jfWl+9IovKk
         JQJoTXVZV0Qj+X2mm6ZDZ6Ihsuo+GNmlSZkXWYulV8J2CvuMaxcNTJdW1gfip+o2FyFv
         gSiP+rKZP6P32udpdzVBKwedXWrmz4qvPh78zZ4cIZq4kdZ0lEsTDdQv94Ka9cIG4bVi
         DfKm0RLzRlEfaazDITCEpK4MnXYg1U2tW+dbDNGlyQmF7dqk5GNgz/mKjOEAK2Culk9O
         V3377SEbkWSHCYAuC0IqbemazCDxQxTpYU014g/rqJLMXN5hMgov5qtvJIUDDWc9Z8HT
         on7Q==
X-Gm-Message-State: AN3rC/4BqaDHLYEpmL2GumNZYDa0Ob3TKc0nijW5ioJTIYl9b3rYpK9o
        R1hl2/w0xUFbOlKZ
X-Received: by 10.107.4.149 with SMTP id 143mr26795146ioe.11.1493687351458;
        Mon, 01 May 2017 18:09:11 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:61ee:b5d7:71fe:5285])
        by smtp.gmail.com with ESMTPSA id t69sm7226036ioi.54.2017.05.01.18.09.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 18:09:10 -0700 (PDT)
Date:   Mon, 1 May 2017 18:09:09 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/6] submodule: rename add_sha1_to_array
Message-ID: <20170502010909.GC154031@google.com>
References: <20170428235402.162251-1-bmwill@google.com>
 <20170502010239.179369-1-bmwill@google.com>
 <20170502010239.179369-2-bmwill@google.com>
 <CAGZ79kbq_WSH01yE+oT9aagmyPWF55eCmU_2Dv_k1soB9-bwnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbq_WSH01yE+oT9aagmyPWF55eCmU_2Dv_k1soB9-bwnA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/01, Stefan Beller wrote:
> On Mon, May 1, 2017 at 6:02 PM, Brandon Williams <bmwill@google.com> wrote:
> 
> > Change-Id: Ia6d15f34cee4d0dc32f7a475c69f4cb3aa8ce5bf
> 
> Uh?

Oops! I forgot to run it through my scrubbing script...

> 
> Maybe another side project for the long todo list: get git-trailers into shape,
> such that it can be configured to yell at you upon formatting the patch or
> sending email when a given trailer occurs.
> 
> Thanks,
> Stefan

-- 
Brandon Williams
