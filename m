Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C08D51F404
	for <e@80x24.org>; Mon, 19 Mar 2018 23:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934015AbeCSXLx (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 19:11:53 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:54067 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933619AbeCSXLw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 19:11:52 -0400
Received: by mail-it0-f54.google.com with SMTP id b136-v6so41891iti.3
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 16:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bUWvQPybqDjO51l/P53/091OuICGKAj/M5GZhWLc2zk=;
        b=jCH2JUZKsWmg2sVdaNfkzhCVjXYFGeTEeu3g+Tm9qGcElSK+ckWwZU6uqfeXjqQq1W
         qsSJrwMFLOt13X2Yb+4B5JNwqRDDgw9hLq8rGNU8oveJo6+pCFunTq3VQOvxlhXqOb94
         EKiFE/dNioVNbc1INWOUuIGcyLwYyvSPm7p701xD0Qi4++y4Gdonl87kM5BBsjebVzuy
         kYhdRPHsALQOTqAMUwp7MsCSBk5QY8X6COSklkZDEtu7mlURrQVBg86zbrm/p1q5XtgJ
         BZ0PAE3CKK90lPZpNkpsOW4qbEufUL3axUSOIESyrh9RxQFPAYhKOR2DCiX8V4qwNlpk
         637g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bUWvQPybqDjO51l/P53/091OuICGKAj/M5GZhWLc2zk=;
        b=WYvPZNJRSQqUrBkchHM3CoLuNgCVDctNFzxKi4tfIQjqBoH72rsI4aDQuvX/80fL5o
         mJ/L72gnETdgsf1CjqRr0TF2TJg6rRBL2qEt+a2D2huYdDvQirR1UwE16xPIiM46W0wi
         ox0QfHzvf2COOAPgerb+Yr2ucRiA7MOpB9X51gWjSL6lQZbbUHjdcuLkGp5RKlkbuvU/
         hfEXVIAxl9iyTizeOINvAoD/qc1DmcbvwdwPA32nyQWUDeDMwOXnc4xsUOYeshkBLhVL
         FhSCxiC2UYcH7oYz5crgu+cX5LwX+WliDQIXSgijyHQ3OzuIfjKsxkwPwGsW9BLHoQp6
         EZkA==
X-Gm-Message-State: AElRT7Ef/clh8IY/Br8xWP8PrfDB6qz+qlJ8l+y3fIx3HhTWXFr14zo9
        iD0gMQ5Uq+SIeYzLGeeih2DhC4ltW5nmA8+Tw5E=
X-Google-Smtp-Source: AG47ELuMmQLhMZUYqPFewsFCTB0XxfELtDIukWvgSZBYkWRL77rJqRcpAFMetz+JmP6OXzoq2A6sIs35Q1+Fr4yLcv4=
X-Received: by 2002:a24:ac52:: with SMTP id m18-v6mr582179iti.21.1521501111564;
 Mon, 19 Mar 2018 16:11:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.146.25 with HTTP; Mon, 19 Mar 2018 16:11:50 -0700 (PDT)
In-Reply-To: <CADzBBBb0KDVJiX2WSNW=vC6b6paWoK=5XrnZNAY+pwpcu-t9JA@mail.gmail.com>
References: <CADzBBBb0KDVJiX2WSNW=vC6b6paWoK=5XrnZNAY+pwpcu-t9JA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 20 Mar 2018 00:11:50 +0100
Message-ID: <CAP8UFD0aQxSZVRfOHUP80H+677zoNWPU1pdg7v4Qk+gKXCG8eg@mail.gmail.com>
Subject: Re: [GSoC] Regarding "Convert scripts to builtins"
To:     Paul Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git <git@vger.kernel.org>, Yash Yadav <yashdimpu@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, Mar 18, 2018 at 11:15 PM, Paul Sebastian Ungureanu
<ungureanupaulsebastian@gmail.com> wrote:
> Hello,
>
> I am interested in the "Convert scripts to builtins" project. I have
> recently started to analyze it better and see exactly what it entails
> and a few questions came to my mind.

Great! As other potential GSoC students are also interested I'm adding
them into Cc.

> First of all, I find it difficult to pick which scripts would benefit
> the most by being rewritten. I am thinking of git bisect, git stash
> and git rebase since these are maybe some of the most popular commands
> of Git. However, on the other side, scripts like
> git-rebase--interactive.sh and git-bisect.sh are also subject of other
> GSoC projects. Should I steer away from these projects or can I
> consider them?

If you are interested in converting these scripts, you should probably
ask publicly to the former GSoC students who have been working on
these projects if they still plan to continue working on them of if
they are ok to let you finish/continue their work. You will get extra
bonus points if they agree to help you or maybe co-mentor you.

> Secondly, what is too little or too much? On one hand, I do want to do
> my best and help the Git community as much as I can. On the other
> hand, I do not want to have too much on my plate and not be able to
> finish my project. Considering that mentors have already decided that
> git rebase --interactive and git bisect are enough for two projects,
> how could I quantify the time required for each command? Looking back
> at the previous editions of GSoC I noticed that most projects were
> focused on only one command.

Yeah, I don't think it is a good idea to focus on more than one
command per project. It could be possible if there were really small
scripts to convert, but I think those have been already converted. It
could perhaps be possible if 2 scripts were very similar, but I don't
think there are similar enough scripts to convert.

You can however submit more than one proposal, so you could for
example submit one proposal to convert one script and another one to
convert another script.

> From my research, these are the scripts that could be subject of this
> project. Which ones do you think could be the best choice for a
> project of this kind?

I think it is definitely a good idea to work on a script that has
started to be converted. Make sure that no one is still actively
working on converting it though.

I think the scripts related to other versions control systems are not
a good choice as they are not really part of the core of Git.

It is also a good idea to choose scripts that potential mentors are
familiar with.

>  * git/git-add--interactive.perl
>  * git/git-archimport.perl
>  * git/git-bisect.sh -- there is a project about this
>  * git/git-cvsexportcommit.perl
>  * git/git-cvsimport.perl
>  * git/git-cvsserver.perl
>  * git/git-difftool--helper.sh
>  * git/git-filter-branch.sh
>  * git/git-instaweb.sh
>  * git/git-merge-octopus.sh
>  * git/git-merge-one-file.sh
>  * git/git-merge-resolve.sh
>  * git/git-mergetool--lib.sh
>  * git/git-mergetool.sh
>  * git/git-quiltimport.sh
>  * git/git-rebase--am.sh
>  * git/git-rebase--interactive.sh -- there is a project about this
>  * git/git-rebase--merge.sh
>  * git/git-rebase.sh
>  * git/git-remote-testgit.sh
>  * git/git-request-pull.sh
>  * git/git-send-email.perl
>  * git/git-stash.sh
>  * git/git-submodule.sh -- there was a project about this
>  * git/git-svn.perl
>  * git/git-web--browse.sh

It would be interesting to know the number of lines of code for each
of these script, as it could give an idea about how big the task of
fully converting the script could be.

> I look forward to hearing from you. I will also submit a draft of my
> proposal soon enough.

Great!

Christian.
