Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99FE42035A
	for <e@80x24.org>; Tue, 11 Jul 2017 17:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933516AbdGKRr4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 13:47:56 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:37897 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932462AbdGKRrz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 13:47:55 -0400
Received: by mail-it0-f42.google.com with SMTP id k192so29190856ith.1
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 10:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gWIjCHtDyHIUjEcVMpu2eh5OpULoH+vlB/XtBAg96fg=;
        b=BBxnPnD3p/ZLXaqmui1UnTBk1yRPGzHywAnq5sgNVzMg335Ld+LoKS2FMnPzuK9Q7g
         urB4hE72POjs0i1kGBM3uf9uZ+AT8PFrvUTCQUbsf4d6hNfbkcOCbKHrV4PltMc55xsn
         HWWZoemr6xHB6GxeGs0aQFhI18SKl53dx/jUtF0DZn9uLPVUIisNbvF5sbG8INncgCYi
         7qeirJhFisIcyfX4z9X+lQSOwlQL1sxrs91F52Sdt8LmcSPGkwJzvMVN7xLf/MZrJ50h
         62n5obeM9HfM9+6YNOZN+MkeMZqQ2AUbXiITlSHmhIlqu9HWSpK+l5GbamA+IJniCDfa
         PWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gWIjCHtDyHIUjEcVMpu2eh5OpULoH+vlB/XtBAg96fg=;
        b=VPxngh3v6jNursxuXLDmTzeyacTpZXv+IeG+S64QOOZqpP1zcNUD4u5zWhMgp7tDvT
         ds8aScNadgtJ6XOSgzNTvEJ3qf3iN6lU+guHd5PkCN79tO8MJ4XhK81kV0CWTg+g2pGs
         EKXIPTfVnqZgNCA6ymyIt6lzI+SjTpfZpEfquftKn1akcdLulPEBZjTkqPW7XSE/ygnw
         Tr6/581RyvvJJBLu465y2tIKKeTLWUduKBSyhEjm+FWKHOb4iA0Tto+our2pESu9vlrU
         2oyEhYVM2WYmNxjbWyjl6qrn3nRqot8HlgR7tVs8dxwwNsaLo8mW1uGuStoUIu76oFP6
         09nA==
X-Gm-Message-State: AIVw110+GqxYYQh1Sw56ml8h5WfKFpg1W+8VpfdFCEln4jqXCA43Pfjz
        uuVPSkeQ79qUHH3+/PrPRHYjD5aUw3Qa
X-Received: by 10.36.214.150 with SMTP id o144mr18437914itg.57.1499795274764;
 Tue, 11 Jul 2017 10:47:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.26.138 with HTTP; Tue, 11 Jul 2017 10:47:54 -0700 (PDT)
In-Reply-To: <CAGZ79kZaf7=uwCPJoPoDiAO9QS21bchaKZvDzWJi=ewPZw9PXQ@mail.gmail.com>
References: <CAEcERAz3vYekvJ8SM1FfdAVsP3LMVqA1O3yoJVThvg-0fPtVCg@mail.gmail.com>
 <CAGZ79kZaf7=uwCPJoPoDiAO9QS21bchaKZvDzWJi=ewPZw9PXQ@mail.gmail.com>
From:   Nikolay Shustov <nikolay.shustov@gmail.com>
Date:   Tue, 11 Jul 2017 13:47:54 -0400
Message-ID: <CAEcERAyU=UqHY0ez8SkJ-1vRmrgB2KcdmwXow59bRHpgs2wQhA@mail.gmail.com>
Subject: Re: "groups of files" in Git?
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The way of Git is that a commit (snapshot) by definition describes a
> set of files (The set of all files in the project). So If you need two features
> there at the same time, you probably want it in the same commit.

Thank you, but if I wanted these two features to be in the same
commit, I would have no reasons to see them as two distinctive groups.
I mean, groups of uncommitted files.

The general problem of not having multiple features in the same code
tree is the cost of doing multiple builds and integration testing
runs.
Now I imagine there could be workaround of having two features
developed at different branches and then merging them into 3rd branch
for building/testing; however this introduces overhead of maintaining
at lest two code trees: one for "dirty changes" where I do the code
changes that are not guaranteed to be even build-able and another
"build/test" code tree. Plus merging the changes from one to another.
A bit too much, IMHO.

On Tue, Jul 11, 2017 at 1:18 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Jul 11, 2017 at 8:45 AM, Nikolay Shustov
> <nikolay.shustov@gmail.com> wrote:
>> Hi,
>> I have been recently struggling with migrating my development workflow
>> from Perforce to Git, all because of the following thing:
>>
>> I have to work on several features in the same code tree parallel, in
>> the same Perforce workspace. The major reason why I cannot work on one
>> feature then on another is just because I have to make sure that the
>> changes in the related areas of the product play together well.
>
> So in that case the features are not independent, but related to each other?
> In that case you want to have these things in the same working tree as
> well as in the same branch.
>
> Take a look at git.git itself, for example:
>
>     git clone git://github.com/git/git
>     git log --oneline --graph
>
> You will see a lot of "Merge X into master/maint" commits, but then
> you may want to dive into each feature by:
>
>     git log --oneline e83e71c5e1
>
> for example and then you'll see lots of commits (that were developed
> in the same branch), but that are closely related. However they are
> different enough to be in different commits. (different features, as
> I understand)
>
>> With Perforce, I can have multiple changelists opened, that group the
>> changed files as needed.
>>
>> With Git I cannot seem to finding the possibility to figure out how to
>> achieve the same result. And the problem is that putting change sets
>> on different Git branches (or workdirs, or whatever Git offers that
>> makes the changes to be NOT in the same source tree) is not a viable
>> option from me as I would have to re-build code as I re-integrate the
>> changes between the branches (or whatever changes separation Git
>> feature is used).
>
> you would merge the branches and then run the tests/integration. Yes that
> seems cumbersome.
>
>> Build takes time and resources and considering that I have to do it on
>> multiple platforms (I do cross-platform development) it really
>> denominates the option of not having multiple changes in the same code
>> tree.
>>
>> Am I ignorant about some Git feature/way of using Git that would help?
>> Is it worth considering adding to Git a feature like "group of files"
>> that would offer some virtutal grouping of the locally changed files
>> in the checked-out branch?
>
> The way of Git is that a commit (snapshot) by definition describes a
> set of files (The set of all files in the project). So If you need two features
> there at the same time, you probably want it in the same commit.
>
> If they are different enough such that you could have them independently,
> but really want to test them together, your testing may need to become
> more elaborate (test a merge of all feature branches) I would think.
>
>>
>> Thanks in advance,
>> - Nikolay
