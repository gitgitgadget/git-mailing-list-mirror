Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B8501F42D
	for <e@80x24.org>; Wed, 21 Mar 2018 11:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbeCULCs (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 07:02:48 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:37828 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751477AbeCULCq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 07:02:46 -0400
Received: by mail-qk0-f181.google.com with SMTP id w6so4918632qkb.4
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 04:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=OqG2ZbbZNxBYWkIYqliGFu31RnfKhhAkuvjIUWBoluU=;
        b=kjih1dwHBjZVa57a/2ftMjezyY58z7tDeFiGXdM+So1w2Y5aSTfAj4FxgZKpIoUTrg
         pTr50riLiJ4sF5i0bEx+ZnTysk5YKmIYPWoaet5VyxuHHWrHoEJC4tcnEqf4wG/7IzyP
         JVcqwszlHWwlHBOabEAy1GbOT/BP9Y3nTyirL7AI0BG0SGi8b57kl1gkf0cnF9bH7aXN
         ZxIt+35PCxflpbz6jfBqkbCdcCWVdkH4FLiHyg16GsXc7mHiYcCNdSnUo8iHOtULLrPI
         k+/ucRiDZkyJtQS3WSr/o9DQEEGq8al9JHnlBIXHqYrhoH3R9bYFh35UW1ox2iPZ1hMU
         zN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=OqG2ZbbZNxBYWkIYqliGFu31RnfKhhAkuvjIUWBoluU=;
        b=BnqNr7tfVpCtEelpdnNqZuW/aZmeuHgFFSSOfOGSvYpxZMLYh0QmXcKkldjEUVONbE
         O3ZBhA8JICKoAbVItmo6t8tYTWbS0yx8ruRoaOtT4B3UkVM+/S2zeRwg+r9ZslAPN4RX
         S3uVOVZeySmyIZ2MEGQ7AYXpqX44t8vsJg0PnZFUxtnCg/lZJPJatPtlhK0y+TFGoHGD
         MNbHVaEsoXu3WBWttaLiMAxXpXvdbKKZ6vJL6uSB5EtxpzvjFM3dkGcw1EKJwlajVFvD
         btBm8MXH+97ew05G0fEI0PrJTcyJduyZ3PnGDtYeB5qiwFn25hybibJ7JHszWDUdiMA/
         x1xw==
X-Gm-Message-State: AElRT7EgpV+1kApWnaXDyDlngUia10MOjUvlo2cegK0tEceLgkPV67BF
        Zv8T7dSJe9hQwGB+mekojcklnIN0Dy9YNInNZto=
X-Google-Smtp-Source: AG47ELvQpl+MErDKLmEjckvtuaL/pRs/DvHzD658cRpZGOO0m15HMCSPoIeNwhZUVXDa4NRgq9pDDZFWGkXUHV/sY0o=
X-Received: by 10.55.22.28 with SMTP id g28mr28405791qkh.152.1521630164639;
 Wed, 21 Mar 2018 04:02:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.190.196 with HTTP; Wed, 21 Mar 2018 04:02:43 -0700 (PDT)
In-Reply-To: <20180319173204.31952-1-predatoramigo@gmail.com>
References: <xmqqsh915kzi.fsf@gitster-ct.c.googlers.com> <20180319173204.31952-1-predatoramigo@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 21 Mar 2018 07:02:43 -0400
X-Google-Sender-Auth: sgMMTd-wcHYEYP9giZ8H-x4I7zQ
Message-ID: <CAPig+cTKkp6kpFcJfVV8W1ejCrCWQH33mHtgFUn+MpMgw5i1pA@mail.gmail.com>
Subject: Re: [GSoC][PATCH] test: avoid pipes in git related commands for test suite
To:     Pratik Karki <predatoramigo@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 19, 2018 at 1:32 PM, Pratik Karki <predatoramigo@gmail.com> wro=
te:
> Thank you Eric Sunshine,
> I have done as you had instructed me. I look forward to more
> understanding of the codebase and would love to fix
> "git rev-parse" problems in my follow-on patches.
> Thank you for the professional review comment.
>
> Sorry for late follow-on patch, I got tied up with my university stuffs.

No need to apologize; this is not a race. It's better to take time
preparing submissions carefully, than trying to rush them out.

> Please do review this patch as before. I will correct it if needed.

Below comments are meant to be instructive and constructive.

> Cheers,
> Pratik Karki

Place a "-- >8--" scissor line right here so that git-am knows where
the commit message begins; otherwise, all of the above commentary will
undesirably be included in the commit message.

> [PATCH] test: avoid pipes in git related commands for test suite

As this is the second attempt at this patch, the subject should be
"[PATCH v2]". Also, as an aid to reviewers -- who see a lot of patches
each day and are likely to forget details of each submission -- please
include a link in the commentary (not in the actual commit message)
pointing at the previous iteration, like this[1].

[1]: https://public-inbox.org/git/20180313201945.8409-1-predatoramigo@gmail=
.com/

> Avoid using pipes downstream of Git commands since the exit codes
> of commands upstream of pipes get swallowed, thus potentially
> hiding failure of those commands. Instead, capture Git command
> output to a file apply the downstream command(s) to that file.

This rewrite of the commit message which I suggested in [2] has a
grammatical error (which I noticed immediately after hitting "Send").
Unfortunately, you copied it verbatim, so the error is reproduced
here. Specifically, you want to insert "and" between "file" and
"apply":

    ... capture Git command output to a file _and_ apply...

[2]: https://public-inbox.org/git/CAPig+cRPzyw525ODC4=3D-E7w=3DzbpbhVN2eqxS=
YDSLij5wfW8S_A@mail.gmail.com/

> Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
> ---
>  t/t5300-pack-object.sh                     | 10 +++---
>  t/t5510-fetch.sh                           |  8 ++---
>  t/t7001-mv.sh                              | 22 ++++++-------
>  t/t7003-filter-branch.sh                   |  9 ++++--
>  t/t9104-git-svn-follow-parent.sh           | 16 +++++----
>  t/t9108-git-svn-glob.sh                    | 14 ++++----
>  t/t9109-git-svn-multi-glob.sh              | 28 +++++++++-------
>  t/t9110-git-svn-use-svm-props.sh           | 42 ++++++++++++------------
>  t/t9111-git-svn-use-svnsync-props.sh       | 36 ++++++++++-----------
>  t/t9114-git-svn-dcommit-merge.sh           | 10 +++---
>  t/t9130-git-svn-authors-file.sh            | 28 +++++++++-------
>  t/t9138-git-svn-authors-prog.sh            | 31 +++++++++---------
>  t/t9153-git-svn-rewrite-uuid.sh            |  8 ++---
>  t/t9168-git-svn-partially-globbed-names.sh | 34 +++++++++++--------
>  t/t9350-fast-export.sh                     | 52 ++++++++++++++++--------=
------
>  15 files changed, 187 insertions(+), 161 deletions(-)

The goal of iterating a patch or patch series is to converge to a
point at which the submission is in good enough shape to be accepted.
Ideally, each iteration should involve fewer changes than the previous
attempt.

Version 1 of this patch touched only 8 files, however, this version
touches 15, and is now uncomfortably large and difficult to review in
a single sitting (it took over 1.5 hours). Rather than converging, it
has instead diverged, and is thus potentially further from being in an
acceptable state than it would have been if v2 had merely addressed
the problems identified by the v1 review.

While the desire to address these additional cases is admirable, it is
better to focus on "landing" the current patch (getting it accepted)
before expanding your efforts; it's also more reviewer-friendly to
stay focused, especially with patches, such as this, which involve
primarily mechanical changes (which tend to be mind-numbing to
review).

> diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
> @@ -311,9 +311,9 @@ test_expect_success 'unpacking with --strict' '
>         rm -f .git/index &&
>         tail -n 10 LIST | git update-index --index-info &&
>         ST=3D$(git write-tree) &&
> -       PACK5=3D$( git rev-list --objects "$LIST" "$LI" "$ST" | \
> -               git pack-objects test-5 ) &&
> -       PACK6=3D$( (
> +       git rev-list --objects "$LIST" "$LI" "$ST" >actual &&
> +       PACK5=3D$(git pack-objects test-5 < actual) &&
> +       PACK6=3D$((

Losing the space between the two left parentheses is wrong. $( ( foo )
), which captures the output of subshell running 'foo', has very
different meaning than $((foo)), which performs arithmetic. This
change turns it into $(( foo) ), which, at best, is undefined.
Although bash seems to tolerate this change, other more strict shells
barf on it.

>                         echo "$LIST"
>                         echo "$LI"
>                         echo "$ST"
> @@ -358,8 +358,8 @@ test_expect_success 'index-pack with --strict' '
>         rm -f .git/index &&
>         tail -n 10 LIST | git update-index --index-info &&
>         ST=3D$(git write-tree) &&
> -       PACK5=3D$( git rev-list --objects "$LIST" "$LI" "$ST" | \
> -               git pack-objects test-5 ) &&
> +       git rev-list --objects "$LIST" "$LI" "$ST" >actual &&
> +       PACK5=3D$(git pack-objects test-5 < actual) &&
>         PACK6=3D$( (
>                         echo "$LIST"
>                         echo "$LI"
> diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
> @@ -187,7 +187,8 @@ test_expect_success 'author information is preserved'=
 '
>                         test \$GIT_COMMIT !=3D $(git rev-parse master) ||=
 \
>                         echo Hallo" \
>                 preserved-author) &&
> -       test 1 =3D $(git rev-list --author=3D"B V Uips" preserved-author =
| wc -l)
> +       git rev-list --author=3D"B V Uips" preserved-author > actual &&

Style: drop space after '>'

> +       test 1 =3D $(wc -l < actual)

Style: drop space after '<'

You could also take advantage of test_line_count() rather than using 'wc':

    test_line_count =3D 1 actual

It's a judgment call whether or not to convert this to use
test_line_count(), however, since you made such a conversion later in
this file, you should do it here too. Or, don't use test_line_count()
in this file. It's not so important whether you do or not, but it is
important that you be consistent about it (which is not currently the
case).

> @@ -205,7 +206,8 @@ test_expect_success "remove a certain author's commit=
s" '
>         cnt1=3D$(git rev-list master | wc -l) &&
>         cnt2=3D$(git rev-list removed-author | wc -l) &&
>         test $cnt1 -eq $(($cnt2 + 1)) &&
> -       test 0 =3D $(git rev-list --author=3D"B V Uips" removed-author | =
wc -l)
> +       git rev-list --author=3D"B V Uips" removed-author >actual &&
> +       test 0 =3D $(wc -l < actual)

Ditto: drop space before '<'
Ditto: test_line_count =3D 0 actual

> @@ -258,7 +260,8 @@ test_expect_success 'Subdirectory filter with disappe=
aring trees' '
>         git filter-branch -f --subdirectory-filter foo &&
> -       test $(git rev-list master | wc -l) =3D 3
> +       git rev-list master >actual &&
> +       test_line_count =3D 3 actual
>  '

Here you used test_line_count().

> diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-pa=
rent.sh
> @@ -204,8 +205,9 @@ test_expect_success "follow-parent is atomic" '
>  test_expect_success "track multi-parent paths" '
>         svn_cmd cp -m "resurrect /glob" "$svnrepo"/r9270 "$svnrepo"/glob =
&&
>         git svn multi-fetch &&
> -       test $(git cat-file commit refs/remotes/glob | \
> -              grep "^parent " | wc -l) -eq 2
> +       git cat-file commit refs/remotes/glob >actual &&
> +       grep "^parent " actual > actual2 &&

Style: drop space after '>'

> +       test_line_count =3D 2 actual2
> diff --git a/t/t9108-git-svn-glob.sh b/t/t9108-git-svn-glob.sh
> @@ -47,8 +47,8 @@ test_expect_success 'test refspec globbing' '
>         git config --add svn-remote.svn.tags\
>                          "tags/*/src/a:refs/remotes/tags/*" &&
>         git svn multi-fetch &&
> -       git log --pretty=3Doneline refs/remotes/tags/end | \
> -           sed -e "s/^.\{41\}//" > output.end &&
> +       git log --pretty=3Doneline refs/remotes/tags/end >actual &&
> +       sed -e "s/^.\{41\}//" actual > output.end &&

This is not a new problem, but since you're touching it, drop space after '=
>'.

>         test_cmp expect.end output.end &&
> @@ -75,14 +75,16 @@ test_expect_success 'test left-hand-side only globbin=
g' '
>         git svn fetch two &&
> -       test $(git rev-list refs/remotes/two/tags/end | wc -l) -eq 6 &&
> -       test $(git rev-list refs/remotes/two/branches/start | wc -l) -eq =
3 &&
> +       git rev-list refs/remotes/two/tags/end >actual &&
> +       test_line_count =3D 6 actual &&
> +       git rev-list refs/remotes/two/branches/start >actual2 &&
> +       test_line_count =3D 3 actual2 &&

It's better to name all these files "actual", rather than inventing
names "actual2", "actual3", etc. Those invented names mislead readers
into thinking that there might be some interrelation between the files
which requires them all to exist at once. But, this is not the case.
Those files serve no purpose after their associated test_line_count(),
and you can clearly indicate such by overwriting each time by reusing
the name "actual".

>         test $(git rev-parse refs/remotes/two/branches/start~2) =3D \
>              $(git rev-parse refs/remotes/two/trunk) &&
>         test $(git rev-parse refs/remotes/two/tags/end~3) =3D \
>              $(git rev-parse refs/remotes/two/branches/start) &&
> -       git log --pretty=3Doneline refs/remotes/two/tags/end | \
> -           sed -e "s/^.\{41\}//" > output.two &&
> +       git log --pretty=3Doneline refs/remotes/two/tags/end >actual3 &&
> +       sed -e "s/^.\{41\}//" actual3 > output.two &&

Style: drop space after '>'

>         test_cmp expect.two output.two
> diff --git a/t/t9109-git-svn-multi-glob.sh b/t/t9109-git-svn-multi-glob.s=
h
> @@ -47,8 +47,8 @@ test_expect_success 'test refspec globbing' '
>         git config --add svn-remote.svn.tags\
>                          "tags/*/src/a:refs/remotes/tags/*" &&
>         git svn multi-fetch &&
> -       git log --pretty=3Doneline refs/remotes/tags/end | \
> -           sed -e "s/^.\{41\}//" > output.end &&
> +       git log --pretty=3Doneline refs/remotes/tags/end >actual &&
> +       sed -e "s/^.\{41\}//" actual > output.end &&

Style: drop space after '>'

>         test_cmp expect.end output.end &&
> @@ -75,14 +75,16 @@ test_expect_success 'test left-hand-side only globbin=
g' '
>         git svn fetch two &&
> -       test $(git rev-list refs/remotes/two/tags/end | wc -l) -eq 6 &&
> -       test $(git rev-list refs/remotes/two/branches/v1/start | wc -l) -=
eq 3 &&
> +       git rev-list refs/remotes/two/tags/end >actual2 &&
> +       test_line_count =3D 6 actual2 &&
> +       git rev-list refs/remotes/two/branches/v1/start >actual3 &&
> +       test_line_count =3D 3 actual3 &&

Ditto: name all these files "actual" rather than unnecessarily
inventing unique names

>         test $(git rev-parse refs/remotes/two/branches/v1/start~2) =3D \
>              $(git rev-parse refs/remotes/two/trunk) &&
>         test $(git rev-parse refs/remotes/two/tags/end~3) =3D \
>              $(git rev-parse refs/remotes/two/branches/v1/start) &&
> -       git log --pretty=3Doneline refs/remotes/two/tags/end | \
> -           sed -e "s/^.\{41\}//" > output.two &&
> +       git log --pretty=3Doneline refs/remotes/two/tags/end >actual4 &&
> +       sed -e "s/^.\{41\}//" actual4 > output.two &&

Style: drop space after '>'

>         test_cmp expect.two output.two
> @@ -120,18 +122,20 @@ test_expect_success 'test another branch' '
>         git config --add svn-remote.four.url "$svnrepo" &&
>         git config --add svn-remote.four.fetch trunk:refs/remotes/four/tr=
unk &&
>         git config --add svn-remote.four.branches \
> -                        "branches/*/*:refs/remotes/four/branches/*/*" &&
> +                        "branches/*/*:refs/remotes/four/branches/*/*" &&
>         git config --add svn-remote.four.tags \
> -                        "tags/*:refs/remotes/four/tags/*" &&
> +                        "tags/*:refs/remotes/four/tags/*" &&

I guess you sneaked in a whitespace change here which is unrelated to
the stated purpose of this patch, thus acted as a speed bump during
review. If this was the only instance in this test script of
whitespace needing correction, then it _might_ be okay to include it
in this patch, however, that's not the case. There are many other such
instance in this test script which could be corrected, so it doesn't
make sense to single out these two and ignore all the others.
Therefore, you should omit this change.

>         git svn fetch four &&
> -       test $(git rev-list refs/remotes/four/tags/next | wc -l) -eq 5 &&
> -       test $(git rev-list refs/remotes/four/branches/v2/start | wc -l) =
-eq 3 &&
> +       git rev-list refs/remotes/four/tags/next >actual &&
> +       test_line_count =3D 5 actual &&
> +       git rev-list refs/remotes/four/branches/v2/start >actual2 &&
> +       test_line_count =3D 3 actual2 &&

Ditto: name all these files "actual" rather than unnecessarily
inventing unique names

>         test $(git rev-parse refs/remotes/four/branches/v2/start~2) =3D \
>              $(git rev-parse refs/remotes/four/trunk) &&
>         test $(git rev-parse refs/remotes/four/tags/next~2) =3D \
>              $(git rev-parse refs/remotes/four/branches/v2/start) &&
> -       git log --pretty=3Doneline refs/remotes/four/tags/next | \
> -           sed -e "s/^.\{41\}//" > output.four &&
> +       git log --pretty=3Doneline refs/remotes/four/tags/next >actual3 &=
&
> +       sed -e "s/^.\{41\}//" actual3 > output.four &&

Style: drop space after '>'

>         test_cmp expect.four output.four
> diff --git a/t/t9110-git-svn-use-svm-props.sh b/t/t9110-git-svn-use-svm-p=
rops.sh
> @@ -21,38 +21,38 @@ uuid=3D161ce429-a9dd-4828-af4a-52023f968c89
>  test_expect_success 'verify metadata for /bar' "
> -       git cat-file commit refs/remotes/bar | \
> -          grep '^git-svn-id: $bar_url@12 $uuid$' &&
> -       git cat-file commit refs/remotes/bar~1 | \
> -          grep '^git-svn-id: $bar_url@11 $uuid$' &&
> -       git cat-file commit refs/remotes/bar~2 | \
> -          grep '^git-svn-id: $bar_url@10 $uuid$' &&
> -       git cat-file commit refs/remotes/bar~3 | \
> -          grep '^git-svn-id: $bar_url@9 $uuid$' &&
> -       git cat-file commit refs/remotes/bar~4 | \
> -          grep '^git-svn-id: $bar_url@6 $uuid$' &&
> -       git cat-file commit refs/remotes/bar~5 | \
> -          grep '^git-svn-id: $bar_url@1 $uuid$'
> +       git cat-file commit refs/remotes/bar >actual &&
> +       grep '^git-svn-id: $bar_url@12 $uuid$' actual &&
> +       git cat-file commit refs/remotes/bar~1 >actual1 &&
> +       grep '^git-svn-id: $bar_url@11 $uuid$' actual1 &&
> +       git cat-file commit refs/remotes/bar~2 >actual2 &&
> +       grep '^git-svn-id: $bar_url@10 $uuid$' actual2 &&
> +       git cat-file commit refs/remotes/bar~3 >actual3 &&
> +       grep '^git-svn-id: $bar_url@9 $uuid$' actual3 &&
> +       git cat-file commit refs/remotes/bar~4 >actual4 &&
> +       grep '^git-svn-id: $bar_url@6 $uuid$' actual4 &&
> +       git cat-file commit refs/remotes/bar~5 >actual5 &&
> +       grep '^git-svn-id: $bar_url@1 $uuid$' actual5
>         "

Ditto: name all these files "actual" rather than unnecessarily
inventing unique names

Same comment applies to many more tests below; I won't be repeating it
beyond this point.

> diff --git a/t/t9130-git-svn-authors-file.sh b/t/t9130-git-svn-authors-fi=
le.sh
> @@ -102,8 +104,10 @@ test_expect_success !MINGW 'fresh clone with svn.aut=
hors-file in config' '
>                 test x"$HOME"/svn-authors =3D x"$(git config svn.authorsf=
ile)" &&
>                 git svn clone "$svnrepo" gitconfig.clone &&
>                 cd gitconfig.clone &&
> -               nr_ex=3D$(git log | grep "^Author:.*example.com" | wc -l)=
 &&
> -               nr_rev=3D$(git rev-list HEAD | wc -l) &&
> +               nr_ex=3D$(git log >actual &&
> +                           grep "^Author:.*example.com" actual | wc -l) =
&&
> +               nr_rev=3D$(git rev-list HEAD >actual &&
> +                            wc -l < actual) &&
>                 test $nr_rev -eq $nr_ex

This transformation is effectively bogus, as explained already in my
review[3] of v1. If git-log or git-rev-list fails, variable nr_ex or
nr_rev will have an empty value, thus 'test' will error out. Move the
git-log and git-rev-list invocations out of the $(...):

    git log >actual &&
    nr_ex=3D$(grep "..." actual | wc -l) &&
    git rev-list HEAD >actual &&
    nr_rev=3D$(wc -l <actual) &&
    test $nr_rev -eq $nr_ex

Also, style: drop space after '<'

[3]: https://public-inbox.org/git/CAPig+cRPzyw525ODC4=3D-E7w=3DzbpbhVN2eqxS=
YDSLij5wfW8S_A@mail.gmail.com/

> diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
> @@ -43,20 +43,20 @@ test_expect_success 'fast-export | fast-import' '
>         MUSS=3D$(git rev-parse --verify muss) &&
>         mkdir new &&
>         git --git-dir=3Dnew/.git init &&
> -       git fast-export --all |
> +       git fast-export --all >actual &&
>         (cd new &&
>          git fast-import &&
>          test $MASTER =3D $(git rev-parse --verify refs/heads/master) &&
>          test $REIN =3D $(git rev-parse --verify refs/tags/rein) &&
>          test $WER =3D $(git rev-parse --verify refs/heads/wer) &&
> -        test $MUSS =3D $(git rev-parse --verify refs/tags/muss))
> +        test $MUSS =3D $(git rev-parse --verify refs/tags/muss)) < actua=
l

Style: drop space after '<'

>  '
>
>  test_expect_success 'fast-export master~2..master' '
>
> -       git fast-export master~2..master |
> -               sed "s/master/partial/" |
> +       git fast-export master~2..master >actual2 &&
> +       sed "s/master/partial/" actual2 |

Not sure why you named this "actual2" rather than just "actual".

>                 (cd new &&
>                  git fast-import &&
>                  test $MASTER !=3D $(git rev-parse --verify refs/heads/pa=
rtial) &&
> @@ -74,11 +74,12 @@ test_expect_success 'iso-8859-1' '
>         git commit -s -m den file &&
> -       git fast-export wer^..wer |
> -               sed "s/wer/i18n/" |
> -               (cd new &&
> -                git fast-import &&
> -                git cat-file commit i18n | grep "=C3=81=C3=A9=C3=AD =C3=
=B3=C3=BA")
> +       git fast-export wer^..wer >actual3 &&
> +       sed "s/wer/i18n/" actual3 |

Ditto: Why "actual3" rather than "actual"?

> +           (cd new &&
> +               git fast-import &&
> +               git cat-file commit i18n >actual4 &&
> +               grep "=C3=81=C3=A9=C3=AD =C3=B3=C3=BA" actual4)
> @@ -87,18 +88,18 @@ test_expect_success 'import/export-marks' '
>         git fast-export --export-marks=3Dtmp-marks HEAD &&
>         test -s tmp-marks &&
>         test_line_count =3D 3 tmp-marks &&
> +       git fast-export --import-marks=3Dtmp-marks\
> +               --export-marks=3Dtmp-marks HEAD >actual &&

Style: not a new problem, but add space before \ since you're touching it

>         test $(
> -               git fast-export --import-marks=3Dtmp-marks\
> -               --export-marks=3Dtmp-marks HEAD |
> -               grep ^commit |
> +               grep ^commit actual |
>                 wc -l) \
>         -eq 0 &&
> @@ -192,7 +193,7 @@ test_expect_success 'submodule fast-export | fast-imp=
ort' '
>          git checkout master &&
>          git submodule init &&
>          git submodule update &&
> -        cmp sub/file ../sub/file)
> +        cmp sub/file ../sub/file) < actual

Style: drop space after '<'

> @@ -361,18 +362,20 @@ test_expect_failure 'no exact-ref revisions include=
d' '
> -test_expect_success 'path limiting with import-marks does not lose unmod=
ified files'        '
> +test_expect_success 'path limiting with import-marks does not lose unmod=
ified files'       '

It's probably better not to sneak in whitespace changes, especially if
you're not fixing all of them in this script (and this isn't even the
correct fix). Same comment applies below.

> -test_expect_success 'full-tree re-shows unmodified files'        '
> +test_expect_success 'full-tree re-shows unmodified files'       '
> @@ -505,8 +508,8 @@ test_expect_success 'refs are updated even if no comm=
its need to be exported' '
>  test_expect_success 'use refspec' '
> -       git fast-export --refspec refs/heads/master:refs/heads/foobar mas=
ter | \
> -               grep "^commit " | sort | uniq > actual &&
> +       git fast-export --refspec refs/heads/master:refs/heads/foobar mas=
ter >actual2 &&
> +       grep "^commit " actual2 | sort | uniq > actual &&

Style: drop space before '>' (and probably the next line too)

>         echo "commit refs/heads/foobar" > expected &&
> @@ -534,7 +537,8 @@ test_expect_success 'when using -C, do not declare co=
py when source of copy is a
>         test_create_repo dst &&
> -       git -C src fast-export --all -C | git -C dst fast-import &&
> +       git -C src fast-export --all -C > actual &&
> +       git -C dst fast-import < actual &&

Style: drop space before '>' and '<'

>         git -C src show >expected &&
>         git -C dst show >actual &&
>         test_cmp expected actual
