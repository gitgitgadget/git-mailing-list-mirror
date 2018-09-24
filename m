Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 244C71F453
	for <e@80x24.org>; Mon, 24 Sep 2018 15:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbeIXVsz (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 17:48:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51171 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeIXVsz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 17:48:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id s12-v6so10258778wmc.0
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 08:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lK4KqGvFEK2CF9XNW4gQrpCEwiUAnmri5jUNmQnGqU8=;
        b=UxRB/bBpBVRk4+B9oRXVNBa/qeuWDgSInSVCwN+KQuXDL36EvL5gi1ApVeqx/aIpKO
         OXgwtlA8j4F0k8uzdbu9Bs3cq9FIqV7lfUNVugK38eBl/ZMEJTQCIrTlY1T9n8DEkywK
         NYxaMp87aauN14lbFAO03QGuT4Ynp4MOjG15tPmYrhNZRDSfYLpMeeK8S90euvyua7EQ
         PxGSm66MK9LviEgx5mZROEQkGLs1g0Y59Ab6ITO6IOPia1UZ0S7uSrYmnpqUbWIVZPrn
         HaBfPw3WsP7XQh0x9YwWEX5X7hk6aVrjHavUmwQh+wuxeFvFSA08oIc2aEF00DFS4BXd
         PuBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lK4KqGvFEK2CF9XNW4gQrpCEwiUAnmri5jUNmQnGqU8=;
        b=K0ROEzf25/l4PcKKkOxW9M9Jyk3Oq57VyRQYR6X92XJyLnI/mrN2VD/g0ugjfE83YV
         qhiGXWxzQEz1cMdwfm+Fj/no06v1AeZPmsy1T5XOYcBJVtbEjNZz2h7yiVJSDhIKxMQf
         AUEfrKjEZIIHqgXSk902MVZqxKk8kzeoSbweNyDUkGw5A4EsNPEsjJmCoSi1Peh4wYog
         PA+uhV5oYLIHw4rpR4PmbpoakPVNg3n6cbsXt21vUrI3HLmpB3oTVAhQlRBoUJpMmr5I
         GeNXqI24wpJtrxmgjFVTZTLi3VXKdPfZwUuTtdrKepkhwokTK8V8Q+fMNxc50DEFjOYK
         ysUQ==
X-Gm-Message-State: ABuFfoiU9J133qN2XezZLyRXuCyu8WGk7wNoshFpCZoBTmxHss1ORRBS
        2hVzZn7/UeH6rJFLtx2TLeyhPfIC
X-Google-Smtp-Source: ACcGV60xlsvsOXpLX4O3RKidrBQIfJzXQmPT9PjmuaY/6Hk8n0b6Osx5JVIKqE1iw+p/dumaeMSnlg==
X-Received: by 2002:a1c:87ca:: with SMTP id j193-v6mr8126677wmd.76.1537803966417;
        Mon, 24 Sep 2018 08:46:06 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 198-v6sm17571615wmm.0.2018.09.24.08.46.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 08:46:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] receive-pack: update comment with check_everything_connected
References: <20180921230444.GA2713@sigill.intra.peff.net>
Date:   Mon, 24 Sep 2018 08:46:04 -0700
In-Reply-To: <20180921230444.GA2713@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 21 Sep 2018 19:04:45 -0400")
Message-ID: <xmqqbm8muceb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> That function is now called "check_connected()", but we forgot to update
> this comment in 7043c7071c (check_everything_connected: use a struct
> with named options, 2016-07-15).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Just a minor annoyance I happened to notice while discussing in another
> thread. I notice both of us still called it check-everything-connected
> in our emails; old habits die hard, I suppose. ;)

Yup, and now I think I caught up ;-)  Thanks.

>
>  builtin/receive-pack.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index a3bb13af10..3b7432c8e4 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1834,7 +1834,7 @@ static void prepare_shallow_update(struct command *commands,
>  	/*
>  	 * keep hooks happy by forcing a temporary shallow file via
>  	 * env variable because we can't add --shallow-file to every
> -	 * command. check_everything_connected() will be done with
> +	 * command. check_connected() will be done with
>  	 * true .git/shallow though.
>  	 */
>  	setenv(GIT_SHALLOW_FILE_ENVIRONMENT, alt_shallow_file, 1);
