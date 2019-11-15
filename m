Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BC5F1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 22:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfKOWFc (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 17:05:32 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35873 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfKOWFc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 17:05:32 -0500
Received: by mail-pf1-f195.google.com with SMTP id b19so7318248pfd.3
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 14:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gIYqUe5Ng6r5ytjwvHEZM9+KIvO18E43GmS4UuECF24=;
        b=iduNNEyP5mcrKvN07g7Ws2NGFcpJ5xOsG9dAadTyfmSTp2cb6frZSW6CsGZG0dIuL0
         GoVNuHqD7Jr7kOgAU6wGrLlPb8jRcdy7V7y9k53HL49dVKdG1u19dFWch2dN82Bsmk8c
         nWUCs7TkEN6Nq4fjVTXwD1qW6EJuYjlvt8J3fHqEX87bsgdhQjFZY8dMw0/8asLYjz1k
         SWmWIl/1FnuAD2F+RcLSh9RtTxmu6FtYU/vQHV7qshx+Jxidd+8eAUg+f7G+K+qwuQV/
         MKfFH7QrBx65y70ZEqVJwNDImOBmCkTSLM0BAWm2k1ppnFVE4qYBtQyLuHSI1a3d//EG
         2g+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gIYqUe5Ng6r5ytjwvHEZM9+KIvO18E43GmS4UuECF24=;
        b=XnDRiz+2UH0km89fiI5y0Z2NYpaDoFoImGsvgpABYC+UFNcQnZ5a5Btdn4Vusn9UX4
         z9hEf5MwtbXe7Lg6r4Ic9cFWw48PLfC+aD2XVv0KK9cH4oLReiV2r/5LSTFuuusTIUEl
         x2MJ33rJTzZ39uuttdRKGKXvtFLKpnYGKE/EYdjO/Gm98MZHR8y/X/DZ/uyqNlZhruRB
         bi91E2TVlyv5FwZXYHL3tIVbDsieTdD4dc+12vtugRUD7m4jhC2Yp2NhSkNJu1EETF8t
         5Q2+3t+/AgOvCRGwLPhvtdjPJb0eRWW/i+I5IWQR90Rjdm4la7hPCiEECnHbyW28XgOS
         8mGA==
X-Gm-Message-State: APjAAAWBE69zCE4d2GdhlqcMfToprbHekUtHz8PYLYDZQ9ACL6sJDuen
        uSyueZpDBvZIbFescwp88fuLHG6x
X-Google-Smtp-Source: APXvYqxXPEyyXpJqyxa0Q1C9zqXKk/9XP6MFiFu9wWc0c8Kv/OU4PncDZJbTJ+XWCh/rI9DCjUgGdA==
X-Received: by 2002:a63:1323:: with SMTP id i35mr19152764pgl.450.1573855530823;
        Fri, 15 Nov 2019 14:05:30 -0800 (PST)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id i71sm11091119pfe.103.2019.11.15.14.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 14:05:29 -0800 (PST)
Date:   Fri, 15 Nov 2019 14:05:28 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] MyFirstContribution: add avenues for getting help
Message-ID: <20191115220528.GA80935@generichostname>
References: <20191115215342.37408-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115215342.37408-1-emilyshaffer@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Fri, Nov 15, 2019 at 01:53:42PM -0800, Emily Shaffer wrote:
> With https://public-inbox.org/git/20191114194708.GD60198@google.com/ we
> now have a mentoring mailing list, to which we should direct new
> contributors who have questions.
> 
> Since #git-devel's traffic is fairly low, it should be OK to direct some
> questions there too. Mention some of the conventions in case folks are
> unfamiliar with IRC.
> 
> Because the mentoring list and #git-devel are both a subset of Git
> contributors, it's possible that no response is found on either forum,
> so list the main mailing list as a fallback and mention some of the
> conventions.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  Documentation/MyFirstContribution.txt | 32 +++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
> index 5e9b808f5f..9fe197c98e 100644
> --- a/Documentation/MyFirstContribution.txt
> +++ b/Documentation/MyFirstContribution.txt
> @@ -23,6 +23,38 @@ useful additional context:
>  - `Documentation/SubmittingPatches`
>  - `Documentation/howto/new-command.txt`
>  
> +[[getting-help]]
> +=== Getting Help
> +
> +If you get stuck, you can seek help in the following places.
> +
> +==== https://groups.google.com/forum/#!forum/git-mentoring[git-mentoring@googlegroups.com]
> +
> +This mailing list is targeted to new contributors and is a great place to post
> +questions and receive kind, detailed answers from volunteers on the Git
> +project. You must join the group to view messages or post.
> +
> +==== https://webchat.freenode.net/#git-devel[#git-devel] on Freenode
> +
> +This IRC channel is for conversations between Git contributors. If someone is
> +currently online and knows the answer to your question, you can receive help
> +in real time. Otherwise, you can read the
> +https://colabti.org/irclogger//irclogger_logs/git-devel[scrollback] to see
> +whether someone answered you. IRC does not allow offline private messaging, so
> +if you try to private message someone and then log out of IRC, they cannot
> +respond to you. It's better to ask your questions in the channel so that you
> +can be answered if you disconnect and so that others can learn from the
> +conversation.
> +
> +==== https://public-inbox.org/git[git@vger.kernel.org]
> +
> +This is the main Git project mailing list where code reviews, version
> +announcements, design discussions, and more take place. If you fail to receive
> +help via the channels above, you can ask your question here. You can join by
> +sending an email to majordomo@vger.kernel.org with "subscribe git" in the body.
> +The Git list requires plain-text-only emails and prefers inline and
> +bottom-posting when replying to mail.

Perhaps we could explicitly mention that subscribing to the list is
optional and not required to post (especially since we CC everyone
here)? New contributors may be intimidated by the volume of mail going
through here so knowing that they don't have to subscribe might be
helpful.

Thanks,

Denton

> +
>  [[getting-started]]
>  == Getting Started
>  
> -- 
> 2.24.0.432.g9d3f5f5b63-goog
> 
