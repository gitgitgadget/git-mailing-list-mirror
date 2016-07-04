Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D97920179
	for <e@80x24.org>; Mon,  4 Jul 2016 18:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbcGDSQW (ORCPT <rfc822;e@80x24.org>);
	Mon, 4 Jul 2016 14:16:22 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35494 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbcGDSQT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2016 14:16:19 -0400
Received: by mail-pa0-f54.google.com with SMTP id xh11so11726249pac.2
        for <git@vger.kernel.org>; Mon, 04 Jul 2016 11:16:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zXHOlOGD6zYjRJp73kNJ1d5J9yC3hEgXMBqkNpYDefY=;
        b=EE8eoC8oh+Vqea2ZI0uos3e4EaeqWWbmx4LWFx31v9iHZBNdlE67Tisg63Lt+8Z0lc
         me7UWC3YavCy3/upN+LDmuZGQvxEAEI4tdUjLfYKeAvLN4RHao0IjodGu6s5kPYwHxKg
         6YekJ2725ConCBqpYOiHTC7OKLcq+8EiKUA9jgJE6oz8lFFF7EJjEuXVXmQvo3seZLv8
         lpW8mMcpxWgtHnrJteNbkWo2wztSXNSsVbTBZNoXVBMDv46jZGSoQgiL/oS57Lb97Okn
         fblNcWyuBotTGn4FREouI0OANfRAjhCOMDtWO3ePm9HYkdhIV/EWMmP1bkegcKpE8Vbw
         c1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zXHOlOGD6zYjRJp73kNJ1d5J9yC3hEgXMBqkNpYDefY=;
        b=RSlCLQ/pzCH6zl9i95alDIeM2cCbIhp5kRTtAQsDH/lHlTq7g0WSdOjtHzNbiuGaVG
         A906tNj4pu+g6jeUH9K2YeFtx/FpEBeOLLJKcSDfMtRc7reHHebiUh14HL7Yyho/B3A0
         4jSi4RfjlmJW0/AgkLgUEDzMawBxa8Edju2mN6dxhooC/h80C4cNxYK9CNF9nVp4e02M
         Y+qhfowILv53o4dACzY1MwC0O8tAqN9k8ixOmdZpqVMB0fdUG8RuK3H6Q5txewwPPoxs
         5Gb37arrCv1Q1i59jkD1fXHD4lRb5d+irHN+yfmfzxyBndnZK8Z0z5GvwtlKmEBPrIcW
         bdmg==
X-Gm-Message-State: ALyK8tKCo/MUWDwNCm4VzUEga9WZ/RUwZWKmlYZAAfHzLsEUd2RyIP3lMAiVDQEH+0sS3z/6ehLKMw3p8B7CxQ==
X-Received: by 10.66.180.40 with SMTP id dl8mr25156540pac.131.1467656177817;
 Mon, 04 Jul 2016 11:16:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.66.126.147 with HTTP; Mon, 4 Jul 2016 11:15:58 -0700 (PDT)
In-Reply-To: <20160704203946.3ac8d3205c08bfaee9a93a46@domain007.com>
References: <CAH_OBieCcx0_=vuZgoJ8GrZhhReEAhnjrz2pQwbwGgPFww4JmQ@mail.gmail.com>
 <20160704203946.3ac8d3205c08bfaee9a93a46@domain007.com>
From:	shawn wilson <ag4ve.us@gmail.com>
Date:	Mon, 4 Jul 2016 14:15:58 -0400
Message-ID: <CAH_OBie4dUB8WXfmKhLaezVKi0=LhnFw=wKJO1c3oUMA7VkYdw@mail.gmail.com>
Subject: Re: split directories into branches
To:	Konstantin Khomoutov <kostix+git@007spb.ru>
Cc:	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 4, 2016 at 1:39 PM, Konstantin Khomoutov
<kostix+git@007spb.ru> wrote:
> On Mon, 4 Jul 2016 12:45:39 -0400
> shawn wilson <ag4ve.us@gmail.com> wrote:
>

>
> To achieve what you're after I used `git subtree split` followed by
> `git filter-branch --tree-filter ...` which moved all the files under
> the directory hierarchy `git subtree split` removes.
>

Ah, that looks like it should work - thanks

> I know Git tracks content, not files (and directory) but still many
> folks have "stable" directories for their files, assign certain
> semantics to them etc.  I've needed such transfers myself, and this
> topic has been raised more than once by folks over there on the
> git-users mailing list.

Or just an option for git {rm,mv,cp} that would allow simple rewriting
of history. Ie:
git mv HEAD~3.. -- foo bar
(obviously not the sanest thing in most cases but would be a shorter
reach than filter-branch - and if newest isn't head then it'd what?
move it back during commits for who knows what - still...)

Thanks for pointing out the users list - didn't notice it and sorry
for posting a user question on a dev list.
