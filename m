Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBB191F404
	for <e@80x24.org>; Tue, 13 Feb 2018 00:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933027AbeBMAxC (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 19:53:02 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:39466 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932838AbeBMAxB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 19:53:01 -0500
Received: by mail-qk0-f173.google.com with SMTP id z197so3799799qkb.6
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 16:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VX08cjX8MgBKLq4/QLuRSGJDey3YSI29Bdv5Xkzf0po=;
        b=o3T4LqSYjbYFwwdkDzZbWiDxvwFNTplMLBfW5smuO0HfEDY8vsp1GNJ81GvZcmSSaz
         1yXOo+P5YCs3kh2rg6+vS3tOg5MMWfJfB5kovMBrzwwhj68O8+luMrGm7/ZE3/+NGG+v
         Zl2bcKnlqaY2DBLpWnbgQ+mHkBYwu9QHlT3gvI2Fg6MILkg6ua0/0D4uM1/MuRy3gWaA
         T76IVQY3IrD3u7/M32WJ9bOlUT/agr4zBQNjdub4fk9clUNDp/L9qV+wGVEcFUy28Xs7
         331XmRjD3Bgbx8ZbkCvWFcc/cPpIRo8zdFuaYE0xOo7b+3nghXCJRrDPGmC1NiSNyBly
         wFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VX08cjX8MgBKLq4/QLuRSGJDey3YSI29Bdv5Xkzf0po=;
        b=SF4pz2iouOFYODq1RG0kd4ineAkq+IHoYqO2e7ZjezpZfv6s3RDFm46lHlRSETCtyY
         vLJkYLc00IVkPtWwO+D2gOW+1xFh2BmurTMqqdwhG2U4L9SkeE8uPJxPAvqpJMV08M48
         MJF3yb/ip/1MdFPtuYPTaLlW29rsQ7h9O8f4mDE+oJ5N2TD3btX7z8UnBPyuZzrg6xlf
         JFBUMRj5uK++N8AllHVrOpJ4ietJ4vHlCCDNkPGDSIkTIKySb3vDWasbWT6teV7E0J4d
         7l3CCDf08Y7eilZRHuyByc+yNk3AXlVK2oF44JAYhfg9lAtlG9FrRnN9Ow0Fybh9Z+Sj
         cR0Q==
X-Gm-Message-State: APf1xPAJu15H73r5K5TurUjIqzI7TmtjXJxpsWgJ4WkebD7QhKNueupq
        HUwxAJXJq6rAd55b5787TluHFrR1p/rO6K+O36uqQgRT
X-Google-Smtp-Source: AH8x227Y0iK0uPuCDHLzSIf/oGhYOv6hlY0ohLTehz9YFLepupEsQJ5NbeaWq82CcAsKrx/ZjNguBdp/+1PK74XkvJw=
X-Received: by 10.55.49.74 with SMTP id x71mr17327345qkx.133.1518483181122;
 Mon, 12 Feb 2018 16:53:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.28.137 with HTTP; Mon, 12 Feb 2018 16:52:20 -0800 (PST)
In-Reply-To: <5f712f6e-ecb4-db85-02de-b48be1bf1f44@pannous.com>
References: <76c2d8b6-b001-8ae5-4e66-fdeed4a1190a@pannous.com> <5f712f6e-ecb4-db85-02de-b48be1bf1f44@pannous.com>
From:   Andrew Ardill <andrew.ardill@gmail.com>
Date:   Tue, 13 Feb 2018 11:52:20 +1100
Message-ID: <CAH5451=YvnrjWreagLMCjMuGTgc-mfoL-MncRrda1PXuEQSCiA@mail.gmail.com>
Subject: Re: please change stash
To:     Karsten Fluegge <info@pannous.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Karsten,

> Normal git tooling creates different files file.ORIG file.LOCAL
> file.REMOTE in case of conflicts.

Which tools are you referring to here? Can you give a short sequence
of commands that show what you mean?

> However `git stash pop` manipulates your files directly resulting in
> lines like:
>
> <<<<<<< Updated upstream
>
>>>>>>>> Stashed changes
>
> This can seriously corrupt files and workflows.

This looks like a normal merge conflict. I suspect that you are using
tools that know how to deal with this format when it used the merge
conflict markers, but maybe not the equivalent markers you get when
popping a conflicting stash.

To demonstrate, here is a short script:

git init test
cd test
echo "base file" >test
git commit -m "base file"
git add test
git commit -m "base file"
git checkout -b conflict_branch
echo "conflicting file" >test
git commit -am "conflict file"
git checkout master
echo "updated file" >test
git commit -am "updated file"
git merge conflict_branch


This merge fails, and the file 'test' looks like this:

<<<<<<< HEAD
updated file
=======
conflicting file
>>>>>>> conflict_branch

As you can see, this sequence of actions doesn't result in 3 different files.

The merge conflict format is a relatively old one, and lots of tools
know how to use it in different ways (such as the tool you are using,
I presume) but say this was to be changed for the stash operation -
what would you propose replace it?
Some options might be to:
- instead of placing the conflicts in the original file, place the
different conflicting versions into different files
- warn when adding/committing/pushing files with conflict markers in them
- teach the tool you are using to handle the stash conflict markers in
a nicer way

Some of these may be possible to do with little work.
This link[0] on stack overflow deals with creating separate files, and
it looks like it might work for stash pop conflicts.
This one[1] shows how to create hooks that catch any conflicts that
are being committed, and would also probably work with stash
conflicts.

Teaching the tool to handle stash conflicts, or making any of the
above changes to the base distribution of git would be significantly
harder, but maybe this can help you in the meantime.

Regards,

Andrew Ardill

[0] https://stackoverflow.com/questions/47512337/configure-git-to-create-multiple-files-for-merge-conflicts
[1] https://stackoverflow.com/questions/24213948/prevent-file-with-merge-conflicts-from-getting-committed-in-git
