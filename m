Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4756C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 15:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90F07610CF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 15:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhJ1Pre (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 11:47:34 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:35983 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhJ1Pre (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 11:47:34 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MSI6i-1mDUry1VCC-00SdQD; Thu, 28 Oct 2021 17:44:42 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 406151E01E7;
        Thu, 28 Oct 2021 15:44:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Qi0b81-Aviwh; Thu, 28 Oct 2021 17:44:40 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (24-usr-pf-main.vpn.it.cetitec.com [10.8.5.24])
        by mail.cetitecgmbh.com (Postfix) with ESMTPSA id AF7491E01E6;
        Thu, 28 Oct 2021 17:44:40 +0200 (CEST)
Received: by pflmari.corp.cetitec.com (Postfix, from local account)
Date:   Thu, 28 Oct 2021 17:44:40 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] Remove negation from the commit and merge option
 "--no-verify"
Message-ID: <YXrFaJXbuSuwfhQ7@pflmari>
References: <YXfwanz3MynCLDmn@pflmari>
 <YXhwGQOTfD+ypbo8@coredump.intra.peff.net>
 <YXlBhmfXl3wFQ5Bj@pflmari>
 <YXlD5ecNSdeBSMoS@coredump.intra.peff.net>
 <YXlTpzrY7KFqRlno@pflmari>
 <xmqq4k92w7do.fsf@gitster.g>
 <YXpFTJTo0pKhM7xG@pflmari>
 <YXpZddOixrJDd//s@pflmari>
 <edca7f6b-e89c-7efa-c6f5-2c3aaaea54f9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edca7f6b-e89c-7efa-c6f5-2c3aaaea54f9@gmail.com>
X-Provags-ID: V03:K1:u4+oDaSwwjuA8Y0NQLq8JhvezSdy82mDpI3Pr1UMi9r+N7KBKAa
 6Z9dk7EnYRB99lklh+l0eUfqfaGd4PYybNeTjixebJNCpeP42E8DhAfHsHDyiCnOU3LzoHt
 QF7xxh0tdwhbYHmJam0oU1uh9ezJx9c7OpYepSlUkzjKVO1V9fvpMouKDeqVdID+2+8ILnD
 ELxS6rNjnfm1rp1Xty60w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kEXTtLmXcUs=:CDfg/Nla+OyU3iwv7kkZfA
 2Q8Y2iAXlz5cK4+Ya4N3gU2jhGZPMWmL7WnQr0v9UnACmbPFTDln0kUMANqHF/wL4Bn5BxpI4
 fyd0Pgt/9IAjGs3TPtj33PE/RuY84lyqt0CvVBqpiwW3+mivBO5JDCznZONDIQ7A79rqB9w9F
 5Ju+AKpkbB5dCWNTAR7wDaImlUs4AsRTx/3yiQR7yIdG+qOvdpnJiqFBCCX/qq2iPTUxPiLqK
 TSEtYZ6tT3pL04NdkId3SoRQDEEPUvrL9Y2V0JEhUK4jEenA3qEjxFbxfrX8mCGZFg+Znen+P
 dyAlrUijyZ6iAwwSIQchnH8qlApcA6MA2xHmIJvoIwZXcIs4mrFi+cW0BGxNxWVLGdWb0CcxT
 cXvMLbZ585KbWfYEiwh5nhXC+kr7jqAWOeF0BwAPjKWBhGhXvVnRG9IptcwpYOcXVEu0lIsI3
 kXU4DVoBHJcQ8Bgplz5MuyoP4XKT4NCyN02C/+9jumRBok4zMZ/ZMKbvt2ZSmImPl+1F8nQyB
 CNYawHFJf+7rciPiRevu/PKl1QjPwTW4wnbWCZk2fn/2VPsOMYLyKEF5/6ZVQw1aE5TmCYxrd
 yurBvLDDt01MH0W0vauQXC9UiqtqBC6hdVqNdK1BNqF2YMLbfxqBzLgXq8IcIeq1jdvkxTrXV
 /ktOgy+TfHi/1nnnyta1dKuZz3BR6b/cuG3G5pjqmkpdRCG759k77FwU2KOUEnTKuqESdHWIZ
 JkRhkaVwKZwk2Eyy
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alex Riesen <raa.lkml@gmail.com>

This documents re-enabling of the hooks disabled by an earlier
"--no-verify" in command-line.

Signed-off-by: Alexander Riesen <raa.lkml@gmail.com>
---

Hi Phillip,

Phillip Wood, Thu, Oct 28, 2021 15:57:58 +0200:
> On 28/10/2021 09:04, Alex Riesen wrote:
> > From: Alex Riesen <raa.lkml@gmail.com>
> > 
> > This allows re-enabling of the hooks disabled by an earlier "--no-verify"
> > in command-line and makes the interface more consistent.
> 
> Thanks for working on this. Since 0f1930c587 ("parse-options: allow
> positivation of options starting, with no-", 2012-02-25) merge and commit
> have accepted "--verify" but it is undocumented. The documentation updates
> and fix to pull in this patch are very welcome, but I'm not sure we need the
> other changes. I've left a couple of comments below.
> 
> [As an aside we should probably improve the documentation in parse-options.h
> if both Peff and Junio did not know how it handles "--no-foo" but that is
> outside the scope of this patch]

Interesting feature. It is unfortunate it was so well hidden. You're right, of
course, and the newly added tests in t7504-commit-msg-hook.sh pass without any
changes to the "builtin/commit.c".

Removal of double-negation in the code was an improvement to its readability,
but I like small patches more.

Also, the series has no conflicts with 2.33.0 anymore and the "git pull" can
be applied independently.

> > diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> > index a3baea32ae..ba66209274 100644
> > --- a/Documentation/git-commit.txt
> > +++ b/Documentation/git-commit.txt
> > @@ -11,7 +11,7 @@ SYNOPSIS
> >   'git commit' [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]
> >   	   [--dry-run] [(-c | -C | --fixup | --squash) <commit>]
> >   	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
> > -	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
> > +	   [--allow-empty-message] [--[no-]verify] [-e] [--author=<author>]
> 
> I think for the synopsis it is fine just to list the most common options.
> Having --no-verify without the [no-] makes it clear that --verify is the
> default so is not a commonly used option.

Yep, makes sense.

> >   	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
> >   	   [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]
> >   	   [-S[<keyid>]] [--] [<pathspec>...]
> > @@ -174,7 +174,13 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
> >   -n::
> >   --no-verify::
> > -	This option bypasses the pre-commit and commit-msg hooks.
> > +	By default, pre-merge and commit-msg hooks are run. When one of these
> 
> I think saying "the pre-merge and commit-msg hooks" would be clearer as you
> do below.
> 
> > +	options is given, these are bypassed.
> > +	See also linkgit:githooks[5].
> > +
> > +--verify::
> > +	This option re-enables running of the pre-commit and commit-msg hooks
> > +	after an earlier `-n` or `--no-verify`.
> >   	See also linkgit:githooks[5].
> 
> Some of the existing documentation describes the "--no-foo" option with
> "--foo" (e.g --[no-]signoff) but in other places we list the two options
> separately (e.g. --[no-]edit), I'd lean towards combining them as you have
> done for the merge documentation but I don't feel strongly about it.

How about this instead:

  -n::
  --no-verify::
          By default, pre-commit and commit-msg hooks are run. When one of these
          options is given, the hooks will be bypassed.
          See also linkgit:githooks[5].

  --verify::
          This option re-enables running of the pre-commit and commit-msg hooks
          after an earlier `-n` or `--no-verify`.

> > diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> > index 3819fadac1..324ae879d2 100644
> > --- a/Documentation/git-merge.txt
> > +++ b/Documentation/git-merge.txt
> > @@ -10,7 +10,7 @@ SYNOPSIS
> >   --------
> >   [verse]
> >   'git merge' [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
> > -	[--no-verify] [-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
> > +	[--[no-]verify] [-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
> 
> Again I'm not sure changing the synopsis makes things clearer.

Removed.

> >   	[--[no-]allow-unrelated-histories]
> >   	[--[no-]rerere-autoupdate] [-m <msg>] [-F <file>] [<commit>...]
> >   'git merge' (--continue | --abort | --quit)
> > diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
> > index 80d4831662..f8016b0f7b 100644
> > --- a/Documentation/merge-options.txt
> > +++ b/Documentation/merge-options.txt
> > @@ -112,8 +112,9 @@ option can be used to override --squash.
> >   +
> >   With --squash, --commit is not allowed, and will fail.
> > ---no-verify::
> > -	This option bypasses the pre-merge and commit-msg hooks.
> > +--[no-]verify::
> > +	By default, pre-merge and commit-msg hooks are run. When `--no-verify`
> 
> I think "the pre-merge ..." would be better here as well.

Like this?

  --[no-]verify::
          By default, the pre-merge and commit-msg hooks are run.
	  When `--no-verify` is given, these are bypassed.
          See also linkgit:githooks[5].

> > diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
> > index 31b9c6a2c1..166ff5fb26 100755
> > --- a/t/t7504-commit-msg-hook.sh
> > +++ b/t/t7504-commit-msg-hook.sh
> > @@ -130,6 +130,14 @@ test_expect_success '--no-verify with failing hook' '
> >   '
> > +test_expect_success '-n with failing hook' '
> > +
> > +	echo "more" >> file &&
> > +	git add file &&
> > +	git commit -n -m "more"
> > +
> > +'
> 
> Is this to check that "-n" works like "--no-verify"?

Frankly, it was to check that the separate "-n" option works as I supposed it
would. I never used parse-options before.

> I think it would be very useful to add another test that checks "--verify"
> overrides "--no-verify".

Replaced the test with one which has "-n --verify".

Thanks!


 Documentation/git-commit.txt    | 7 ++++++-
 Documentation/merge-options.txt | 5 +++--
 t/t7504-commit-msg-hook.sh      | 8 ++++++++
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index a3baea32ae..2268787483 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -174,9 +174,14 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
 
 -n::
 --no-verify::
-	This option bypasses the pre-commit and commit-msg hooks.
+	By default, pre-commit and commit-msg hooks are run. When one of these
+	options is given, the hooks will be bypassed.
 	See also linkgit:githooks[5].
 
+--verify::
+	This option re-enables running of the pre-commit and commit-msg hooks
+	after an earlier `-n` or `--no-verify`.
+
 --allow-empty::
 	Usually recording a commit that has the exact same tree as its
 	sole parent commit is a mistake, and the command prevents you
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 80d4831662..80267008af 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -112,8 +112,9 @@ option can be used to override --squash.
 +
 With --squash, --commit is not allowed, and will fail.
 
---no-verify::
-	This option bypasses the pre-merge and commit-msg hooks.
+--[no-]verify::
+	By default, the pre-merge and commit-msg hooks are run.
+	When `--no-verify` is given, these are bypassed.
 	See also linkgit:githooks[5].
 
 -s <strategy>::
diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
index 31b9c6a2c1..67fcc19637 100755
--- a/t/t7504-commit-msg-hook.sh
+++ b/t/t7504-commit-msg-hook.sh
@@ -130,6 +130,14 @@ test_expect_success '--no-verify with failing hook' '
 
 '
 
+test_expect_success '-n followed by --verify with failing hook' '
+
+	echo "even more" >> file &&
+	git add file &&
+	test_must_fail git commit -n --verify -m "even more"
+
+'
+
 test_expect_success '--no-verify with failing hook (editor)' '
 
 	echo "more stuff" >> file &&
-- 
2.33.0.22.g8cd9218530

