Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 078CF2095E
	for <e@80x24.org>; Sat, 18 Mar 2017 04:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751087AbdCREht (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 00:37:49 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38415 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbdCREhs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 00:37:48 -0400
Received: by mail-wm0-f49.google.com with SMTP id t189so29269176wmt.1
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 21:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GEYydKKgyFdxxFxfXOpDxdotTAaWtKW/pVHOxLTGkYI=;
        b=E+q8Ma0mOG1JA+hMhJUHAbwgBxj0d1XLCRVykWv857Qsp8AS2A0bq6GEvYzA2O1QEg
         wLiAficiKc17OHRP0q0MYNtlEeZTrdOOwF39Tp1E1KSq74YMRu4sTXdo9uiF7pnf3Wrb
         rLB1eT+DuSn//bLm0o6Kwa//0idNsTw2baQ8Kuknd0q4SNEBz22cxmzBf0QV9Kjv3gT5
         dlGihU90//C3VgqaTWLuLKz3uoDOX13DvCPzs11pVx3z2/PjfIuRb1mP1XHR3pDLYwFN
         Y6Is6lsA98873tBh2ixt+AuR0eZ8jSawdFjdB49r9Jkk+cy9Gdjc8Ai9b6l1L5llBpxX
         v9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GEYydKKgyFdxxFxfXOpDxdotTAaWtKW/pVHOxLTGkYI=;
        b=FArW1S1fznGWOmOlN5fXn9bulqvkQNUMV7mgm5CdAVkhp/xrSg0vnvV/NrIIslIzO0
         vSRkb6czxc0rJMeRuAzs7bGOtVcKyFaxwvszCH/3BIXewhkT4jOhellX1K3Ceg7Ss4bs
         J2Xk4suIhHkbiBPq8Y6Tw+tL2VKgRt1DOfNci3vK5yFqNIke1/tom+9k8R22aaChGjLB
         V6vgxxnXgR+hNnmq9iyqFBLRiYqG2vZSdf5W6MzOw6EBtw6LpRwpOdni+eKyGWRSV5RW
         fiw3oJkBiJx+RPetZWm3pmuC6vJSddU00LeeNCL6g+utnl6MCG5BmokFGSLXUBS3h04+
         YfaA==
X-Gm-Message-State: AFeK/H0qoZ1h5W5rwSECQcOFA0Cme6rm4K4ifGGOC35h6gc7exbUl/eebSOA31ceCO7XtmitloYzz1IMXc2zwQ==
X-Received: by 10.28.45.213 with SMTP id t204mr1094053wmt.113.1489811460588;
 Fri, 17 Mar 2017 21:31:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.130.1 with HTTP; Fri, 17 Mar 2017 21:30:40 -0700 (PDT)
In-Reply-To: <xmqqmvcj61j2.fsf@gitster.mtv.corp.google.com>
References: <CAPUVn2u0Uos2mT5+4ejj8m0okNK6XwerL6ce2miHfhtuEs-ZnQ@mail.gmail.com>
 <xmqqmvcj61j2.fsf@gitster.mtv.corp.google.com>
From:   Nevada Sanchez <sanchez.nevada@gmail.com>
Date:   Sat, 18 Mar 2017 00:30:40 -0400
Message-ID: <CAPUVn2tXxq4Ab0aDKPmRpojnWuTdJBTuYskJLcgNgEemNJ3FnQ@mail.gmail.com>
Subject: Re: Bug with .gitignore and branch switching
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 17, 2017 at 5:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nevada Sanchez <sanchez.nevada@gmail.com> writes:
>
>> Here's an easy to reproduce bug. It's the only example I know of where
>> git legitimately loses data in a way that is unrecoverable,
>> unexpected, and without warning.
>
> This is an example of a user explicitly telling git to discard data
> and git performing as it is told.
>
> There is no "untracked but precious" vs "untracked and expendable"
> difference in the current system.  An untracked file that matches
> patterns listed in .gitignore is treated as the latter.
>
> When you have an untracked file that .gitignore knows about in the
> working tree while you are on "feature", if switching to another
> branch requires to remove that file, the content there is deemed
> expendable, because the user said so by listing it in .gitignore.
>
> We've discussed the lack of "untracked but precious" class a few
> times on the list in the past, but I do not recall the topic came up
> in the recent past.  It perhaps is because nobody found that class
> useful enough so far.

I must admit that I missed that attribute of .gitignore (i.e.
untracked and **expendable**). I have grown accustomed to Git being
rather conservative and erring on the side of not losing data unless
the user is doing something deliberate (for example, 'git clean' won't
work unless you force it, checkouts fail if they do anything that
might lose data... unless it is in .gitignore, as I just learned).
When I saw this behavior, I assumed that it was a bug.

This isn't necessarily a situation I need to have fixed--it is not
part of my workflow and since that fateful commit, all feature
branches checked out after the change to .gitignore will not have any
problems as I switch branches. It was an unfortunate surprise to one
of my co-workers, not long after I reassured him that git was
conservative and will almost never accidentally lose data (even if it
means going to 'git reflog').

In keeping with this spirit, I would tend to lean towards having
"untracked but precious" being the default behavior (more
conservative), and if a user wants "untracked but expendable"
behavior, then that case requires special effort from the user (like
learning about and using a new type of ignore file). My guess is that
if the user is both ignoring and committing something to their
repository, it is probably a mistake, and as that user, I would rather
discover that mistake early with loud warning messages (and/or a
suggestion to use an alternate ignore strategy, or config flag), than
learn about it by losing data.

In summary, I do not need this fixed for my workflow, but want to
bring it to light in case other users are being similarly surprised. I
struggle to guess how far reaching of an impact it would have on
existing users to change the default behavior, but it would probably
be less than that of the push default behavior change that happened
not too long ago.

A quick and easy immediate step is to make note of this behavior in
the very first sentence of gitignore(5):

> A gitignore file specifies intentionally untracked files that Git should ignore *and that Git is allowed to overwrite without warning*.

More details about untracked but expendable can be placed in the NOTES
section, but the last part of that sentence would be quite helpful.

Thank you,
-Nevada
