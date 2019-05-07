Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A3EB1F45F
	for <e@80x24.org>; Tue,  7 May 2019 14:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfEGOK2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 10:10:28 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40304 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfEGOK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 10:10:27 -0400
Received: by mail-lf1-f67.google.com with SMTP id o16so11959739lfl.7
        for <git@vger.kernel.org>; Tue, 07 May 2019 07:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:sender:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=9v6Nfhecyi102+QYCy1oJhtzPmUr4S/3a0z4i0Vv/Iw=;
        b=BKXJkcieB7eAUIOYPYJbsPLkhFFMZfd8GElFRBljpsnEGfxyH9C8ndfO8NkqSWjpWW
         S1cO1nGtbSbQ+HDoWeHjqmoecYf02GXAKjfAJFHxKQ4GhPCrrlmVdNxz+spqb3tml3dj
         u6dQZ0fxISrt5EARGQghXulPrRJupR2evhpKy4Eh0bV8NtEKDkHlWNxOuHMRSoxTm7M8
         Oxq/tRDTLqmMgyxlvdTI5sa6gJZOV2XhZ08LDcLm0orrMS7Oeqt4ctqNlZac3kXA14yc
         g1UiUyuPCr69DUi1nyNJWTKP8PMDP4nLfN6pJEGWvdgWJawhKV8NJYIoUTWEFxIRZ85T
         EfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:sender:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=9v6Nfhecyi102+QYCy1oJhtzPmUr4S/3a0z4i0Vv/Iw=;
        b=CT7Dea+fzQcs9QlWSDSEXH7fuUj/OeC3K3VhCCSgQMJOm1Bc79K1U/66buUZ1s12np
         h75c5xQetnQ66PBC44TbsKQGQ3yTPAt3rLlcM/PdGWHiDUgh3FFTrFypKjldFLlS2/2R
         nRSereoraJj/B2A07RzbMKvLq/4CgaaLriF9mwenxJgo/h8JQjl4SshpMDog7xv0s5Kc
         KgRiTMkPARGR8gvaQ3bq1c5DHPSyjnCBzsWMsXtLHrO4e+VHRm3Z+1tF5m5RyGk27Glk
         JqcZn9cE2GTE+RZZW5sTQmCh2uByS58/KlYKySV6hMIYTEKawvWrgFqJ0P02E4zTBCnv
         kt0A==
X-Gm-Message-State: APjAAAWhWTOkJxmoh+cqA/ocP+aAUkC68C6mLxs1jyLe/9UXkenqnFPZ
        oigOCHMMtnRgfXGBYkFoJXbjcnY+0T/yf8N9cgY=
X-Google-Smtp-Source: APXvYqyx3kj7OOs09+KoYpnZEGz3WKG/xYNzpzVxlH0CWcL+kEGaijxx48t42v1LTTZTttrNxtiISy/+LYy4j+sT/B0=
X-Received: by 2002:ac2:428f:: with SMTP id m15mr16655002lfh.40.1557238225378;
 Tue, 07 May 2019 07:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd499BEHd79zL76um2oB4YMdScM2icrMXstg1g=xwdBqk43EQ@mail.gmail.com>
 <20190503191231.GA5426@esm> <CAHd499CUOnFVkNGEG-MmG5OsUPpmWHET2X1j1fjNuGUkELf-5w@mail.gmail.com>
 <874l67i1ie.fsf@evledraar.gmail.com>
In-Reply-To: <874l67i1ie.fsf@evledraar.gmail.com>
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Tue, 7 May 2019 09:10:12 -0500
X-Google-Sender-Auth: -rgMmAH1m_EY_zR1bKoQe7OM-jo
Message-ID: <CAHd499BkdpsA2BdB0Hsv3xXzpMyMzW8CSuYf2gQX0Jf7OoYBGw@mail.gmail.com>
Subject: Re: Merge commit diff results are confusing and inconsistent
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     =?UTF-8?Q?Eckhard_Maa=C3=9F?= <eckhard.s.maass@googlemail.com>,
        Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 6, 2019 at 6:52 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
> Maybe an example helps, let's say you have two paint buckets, one with
> red paint, one with yellow paint. You mix them. What happens?
>
>     (
>         rm -rf /tmp/git &&
>         git init /tmp/git &&
>         cd /tmp/git &&
>         git checkout -b red &&
>
>         echo red >color.txt &&
>         git add color.txt &&
>         git commit -m"red" &&
>
>         git checkout --orphan green &&
>         git reset --hard &&
>         echo green >color.txt &&
>         git add color.txt &&
>         git commit -m"green" &&
>
>         git merge --allow-unrelated-histories red;
>         echo yellow >color.txt &&
>         git add color.txt &&
>         git commit -m"red + green =3D yellow"
>     )
>
> I *think* what you're alluding to is trying to discover some sort of
> change to whatever the default merge resolution would have been, which
> in this case would be closer to:
>
>     (echo green && echo red) >color.txt
>
> But it's important to understand that the whole business of suggesting
> how you should merge is just sugar that isn't in any way represented in
> the object model that makes it into the repository.
>
> In that model we just had one branch with "color.txt" containing "red",
> and another with "green". Then we merged the two together and that
> commit merged two histories together, did something to yield an end
> result, and now the "color.txt" file contains "yellow".
>
> But what single thing can you look at to describe how you ended up with
> "yellow"? There isn't such a single thing, I just know that I have a
> commit with two parents:
>
>     $ git cat-file -p HEAD
>     tree 6318a50d67e6de533498a4a0c9f46360cff6908a
>     parent 2332fc6b40c1cbf9f5daf809f09eb4defdd2ce30
>     parent 1707f13d2d236d61ac7496962ecebc50ffff5be3
>
> And that if I diff against the 1st parent we went from green to yellow:
>
>     $ git diff HEAD^1..HEAD
>     diff --git a/color.txt b/color.txt
>     index a5b73ed..d1ed081 100644
>     --- a/color.txt
>     +++ b/color.txt
>     @@ -1 +1 @@
>     -green
>     +yellow
>
> And the other from red to yellow:
>
>     $ git diff HEAD^2..HEAD
>     diff --git a/color.txt b/color.txt
>     index a9d1386..d1ed081 100644
>     --- a/color.txt
>     +++ b/color.txt
>     @@ -1 +1 @@
>     -red
>     +yellow
>
> To the extent that we can show a single diff at all that's diff-tree's
> --cc option:
>
>     $ git diff-tree --cc HEAD
>     e89ef1f780d7c979c18cc0f03fd74c560466ef03
>     diff --cc color.txt
>     index a5b73ed,a9d1386..d1ed081
>     --- a/color.txt
>     +++ b/color.txt
>     @@@ -1,1 -1,1 +1,1 @@@
>     - green
>      -red
>     ++yellow
>
> Sometimes it makes things better, sometimes it's just more
> confusing. It's what "git show" will use to render merge commits.

Your example is very helpful. I understand what you're saying for
conflicted lines. But the "whatever the default merge resolution would
have been" doesn't exist, because there's no reality where line 1 in
color.txt can be something "automatic" (i.e. deduced by git). The only
reality for the merge commit is some hand-edited replacement to line
1. So there is no "diff what I see with some alternate reality".

The majority use case I'm interested in is seeing net-positive changes
that happen in merge commits. Normally I take for granted that merge
commits have nothing meaningful in them (meaningful here defined as
something unexpected for a merge commit). But what if someone makes a
poor decision and does some crazy refactoring in 1 file and amends it
into a merge commit? Let's also say that these changes are done to a
file that wasn't modified in any parent (say a unrelated.txt next to
your color.txt). Since neither parent cares about that file for the
purposes of the merge, I am trying to make sense of a revision
specification that can be used to see what they did to that file.

Even ignoring that issue, the more concerning observation of mine is
that `diff @^!` produces any output at all. If you exclude both
parents, why do I see a diff for parent 2 (I see the complete diff of
the branch that was merged in)?

Again, thank you for your example, you definitely made things very
clear for me. I see where the confusion is. And I think --cc is a good
way to get more context. At this point I'm just concerned about the
@^! behavior with merge commits & diff.
