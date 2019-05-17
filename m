Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B2E71F461
	for <e@80x24.org>; Fri, 17 May 2019 11:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbfEQLDA (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 07:03:00 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:33299 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbfEQLC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 07:02:59 -0400
Received: by mail-pl1-f177.google.com with SMTP id y3so3228663plp.0
        for <git@vger.kernel.org>; Fri, 17 May 2019 04:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j3kPIkcB0mBMV7NOSwdqZ0G7NSxdeoi3DV3VLbsadOg=;
        b=CAhcBSKzIYai1p66hJiNgs12Ujorz69hRsqs+JeR40fiAiD+5pQXgmSIxiV9cLqaUv
         zTUO17BMN3Q9C2e79makNo1beT5AwoxcFspqSmQEe/luFTvgbr3FzkyCnmQDzwtOUS3Z
         eCaHlAf88NKz6QaNZODMnbTBhKhGawP9+j72+A79pYHdMXtqz5YFU712igjvTfstw1jR
         8qbKyhVE6BFRCScImS6GUaVzLqoGr1UqsKWqFq9Kw/cwirO39tFJHZjs+jT2/Ix/vu96
         p52LF5Nw6NVZDTrfExFenbW8VoUp/yGR4Z/31lBbzN39lhTSXDzXX62XoPGZkyO2WQMk
         9vAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j3kPIkcB0mBMV7NOSwdqZ0G7NSxdeoi3DV3VLbsadOg=;
        b=hLvOBoXC9Uq+RJP/y8NeHrZ/+giHx7EibkII1Al0f2/MSmK7dWa6xh+CVgsPLEJP/L
         ouKr5r7/gOZbaxL72oDvhiMQ6d0BLrgwcIf0gfHL1WIDIbmODUPCSR9dYI2K9FyJhjhR
         sy4smd/0eUtp99XKabhBpqYo3ETQORpZO5yDl8si9yk2zszVjmSKDeLf+4tYALi9WCGC
         8g4tQ8+QLMDTJzuDCO+YwyjLEu9uB4pq8nykyftRdzcuMdkQSm/Ehko+wFlQ/Om2IALo
         p/SnKOpvNoE1rko///w+8I4IHWGm+A4FDUsjdr4S9UEYl9j6OzsHr5TWT0gwH04zmZh7
         6BXQ==
X-Gm-Message-State: APjAAAUyuip8ApgkCyGqVuX9m6+1LfuHy+9mtRW4wCix08n06JF1Gcn9
        iLbH/HgdMTgOfD6oDcp3D412Id17qLZgLl8TPTFtXZk4
X-Google-Smtp-Source: APXvYqxGYMY8gqAUTIhqwQj5ESFIe/rKFjk1tFxLGU8Hlej+EJSq5aZeS1V6/dr0CmIrAZBkiaVV3HmCkhCaVWI3uaU=
X-Received: by 2002:a17:902:a611:: with SMTP id u17mr21158039plq.38.1558090978629;
 Fri, 17 May 2019 04:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAGqZTUvTg5S_-i9JjOwEG75CY+xFXJHAwTqh8uLG3SQTa3O0YA@mail.gmail.com>
 <CAPig+cQ0MB4F++JDC-RO2SFA4Hv7DiEW4hNJGQs71Wi75pXuOg@mail.gmail.com>
In-Reply-To: <CAPig+cQ0MB4F++JDC-RO2SFA4Hv7DiEW4hNJGQs71Wi75pXuOg@mail.gmail.com>
From:   clime <clime7@gmail.com>
Date:   Fri, 17 May 2019 13:02:47 +0200
Message-ID: <CAGqZTUv7zkgT=GJK5Mo7HCoNcjqvsZoCKb93Pc=_r6LcskAabw@mail.gmail.com>
Subject: Re: getting pull/push/fetch url
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 17 May 2019 at 10:10, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Fri, May 17, 2019 at 3:30 AM clime <clime7@gmail.com> wrote:
> > for my app, i need to be able get remote urls (fetch/pull/push) so
> > that i can derive some information from those, e.g. pull url netloc
> > from which i derive where other custom endpoints (binary file storage)
> > related to the remote git repo is located. This is just one example. I
> > am also using fetch url to store it into the composed package that i
> > generate by the app.
> >
> > Now, the problem is that getting those urls (fetch/pull/push) doesn't
> > seem to be an easy task. Currently i have the attached scripts to do
> > that. But i noticed that older gits like 1.7 use origin as a fallback
> > for pull url whereas the newer raise an error.
> >
> > My question is if there is a better way to determine the urls that
> > would be backward compatible and easier than what i am doing right
> > now.
>
> Perhaps not a complete answer (and I'm sure people more familiar with
> the topic can provide better direction), but have you tried querying
> this information via higher-level commands rather than low-level
> git-config? For instance, to get the name of the remote for a branch:
>
>     git branch --list --format='%(upstream:remotename)' $BRANCH
>
> and, to get the fetch URL for a remote:
>
>     git remote get-url $REMOTE
>
> or the push URL:
>
>     git remote get-url --push $REMOTE

Right, the problem is that both constructs `git branch --list
--format=<format> <branch>` and `git remote get-url <remote>`
works only under git v2 (not exactly sure about the minor version) but
they do not work under git 1.7.1 and git 1.8.3, it
seems.

Anyway, i figured i was too fuzzy in what kind of url i actually need.
I thought about it a bit more and figured that I probably this

function git_branch_remote {
    branch_remote="$(git -C "$GIT_ROOT" config --get
branch."$GIT_BRANCH".pushRemote)"

    if [ -z "$branch_remote" ]; then
        branch_remote="$(git -C "$GIT_ROOT" config --get remote.pushDefault)"
    fi

    if [ -z "$branch_remote" ]; then
        branch_remote="$(git -C "$GIT_ROOT" config --get
branch."$GIT_BRANCH".remote)"
    fi

    if [ -z "$branch_remote" ]; then
        branch_remote="origin"
    fi

    echo "$branch_remote"
}

Because basically, if some wants to go for triangle workflow, then
push url remote should be preferred because
that's where user has write access. If not, then there is a fallback
to branch.<branch>.remote and to origin
eventually, which is just nice to have cause it makes a minimal setup
for my app easier.

So basically, it is possible that an effective (where git actually
pushes when `git push` is invoked) remote
for pushing will be different than what that function returns (e.g.
when git 1.7.1. is used which doesn't
know about branch.<branch>.pushRemote and remote.pushDefault) but it
doesn't really matter as long
as a user is able to make a local configuration where effective push
remote and remote returned by
the fuction will align.

Then i also need 'origin' being returned immediatelly after clean
clone but that's the case as well.

So when i have this kind of 'abstracted' remote, then i need to take
pushUrl on one place and fetch
url on another but there should be no problem there.

Sorry, i didn't realize i actually kind of this 'hybrid remote' thing.
There still might an easier way to write
that function (in a compatible way). Not sure about that.

Anyway, thanks
clime
