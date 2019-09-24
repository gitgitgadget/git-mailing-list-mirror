Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A82E1F463
	for <e@80x24.org>; Tue, 24 Sep 2019 12:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbfIXMNb (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 08:13:31 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36789 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728837AbfIXMNb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 08:13:31 -0400
Received: by mail-qt1-f194.google.com with SMTP id o12so1809580qtf.3
        for <git@vger.kernel.org>; Tue, 24 Sep 2019 05:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sIqs+Yt9rrxVawy5JDQc+rWkmOD36m1m8n5xMSmjbAU=;
        b=UUCKv1j75QKgGqPnZ3Zlja2XRZzlWWTX2H/KY31AoBiU1w2Xzrbvn+LkGD8AxMJ1ru
         +L/wVwFgTqR0YrOwGZheEREi8/u38Ms7iODYFvzez2aFkGIf6xFQDPxm+AzGT2buTdud
         VbpYG8F0E63CyKCzKoHD4lOlXyeJtRUkhrCgdY4a3FM5LCZvh01KTqHsov3qavZKhXoD
         QlqhZYs5W3WqIrdbWD2J4W/5WTRQ77gzrbB5EdQd9H1ySJxZGOVl8WytGTvtj8JUdNTn
         yP1fXaG3FP0Fumxy+F8nEocjCvjNFrRdtIbEAD1NZgRfNBjHuVx0qO7I6duURYVJZM6S
         82BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sIqs+Yt9rrxVawy5JDQc+rWkmOD36m1m8n5xMSmjbAU=;
        b=jtBAKC7+LDCUGemXUZizfJ2TpWDfihgOhUwXG6oRuC7rGzVGZzklrjag3Ku7oD3ea3
         NNnx73/nKv/0yW5QTm2+IFLg6NeSfWnxeVX5QMofhLwrLz5Z0kJlKDvUnmpcXy8ijtkf
         2KUTCxu3/taxQW3hpg1jpzMhCtuHBBvtfQSY136ET6rMKDg43shiHb3OTApi+UysPVdx
         UdWKy7hQBdg9bslNmSlIfA8T2iJ4d0FynOdiF8HhHJcsiy6YoTKNPb6AhRgQt86egaN5
         QJO7btxonMIq60JVsYACudwThC+INsFAv1xdIKN3VCzbHnLA+jfp25coHpQgNsUvn6+R
         JoIA==
X-Gm-Message-State: APjAAAVv7/z4JOkS1DzleYoUK2+cpnNmRYHzkT0yZN4ZVoQ3lONzveep
        983rZrM+q5eXZbSrIiI5q10=
X-Google-Smtp-Source: APXvYqyXWClomInrcvbkq+tUGBowhqwpBgl9Q171NNLwyIzXQEyhdBnXcOaV+tRtjVhxDO9JYN+t5Q==
X-Received: by 2002:ac8:5203:: with SMTP id r3mr2501124qtn.48.1569327209412;
        Tue, 24 Sep 2019 05:13:29 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:8434:a619:c799:e8af? ([2001:4898:a800:1010:356a:a619:c799:e8af])
        by smtp.gmail.com with ESMTPSA id t17sm1227211qtt.57.2019.09.24.05.13.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2019 05:13:28 -0700 (PDT)
Subject: Re: [PATCH] add a Code of Conduct document
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     git@sfconservancy.org, Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, garimasigit@gmail.com
References: <20190924064454.GA30419@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6a9fb4c2-6c80-4475-03d3-89bdba73095b@gmail.com>
Date:   Tue, 24 Sep 2019 08:13:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20190924064454.GA30419@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/24/2019 2:44 AM, Jeff King wrote:
> We've never had a formally written Code of Conduct document. Though it
> has been discussed off and on over the years, for the most part the
> behavior on the mailing list has been good enough that nobody felt the
> need to push one forward.
> 
> However, even if there aren't specific problems now, it's a good idea to
> have a document:
> 
>   - it puts everybody on the same page with respect to expectations.
>     This might avoid poor behavior, but also makes it easier to handle
>     it if it does happen.

This point is very important. We have a long document about how
to style our code, and it's very easy to point to it when someone uses
code style that doesn't fit. "We don't do that here" can apply to
behavior as well.

>   - it publicly advertises that good conduct is important to us and will
>     be enforced, which may make some people more comfortable with
>     joining our community

And on the other side: the covenant you use includes positive examples.
 
>   - it may be a good time to cement our expectations when things are
>     quiet, since it gives everybody some distance rather than focusing
>     on a current contentious issue

Let's adopt a CoC before we need it.

> This patch adapts the Contributor Covenant Code of Conduct. As opposed
> to writing our own from scratch, this uses common and well-accepted
> language, and strikes a good balance between illustrating expectations
> and avoiding a laundry list of behaviors. It's also the same document
> used by the Git for Windows project.
> 
> The text is taken mostly verbatim from:
> 
>   https://www.contributor-covenant.org/version/1/4/code-of-conduct.html

This is wise. Adopting an existing document is better than rolling our own.

> I also stole a very nice introductory paragraph from the Git for Windows
> version of the file.
> 
> There are a few subtle points, though:
> 
>   - the document refers to "the project maintainers". For the code, we
>     generally only consider there to be one maintainer: Junio C Hamano.
>     But for dealing with community issues, it makes sense to involve
>     more people to spread the responsibility. I've listed the project
>     committee address of git@sfconservancy.org as the contact point.
> 
>   - the document mentions banning from the community, both in the intro
>     paragraph and in "Our Responsibilities". The exact mechanism here is
>     left vague. I can imagine it might start with social enforcement
>     (not accepting patches, ignoring emails) and could escalate to
>     technical measures if necessary (asking vger admins to block an
>     address). It probably make sense _not_ to get too specific at this
>     point, and deal with specifics as they come up.

It makes sense to leave these vague. If we are too specific, then those
rules can be used against us by a bad actor.
 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Obviously related to the discussion in:
> 
>   https://public-inbox.org/git/71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com/
> 
> After some poking around at various CoC options, this one seemed like
> the best fit to me. But I'm open to suggestions or more discussion. It
> seems to me that the important piece is having _some_ CoC, and picking
> something standard-ish seems a safe bet.
> 
> I did find this nice set of guidelines in an old discussion:
> 
>   https://github.com/mhagger/git/commit/c6e6196be8fab3d48b12c4e42eceae6937538dee

While this document has good information, most of it would be better suited
for a "Reviewing Code" guide. The CoC is more general, as it applies to
behavior on-list AND off-list.

> I think it's missing some things that are "standard" in more modern CoCs
> (in particular, there's not much discussion of enforcement or
> responsibilities, and I think those are important for the "making people
> comfortable" goal). But maybe there are bits we'd like to pick out for
> other documents; not so much "_what_ we expect" as "here are some tips
> on _how_".
> 
> If people are on board with this direction, it might be fun to pick up a
> bunch of "Acked-by" trailers from people in the community who agree with
> it. It might give it more weight if many members have publicly endorsed
> it.

I fully endorse this patch! Thanks!

-Stolee
