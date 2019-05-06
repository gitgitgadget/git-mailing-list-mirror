Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86F971F45F
	for <e@80x24.org>; Mon,  6 May 2019 23:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfEFXxB (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 19:53:01 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35090 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfEFXxB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 19:53:01 -0400
Received: by mail-ed1-f66.google.com with SMTP id p26so17006414edr.2
        for <git@vger.kernel.org>; Mon, 06 May 2019 16:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=WVyQtRwjqeLfwOklYwDzsr+OMjFFg735rkdZYvpTEP8=;
        b=PMyl3JCwtgJhAlTPsDyP2rVSJB5ph5J+0Re0qVy6swmln8f8wng53qcNogr2YZ85ym
         5z+xaJTin1Z94OrakqHp+fue5ZAr1xm2zoqlWDkGynHY0eY6S6UL9dnUVN4hLvtyMMGv
         xsj3fCx8ezJn8GIaANya/IM5W46h5CP/7Di4RpQpZ4a/+6+Gqb+HEKQn98vzMsjFtWtb
         HHmDuChjEzes9pexoUFE7FJuuuu/AhWea9ygPIALwvgCjwx//QXsakiDHUNe+uQizpXw
         Mp5hhDEGf8iZrkEa1fyBFXi6X+9o0JDol6suZ6LP4UzCCu9GvIWhzunpbV5MGXQ5sKMg
         qWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=WVyQtRwjqeLfwOklYwDzsr+OMjFFg735rkdZYvpTEP8=;
        b=Z0fYPq+ZJm+UpoP3N3AZis7OQmXlSWYVRYm5HJ3U2DPzsq9VAF8A4400XFwAtKmhBg
         WhS7/UqOGuqQu4FgfOI6Y7Q9eAzKjm4LnqhKNAaSu6ERDEPnHLInpIt10oDLag7hgnYd
         C37Iu7I0DC4O9Q6BE7sV/diF2OJthiO/5A0d+ErYrkTG60eYuMpryIxrWOiXE/XXEHP6
         TKfjOAbCB7U6s3WpxcOnyDKd8/+4FFFtW+5wteCtClqBRprjjMrQqxFma9PezHVaInpU
         766U2hCPnfIhIPSNewdAbGg85SfSRTEdLsGF5r+J4W4R5r+W3zgbdogD9tyWgFBWpUF5
         zGMA==
X-Gm-Message-State: APjAAAWsSZ25bNkcWjYEAY5x+ycywsuVSX2m0ntO3LrzBSqGf8DArao0
        vsNoIJ/SxNunTmOTkpA/Fa0=
X-Google-Smtp-Source: APXvYqx7gYz2kvV6nwp7+8EtN+lTCLkBnaiov3YhWPfkbUKAChdfwIObAwstwuWHYkP66FjX0jwQ5Q==
X-Received: by 2002:a17:906:391b:: with SMTP id f27mr21058770eje.258.1557186778883;
        Mon, 06 May 2019 16:52:58 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id b1sm1848652eje.7.2019.05.06.16.52.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 16:52:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Eckhard =?utf-8?Q?Maa=C3=9F?= <eckhard.s.maass@googlemail.com>,
        Git <git@vger.kernel.org>
Subject: Re: Merge commit diff results are confusing and inconsistent
References: <CAHd499BEHd79zL76um2oB4YMdScM2icrMXstg1g=xwdBqk43EQ@mail.gmail.com> <20190503191231.GA5426@esm> <CAHd499CUOnFVkNGEG-MmG5OsUPpmWHET2X1j1fjNuGUkELf-5w@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CAHd499CUOnFVkNGEG-MmG5OsUPpmWHET2X1j1fjNuGUkELf-5w@mail.gmail.com>
Date:   Tue, 07 May 2019 01:52:57 +0200
Message-ID: <874l67i1ie.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 06 2019, Robert Dailey wrote:

> I feel like you got hung up too much on exact wording of what I was
> trying to describe. I do apologize I don't have the background to
> explain things 100% accurately, especially at a low level. My
> explanations are mostly intended to be as a user, based on what is
> observable, and based on intent. I'll clarify in the quotes below...
>
> On Fri, May 3, 2019 at 2:12 PM Eckhard Maa=C3=9F
> <eckhard.s.maass@googlemail.com> wrote:
>> Hold on. Basically, there is no such thing as "committed directly" for a
>> merge. You only have differences of the commit to its parents. What you
>> aim for are changes that you cannot find in either preimage - and this
>> can be observed best with the --cc option. Maybe also interesting would
>> be -c for showing a comined diff and -m for showing diffs to parents
>> after one another.
>
> "Committed directly" here means that I made some changes, none of
> which is part of a parent commit. Since no additional commits were
> made following the merge, I assume that within the merge commit is
> some type of diff. If I perform a merge, make some changes, and amend
> those changes into the merge, in mind they ARE contained in that merge
> commit. The underlying machinery doesn't matter here: This is the
> observable state to the user.
>
> Maybe the machinery, which I have no knowledge of or transparency
> into, is important because it is affecting the behavior I'm seeing
> when I do the diffs? Not sure...
>
>> There shouldn't be "just the diff of <commit>" - you always have to tell
>> where to diff it too, intrinsically Git does not save patches, but the
>> whole content, after all.
>
> I do understand this. But again, I'm not trying to be super technical
> here. In plain english, all I'm trying to say is that I want to see
> the changes that 1 commit introduces into the code base. So when it
> comes to communicating the end result I want, I talk about it in terms
> of 1 commit (the merge commit). The means to get that output is part
> of my question and overall confusion. But as a baseline, I want to
> clarify that I do understand a range is required input for the diff
> command. In the case of merge commits, the way you specify the ranges
> has many forms so I'm not sure based on the results I see, which one
> is correct or what they all mean.
>
>> Somebody else might know better why the diff actually produced the
>> results you were looking for. I admit it is puzzling to me - I would
>> have expected to error it out on the output of git rev-parse as there
>> are three items.
>
> Actually I can't think of any other command that can show me what
> revision ranges translate to in "raw" commits. To me the raw forms are
> always <sha1> and ^<sha1>, repeated as many times and in as many
> orders necessary. Don't all of the vanity revision specifications
> ultimately boil down to "from this parent" and "not from this parent"?

Maybe an example helps, let's say you have two paint buckets, one with
red paint, one with yellow paint. You mix them. What happens?

    (
        rm -rf /tmp/git &&
        git init /tmp/git &&
        cd /tmp/git &&
        git checkout -b red &&

        echo red >color.txt &&
        git add color.txt &&
        git commit -m"red" &&

        git checkout --orphan green &&
        git reset --hard &&
        echo green >color.txt &&
        git add color.txt &&
        git commit -m"green" &&

        git merge --allow-unrelated-histories red;
        echo yellow >color.txt &&
        git add color.txt &&
        git commit -m"red + green =3D yellow"
    )

I *think* what you're alluding to is trying to discover some sort of
change to whatever the default merge resolution would have been, which
in this case would be closer to:

    (echo green && echo red) >color.txt

But it's important to understand that the whole business of suggesting
how you should merge is just sugar that isn't in any way represented in
the object model that makes it into the repository.

In that model we just had one branch with "color.txt" containing "red",
and another with "green". Then we merged the two together and that
commit merged two histories together, did something to yield an end
result, and now the "color.txt" file contains "yellow".

But what single thing can you look at to describe how you ended up with
"yellow"? There isn't such a single thing, I just know that I have a
commit with two parents:

    $ git cat-file -p HEAD
    tree 6318a50d67e6de533498a4a0c9f46360cff6908a
    parent 2332fc6b40c1cbf9f5daf809f09eb4defdd2ce30
    parent 1707f13d2d236d61ac7496962ecebc50ffff5be3

And that if I diff against the 1st parent we went from green to yellow:

    $ git diff HEAD^1..HEAD
    diff --git a/color.txt b/color.txt
    index a5b73ed..d1ed081 100644
    --- a/color.txt
    +++ b/color.txt
    @@ -1 +1 @@
    -green
    +yellow

And the other from red to yellow:

    $ git diff HEAD^2..HEAD
    diff --git a/color.txt b/color.txt
    index a9d1386..d1ed081 100644
    --- a/color.txt
    +++ b/color.txt
    @@ -1 +1 @@
    -red
    +yellow

To the extent that we can show a single diff at all that's diff-tree's
--cc option:

    $ git diff-tree --cc HEAD
    e89ef1f780d7c979c18cc0f03fd74c560466ef03
    diff --cc color.txt
    index a5b73ed,a9d1386..d1ed081
    --- a/color.txt
    +++ b/color.txt
    @@@ -1,1 -1,1 +1,1 @@@
    - green
     -red
    ++yellow

Sometimes it makes things better, sometimes it's just more
confusing. It's what "git show" will use to render merge commits.
