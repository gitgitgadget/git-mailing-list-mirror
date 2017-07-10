Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3078620357
	for <e@80x24.org>; Mon, 10 Jul 2017 16:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754600AbdGJQts (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 12:49:48 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36807 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754428AbdGJQtr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 12:49:47 -0400
Received: by mail-pf0-f194.google.com with SMTP id z6so15281657pfk.3
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 09:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZKrWQNHY9UaH6JLiBYhMrLp27kXdDBbpYNkvRA+l+M8=;
        b=ZA+/q4G7jkDAY4kZvjP9sSMrwOBGoJWhLQbiMBplIwyDzvowou8FdCmkt1fW5AfImS
         ZfQ13D43iR4/I5Mv7abgWVjrBwQxeat2rSz3SWwXW6xNTD2ONB//NPQbSfie6IMOxv+7
         keAGidwI6GSD+BDql4GkoOkNhAYfTTA6BH/9QrJunDc/pMfRQOtYHZbocPHbxe3tn8is
         XhPAl9n06WcxUwGOT17SqYF7aXNs9BWHkhkar0TE5rtWMlc23m5IRk9g8Ukjk+pHdCWK
         WoaumMu3qAGNHc0yTccU3Z0dlG1GNCfIfcgA9DtAPQjnlAuXYrEm0fbr3jbKvijJqGrU
         N42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZKrWQNHY9UaH6JLiBYhMrLp27kXdDBbpYNkvRA+l+M8=;
        b=uTk5lnQ99qkXg4uNJ4QvjV7uiOHjuRCDaDiH3E6hZ+vLFGD605MDo7WMoc2LRJOFM+
         p2HFNlIWmjyFvv7LggN7VPK6iBPGzXfOij4BEl6zSrGthpdKJKaXXFZaVkxXclw7gBtE
         /PBHuyzlh4FYO+LLuAwWismBN+BA3vIYQ3T1oYdYRJRrhTLzaE6LUw1WHhOYWUHUzKos
         jA5dfwcwK0QPp1Lbf2piuKQEw81PgRGjaOTFWPGrwxwnqVMjSfUjigWE3dWJ0LedvsFK
         3VDTK4x7jzorK3eDkVKjJ+UFwn9yqJCmr0pJ1bvMZcggvJzo7rljeQcBXJcmH/3yvQFy
         ex1Q==
X-Gm-Message-State: AIVw113BftQL+oV7vq5QmjpVp/h4LGux2+5YMQkAFtgdPBqby9KLCYgP
        qBP3s7uM3XfFSw==
X-Received: by 10.99.66.1 with SMTP id p1mr15591508pga.120.1499705386833;
        Mon, 10 Jul 2017 09:49:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:79e6:b06d:25fb:addc])
        by smtp.gmail.com with ESMTPSA id 79sm10705022pfn.51.2017.07.10.09.49.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Jul 2017 09:49:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: correct a mistake in an illustration
References: <20170710141830.8655-1-kaarticsivaraam91196@gmail.com>
Date:   Mon, 10 Jul 2017 09:49:44 -0700
In-Reply-To: <20170710141830.8655-1-kaarticsivaraam91196@gmail.com> (Kaartic
        Sivaraam's message of "Mon, 10 Jul 2017 19:48:30 +0530")
Message-ID: <xmqqmv8c6xuf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> The first illustration of the "RECOVERING FROM UPSTREAM REBASE"
> section in the 'git-rebase' documentation wasn't in line with the
> rest of the illustrations of that section.
>
> Correct it.

Yeah. It is unclear from the lack of context, but this part shows
the original state with some number of commits on the 'master'
branch, and the illustrations that follow depict the evolution of
histories starting from this state, yet they have one less commit
on their 'master' branch (and they are not trying to say the master
is reset to lose one commit), which is what "wasn't in line" in the
log message means.  

Looks correct to me.  Thanks.

>
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---
>  Documentation/git-rebase.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 53f4e1444..652a99062 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -675,7 +675,7 @@ on this 'subsystem'.  You might end up with a history like the
>  following:
>  
>  ------------
> -    o---o---o---o---o---o---o---o---o  master
> +    o---o---o---o---o---o---o---o  master
>  	 \
>  	  o---o---o---o---o  subsystem
>  			   \
