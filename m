Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5A231F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 20:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfJ2UZ3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 16:25:29 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41832 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbfJ2UZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 16:25:28 -0400
Received: by mail-lj1-f194.google.com with SMTP id m9so78409ljh.8
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 13:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deltaq.org; s=deltaq;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kd6sXpRXAphrgpq7p7mEQ/oQ/2M6Fgt0IL5i3JyWAZw=;
        b=VZPQdhHnUXVXjdLi0z6ANR8qd87PN0M421/eqYGoXuhXfHWx905A344JDLDFpU+RcS
         nSeFG/enbNhYPzgKtwMXdJ/aVNWoqJl9LeX7c4FprvZpCfEMY5uu43JNA+j5xWtwlff/
         s4eOUqAhYfzNqV6Nj+NsE9aTYDdzeaRbOoSjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kd6sXpRXAphrgpq7p7mEQ/oQ/2M6Fgt0IL5i3JyWAZw=;
        b=IgbsxG/qug6Sz5/hxPUaMusGIbdv1AFxzd8StgKJVHyTE2+8e/a7BxVGAB6F3QCJs6
         +IXOM8Seh3gU9z13AG36yoxGuyIcgLNYMRZxGmN8bf77fv9pDDjpkgZoUWtF/zRZzq9Q
         8oBEJ+ntc6UrMi1kuBD+OnF5k5wR53b6tBS26/8C5T2PqGobd5ywrJYfiTwpGV8bTMgq
         wlZewxxqPMRK8A/Mp6cAEgJntAoy/3rdmYTTHAStIl5EGDdczSdgPspX23dOtaNjkAqb
         H1p67GznL+oBGZ23FG6dFR+oa8oRS5io12Z7lPdZSvp17GP99wKSKCUOb3g0BksypiW7
         yEBg==
X-Gm-Message-State: APjAAAU+LJaMFr4LUzdjbUZnoHZavAzYvRQURTLEBSWKAD8BLYJAMZnq
        PNYtb9+bnBn/ZmZq5sTl15YH9b9oC8IVjVLyQ3rcWg==
X-Google-Smtp-Source: APXvYqzRyFKu+v2PXWXV5hIcW8ddnmrfITCYDpcZ2DSevRRn9yXOr74Dow5lGIvhxvh0rR7qZJD+JR1rcBrm2mBcwRo=
X-Received: by 2002:a2e:858d:: with SMTP id b13mr3575658lji.71.1572380726431;
 Tue, 29 Oct 2019 13:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <pull.423.git.1572289087.gitgitgadget@gmail.com> <CAKPyHN3WEpVLnxYN5FsovW3G_borc+YrF05Npr0Wyvv6YhbcaQ@mail.gmail.com>
In-Reply-To: <CAKPyHN3WEpVLnxYN5FsovW3G_borc+YrF05Npr0Wyvv6YhbcaQ@mail.gmail.com>
From:   Jonathan Gilbert <logic@deltaq.org>
Date:   Tue, 29 Oct 2019 15:25:04 -0500
Message-ID: <CAPSOpYsA9n6Y1vH1_+vRTCV7Mrvox4L2LpQmpXBnpH8ke0yDhQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] Allow the 'revert' option in Git Gui to operate on
 untracked files, deleting them
To:     "Bert Wesarg bert.wesarg-at-googlemail.com |GitHub Public/Example Allow|" 
        <xlwsizdz58ciy7t@sneakemail.com>
Cc:     Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That's kind of neat, I wasn't aware of that facet of Git Gui :-) But,
it isn't quite the same feature:

* It has to be manually set up on each installation.
* It invokes an external process, I don't know if it's safe to assume
that "rm" will work on all platforms (though I just tested it on my
Windows installation and it worked).
* It doesn't remove directories that it makes empty.
* I don't see a way to bind it to a keyboard shortcut. That could just
be me not knowing enough about custom tools, though. :-)
* It only processes the first file selected.
* If I select a tracked file, it will still delete it, and the feature
I'm looking for is more of a "return repository to clean state" type
function, like "revert" already is but extended to handle files that
you can't actually "git revert".

Thanks,

Jonathan Gilbert

On Tue, Oct 29, 2019 at 9:32 AM Bert Wesarg
bert.wesarg-at-googlemail.com |GitHub Public/Example Allow|
<xlwsizdz58ciy7t@sneakemail.com> wrote:
>
> On Mon, Oct 28, 2019 at 7:58 PM Jonathan Gilbert via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > My development environment sometimes makes automatic changes that I don't
> > want to keep. In some cases, this involves new files being added that I
> > don't want to commit or keep. I have typically had to explicitly delete
> > those files externally to Git Gui, and I want to be able to just select
> > those newly-created untracked files and "revert" them into oblivion.
> >
>
> I have an entry in the 'Tools" menu for this called 'Delete':
>
> [guitool "Delete"]
>     cmd = rm -f \"$FILENAME\"
>     noconsole = yes
>     needsfile = yes
>     confirm = yes
>
> Best,
> Bert
>
> > This change updates the revert_helper function to check for untracked files
> > as well as changes, and then any changes to be reverted and untracked files
> > are handled by independent blocks of code. The user is prompted
> > independently for untracked files, since the underlying action is
> > fundamentally different (rm -f). If after deleting untracked files, the
> > directory containing them becomes empty, then the directory is removed as
> > well.
> >
> > This introduces new strings in index.tcl. I have been told that there is a
> > separate process whereby the translations get updated.
> >
> > Jonathan Gilbert (1):
> >   git-gui: Revert untracked files by deleting them
> >
> >  git-gui/lib/index.tcl | 139 +++++++++++++++++++++++++++++++-----------
> >  1 file changed, 104 insertions(+), 35 deletions(-)
> >
> >
