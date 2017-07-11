Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB6312035A
	for <e@80x24.org>; Tue, 11 Jul 2017 20:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932680AbdGKUDJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 16:03:09 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:33977 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932446AbdGKUDI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 16:03:08 -0400
Received: by mail-lf0-f44.google.com with SMTP id t72so1707006lff.1
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 13:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9JFsEs+lS4o2XGhVbrtZYlfLF1m9osKUX+9Hi+GFhxQ=;
        b=fFDU1bSL9RokQRG36o1VzQwsbaV2icGbSz94n0YZfYZRl+2wJcEdtgbPjm+xFnGNbD
         4KKMF4JQvGfA48WVEyJZ/fwAwNqYwtLNAnz8TGkVH4Sx8HGdfQ8AnEN6eE0T85Klw2qD
         PxL/t9R+mlpZZnU5UzZ0IY/pakWrdJVUTvDI/Cj5ugewhZpKA57hIwz4zr5aBjjagx+A
         C7XQeJ+t4g0eToZ036yqcaPiRN42Zmk2277gpDFwJS9NexY7PRodH87Ru13Gkiq1PGLf
         euhxqOQ6eyY8NrpBM9QnjjeU4MYQmQY4V4wAWrKLsok01j1BdUztb1ScCrTnWQ16PGWa
         sEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9JFsEs+lS4o2XGhVbrtZYlfLF1m9osKUX+9Hi+GFhxQ=;
        b=fHbAl4LrZInxRaQIhOz8/ayKub+0WGqOxeDWb/wHNqwLxX1jkv6Kw/qIPpdS96xK79
         mphyCeJtjS6nVkmndR0cIdn4tyHYc1VtmKkposuqXv1Re+bttZr/YXrJsrpxzY6AUrqP
         Ov3+5A6qjCVmVHyTXzUR/t1QoEJFGxhm7BNDO7sPxd1d9Px7eHISfsrghS81r7PWPdF6
         0bXARR0kT/SbqEv7l5QeHV9traiplLSHS+KhFshSeSg69eRc5asXfm1+O1okyQhf655S
         c9FqtWgjMrI+7bLmhRHO9a38+6VeHSWkhjm9+Et3lgRE6CWY+2mez0uj/UHYIJMQ5Kgg
         xS2Q==
X-Gm-Message-State: AIVw111nvUoUUJJtKaBeSg5zbrvgQvWvFr8LvIhChN2iTCQL7UtqSc8b
        bf+QM0akEt0/63Dd
X-Received: by 10.46.0.170 with SMTP id e42mr633628lji.25.1499803387190;
        Tue, 11 Jul 2017 13:03:07 -0700 (PDT)
Received: from debian (c83-253-195-111.bredband.comhem.se. [83.253.195.111])
        by smtp.gmail.com with ESMTPSA id u13sm46022ljd.42.2017.07.11.13.03.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jul 2017 13:03:06 -0700 (PDT)
Received: from iveqy by debian with local (Exim 4.84)
        (envelope-from <iveqy@paksenarrion.iveqy.com>)
        id 1dV1Tm-0002QL-84; Tue, 11 Jul 2017 22:09:54 +0200
Date:   Tue, 11 Jul 2017 22:09:54 +0200
From:   Fredrik Gustafsson <iveqy@iveqy.com>
To:     Nikolay Shustov <nikolay.shustov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: "groups of files" in Git?
Message-ID: <20170711200954.GA14625@paksenarrion.iveqy.com>
References: <CAEcERAz3vYekvJ8SM1FfdAVsP3LMVqA1O3yoJVThvg-0fPtVCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEcERAz3vYekvJ8SM1FfdAVsP3LMVqA1O3yoJVThvg-0fPtVCg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
I will choose a bit of a less diplomatic path here. Instead of trying to
tell you how you can make git fit your needs, I would say that you
shouldn't. I've two arguments:

1.
It's always painful when you try to use a tool in some way it's not
intended or used to work. If you're doing something different than
anyone else using that tool, you're probably doing something wrong!

I doubt that your case is so special, so my suggestion is to either use
git the way most people use it, with one branch for each feature, or do
not use git at all, since perforce seems to be better with your
workstyle.

2.
Git is a snapshot based SCM system. That means that each commit unique
identify a version of the code. With your system (as well as any time
you're not commiting all changed files) the commit is never tested.
You've no idea of actually knowing if your two changes is dependent or
not. Of course you can guess, but it's still a guess and in your current
work way with perforce you have no way of knowing if your changesets
have a dependency between eachother or not since you never test them
individually.

--

Please let me know if you feel that I've missed something.

I can see four solutions:

1.
Now I would suggest that you have each feature in a commit and simply
run your tests every few commits so you don't have to run it for each
commit.

2.
Improve your build and test time. I'm sure there's things here to
improve.

3.
Continue to use perforce. If I recall correctly perforce has even a git
integration today.

4.
Use integration branches in git and run the tests on that branch. This
can be easy todo if you write some scripts for it.

Good luck!

-- 
Fredrik Gustafsson

phone: +46 733-608274
e-mail: iveqy@iveqy.com
website: http://www.iveqy.com
