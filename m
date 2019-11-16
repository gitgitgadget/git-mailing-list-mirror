Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B4361F4B5
	for <e@80x24.org>; Sat, 16 Nov 2019 00:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfKPAJw (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 19:09:52 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34461 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfKPAJv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 19:09:51 -0500
Received: by mail-pl1-f194.google.com with SMTP id h13so5779250plr.1
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 16:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fqu18kjxb/Ay+eW/qLIA0Iw5aaFip8EUd9mRzjDAt7U=;
        b=syid+48Erf841W48wn6VVHZszZXZPPMatD4al2ik2D9zNe6HmQu9mNIP9a6KBSsi5u
         LvrJfJZpp3bMaDdAzVz9B6mRNzSJ8grC+SEBfGZeEItX7gzDq5LBL9O8tMceP5wLiA0E
         yeM66hbUcyOcep1U0m+ndiPzK9HqvcvP5faWwuwBf27Dy5fb4SLrWKrKKqAMxQTDXmJu
         UBwz5nxRBxnDYkuICV+isDVH5V12GQ1Z31G+DxoNEFjPX0VaBndQ/4uxAQEmNQ4nnk2E
         Y32is1hSO9OHh+9iFeE7vzJ6a19I5COjR32vhRew1siKGipjPposO5K73MWSxLWvS4Gs
         DVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fqu18kjxb/Ay+eW/qLIA0Iw5aaFip8EUd9mRzjDAt7U=;
        b=aswqHWS2f9k09d+X9U1tBrQbk5YsmLE7TjN3WGO7WjoR7gCsTyyLaWJTA1ObXl/aPd
         5hqWe5GnNojOYQ66aU2cifNlNsmkZPJBysVTyJbelgXnxmVtokWwiP6praSbVuzuhMGQ
         SgjFQFSRWR97VK8aCEyOhN9kuM0InPqDwYaLBL+QQsISc5V4wLzXa113/PAnqHGbFF8X
         JoOvvG6GiSVd8OTmqzYZtUrGGADZqVVDt7Befds2CiaavGBFK6Q6pq/5jJroDShmODVx
         Bb40/WPTnqZhndcuFj1c/9wgBQOovdHzLhPiueSkrMullXtN1A+x5otXqT6hjmMJLbkk
         l6Pw==
X-Gm-Message-State: APjAAAXWoMOVYNhmkP98YmcrfcTvbJlRLdnKCFJXHQJxOJbzXJIxbOAn
        SD6niGREd20q1F7RY2HBehA=
X-Google-Smtp-Source: APXvYqzWgH9LhOkPXx78HKXdT2LzAqCvD3kMtQzWzo2DDKjn6mf4zbiBmJ11zTqyOUIaWRxyq4rvVA==
X-Received: by 2002:a17:902:59c9:: with SMTP id d9mr17230443plj.229.1573862990738;
        Fri, 15 Nov 2019 16:09:50 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id y123sm11436330pfg.64.2019.11.15.16.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 16:09:49 -0800 (PST)
Date:   Fri, 15 Nov 2019 16:09:47 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2] MyFirstContribution: add avenues for getting help
Message-ID: <20191116000947.GA30187@google.com>
References: <20191115215342.37408-1-emilyshaffer@google.com>
 <20191115230637.76877-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115230637.76877-1-emilyshaffer@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer wrote:

> --- a/Documentation/MyFirstContribution.txt
> +++ b/Documentation/MyFirstContribution.txt
> @@ -23,6 +23,39 @@ useful additional context:
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

optional: https://j.mp/gitdevlog also works and is briefer.

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
> +help via the channels above, you can ask your question here. The Git list
> +requires plain-text-only emails and prefers inline and bottom-posting when
> +replying to mail; you will be CC'd in all replies to you. Optionally, you can
> +subscribe to the list by sending an email to majordomo@vger.kernel.org with
> +"subscribe git" in the body.
> +

Very nice.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
