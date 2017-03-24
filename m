Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC80E1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 23:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753598AbdCXXyC (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 19:54:02 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:36415 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751398AbdCXXyB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 19:54:01 -0400
Received: by mail-pg0-f43.google.com with SMTP id g2so2290894pge.3
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 16:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P0rrOsDViab9VGDetSRQuR56Gt0klyspb4o53Y3ZqZA=;
        b=ArVBmM+ZYTEd8HnoNCD8pMtBh08CDiwB/TlTW496OmVSxwc/zNCFwWuJ6DUeVKWZw0
         0hIWM2tqTm8yk6bG87di64R2lXcC4aPl5OyeWx5VDeaDp6VNXhOkpBpBUZO4Htjw18DC
         FveBAgsCF/UuxqGF7F8E6DqpDhei41uYGQXgML2Z71A0G0ioIfZq3+bARd/KnqMLnMGd
         cbGhjU5gju9yVnqlSSWclN+2B9nuxxa9c5nqCl+S09JAkTQSLFZETyVlXHvqU6IUzmQU
         vUvWeK+Hx0X3WczSbOOd4ghk78OCXDIIvGKuu/gBug+kD8oFUeB2VKlB0m733PK+BuQ0
         3hNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P0rrOsDViab9VGDetSRQuR56Gt0klyspb4o53Y3ZqZA=;
        b=YLdYSCwJRBIrpmj6OqHCiDIPKIkPKvvolL8DcY/zIY/D9SETfsCn0ct482f+/LvVu7
         oXfiVHeez7H8FBwPcJOsR1O6TJC8GdaJgDGbwvfQy5smkDMzwPVynpoyXZfe66D2ythm
         zQL1sidPtzQGs9wlUHbJwoQHw8OwfDtpSad4i2Lfc81hEvh9mcC2BgC1oITWsHn8wecM
         K5THTt+pMdQAzBVdyZUa98LO1PD8UvL5oZI5V046GF8+fdwzmEEkkUTfy6E6Z9Uwvc/R
         avl+aLwo5YGMvJCIrm7fx/P2BeTwyyb8lucHM52iMnmYvtYdxVOBgAzrg4qTTy9XylUO
         Re7g==
X-Gm-Message-State: AFeK/H2TDK5fUB7gmNb7Uqn/LJ3jfOvI+mtyAVGZFnwKmG8SHdSSt9OQPJMDUFB9ukPx5sZF
X-Received: by 10.98.14.81 with SMTP id w78mr12646747pfi.9.1490399639953;
        Fri, 24 Mar 2017 16:53:59 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:3c35:65e8:559b:2627])
        by smtp.gmail.com with ESMTPSA id 189sm6662912pgd.30.2017.03.24.16.53.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 16:53:59 -0700 (PDT)
Date:   Fri, 24 Mar 2017 16:53:57 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2017, #10; Fri, 24)
Message-ID: <20170324235357.GA26537@google.com>
References: <xmqq4lyi74lw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4lyi74lw.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/24, Junio C Hamano wrote:
> * bw/recurse-submodules-relative-fix (2017-03-17) 5 commits
>  - ls-files: fix bug when recursing with relative pathspec
>  - ls-files: fix typo in variable name
>  - grep: fix bug when recursing with relative pathspec
>  - setup: allow for prefix to be passed to git commands
>  - grep: fix help text typo
> 
>  A few commands that recently learned the "--recurse-submodule"
>  option misbehaved when started from a subdirectory of the
>  superproject.

Anything more you think needs to be done about this?  I noticed that
Dscho's config series hit master so I could rebase against that (as
there is a small conflict).  Aside from that it didn't seem like there
were many complaints with the proposed fix.

-- 
Brandon Williams
