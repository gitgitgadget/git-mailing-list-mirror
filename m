Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 666D01F42D
	for <e@80x24.org>; Sun, 27 May 2018 12:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936400AbeE0Mxs (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 May 2018 08:53:48 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:33924 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936343AbeE0Mxr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 May 2018 08:53:47 -0400
Received: by mail-wr0-f169.google.com with SMTP id j1-v6so16114583wrm.1
        for <git@vger.kernel.org>; Sun, 27 May 2018 05:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lECji0lTqpwsKkZRp8Gk2mdtyS48qIO2O2+DU+j/CH8=;
        b=g3YpO5Mh2vWQ04PFX0EpqmubRW3Y9FlIrugOtNFHKi8oPKOoWwQ5Ca2FYk1+1vvSLp
         8htjSlDjPmkz8ZTRK3Q9zZUavpE1Y7+gPYhaFSdKjP7HSR6MV7Mojb9ybQWZXzIuoFiu
         KmOu4hgKZBuGWPu6vmloAFD0hgiDSSF0YBoG/dOsQ177UZzht33OljZ+7mFyJqdDTI6G
         s5E+berC5pcIiX08OVf8jqXcfkPVjT/isYASgY1x7aYWVT4iPrP/VeWAzfsi8PglCDdS
         G37j5y6c+IToB2u17MHokiletid+Omac3NPP8+VewHGWwQOKRPydYvRcgyiSyNZZDSDz
         AhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lECji0lTqpwsKkZRp8Gk2mdtyS48qIO2O2+DU+j/CH8=;
        b=bpIdqb25UzJI9e4rGG4CvK48CRUIobIGRkwDVxg9TImMDzTPFuJU3ZDu7An3mQP4y3
         SozUmDnVL2tiEzVvqK5zmENLUCH3DAxyrtZzxYHD+7sZ75o4xhPrOBXtEsPFni1hWhOe
         XBVNTLu68cjCh5h/DRrNEoX0AhAdh9rGXMSADpIcigxPPOILMl/41N305rUUwRvxMObG
         YDVdyLvFuv3fjMmUPq8lgfMejirP1sfAifvxazl6UJiwEH7f3FmkoLJuffsROXNtxeZV
         KjVvU387f9oucmaeQDaPFOq/OYlMADGKRjF7JiC5AacKn1TDXqT+dnscFHWAoFI61I/a
         oYDA==
X-Gm-Message-State: ALKqPwc7BZ417COoIwE7UKsryBfz9sM28DALMi4HzOkIYd9rgaN43V29
        jSDSKc7G+/5JXjFWjv3fg8syf7/Ty9dbSeAVdMjojQ==
X-Google-Smtp-Source: ADUXVKJZighx50bT6PvlZy79BtW2fSuimujEpDEZj2cGOHoj+mleidzP0i2xcxKL8gZNMOrw3F8h+27krdXwCnaB6IM=
X-Received: by 2002:a19:ea99:: with SMTP id y25-v6mr5173344lfi.20.1527425625604;
 Sun, 27 May 2018 05:53:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:d485:0:0:0:0:0 with HTTP; Sun, 27 May 2018 05:53:25
 -0700 (PDT)
In-Reply-To: <1EAAF778D73B4AA689ADB5AE2EE9D1DD@PhilipOakley>
References: <CAAUqJDu_3DTyd1cFKaNRKOzo3AHosfxP1jjWpa=HGtyAyitTeA@mail.gmail.com>
 <CAAUqJDvsRBJWZh5_A2e2x-CqgXi5gLSjo6-P2sYxsKz3qfidSw@mail.gmail.com> <1EAAF778D73B4AA689ADB5AE2EE9D1DD@PhilipOakley>
From:   =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Date:   Sun, 27 May 2018 14:53:25 +0200
Message-ID: <CAAUqJDvCgXPubhtSKzMLqTU5au320U15UQ8Lst7+JeZYBp8wTA@mail.gmail.com>
Subject: Re: git rebase -i --exec and changing directory
To:     Philip Oakley <philipoakley@iee.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

2018-05-27 14:28 GMT+02:00 Philip Oakley <philipoakley@iee.org>:
> You may need to give a bit more background of things that seem obvious to
> you.
> So where is the src directory you are cd'ing to relative to the
> directory/repository you are creating?

It is located in the top-level directory of the working tree (in the
same directory that .git is in).

From git-rebase(1):

    The "exec" command launches the command in a shell (the one
    specified in $SHELL, or the default shell if $SHELL is not set), so
    you can use shell features (like "cd", ">", ";" ...). The command is
    run from the root of the working tree.

So I need to run 'cd src' if I want to run a command in there
(regardless of the working directory of the git rebase command
itself).

> What is [the name of] the directory you are currently in, etc. ?

I don't think that is relevant here. FWIW, when verifying the problem
I ran the reproducer from my original message in a directory whose
path did not contain any spaces or special characters.

Did you try to run the reproducing commands I posted? Did you get a
different result? You should see the following in the output of 'cd
dir && git status':

[...]
Changes not staged for commit:
 (use "git add/rm <file>..." to update what will be committed)
 (use "git checkout -- <file>..." to discard changes in working directory)

       deleted:    a
       deleted:    b
       deleted:    dir/x
       deleted:    reproduce.sh

Untracked files:
 (use "git add <file>..." to include in what will be committed)

       x
[...]

When I drop the 'cd dir && ' from before 'git status', the output is
as expected:

You are currently editing a commit while rebasing branch 'master' on '19765=
db'.
 (use "git commit --amend" to amend the current commit)
 (use "git rebase --continue" once you are satisfied with your changes)

nothing to commit, working tree clean

>
> Philip
> --
>
> From: "Ondrej Mosn=C3=A1=C4=8Dek" <omosnacek@gmail.com>
> Bump? Has anyone had time to look at this?
>
> 2018-05-19 18:38 GMT+02:00 Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com=
>:
>>
>> Hello,
>>
>> I am trying to run a script to edit multiple commits using 'git rebase
>> -i --exec ...' and I ran into a strange behavior when I run 'cd'
>> inside the --exec command and subsequently run a git command. For
>> example, if the command is 'cd src && git status', then git status
>> reports as if all files in the repository are deleted.
>>
>> Example command sequence to reproduce the problem:
>>
>>     # Setup:
>>     touch a
>>     mkdir dir
>>     touch dir/x
>>
>>     git init .
>>     git add --all
>>     git commit -m commit1
>>     git tag base
>>     touch b
>>     git add --all
>>     git commit -m commit2
>>
>>     # Here we go:
>>     git rebase -i --exec 'cd dir && git status' base
>>
>>     # Spawning a sub-shell doesn't help:
>>     git rebase -i --exec '(cd dir && git status)' base
>>
>> Is this expected behavior or did I found a bug? Is there any
>> workaround, other than cd'ing to the toplevel directory every time I
>> want to run a git command when I am inside a subdirectory?
>>
>> $ git --version
>> git version 2.17.0
>>
>> Thanks,
>>
>> Ondrej Mosnacek
>
>
