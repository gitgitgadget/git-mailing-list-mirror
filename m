Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19D491F516
	for <e@80x24.org>; Thu, 21 Jun 2018 20:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933134AbeFUU6e (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 16:58:34 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38276 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932721AbeFUU6d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 16:58:33 -0400
Received: by mail-wm0-f67.google.com with SMTP id 69-v6so8489873wmf.3
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 13:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DV3n3iI1qH5C63yKRE9CjyD+5QNUfbEuzjI5qbBS/Us=;
        b=qwYwpocpfVIS5pDw1aDTYGWrhxBx8T5H2KIsL8D/4VnWl/M2OYxX+QF2Hk2UIUxHOk
         FDP0TUg4seMTy095T+eI1WHqfPZkg8xiVRSapkjaNl3o1FWiq/QNXVAFdrZyDNpMjR6d
         N6TquMHWSToVfE9vRbwbb7JqVDah477RPxeWmfBTyEVqIQZP87Aad+RrlmmpqdQgfD05
         qwW5E/hxLzeiabEHQdjNCOePwOh9Cm3AlIsfI5WT8jbq8N0qQv2TwDNcKacypMqFR4jZ
         FuYurB3qf05B8Ztadz8PYGXsQ7tj53nJ9MaEaeCpnc5XujzBd34B+Ygmjm3X2u+sHI1+
         p1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DV3n3iI1qH5C63yKRE9CjyD+5QNUfbEuzjI5qbBS/Us=;
        b=N8f4sZdGEozi2fnkaepFLTt1N6qGHQFqGxRLh4tYxH7qWlh4iRwUqTqGVGQRc/N5ca
         GXBzhXpYgcyyEOPySMJu/XWCw/y9FFeCfdsRCbSUPBktHBeNv+9N0EW7r5VjbBXvx9wZ
         M5fIN98sPx/XMh4hENqprYVYEC3yQoqQbDUGRRRJoQGU6dX5zWA3E6kITbVrRe4cONN0
         SShUuaNOo+cqio5hx+eJ+wZZnfZ04pRs+mfzJEbl5D6VnVZRfG9d/mohTqlfLSSf46y6
         zUtg0BCQyAtfoE+l4e74gbM/sgAhkeCzlY6ttgpaUbWJQz0/tdIq07kODQvNcQLX13ka
         rAXQ==
X-Gm-Message-State: APt69E0EUOyRba+SYDmQESBJfQy4emW6w8mry6H3TT5L6DgCshfpr6TW
        SHycplQdI3SMT31atQFmFz4=
X-Google-Smtp-Source: ADUXVKLXGKJKIGccIjhq7pn0g0PxNa8IhNiiphkBF0wEVQiJFN1S2vjMWLw6YX9P2CqpFzZGS0Ybng==
X-Received: by 2002:a1c:e184:: with SMTP id y126-v6mr6042145wmg.128.1529614711752;
        Thu, 21 Jun 2018 13:58:31 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h193-v6sm9356662wmd.25.2018.06.21.13.58.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 13:58:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] docs: link to gitsubmodules
References: <20180605202449.28810-1-bmwill@google.com>
        <20180620215030.21829-1-bmwill@google.com>
Date:   Thu, 21 Jun 2018 13:58:30 -0700
In-Reply-To: <20180620215030.21829-1-bmwill@google.com> (Brandon Williams's
        message of "Wed, 20 Jun 2018 14:50:30 -0700")
Message-ID: <xmqqzhznrh55.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Add a link to gitsubmodules(7) under the `submodule.active` entry in
> git-config(1).
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  Documentation/config.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Thanks.

>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index ab641bf5a..340eb1f3c 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -3327,12 +3327,13 @@ submodule.<name>.ignore::
>  submodule.<name>.active::
>  	Boolean value indicating if the submodule is of interest to git
>  	commands.  This config option takes precedence over the
> -	submodule.active config option.
> +	submodule.active config option. See linkgit:gitsubmodules[7] for
> +	details.
>  
>  submodule.active::
>  	A repeated field which contains a pathspec used to match against a
>  	submodule's path to determine if the submodule is of interest to git
> -	commands.
> +	commands. See linkgit:gitsubmodules[7] for details.
>  
>  submodule.recurse::
>  	Specifies if commands recurse into submodules by default. This
