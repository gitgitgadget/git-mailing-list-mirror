Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242A3C43334
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 13:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbiFRNBM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jun 2022 09:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbiFRNBL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jun 2022 09:01:11 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB00219FBE
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 06:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655557268;
        bh=NLpAEW8ZLV7wRx6ct7+hl0uC+K6cSkb8thBg0ebb+vI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Co3kga/1YeuV6Da3diqiQoV+irjovc4UuM65sZZ7UkDj5uT4BXHTUVA4pL4oxe2oU
         sIqC02RPOdP09YJ2HiC4n1FdICHteoSrB3y9/iaEaaW8GLtjnYa0fWjykMkSLCofw4
         XXsaARLJx3wd7QMJDKzYZQHXPiRk9egEhxwzhRrU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.60.234] ([89.1.215.185]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZkpb-1oEuA838QZ-00WoFB; Sat, 18
 Jun 2022 15:01:07 +0200
Date:   Sat, 18 Jun 2022 15:01:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Dennis van Gerwen <dvg@xs4all.nl>
cc:     git@vger.kernel.org
Subject: Re: Feature Request: Custom split location for `git add --patch`
In-Reply-To: <da79cc66-42a0-2563-d09b-fbc0ad5b28bd@xs4all.nl>
Message-ID: <nycvar.QRO.7.76.6.2206181359400.349@tvgsbejvaqbjf.bet>
References: <da79cc66-42a0-2563-d09b-fbc0ad5b28bd@xs4all.nl>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HkpeUw46ybRF/dG81xAG2Tzl1yDcKWlhwDIq7FoQ3GJ6saY+ZSz
 Fgtua8u78xyGJ12ZGtH44ayG7C66vvNbSfb9m1NnXzfSRl0CwdRcqHjp0QUatWoj0OLfcZj
 VVhSH2VjiBif2+UhsYeBObDx5iSWLy2TRZ3XXNCDIoIteeNX41UtRnNn2y3crC7reiMj9RE
 3TbopRR+OGLHROVk6coHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U1cZ031xus4=:N1pOgYtrzY1MpgPADCAVPW
 U8hveaGUMkQ38fhdE2lGk+pmWTserk826vS1EC9dYIHxgbnz7Px4jKhqwV2nF7lwMxx4/Z+kv
 61HAVSexn5xdQ3T5q0XqlKB6+AJlbyXziazWGXjIOY7lD+iYCKpQ5ZN43NEeUtuvc2NCeKwbt
 NvzAY3cA+Xq0qL9tbe7Lx/5yBRP2QB6o4qOtLimZ672pCPJJtqj4ov9AVyHdyHw7EXZZ917Tw
 22j8qVXf1sdnQaYHMLQ8EYO+Vr4oHZ8JI+ONRbCANyUaKcfsgcbx8N5F6Sb5SEuc3zO6ly/Dr
 onRl8dMJ/si47yX0mu1ILlAp5AP50x9NmjueFLclGX/3VWTWROJpIEXzK5offZcEqO+ePaL3Z
 ibzyF431MW30LYuPbJugVxwSgEzxJ6/RX21E9KjQ4ANzCLN2dkKR3KMICJ7YqapmXvopK6n1V
 ReThaT4zZxhdL8XYcHOvJTpqovSlDg3iWlyqklo+8YONg6ONFHWMTkBn+vVqYseCFUIHkWE7c
 r9Fm3Z4J1NbeMUzeGnaStiYFsc8KMQEDqtglUYnFJaWQzlEfbF3DXQe50nM0RsfmEPRsjW/u6
 GbOYFqmUhay73xtAt4q1InU3g+Wvivl0j55FESPHamPay/v7a1COzhsv/KJeMy5/JkOPLbspJ
 B+zZdQYbL6TRbbqfbjadXssUaZ9w2enC1rGeiX3HKyK2gsFZqE3RoHKvssefgzJHQ5auab52c
 wTBVgDGwFJevRRS8wMQvLG5/OhdZRGhFx22l7O4tb6Jc6Qf1Rpk5cbe2Fg9EXTJ9i/7IQGxgX
 fZ4/4FxtLVnkn7jbniFdeCfJ28JRLyyK6yi9nUXJVp8objvZNU7Q5y4gmIVwNa8fSNqJJ1kex
 3MH0UQwvt9StUsM8bgtxQHJ8zpnr6Gy1Lv6N4rdxgEosDdIlUxvnAbbZNXdM/PqdbS5mfeuDx
 jdxk5EHINBxN2hZuc45TMQXmYzbVQtz4X1goSZYSoLGMgIYT6dDOTcCr+pqWP4lvgIsfKwS+a
 47SJ08I8Z0RtiC6C91f9QQik3DwSmXBtJi+4WDA9/qzVnNUI+nWrgNhofzkocmFqapjTZE88A
 NaLMdhDQbeApFUVr9wKR4tAjgtLWlTHq283h4eADVXRIoSSeSzEXH08ZA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dennis,

On Thu, 16 Jun 2022, Dennis van Gerwen wrote:

> ## Problem
>
> If a hunk cannot be split automatically, the `s` (split) option disappea=
rs
> from the list of options, and we get:
>
> > (1/6) Stage this hunk [y,n,q,a,d,j,J,g,/,e,?]? s
> > Sorry, cannot split this hunk
>
>
> See for example these questions on StackOverflow: [2], [3]
>
> I am aware that this problem can be solved by using the [`--edit` option=
][4]
> to edit the hunk, as explained in the docs under [editing patches][5].
>
> However, if we have a large contiguous hunk, and we only want to split a=
t one
> specific location, using `--edit` can be quite cumbersome, because (as f=
ar as
> I know) we need to edit all the lines that we do not want to stage.
>
> ## Feature request
>
> Would it be possible to add a "custom split location" feature, allowing =
the
> user to specify where a contiguous hunk should be split?
>
> Some options:
>
> - Always show the `s` (split hunk) option, and let the user specify a li=
ne
> number if an automatic split cannot be made.
>
> - Add a new [patch option][6], in addition to `s` (split hunk), to split=
 any
> hunk at a custom location.
>
> - Add a new operation for editing patches, for example "s" (in addition =
to
> "+", "-", and " "), indicating where to split (e.g. "split after this li=
ne").
> This way the user only needs to modify a single line in edit mode.
>
> I'm sure there are a lot of nasty details to consider, but I do think su=
ch a
> feature would be very convenient.

While I am personally not interested in having this option (I find that I
always have to edit other aspects when splitting at non-context lines,
anyway, so I _have_ to use `e`), if you are interested in giving this a
go, I will be more than happy to help.

The most important thing to note is that there are currently _two_
implementations of the `git add -p` command, one in Perl and one in C. The
former one is slated to be dropped in favor of the latter, so I will
concentrate on the implementation in C.

The function implementing the current split logic is not exactly for the
faint of heart, ~150 lines of almost undocumented code:
https://github.com/git/git/blob/v2.37.0-rc0/add-patch.c#L892-L1049

But then, it does both a lot more _and_ a lot less of what you want: It
automatically finds all stretches of context lines and then expands the
indicated single hunk into as many hunks as it can split it into, sharing
the stretches of context lines between adjacent hunks.

Obviously, you would need to add a new function that is inspired by this
function, but differs in the following aspects:

- It requires an additional parameter, the line offset at which to split
  the hunk.

- It always splits the hunk into two hunks, no more, no less.

However, from my experience with the Git GUI code implementing line
staging, the biggest challenge will be that one of the assumptions of the
current hunk splitting design will be broken by your feature: so far,
when applying a hunk, no other hunks need to be touched: they remain
unchanged.

When splitting a hunk by context lines, the new hunks will share
overlapping context lines, but those remain invariant whether hunks are
applied or not.

With your desired feature, this would change. Take this hunk, for example:

	-- snip --
	@@
	 All journeys start with a first step.

	-[tbd]
	+Actually, some journeys, some interesting ones, end in a disaster
	+right at the start, because the first step was skipped.

	 And this concludes the chapter. Good night.
	-- snap --

Let's just split this for simplicity's sake between the `-` and the `+`
lines. So the first hunk would become:

	-- snip --
	@@
	 All journeys start with a first step.

	-[tbd]

	 And this concludes the chapter. Good night.
	-- snap --

and the second:

	-- snip --
	@@
	 All journeys start with a first step.

	 [tbd]
	+Actually, some journeys, some interesting ones, end in a disaster
	+right at the start, because the first step was skipped.

	 And this concludes the chapter. Good night.
	-- snap --

Note how the `-` line became a context line? It _has_ to be, otherwise the
second hunk could not be applied as-is. That is, until the first hunk has
been applied. In which case the second hunk needs to be modified:

	-- snip --
	@@
	 All journeys start with a first step.

	+Actually, some journeys, some interesting ones, end in a disaster
	+right at the start, because the first step was skipped.

	 And this concludes the chapter. Good night.
	-- snap --

Now the `[tbd]` line in the context has vanished.

This is really an important concept to keep in mind: if you split at
context lines, your hunks can remain immutable. If you want to split
elsewhere, after one of the hunks resulting from said split is a applied,
you have to recompute the other hunk.

In Git GUI, that's easy: it always presents the entire diff, and when
something gets (un-)staged, the entire diff is recomputed.

In `add -p`, we try very hard _not_ to stage anything until the user is
done deciding what to stage and what to skip. It then applies the entire
file diff in one fell swoop.

So why does it work with `edit`, then? You can edit a hunk and stage it,
right? That's because it is still a single hunk. It does not modify any
line that might be the context line of a different hunk.

With this in mind, if you are still interested to tackle this feature,
here are a couple of notes that should get you started:

- The hunks are recorded as an array of element type `struct hunk`
  (https://github.com/git/git/blob/v2.37.0-rc0/add-patch.c#L243-L248) in
  the `struct file_diff`
  (https://github.com/git/git/blob/v2.37.0-rc0/add-patch.c#L256-L261).

- Each hunk has a `start` and `end` offset. This is the offset into the
  diff that is stored in plain text in the `plain` strbuf in `struct
  add_p_state`.

  They have to be offsets instead of pointers because that strbuf can be
  modified, i.e. it might need to grow so much that its needs to move to a
  new memory location (which would invalidate all existing pointers).

- Likewise, there are `colored_start` and `colored_end` (byte) offsets
  that point into the `colored` strbuf of the `struct file_diff`. This is
  because the colored version of the diff may optionally be generated by
  another tool than Git itself, and the only requirement is that it
  generates the same amount of lines and Git assumes a 1:1 correlation
  between the lines.

- Each hunk also has a hunk header. The `old_offset`, `old_count`,
  `new_offset` and `new_count` attributes correspond to the diff hunk
  header, i.e. they refer to line numbers/counts in the pre/post image.

- When splitting a hunk, a new element has to be inserted into the `hunk`
  array of the `struct file_diff`, and the new hunk's numbers have to be
  adjusted carefully, as well as the hunk from which the new hunk was
  split out.

- Since the split hunks require context lines that the corresponding lines
  did not have in the original diff, you cannot simply adjust the `start`
  and `end` offsets to point into the existing diff.

  You have to use the same trick as the `edit` feature: append the new
  hunk with its context lines to `plain` (and to `colored`, unless that's
  empty), and then point to those offsets.

- You need to take care to record relationships between hunks so that one
  hunk's content can be adjusted accordingly if another hunk is staged to
  be applied and therefore changes the former hunk's context lines.

  This is similar to the role of the `delta` field that keeps track how
  the post image line number in the hunk header needs to be adjusted
  depending how previous hunks have been edited.

Ciao,
Dscho
