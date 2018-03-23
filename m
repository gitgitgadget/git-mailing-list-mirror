Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A26E1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752441AbeCWRLh (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:11:37 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:36843 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752438AbeCWRLf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:11:35 -0400
Received: by mail-it0-f49.google.com with SMTP id c1-v6so3477366itj.1
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o4DkU6jJFHr4DIRxa+wHbrM9E4HhLiLRRzVpEtzai3o=;
        b=uv9E7JtnZB151C5EFM3erCEwW9VrxLAFAK+2qhlBp5IPXUi+LZ3Z08gMQyU4Nfzntr
         oxrDdI9X4PknUiznkjJ+KQVSTHZj9N4F82Dk7Vim9+catiBFZeN9s+FfQQjV7Akbct3S
         4RkmFMvwZliQ+8bQgznPCTSG7tyYbLtRysCf3HxBOPoRTHBSEEq80cNP7FbOBqcOlrVU
         Fzcpix6uxZD3MaG6+6UXbJz5+8+psLWF11hJ4vmLJemy0KZ5eJDK0qBGp/X1jdPV0qYj
         hzvA3e4EY9JrntD2W2M1QFr2Jt7GX2WwamVlFU3ynXsYWhhtHhiFbb+9ZUmrCEDakhJ7
         T18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o4DkU6jJFHr4DIRxa+wHbrM9E4HhLiLRRzVpEtzai3o=;
        b=gi3Dfa6nkYr8yLMzCS4+lAJEZCBpeod2qguOwETBM3V+l+SkRbBK2az6WDQCqJEg5l
         mJ8hyUjmhn7cxikTP/F8S1dhuLNJs1kwluO3mks45y8SfFbmnuT+8A+cArlunBKcbcaD
         hOezv7/AKlpoJ3XIS11KB+YriTnTULXCLed6uOdHWRHvGfMJ3+JGpqMZ5IgQTtmT7Q7F
         pgkIZRRNtO/YuHiNpJq80PqWNAGH/Gz9C1wRQfsgo7sLt1zVucMykzjnbFGjfBNP806D
         fTvnlr/zPsmjNfL7h6Vo4gAV9JhZRaVgYOnxi1OYv+D8Lf78eqUU3IkE2WWEiJ1j7ekN
         Z7Zg==
X-Gm-Message-State: AElRT7FfsExmX49M7StIq6D19a2npgpwDFyIH0G77o02trM4mrqMWitM
        h0njTdFO4z0ImpNrMIX9cAq3iMP5vNZlVnDOYzd04A==
X-Google-Smtp-Source: AG47ELv61Jd7bYSyol7QNGptRntMlNSRQqAQaEdWU87u0OSUP4nPGvNJZjYbfcvr8spRH9UqkDUqY2OwFdysQN6T2ms=
X-Received: by 2002:a24:fa89:: with SMTP id v131-v6mr14459195ith.40.1521825094684;
 Fri, 23 Mar 2018 10:11:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.34.9 with HTTP; Fri, 23 Mar 2018 10:11:34 -0700 (PDT)
In-Reply-To: <1521760546.11809.20.camel@gmail.com>
References: <1521576562.2188.10.camel@gmail.com> <CAP8UFD3NKCSN8mVDiCUzvor5uZh4nFCAw4T0zgxpvHLf9AWmyA@mail.gmail.com>
 <1521760546.11809.20.camel@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 23 Mar 2018 18:11:34 +0100
Message-ID: <CAP8UFD3bRaPke8MvubZ3+v6RrY7K7Peip1dpQ2LG9kxKoXcmbw@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFtHU29DXSBDb252ZXJ0IOKAnGdpdCBzdGFzaOKAnSB0byBidWlsdGluIHByb3Bvcw==?=
        =?UTF-8?B?YWw=?=
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 23, 2018 at 12:15 AM, Paul-Sebastian Ungureanu
<ungureanupaulsebastian@gmail.com> wrote:
>
> On Tue, 2018-03-20 at 23:08 +0100, Christian Couder wrote:
>>
>> On Tue, Mar 20, 2018 at 9:09 PM, Paul-Sebastian Ungureanu
>> <ungureanupaulsebastian@gmail.com> wrote:
>> >
>> > * Convert function: this step is basically makes up the goal of
>> > this
>> > project.
>>
>> Could you explain a bit more how you would convert a function? Or
>> could you explain for example how you would convert "git stash list"
>> below?
>
> In order to convert a command, all the functions which are used by the
> command must be converted first. The conversion will start with the
> bottom-level functions, which do not have any dependencies.
>
> For example, to convert "git stash list", the parser will call
> =E2=80=9Clist_stash=E2=80=9D, which will call =E2=80=9Chave_stash=E2=80=
=9D. The conversion of these
> functions will be made in reverse order they were mentioned (have_stash
> first and then list_stash).

Ok.

> It is very important to know the Git source well in order to avoid
> reimplementing functionality. In this case =E2=80=9Chave_stash()=E2=80=9D=
 is somehow
> already implemented as =E2=80=9Cget_oid(ref_stash, &obj)=E2=80=9D.
>
>> > I am expecting to submit a patch for every command that is
>> > converted.
>> > This way, I have well set milestones and results will be seen as
>> > soon
>> > as possible. Moreover, seeing my contributions getting merged will
>> > be a
>> > huge confidence boost to myself.
>> > Each =E2=80=9Cconvert=E2=80=9D phase of the project below is not only =
about
>> > converting
>> > from Shell to C, but also ensuring that everything is documented,
>> > there
>> > are enough tests and there are no regressions.
>> >
>> > 14th May - 20th May             - Convert "git stash list"
>>
>> For example could you explain a bit more which functions/commands you
>> would create in which file and how you would call them to convert
>> `git
>> stash list`
>
> The new C code will be found in stash-helper.c and will be used by git-
> stash.sh until the full conversion is complete. As soon as the entire
> conversion is done, stash-helper.c will be promoted to stash.c. Any
> functionality that will be implemented, but is not strictly related to
> git stash will reside in the appropriate files (for example if I had to
> implement similar to get_oid, which is not related to git stash, but to
> Git, then I would not implement it in stash-helper.c; anyway, I do not
> believe I will encounter this situation that often).

Ok.

> In the updated version of the proposal [1], I included the ideas stated
> before and more information about the procces of benchmarking. In
> addition, to test my capabilities and to be sure that I am able to work
> on a project of this kind, I tried to convert =E2=80=9Cgit stash list=E2=
=80=9D into a
> built-in (the code can be found in proposal).
>
> [1] https://docs.google.com/document/d/1TtdD7zgUsEOszHG5HX1at4zHMDsPmSB
> YWqydOPTTpV8/edit

I guess that below you inlined the updated version of your proposal. Nice.

> Convert =E2=80=9Cgit stash=E2=80=9D to builtin

[...]

> * Ensure that no regression occurred: considering that there are plenty
> of tests and that I have a good understanding of the function, this
> should be a trivial task.

There are a lot of things that the test suite doesn't test.

> * Write more tests to ensure the best code coverage. This step will be
> almost non existent due to step 4.

Maybe you should use a numbered list if you want to refer to the items
by their number.

> * In the end, an analysis based on performance can be made.
> Benchmarking the script will be done by recording the running time
> given a large set of diversified tests that cover all the
> functionalities, before and after conversion. The new commands should
> run faster just because they were written in C, but I expect to see
> even more improvements.

If you want to do benchmarks, you might want to add performance tests
into t/perf.

[...]

> ## Example of conversion (for =E2=80=9Cgit stash list=E2=80=9D)
> ------------------------------------------
> To test my capabilities and to be sure that I am able to work on a
> project of this kind, I tried to convert =E2=80=9Cgit stash list=E2=80=9D=
 into a built-
> in. The result can be found below in text-only version or at the Github
> link.

I think it would be better if it was sent as a patch (maybe an RFC
patch) to the mailing list and add the link to the patch email in the
maling list archive to your proposal.

[...]

> Useful resources
> There has been a lot of progress made in this direction already and I
> believe it will serve of great help. However, from my understanding it
> is not yet mergeable and it requires changes.
>
> https://public-inbox.org/git/20170608005535.13080-1-joel@teichroeb.net/
> T/#m8849c7ce0ad8516cc206dd6910b79591bf9b3acd

It could be useful if you described a bit more how you could (re)use
the work that has already been made.

In the rest of your proposal it looks like you are starting from
scratch, which is a bit strange if a lot of progress has already been
made.

> ## Project Schedule
> ------------------------------------------
> I can spend about 25 hours during the exam period (last half of May and
> the first half of June) and about 40 hours a week as soon as I am done
> with exams. I hope that by the start of the program (14th of May), I
> will have completed a good part of the project and that will compensate
> for the exam period.
>
> After Google Summer of Code ends, I will do my best to keep
> contributing to Git. Hopefully, all the work I proposed over the summer
> will be done and I will be able to move towards other areas, maybe by
> continuing converting other scripts to builtins or something else,
> depending on what are the priorities of the Git team.
>
> Google Summer of Code starts on 14th of May and lasts 13 weeks. I
> propose to convert one command per week. I actually do not expect each
> command to take exactly one week, some may be easier to convert and
> other may be more challenging, but I believe that the average time of
> conversion is around 1 week.
>
> I am expecting to submit a patch for every command that is converted.
> This way, I have well set milestones and results will be seen as soon
> as possible. Moreover, seeing my contributions getting merged will be a
> huge confidence boost to myself.
>
> Each =E2=80=9Cconvert=E2=80=9D phase of the project below is not only abo=
ut converting
> from Shell to C, but also ensuring that everything is documented, there
> are enough tests and there are no regressions.
>
> 14th May - 20th May             - Convert "git stash list"
> 21st May - 27th May             - Convert "git stash show"
> 28th May - 3rd June             - Convert "git stash save"
> 4th June - 10th June            - Convert "git stash push"
> 11th June - 17th June*          - Convert "git stash apply"
> 18th June - 24th June           - Convert "git stash clear"
> 25th June - 1st July            - Convert "git stash create"
> 2nd July - 8th July             - Convert "git stash store"
> 9th July - 15th July*           - Convert "git stash drop"
> 16th July - 22nd July           - Convert "git stash pop"
> 23rd July - 29th July           - Convert "git stash branch"
> 30th July - 5th August          - Remove old Shell script.
> 6th August - 12th August*       - Wrap-up the project by writing more
> tests and documentation.
> 12th August - forever           - Pick up another project.
>
> * 1st, 2nd and 3rd mentor and student evaluation

It is probably better especially for reviewers and more common to work
in small batches, for example to send a patch series converting a few
related commands, then to start working on the next small batch of
commands in another patch series while improving the first patch
series according to reviews.

Also we ask GSoC students to communicate publicly every week about
their project for example by writing a blg post or sending a report to
the mailing list.

> ## Git contributions
> ------------------------------------------
> My first contribution to Git was to help making =E2=80=9Cgit tag --contai=
ns
> <id>=E2=80=9D les chatty if <id> is invalid. Looking over the list of ava=
ilable
> microprojects, there were a couple of microprojects which got my
> attention, but I picked this up because it seemed to be a long-standing
> bug (I noticed it was approached by students in 2016, 2017 and now in
> 2018). Thanks to the code reviews from the mailing list, after a few
> iterations I succeeded in coming up with a patch that not only fixed
> the mentioned problem, but also a few others that were having the same
> cause.
>
> It got merged in the proposed updates branch.

What is its status in Junio's "What's cooking in Git" emails?

> I worked on only one project because I tried to achieve the best
> quality I could. Even after I submitted one patch that was good enough
> [8], I decided to try another approach that worked better in the end
> [9].
>
> First of all, I weighed the ideas mentioned at [10] and considered the
> second one to be the best. After a few iterations [1], [2], [3], [4],
> [5], [6] and after Junio=E2=80=99s review I decided to try another approa=
ch and
> submitted another patch [7].
>
> I changed the approach, because this issue was affecting not only =E2=80=
=9Cgit
> tag=E2=80=9D command, but also =E2=80=9Cgit for-each-ref=E2=80=9D, =E2=80=
=9Cgit branch=E2=80=9D and many more.
> The new submission was based on Junio=E2=80=99s ideea and fixed the cause=
 at a
> lower level than the previous patch.
>
> In order to make sure that the new code was 100% correct and
> familiarize myself with the testing system, I also write a new set of
> tests.

Thanks.
