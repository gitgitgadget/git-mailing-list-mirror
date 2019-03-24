Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B23420248
	for <e@80x24.org>; Sun, 24 Mar 2019 11:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfCXL0p (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 07:26:45 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38705 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfCXL0o (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 07:26:44 -0400
Received: by mail-ot1-f67.google.com with SMTP id e80so5636143ote.5
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 04:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SAFM34UQZiC+PrnoY0dkO6+e+lRqFnmbl9Re3fWqw8Y=;
        b=tgn2vX9CgRCs8dtOnbz8sHNkmfrz9L/JvH/I5sE6hhJVFqBYHBDb+zeOjhVZ4XqtlW
         QbJxkj5XBOerLeZ39IrB7Y7VeFo+FQjZKS1RLJcyheLsgYgZDp6Z2+kwSAqxbKLDZCst
         HH/zZvcrakJAlOGagvKrqfha2oStWKlUJSVJ+iL9XNW3p5tEuzZz4vmogutHDs+8sclP
         VihU/t+dCPDqu6coCNqmokUD/w/45dHgM47Jw0KCIXemmDgl8Du/PypTzMPc8nmQsGvv
         +0YRgZ0coHpdmXB4xxes2U7dIEaxSvJnQ9UogIiTl3GlVKGahJvPXMKPsjPT+cbUsuuJ
         /9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SAFM34UQZiC+PrnoY0dkO6+e+lRqFnmbl9Re3fWqw8Y=;
        b=FkNqrvsJnhTO6v+dGvJAws0lzPlZB3TBtMX5e7kME819FAJqBQz3Q1f5M0qFZfvM3u
         OVi+vHuVxD8W+YpsAziiTPn+wbdQLVfJE5Vc1+nkBphliPT7jNzQhwbepbUpWITzfi7Z
         MYB9aSWOGZRhTAo4ALrEy+6jq55eKYhpmVvjIczC1hBel3Ce37c02woGPAv/I+BHEPO2
         hkyWZfKrSuY5CybOi0d9qaqTe5VenHMkUS7x9jGvCYfctPxXzXYpk11rgMKlZnD/njMC
         JDsgRckazNvY3aELBYd7Qn3Ux1siOmg0S3fVBSSVDKXSxgjCBq+z1rArL6G3Gw0VSfzg
         neVg==
X-Gm-Message-State: APjAAAW1ElYBoBw7oO12DkX4nMdH3k+N9eAmbShujUgSPcfgGveQNytO
        Q+ZHz79dWra4uO7j02bamy5T4YvEl/X8/2XBwAI=
X-Google-Smtp-Source: APXvYqy+izVu1rXT7eB/9TNWR7mfu8svsVIA9do8+LeRZwFO3MwXK2qkSgWna3JzWJiPKv83sTisWC3IySrNmXdqLjo=
X-Received: by 2002:a9d:4d07:: with SMTP id n7mr14528895otf.162.1553426803658;
 Sun, 24 Mar 2019 04:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1552835153.git.ttjtftx@gmail.com> <5a3c6e24eb901c830e8e43608d81aef5d7b60315.1552835153.git.ttjtftx@gmail.com>
 <87imwha1o3.fsf@evledraar.gmail.com>
In-Reply-To: <87imwha1o3.fsf@evledraar.gmail.com>
From:   jonathan chang <ttjtftx@gmail.com>
Date:   Sun, 24 Mar 2019 19:26:32 +0800
Message-ID: <CAOAu_YJs_ZL0nAARNmdSFjmdh6mSP+e7KvzNB3wj-JGe5sHcdA@mail.gmail.com>
Subject: Re: [GSoC][PATCH v3 2/3] t0000: avoid using pipes
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 18, 2019 at 12:47 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Sun, Mar 17 2019, Jonathan Chang wrote:
>
> > The exit code of the upstream in a pipe is ignored thus we should avoid
> > using it. By writing out the output of the git command to a file, we ca=
n
> > test the exit codes of both the commands.
> >
> > Signed-off-by: Jonathan Chang <ttjtftx@gmail.com>
> > ---
> >  t/t0000-basic.sh | 28 ++++++++++++++--------------
> >  1 file changed, 14 insertions(+), 14 deletions(-)
> >
> > diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> > index 53821f5817..47666b013e 100755
> > --- a/t/t0000-basic.sh
> > +++ b/t/t0000-basic.sh
> > @@ -1118,27 +1118,25 @@ P=3D$(test_oid root)
> >
> >  test_expect_success 'git commit-tree records the correct tree in a com=
mit' '
> >       commit0=3D$(echo NO | git commit-tree $P) &&
> > -     tree=3D$(git show --pretty=3Draw $commit0 |
> > -              sed -n -e "s/^tree //p" -e "/^author /q") &&
> > +     git show --pretty=3Draw $commit0 >actual &&
> > +     tree=3D$(sed -n -e "s/^tree //p" -e "/^author /q" actual) &&
> >       test "z$tree" =3D "z$P"
>
> This change is an improvement just changing the "git" invocations. But I
> wonder as we're reviewing this / churning this if we couldn't also
> modernize this style to just:
>
>     git .. >tmp &&
>     sed -n -e <tmp >actual &&
>     test_must_be_empty actual

Do you mean something like this:

-       git show --pretty=3Draw $commit0 >actual &&
-       tree=3D$(sed -n -e "s/^tree //p" -e "/^author /q" actual) &&
-       test "z$tree" =3D "z$P"
+       git show --pretty=3Draw $commit0 >tmp &&
+       sed -n -e "/$P/d" -e "s/^tree //p" -e "/^author /q" tmp >actual &&
+       test_must_be_empty actual

It works. But the semantic is different if we use test_must_be_empty.
I wonder if you mean test_cmp because I found some commits[1 2 3]
that changes 'test "z...' to use test_cmp with 'git log -G 'test "z' --onel=
ine'
and git-show. However, they are all around 2013, so I'm not so sure
this is what you mean either.

I did found some use of sed's 'd' function in conjunction with
test_must_be_empty, using:
  git grep -A 5 'sed .*/d' | grep -B 5 'test_must_be_empty'
However, they don't use parameter expansion in sed.

There are some places where parameter expansion is used in sed, but
that would require test_cmp in this case, and would need to write to
another file to compare.

Maybe this 'test "z$A" =3D "z$B"' syntax is fine, yet most of the existing
usages are added around 12 years ago according git-blame I saw on
github.


[1]: 03c893cbf9 ("t1006: modernize output comparisons", 2013-07-10)
[2]: 848575d833 ("push test: simplify check of push result", 2013-03-18)
[3]: ed838e6615 ("t1300: style updates", 2012-10-23)


> > @@ -1162,12 +1161,13 @@ test_expect_success 'very long name in the inde=
x handled sanely' '
> >       >path4 &&
> >       git update-index --add path4 &&
> >       (
> > -             git ls-files -s path4 |
> > -             sed -e "s/      .*/     /" |
> > +             git ls-files -s path4 >actual &&
> > +             sed -e "s/      .*/     /" actual |
> >               tr -d "\012" &&
> >               echo "$a"
> >       ) | git update-index --index-info &&
> > -     len=3D$(git ls-files "a*" | wc -c) &&
> > +     git ls-files "a*" >actual &&
> > +     len=3D$(wc -c <actual) &&
> >       test $len =3D 4098
>
> Ditto. Maybe the initial author wanted to avoid writing out 4k lines,
> but now that we're doing so anyway...

This is 'wc -c', so I think I don't have to modify it?

By the way, I found 2 lines that can be changed to use test_must_be_empty
in t0000-basic.sh. I paste the diff below:
---
@@ -51,7 +51,7 @@ test_expect_success 'verify that the running shell
supports "local"' '

 test_expect_success '.git/objects should be empty after git init in
an empty repo' '
        find .git/objects -type f -print >should-be-empty &&
-       test_line_count =3D 0 should-be-empty
+       test_must_be_empty should-be-empty
 '

 # also it should have 2 subdirectories; no fan-out anymore, pack, and info=
.
@@ -1110,7 +1110,7 @@ test_expect_success 'git update-index --refresh
should succeed' '

 test_expect_success 'no diff after checkout and git update-index --refresh=
' '
        git diff-files >current &&
-       cmp -s current /dev/null
+       test_must_be_empty current
 '
