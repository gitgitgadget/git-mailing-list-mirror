Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B69E620A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 03:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbeLJDwm (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 22:52:42 -0500
Received: from mail-it1-f175.google.com ([209.85.166.175]:35448 "EHLO
        mail-it1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeLJDwm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 22:52:42 -0500
Received: by mail-it1-f175.google.com with SMTP id p197so15912861itp.0
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 19:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tc0iFIzcQDOZvxrXW1+v4ygCNng7/dsfEFgyPzBorSc=;
        b=qOnqZPVbpXZyFZRKy67YQFQE02m9tKSiqyafuzTLYQX3ynapxpdrLWFw2em66jZq9r
         Ex8Ydc4r9Bn3N+axOyH2gYMxipjUgSQjjLqkHGP7S0Sdm9VsMDNfvV3AeR85NfXMBHmj
         3VRx1OYuRrjELiXVER3lmfMF8Ab9XhnY8ziTlNK5fbmAIQklCW36wUfTB5kVvGmkqYVU
         zAwSVqbG5IeA842JMI1jfCdQJKq0UF2+NXizjeZOcKEkj/J/sDt47lgcDX4r9FLvoM0n
         1RroQC3uxdwW8nrXxnc3ej+LMUtUQckVLOyOX9bii6cpo299jUt+KTzcs8l1+/nzdCGh
         dvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tc0iFIzcQDOZvxrXW1+v4ygCNng7/dsfEFgyPzBorSc=;
        b=f/jkeFnMpsUt4n7IXrFmgX+WBeeeiqKEnYWvXX5l6lNR0G7Lye5751Q0Zyockj+chH
         2x3IlO9pFLFKWreQ+2RYnP6/MgoNeXtsPjnzrUp8jOIriIDHXjVzc5Lgr4e6ZF0Iawmn
         TQ0aDseasozgExXSoPun8aDYYNOEXCs6XD7cp2a9adt7n7i4wwyB0er9+GHmcI01uxp+
         7o548HD39FSDBPjXHizjOPrPXRFyMR2QK10y+ATTeBY2qDxzhVuuc1QqLfsNgFopkYX2
         ekiHYyXPa8nglYsTe7WN0DVbWSN+vUpgbxiH7nTG/BXFnc3/Hy4WlJKXBgKslbmmZBdZ
         ybvw==
X-Gm-Message-State: AA+aEWYaQ4vrQibyRJETzs59RTtO3QqO0Js070ivz9ZclMB3lBY+ywbT
        3B6l/8zpzOxoNJhGXEQz+Zc=
X-Google-Smtp-Source: AFSGD/UoUv6OA1WXYzmte5klTsJxMOXbSottBlJrUN8BaRzjnqfpnGPnM3GXXoY3vJR9wy6YJo+5mQ==
X-Received: by 2002:a24:2912:: with SMTP id p18mr9578767itp.16.1544413961098;
        Sun, 09 Dec 2018 19:52:41 -0800 (PST)
Received: from archbookpro.localdomain (ktnron0919w-grc-01-76-68-140-144.dsl.bell.ca. [76.68.140.144])
        by smtp.gmail.com with ESMTPSA id k18sm3819680ioa.39.2018.12.09.19.52.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 19:52:40 -0800 (PST)
Date:   Sun, 9 Dec 2018 22:52:38 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2018, #01; Sun, 9)
Message-ID: <20181210035238.GA2104@archbookpro.localdomain>
References: <xmqq8t0z3xcc.fsf@gitster-ct.c.googlers.com>
 <20181209090300.GA32640@archbookpro.localdomain>
 <xmqqo99u2hjy.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo99u2hjy.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 10, 2018 at 12:21:05PM +0900, Junio C Hamano wrote:
> I think v3 (which we see above) describes what it wants to do
> clearly enough and implements what it wants to do cleanly.  I do not
> think the patch itself has much room for further improvement.
> 
> When I re-read the final patch and all the earlier comments I made
> in the thread that began at [*1*], I still do not see in what
> practical workflow and usecase the users would find the feature this
> change adds useful.  
> 
> For each new feature, I want a story we can sell it to the users:
> "if your workflow is like this or that, you would find yourself
> wanting to do this, which was (impossible|cumbersome) to do before;
> with this new thing, you can".
> 
> And the "story" is not "If you have remote.$name.url and want to
> move its value to remote.$name.pushurl while setting the former to a
> new value, then..."  I want to know why the user gets in such a
> situation in the first place.
> 
> To be helped by the feature, the user
> 
>  (1) must first have a remote.$name.url (but not remote.$name.pushurl)
> 
>  (2) that URL must also be usable for pushing
> 
>  (3) and then has another URL that can be used for fetching
> 
>  (4) and somehow that new URL is more suitable for fetching than the
>      original one.
> 
> When all of the above holds, then "set-url --save-to-push" can be
> used to move the original URL that can be used for both fetching and
> pushing to remote.$name.pushurl and set remote.$name.url to the new
> value with a single command.  But is that a sensible situation to be
> in the first place?

The following is the story that led to me writing the feature in the
first place:

I have a project that's been developed on my own machine. I want to
deploy it onto a server to test, so I use SSH key forwarding and clone
the project with the SSH URL onto the server. After fixing some small
bugs, I'll push the changes directly from the server up. 

Now that the server is running, I only touch the repo on the server
occasionally. I want to pull updates from the main repository without
necessarily having to use SSH key forwarding because I might be
forgetful and forget to start ssh-agent or I might have someone else
administer the server who doesn't have key-access to the repository.
However, I also don't want to get rid of my ability to push over SSH so,
in this case, I'd run 
`git remote set-url --save-to-push origin <HTTPS_URL>`.

Although it's definitely not an every day activity, I've run into the
use case a few times where having this ability would definitely be
useful.

> 
> I guess it would help the readers if the documentation (or proposed
> log message) were more explicit that this is to help the project
> originator more than the project followers, perhaps.  My working
> assumption during the review discussion on this patch has been that
> there are orders-of-magnitude many project followers who start from
> fetching and locally tweaking without ever publishing than those who
> start to pushing to a project from day one of joining, or the day
> they themselves initiated the project.  And for these majority
> "followers", the first URL is often the one to fetch, which may not
> necessarily be usable for pushing, and that URL is advertised for
> the wider general public as the most suitable URL for fetching the
> project's source.  So to these people, neither (2) or (4) would
> hold.
> 
> But for project initiators and those joining a project with write
> access from day one, the story may be a bit different.  They may
> start with a single URL that can be used for both fetching and
> pushing, which means (2) would hold for them, unlike for the
> majority of users.
> 
> I am still not sure what a good example situation is that makes (4)
> hold, though.  Perhaps you originally had a R/W URL that always
> require authentication, but now you want to use an anonymous R/O URL
> for your fetch traffic without having to authenticate?  If there is
> a model situation to make all of these four hold, perhaps it can be
> added somewhere to help users who would find the new feature useful
> discover it.

If the above makes sense to you, I can try to distill the use-case down
to its essence and include it documentation for the patch.

> 
> Without that, I remain unconvinced.
> 
> Thanks.
> 
> 
> [Reference]
> 
> *1*  https://public-inbox.org/git/1d1b0fe85ddd89cf8172e730e8886d5b4a9ea7eb.1540627720.git.liu.denton@gmail.com/
