Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CE31202AA
	for <e@80x24.org>; Mon, 25 Feb 2019 10:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfBYKZN (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 05:25:13 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37357 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfBYKZN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 05:25:13 -0500
Received: by mail-ed1-f66.google.com with SMTP id m12so7087610edv.4
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 02:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=FJmcS2zpX5bfQKqtZwTVIkf/Mk6ZBPHNYGNwOgUyNcA=;
        b=A7jY6oKzsaBamvplK0xFGZRt3dXKkJKB+RR5DFkmSj0y4R7TDZwHchF3aAxcmnhSv3
         UbHthjWAss5CQrp+/nbn7bNeNmYVsMZpacE7/Av2drM8oDVLMB1U8tV25ZB0GFGUBQhk
         i2rEOLtDbnaJSmcqEG6dAKC0aiwHiq411ahmUpRBehXVYxlrxBoZk7YOQsudqM1TiRZQ
         iGKV8iDW0oddVVm5sdmaZucmoSQyZtvcdGDN3dIs4w0+O636ZwR6acsDB/2TH5upIPmC
         uZ5tecV+LikjpUtDrRQnYafJxGMRW4z9trFhdygu5ZRs0sH/uMLbDsTWeHs2j7GYRpuG
         ubFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=FJmcS2zpX5bfQKqtZwTVIkf/Mk6ZBPHNYGNwOgUyNcA=;
        b=OqV0RpbCOxvf1vTVV4n6lWaV3WJiaGW6h30w/3PxvJlK6ZTz0yWuXrpRDWmmSy3a21
         COU2kMAuk828r0tyPzpRZxVyUF+8nJ3G/NgTHyLvnCccbNYACDt+9u2MNyMaFk7WAj0w
         UycLLT2ya8fC2RDLnrg+1FNpveUrVQb/0RzBKH7SeuyXtzCT0i/uMMfg/hTwvHMTdutA
         RpSQ/AAL+SOLdFEyazOHobH+07HbZGjceaZ2DnYTctsm9e7EiySENKudvjCDfYa7zrOa
         2KV+s03mqmsjzFe5RWNVt9ffiRMn8/y5GeLpd/KiGrmWTe/92XRm5xgpxRjLGBEuTGvp
         scZg==
X-Gm-Message-State: AHQUAubbYlJAdmvfME9i3xJlw/+7hMljtWjbIloRqAHrJbMrBAazv7VP
        LiCZ53em0Q2tG1Dw2o2S7is=
X-Google-Smtp-Source: AHgI3IbWjUcbrsMVOH7JFy80+IDURyUgfu7+9SCKcQ/K59CSBcX1zIjfdbF75OfhXmzn+5u1/gtaLA==
X-Received: by 2002:a17:906:a445:: with SMTP id cb5mr12330322ejb.72.1551090310474;
        Mon, 25 Feb 2019 02:25:10 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id 57sm2589538eds.14.2019.02.25.02.25.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 02:25:09 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [GSoC][PATCH 3/3] clone: use dir-iterator to avoid explicit dir traversal
References: <20190223190309.6728-1-matheus.bernardino@usp.br>
        <20190223190309.6728-4-matheus.bernardino@usp.br>
        <87va1a3z8e.fsf@evledraar.gmail.com>
        <CAP8UFD2LLL+V54k3XmHzmg5t1zanpAvY_=7GqXL43vLPTTmuww@mail.gmail.com>
        <CAHd-oW4P-aAKH0_kKrOJeprWmvPCUfa++X3pSNYSQisAV-25HA@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CAHd-oW4P-aAKH0_kKrOJeprWmvPCUfa++X3pSNYSQisAV-25HA@mail.gmail.com>
Date:   Mon, 25 Feb 2019 11:25:08 +0100
Message-ID: <87zhqk5fnf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 25 2019, Matheus Tavares Bernardino wrote:

> Hi, Christian and =C3=86var
>
> First of all, thanks for the fast and attentive reviews.
>
> I am a little confused about what I should do next. How should I
> proceed with this series?
>
> By what was said, I understood that the series:
> 1) Is indeed an improvement under --local, because it won't deference
> symlinks in this case.
> 2) Don't make --dissociate any better but as it is already buggy that
> would be some work for another patchset.
> 3) Makes git-clone copy hidden paths which is a good behaviour.
> 4) Breaks --no-hardlinks when there are symlinks at the repo's objects
> directory.
>
> I understood that even though git itself does not create symlinks in
> .git/objects, we should take care of the case where the user manually
> creates them, right? But what would be the appropriate behaviour: to
> follow (i.e. deference) symlinks (the way it is done now) or just copy
> the link file itself (the way my series currently do)? And shouldn't
> we document this decision somewhere?
>
> About the failure with --no-hardlinks having symlinks at .dir/objects,
> it's probably because copy_or_link_directory() is trying to copy a
> file which is a symlink to a dir and the copy function used is trying
> to copy the dir not the link itself. A possible fix is to change
> copy.c to copy the link file, but I haven't studied yet how that could
> be accomplished.
>
> Another possible fix is to make copy_or_link_directory() deference
> symlink structures when --no-hardlinks is given. But because the
> function falls back to no-hardlinks when failing to hardlink, I don't
> think it would be easy to accomplish this without making the function
> *always* deference symlinks. And that would make the series lose the
> item 1), which I understand you liked.


I don't really have formed opinions one way or the other about what
these specific flags should do in combination with such a repository,
e.g. should --dissociate copy data rather than point to the same
symlinks?

I'm inclined to think so, but I've only thought about it for a couple of
minutes. Maybe if someone starts digging they'll rightly come to a
different conclusion.

Rather, my comment is on the process. Clone behavior is too important to
leave to prose in a commit message. I already found a case where we hard
error not explicitly called out, are there other edge cases I didn't
think of?

So having this e.g. be a 4-part series where 3/4 is introducing tests in
the direction I posted upthread (but needs more work), with 4/4 going
through/justifying each one.


> On Sun, Feb 24, 2019 at 6:41 AM Christian Couder
> <christian.couder@gmail.com> wrote:
>>
>> On Sat, Feb 23, 2019 at 11:48 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> <avarab@gmail.com> wrote:
>> >
>> >
>> > On Sat, Feb 23 2019, Matheus Tavares wrote:
>> >
>> > > Replace usage of opendir/readdir/closedir API to traverse directories
>> > > recursively, at copy_or_link_directory function, by the dir-iterator
>> > > API. This simplifies the code and avoid recursive calls to
>> > > copy_or_link_directory.
>> >
>> > Sounds good in principle.
>> >
>> > > This process also brings some safe behaviour changes to
>> > > copy_or_link_directory:
>> >
>> > I ad-hoc tested some of these, and could spot behavior changes. We
>> > should have tests for these.
>>
>> I agree that ideally we should have a few tests for these, but this is
>> a grey area (see below) and there are areas that are not grey for
>> which we don't have any test...
>>
>> And then adding tests would make this series become larger than a
>> typical GSoC micro-project...
>>
>> > >  - It will no longer follows symbolic links. This is not a problem,
>> > >    since the function is only used to copy .git/objects directory, a=
nd
>> > >    symbolic links are not expected there.
>> >
>> > I don't think we should make that assumption, and I don't know of
>> > anything else in git that does.
>>
>> I think Git itself doesn't create symlinks in ".git/objects/" and we
>> don't recommend people manually tweaking what's inside ".git/". That's
>> why I think it's a grey area.
>>
>> > I've certainly symlinked individual objects or packs into a repo for
>> > debugging / recovery, and it would be unexpected to clone that and miss
>> > something.
>>
>> If people tweak what's inside ".git" by hand, they are expected to
>> know what they doing and be able to debug it.
>>
>> > So in the general case we should be strict in what we generate, but
>> > permissive in what we accept. We don't want a "clone" of an existing
>> > repo to fail, or "fsck" to fail after clone...
>>
>> Yeah, but realistically I don't think we are going to foolproof Git
>> from everything that someone could do by tweaking random things
>> manually in ".git/".
>>
>> I am not saying that it should be ok to make things much worse than
>> they are now in case some things have been tweaked in ".git/", but if
>> things in general don't look worse in this grey area, and a patch
>> otherwise improves things, then I think the patch should be ok.
>>
>> > When trying to test this I made e.g. objects/c4 a symlink to /tmp/c4,
>> > and a specific object in objects/4d/ a symlink to /tmp too.
>> >
>> > Without this patch the individual object is still a symlink, but the
>> > object under the directory gets resolved, and "un-symlinked", also with
>> > --dissociate, which seems like an existing bug.
>> >
>> > With your patch that symlink structure is copied as-is. That's more
>> > faithful under --local, but a regression for --dissociate (which didn't
>> > work fully to begin with...).
>>
>> I think that I use --local (which is the default if the repository is
>> specified as a local path) much more often than --dissociate, so for
>> me the patch would be very positive, especially since --dissociate is
>> already buggy anyway in this case.
>>
>> > I was paranoid that "no longer follows symbolic links" could also mean
>> > "will ignore those objects", but it seems to more faithfully copy thin=
gs
>> > as-is for *that* case.
>>
>> Nice!
>>
>> > But then I try with --no-hardlinks and stock git dereferences my symli=
nk
>> > structure, but with your patches fails completely:
>> >
>> >     Cloning into bare repository 'repo2'...
>> >     error: copy-fd: read returned: Is a directory
>> >     fatal: failed to copy file to 'repo2/objects/c4': Is a directory
>> >     fatal: the remote end hung up unexpectedly
>> >     fatal: cannot change to 'repo2': No such file or directory
>>
>> Maybe this could be fixed. Anyway I don't use --no-hardlinks very
>> often, so I still think the patch is a positive even with this
>> failure.
>>
>> > So there's at least one case in a few minutes of prodding this where we
>> > can't clone a working repo now, however obscure the setup.
>> >
>> > >  - Hidden directories won't be skipped anymore. In fact, it is odd t=
hat
>> > >    the function currently skip hidden directories but not hidden fil=
es.
>> > >    The reason for that could be unintentional: probably the intention
>> > >    was to skip '.' and '..' only, but it ended up accidentally skipp=
ing
>> > >    all directories starting with '.'. Again, it must not be a problem
>> > >    not to skip hidden dirs since hidden dirs/files are not expected =
at
>> > >    .git/objects.
>> >
>> > I reproduce this with --local. A ".foo" isn't copied before, now it
>> > is. Good, I guess. We'd have already copied a "foo".
>> >
>> > >  - Now, copy_or_link_directory will call die() in case of an error on
>> > >    openddir, readdir or lstat, inside dir_iterator_advance. That mea=
ns
>> > >    it will abort in case of an error trying to fetch any iteration
>> > >    entry.
>>
>> It would be nice if the above paragraph in the commit message would
>> say what was the previous behavior and why it's better to die() .
>>
>> > Good, but really IMNSHO this series is tweaking some critical core code
>> > and desperately needs tests.
>>
>> It's critical that this code works well in the usual case, yes. (And
>> there are already a lot of tests that test that.) But when people have
>> manually tweaked things in their ".git/objects/", it's not critical
>> what happens. Many systems have "undefined behaviors" at some point
>> and that's ok.
>>
>> And no, I am not saying that we should consider it completely
>> "undefined behavior" as soon as something is manually tweaked in
>> ".git/", and yes, tests would be nice, and your comments and manual
>> tests on this are very much appreciated. It's just that I don't think
>> we should require too much when a patch, especially from a first time
>> contributor, is already improving things, though it also changes a few
>> things in a grey area.
>>
>> > Unfortunately, in this as in so many edge case we have no existing
>> > tests.
>> >
>> > This would be much easier to review and would give reviewers more
>> > confidence if the parts of this that changed behavior started with a
>> > patch or patches that just manually objects/ dirs with various
>>
>> I think "created" is missing between "manually" and  "objects/" in the
>> above sentence.
>>
>> > combinations of symlinks, hardlinks etc., and asserted that the various
>> > options did exactly what they're doing now, and made sure the
>> > source/target repos were the same after/both passed "fsck".
>> >
>> > Then followed by some version of this patch which changes the behavior,
>> > and would be forced to tweak those tests. To make it clear e.g. that
>> > some cases where we have a working "clone" are now a hard error.
>>
>> Unfortunately this would be a lot of work and not appropriate for a
>> GSoC micro-project.
>>
>> Thanks,
>> Christian.
