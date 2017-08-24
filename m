Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 560BF1F4DD
	for <e@80x24.org>; Thu, 24 Aug 2017 03:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751128AbdHXDvI (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 23:51:08 -0400
Received: from mail-vk0-f48.google.com ([209.85.213.48]:35542 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751019AbdHXDvH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 23:51:07 -0400
Received: by mail-vk0-f48.google.com with SMTP id d124so6467872vkf.2
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 20:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=14z0xkPveYOai65FvhwUlcTOM8kbaUY4aEqKJTjZNdc=;
        b=KJ72nPeAGK+UueJR9Q1QHlo+7Iaru8vl4IWFpfSMdoYNz+0H2vhlPzZ03n8NaLRB9J
         je2FVBrdTw3Oga8xLV9VkPoBuXYj0NJfzOFaBeFOszha5ZSJ6WvS1QCBgIz1NjYQnhRq
         rz9LLwXFFVaeErVfz6rU0tCZRT/d0I7cwmAy/YP5IEFAdm/A3/ISD5ksD4Av4DQU2fJ9
         vhzjoAz6Akp0+j4KS2mMYkchKSCOk64A/2FRTZy1REBNnfamNotksMi3VkcTmUjhhs96
         USiN0ANJ9r4ifEjP052D+9sR623ka+tGKNItbeQLomRmuRZi/7GMkr+tM11VPUw27JYL
         ACCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=14z0xkPveYOai65FvhwUlcTOM8kbaUY4aEqKJTjZNdc=;
        b=CBT5uh/XSZCO0R2WTulWMXCf0NHv/7aYXpz2b4ECnebdJpLd9hAKKiYpQQ2EKo+gXF
         nZzUHZhbI+3xUIq79ZJAo72JoI9i2MkfPSnXXmCLtrQIWPFJhGSu4j8qNZnIzE8XQN9u
         WaKg8XMTUS9i7iy7S/3OM9r8pZXVrc93eN5RgKfMLkVqh6LAQAizQI3uj86faRuP7D7L
         O9NHdf0Ssjaj4hI3um6UaUeq5MYEZZtQw48nsuUqNWWooOd44A6VilHFI7DMbOs8IJOp
         8SIPcpS240KryJpBt6pstgUje150hTtizGcelM6ihHuLGMgfof95H8dtW4Ft92U9XDSf
         QvWw==
X-Gm-Message-State: AHYfb5i2brlArXDPikmbW/96m+Sm24tXAkGy8L3Hzf78zBTst5Jf+ZYj
        V/kYkm+pJ5oTKERBKz0XQlawTQhjnsfx
X-Received: by 10.31.13.78 with SMTP id 75mr3119308vkn.121.1503546666402; Wed,
 23 Aug 2017 20:51:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.111.68 with HTTP; Wed, 23 Aug 2017 20:51:05 -0700 (PDT)
In-Reply-To: <78619186c5d587de768f3c5ff033dfeb97bab645.1503494617.git.martin.agren@gmail.com>
References: <CAJXxHvVSXkQ4SYA5=ZtnWZCBbVk51oWY1OqM_XbGNoruyAGBrA@mail.gmail.com>
 <78619186c5d587de768f3c5ff033dfeb97bab645.1503494617.git.martin.agren@gmail.com>
From:   STEVEN WHITE <stevencharleswhitevoices@gmail.com>
Date:   Wed, 23 Aug 2017 20:51:05 -0700
Message-ID: <CAJXxHvXqbwdyW0U=KQ_iRoZg1zVpKr1vchXp7+8eR8ZE2qUGdw@mail.gmail.com>
Subject: Re: [PATCH 2/2] treewide: correct several "up-to-date" to "up to date"
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These corrections all look great (English-language-wise). :)

On Wed, Aug 23, 2017 at 10:49 AM, Martin =C3=85gren <martin.agren@gmail.com=
> wrote:
> Follow the Oxford style, which says to use "up-to-date" before the noun,
> but "up to date" after it. Don't change plumbing (specifically
> send-pack.c, but transport.c (git push) also has the same string).
>
> This was produced by grepping for "up-to-date" and "up to date". It
> turned out we only had to edit in one direction, removing the hyphens.
>
> Fix a typo in Documentation/git-diff-index.txt while we're there.
>
> Reported-by: Jeffrey Manian <jeffrey.manian@gmail.com>
> Reported-by: STEVEN WHITE <stevencharleswhitevoices@gmail.com>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
> I figure "Already up-to-date." is "[X is|I am] already up to date." as
> opposed to "Already [have] up-to-date [X].".
>
>  Documentation/git-apply.txt               | 4 ++--
>  Documentation/git-cvsserver.txt           | 2 +-
>  Documentation/git-diff-index.txt          | 6 +++---
>  Documentation/git-merge.txt               | 2 +-
>  Documentation/git-rebase.txt              | 2 +-
>  Documentation/git-rerere.txt              | 2 +-
>  Documentation/git-rm.txt                  | 2 +-
>  Documentation/git-svn.txt                 | 2 +-
>  Documentation/git-update-index.txt        | 2 +-
>  Documentation/gitcore-tutorial.txt        | 8 ++++----
>  Documentation/githooks.txt                | 2 +-
>  Documentation/gitrepository-layout.txt    | 2 +-
>  Documentation/gittutorial.txt             | 2 +-
>  Documentation/merge-options.txt           | 2 +-
>  Documentation/technical/pack-protocol.txt | 2 +-
>  Documentation/technical/trivial-merge.txt | 4 ++--
>  Documentation/user-manual.txt             | 2 +-
>  t/t6040-tracking-info.sh                  | 4 ++--
>  contrib/examples/git-merge.sh             | 4 ++--
>  contrib/examples/git-resolve.sh           | 2 +-
>  contrib/subtree/t/t7900-subtree.sh        | 2 +-
>  git-merge-octopus.sh                      | 2 +-
>  builtin/merge.c                           | 4 ++--
>  merge-recursive.c                         | 2 +-
>  notes-merge.c                             | 2 +-
>  remote.c                                  | 2 +-
>  unpack-trees.c                            | 2 +-
>  git-gui/po/README                         | 2 +-
>  git-p4.py                                 | 2 +-
>  templates/hooks--pre-rebase.sample        | 2 +-
>  30 files changed, 40 insertions(+), 40 deletions(-)
>
> diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
> index 631cbd840..4ebc3d327 100644
> --- a/Documentation/git-apply.txt
> +++ b/Documentation/git-apply.txt
> @@ -66,7 +66,7 @@ OPTIONS
>         disables it is in effect), make sure the patch is
>         applicable to what the current index file records.  If
>         the file to be patched in the working tree is not
> -       up-to-date, it is flagged as an error.  This flag also
> +       up to date, it is flagged as an error.  This flag also
>         causes the index file to be updated.
>
>  --cached::
> @@ -259,7 +259,7 @@ treats these changes as follows.
>  If `--index` is specified (explicitly or implicitly), then the submodule
>  commits must match the index exactly for the patch to apply.  If any
>  of the submodules are checked-out, then these check-outs are completely
> -ignored, i.e., they are not required to be up-to-date or clean and they
> +ignored, i.e., they are not required to be up to date or clean and they
>  are not updated.
>
>  If `--index` is not specified, then the submodule commits in the patch
> diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserve=
r.txt
> index a336ae5f6..ba90066f1 100644
> --- a/Documentation/git-cvsserver.txt
> +++ b/Documentation/git-cvsserver.txt
> @@ -223,7 +223,7 @@ access method and requested operation.
>  That means that even if you offer only read access (e.g. by using
>  the pserver method), 'git-cvsserver' should have write access to
>  the database to work reliably (otherwise you need to make sure
> -that the database is up-to-date any time 'git-cvsserver' is executed).
> +that the database is up to date any time 'git-cvsserver' is executed).
>
>  By default it uses SQLite databases in the Git directory, named
>  `gitcvs.<module_name>.sqlite`. Note that the SQLite backend creates
> diff --git a/Documentation/git-diff-index.txt b/Documentation/git-diff-in=
dex.txt
> index a17150695..b38067771 100644
> --- a/Documentation/git-diff-index.txt
> +++ b/Documentation/git-diff-index.txt
> @@ -85,7 +85,7 @@ a 'git write-tree' + 'git diff-tree'. Thus that's the d=
efault mode.
>  The non-cached version asks the question:
>
>    show me the differences between HEAD and the currently checked out
> -  tree - index contents _and_ files that aren't up-to-date
> +  tree - index contents _and_ files that aren't up to date
>
>  which is obviously a very useful question too, since that tells you what
>  you *could* commit. Again, the output matches the 'git diff-tree -r'
> @@ -100,8 +100,8 @@ have not actually done a 'git update-index' on it yet=
 - there is no
>    torvalds@ppc970:~/v2.6/linux> git diff-index --abbrev HEAD
>    :100644 100664 7476bb... 000000...      kernel/sched.c
>
> -i.e., it shows that the tree has changed, and that `kernel/sched.c` has =
is
> -not up-to-date and may contain new stuff. The all-zero sha1 means that t=
o
> +i.e., it shows that the tree has changed, and that `kernel/sched.c` is
> +not up to date and may contain new stuff. The all-zero sha1 means that t=
o
>  get the real diff, you need to look at the object in the working directo=
ry
>  directly rather than do an object-to-object diff.
>
> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index 04fdd8cf0..53366a170 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -133,7 +133,7 @@ exception is when the changed index entries are in th=
e state that
>  would result from the merge already.)
>
>  If all named commits are already ancestors of `HEAD`, 'git merge'
> -will exit early with the message "Already up-to-date."
> +will exit early with the message "Already up to date."
>
>  FAST-FORWARD MERGE
>  ------------------
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 4f6bed61a..6805a74ae 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -334,7 +334,7 @@ which makes little sense.
>
>  -f::
>  --force-rebase::
> -       Force a rebase even if the current branch is up-to-date and
> +       Force a rebase even if the current branch is up to date and
>         the command without `--force` would return without doing anything=
.
>  +
>  You may find this (or --no-ff with an interactive rebase) helpful after
> diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
> index 9ee083c41..031f31fa4 100644
> --- a/Documentation/git-rerere.txt
> +++ b/Documentation/git-rerere.txt
> @@ -205,7 +205,7 @@ development on the topic branch:
>  ------------
>
>  you could run `git rebase master topic`, to bring yourself
> -up-to-date before your topic is ready to be sent upstream.
> +up to date before your topic is ready to be sent upstream.
>  This would result in falling back to a three-way merge, and it
>  would conflict the same way as the test merge you resolved earlier.
>  'git rerere' will be run by 'git rebase' to help you resolve this
> diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
> index 683e59133..b5c46223c 100644
> --- a/Documentation/git-rm.txt
> +++ b/Documentation/git-rm.txt
> @@ -146,7 +146,7 @@ the submodule's history. If it exists the submodule.<=
name> section
>  in the linkgit:gitmodules[5] file will also be removed and that file
>  will be staged (unless --cached or -n are used).
>
> -A submodule is considered up-to-date when the HEAD is the same as
> +A submodule is considered up to date when the HEAD is the same as
>  recorded in the index, no tracked files are modified and no untracked
>  files that aren't ignored are present in the submodules work tree.
>  Ignored files are deemed expendable and won't stop a submodule's work
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index aa2aeabb6..636e09048 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -424,7 +424,7 @@ Any other arguments are passed directly to 'git log'
>  'set-tree'::
>         You should consider using 'dcommit' instead of this command.
>         Commit specified commit or tree objects to SVN.  This relies on
> -       your imported fetch data being up-to-date.  This makes
> +       your imported fetch data being up to date.  This makes
>         absolutely no attempts to do patching when committing to SVN, it
>         simply overwrites files with those specified in the tree or
>         commit.  All merging is assumed to have taken place
> diff --git a/Documentation/git-update-index.txt b/Documentation/git-updat=
e-index.txt
> index 1579abf3c..e19eba62c 100644
> --- a/Documentation/git-update-index.txt
> +++ b/Documentation/git-update-index.txt
> @@ -214,7 +214,7 @@ will remove the intended effect of the option.
>  Using --refresh
>  ---------------
>  `--refresh` does not calculate a new sha1 file or bring the index
> -up-to-date for mode/content changes. But what it *does* do is to
> +up to date for mode/content changes. But what it *does* do is to
>  "re-match" the stat information of a file with the index, so that you
>  can refresh the index for a file that hasn't been changed but where
>  the stat entry is out of date.
> diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-t=
utorial.txt
> index 7577f27ec..e29a9effc 100644
> --- a/Documentation/gitcore-tutorial.txt
> +++ b/Documentation/gitcore-tutorial.txt
> @@ -631,7 +631,7 @@ So after you do a `cp -a` to create a new copy, you'l=
l want to do
>  $ git update-index --refresh
>  ----------------
>  +
> -in the new repository to make sure that the index file is up-to-date.
> +in the new repository to make sure that the index file is up to date.
>
>  Note that the second point is true even across machines. You can
>  duplicate a remote Git repository with *any* regular copy mechanism, be =
it
> @@ -701,7 +701,7 @@ $ git checkout-index -u -a
>  ----------------
>
>  where the `-u` flag means that you want the checkout to keep the index
> -up-to-date (so that you don't have to refresh it afterward), and the
> +up to date (so that you don't have to refresh it afterward), and the
>  `-a` flag means "check out all files" (if you have a stale copy or an
>  older version of a checked out tree you may also need to add the `-f`
>  flag first, to tell 'git checkout-index' to *force* overwriting of any o=
ld
> @@ -1283,7 +1283,7 @@ run a single command, 'git-receive-pack'.
>
>  First, you need to create an empty repository on the remote
>  machine that will house your public repository. This empty
> -repository will be populated and be kept up-to-date by pushing
> +repository will be populated and be kept up to date by pushing
>  into it later. Obviously, this repository creation needs to be
>  done only once.
>
> @@ -1450,7 +1450,7 @@ transport protocols (HTTP), you need to keep this r=
epository
>  would contain a call to 'git update-server-info'
>  but you need to manually enable the hook with
>  `mv post-update.sample post-update`.  This makes sure
> -'git update-server-info' keeps the necessary files up-to-date.
> +'git update-server-info' keeps the necessary files up to date.
>
>  3. Push into the public repository from your primary
>     repository.
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index 623ed1a13..1bb4f92d4 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -369,7 +369,7 @@ them.
>
>  When enabled, the default 'post-update' hook runs
>  'git update-server-info' to keep the information used by dumb
> -transports (e.g., HTTP) up-to-date.  If you are publishing
> +transports (e.g., HTTP) up to date.  If you are publishing
>  a Git repository that is accessible via HTTP, you should
>  probably enable this hook.
>
> diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitre=
pository-layout.txt
> index f51ed4e37..adf9554ad 100644
> --- a/Documentation/gitrepository-layout.txt
> +++ b/Documentation/gitrepository-layout.txt
> @@ -71,7 +71,7 @@ objects/info/packs::
>         This file is to help dumb transports discover what packs
>         are available in this object store.  Whenever a pack is
>         added or removed, `git update-server-info` should be run
> -       to keep this file up-to-date if the repository is
> +       to keep this file up to date if the repository is
>         published for dumb transports.  'git repack' does this
>         by default.
>
> diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.tx=
t
> index 794b83393..242de31cb 100644
> --- a/Documentation/gittutorial.txt
> +++ b/Documentation/gittutorial.txt
> @@ -109,7 +109,7 @@ summary of the situation with 'git status':
>  $ git status
>  On branch master
>  Changes to be committed:
> -Your branch is up-to-date with 'origin/master'.
> +Your branch is up to date with 'origin/master'.
>    (use "git reset HEAD <file>..." to unstage)
>
>         modified:   file1
> diff --git a/Documentation/merge-options.txt b/Documentation/merge-option=
s.txt
> index 5b4a62e93..4e3230430 100644
> --- a/Documentation/merge-options.txt
> +++ b/Documentation/merge-options.txt
> @@ -39,7 +39,7 @@ set to `no` at the beginning of them.
>
>  --ff-only::
>         Refuse to merge and exit with a non-zero status unless the
> -       current `HEAD` is already up-to-date or the merge can be
> +       current `HEAD` is already up to date or the merge can be
>         resolved as a fast-forward.
>
>  --log[=3D<n>]::
> diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/te=
chnical/pack-protocol.txt
> index a34917153..ed1eae8b8 100644
> --- a/Documentation/technical/pack-protocol.txt
> +++ b/Documentation/technical/pack-protocol.txt
> @@ -199,7 +199,7 @@ After reference and capabilities discovery, the clien=
t can decide to
>  terminate the connection by sending a flush-pkt, telling the server it c=
an
>  now gracefully terminate, and disconnect, when it does not need any pack
>  data. This can happen with the ls-remote command, and also can happen wh=
en
> -the client already is up-to-date.
> +the client already is up to date.
>
>  Otherwise, it enters the negotiation phase, where the client and
>  server determine what the minimal packfile necessary for transport is,
> diff --git a/Documentation/technical/trivial-merge.txt b/Documentation/te=
chnical/trivial-merge.txt
> index c79d4a7c4..1f1c33d0d 100644
> --- a/Documentation/technical/trivial-merge.txt
> +++ b/Documentation/technical/trivial-merge.txt
> @@ -32,7 +32,7 @@ or the result.
>  If multiple cases apply, the one used is listed first.
>
>  A result which changes the index is an error if the index is not empty
> -and not up-to-date.
> +and not up to date.
>
>  Entries marked '+' have stat information. Spaces marked '*' don't
>  affect the result.
> @@ -65,7 +65,7 @@ empty, no entry is left for that stage). Otherwise, the=
 given entry is
>  left in stage 0, and there are no other entries.
>
>  A result of "no merge" is an error if the index is not empty and not
> -up-to-date.
> +up to date.
>
>  *empty* means that the tree must not have a directory-file conflict
>   with the entry.
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.tx=
t
> index d3c53b513..b4d88af13 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -2195,7 +2195,7 @@ $ cd work
>  Linus's tree will be stored in the remote-tracking branch named origin/m=
aster,
>  and can be updated using linkgit:git-fetch[1]; you can track other
>  public trees using linkgit:git-remote[1] to set up a "remote" and
> -linkgit:git-fetch[1] to keep them up-to-date; see
> +linkgit:git-fetch[1] to keep them up to date; see
>  <<repositories-and-branches>>.
>
>  Now create the branches in which you are going to work; these start out
> diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
> index 97a07655a..16ca6081f 100755
> --- a/t/t6040-tracking-info.sh
> +++ b/t/t6040-tracking-info.sh
> @@ -100,7 +100,7 @@ test_expect_success 'checkout (up-to-date with upstre=
am)' '
>         (
>                 cd test && git checkout b6
>         ) >actual &&
> -       test_i18ngrep "Your branch is up-to-date with .origin/master" act=
ual
> +       test_i18ngrep "Your branch is up to date with .origin/master" act=
ual
>  '
>
>  test_expect_success 'status (diverged from upstream)' '
> @@ -130,7 +130,7 @@ test_expect_success 'status (up-to-date with upstream=
)' '
>                 # reports nothing to commit
>                 test_must_fail git commit --dry-run
>         ) >actual &&
> -       test_i18ngrep "Your branch is up-to-date with .origin/master" act=
ual
> +       test_i18ngrep "Your branch is up to date with .origin/master" act=
ual
>  '
>
>  cat >expect <<\EOF
> diff --git a/contrib/examples/git-merge.sh b/contrib/examples/git-merge.s=
h
> index ee99f1a4e..932e78dbf 100755
> --- a/contrib/examples/git-merge.sh
> +++ b/contrib/examples/git-merge.sh
> @@ -399,7 +399,7 @@ case "$allow_fast_forward,$#,$common,$no_commit" in
>  ?,1,"$1",*)
>         # If head can reach all the merge then we are up to date.
>         # but first the most common case of merging one remote.
> -       finish_up_to_date "Already up-to-date."
> +       finish_up_to_date "Already up to date."
>         exit 0
>         ;;
>  t,1,"$head",*)
> @@ -459,7 +459,7 @@ t,1,"$head",*)
>         done
>         if test "$up_to_date" =3D t
>         then
> -               finish_up_to_date "Already up-to-date. Yeeah!"
> +               finish_up_to_date "Already up to date. Yeeah!"
>                 exit 0
>         fi
>         ;;
> diff --git a/contrib/examples/git-resolve.sh b/contrib/examples/git-resol=
ve.sh
> index 70fdc27b7..3099dc851 100755
> --- a/contrib/examples/git-resolve.sh
> +++ b/contrib/examples/git-resolve.sh
> @@ -41,7 +41,7 @@ fi
>
>  case "$common" in
>  "$merge")
> -       echo "Already up-to-date. Yeeah!"
> +       echo "Already up to date. Yeeah!"
>         dropheads
>         exit 0
>         ;;
> diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900=
-subtree.sh
> index 3c87ebaf5..d05c613c9 100755
> --- a/contrib/subtree/t/t7900-subtree.sh
> +++ b/contrib/subtree/t/t7900-subtree.sh
> @@ -253,7 +253,7 @@ test_expect_success 'merge the added subproj again, s=
hould do nothing' '
>                 # this shouldn not actually do anything, since FETCH_HEAD
>                 # is already a parent
>                 result=3D$(git merge -s ours -m "merge -s -ours" FETCH_HE=
AD) &&
> -               check_equal "${result}" "Already up-to-date."
> +               check_equal "${result}" "Already up to date."
>         )
>  '
>
> diff --git a/git-merge-octopus.sh b/git-merge-octopus.sh
> index 6c390d6c2..7d19d3795 100755
> --- a/git-merge-octopus.sh
> +++ b/git-merge-octopus.sh
> @@ -74,7 +74,7 @@ do
>
>         case "$LF$common$LF" in
>         *"$LF$SHA1$LF"*)
> -               eval_gettextln "Already up-to-date with \$pretty_name"
> +               eval_gettextln "Already up to date with \$pretty_name"
>                 continue
>                 ;;
>         esac
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 328945d60..3941c3275 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1345,7 +1345,7 @@ int cmd_merge(int argc, const char **argv, const ch=
ar *prefix)
>                  * If head can reach all the merge then we are up to date=
.
>                  * but first the most common case of merging one remote.
>                  */
> -               finish_up_to_date(_("Already up-to-date."));
> +               finish_up_to_date(_("Already up to date."));
>                 goto done;
>         } else if (fast_forward !=3D FF_NO && !remoteheads->next &&
>                         !common->next &&
> @@ -1428,7 +1428,7 @@ int cmd_merge(int argc, const char **argv, const ch=
ar *prefix)
>                         }
>                 }
>                 if (up_to_date) {
> -                       finish_up_to_date(_("Already up-to-date. Yeeah!")=
);
> +                       finish_up_to_date(_("Already up to date. Yeeah!")=
);
>                         goto done;
>                 }
>         }
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 1494ffdb8..182626c02 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1927,7 +1927,7 @@ int merge_trees(struct merge_options *o,
>         }
>
>         if (oid_eq(&common->object.oid, &merge->object.oid)) {
> -               output(o, 0, _("Already up-to-date!"));
> +               output(o, 0, _("Already up to date!"));
>                 *result =3D head;
>                 return 1;
>         }
> diff --git a/notes-merge.c b/notes-merge.c
> index c12b354f1..65bd32629 100644
> --- a/notes-merge.c
> +++ b/notes-merge.c
> @@ -624,7 +624,7 @@ int notes_merge(struct notes_merge_options *o,
>         if (!oidcmp(&remote->object.oid, base_oid)) {
>                 /* Already merged; result =3D=3D local commit */
>                 if (o->verbosity >=3D 2)
> -                       printf("Already up-to-date!\n");
> +                       printf("Already up to date!\n");
>                 oidcpy(result_oid, &local->object.oid);
>                 goto found_result;
>         }
> diff --git a/remote.c b/remote.c
> index 43c317e4e..411309006 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -2084,7 +2084,7 @@ int format_tracking_info(struct branch *branch, str=
uct strbuf *sb)
>                                 _("  (use \"git branch --unset-upstream\"=
 to fixup)\n"));
>         } else if (!ours && !theirs) {
>                 strbuf_addf(sb,
> -                       _("Your branch is up-to-date with '%s'.\n"),
> +                       _("Your branch is up to date with '%s'.\n"),
>                         base);
>         } else if (!theirs) {
>                 strbuf_addf(sb,
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 38000ac8f..bf226be26 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -162,7 +162,7 @@ void setup_unpack_trees_porcelain(struct unpack_trees=
_options *opts,
>         msgs[ERROR_BIND_OVERLAP] =3D _("Entry '%s' overlaps with '%s'.  C=
annot bind.");
>
>         msgs[ERROR_SPARSE_NOT_UPTODATE_FILE] =3D
> -               _("Cannot update sparse checkout: the following entries a=
re not up-to-date:\n%s");
> +               _("Cannot update sparse checkout: the following entries a=
re not up to date:\n%s");
>         msgs[ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN] =3D
>                 _("The following working tree files would be overwritten =
by sparse checkout update:\n%s");
>         msgs[ERROR_WOULD_LOSE_ORPHANED_REMOVED] =3D
> diff --git a/git-gui/po/README b/git-gui/po/README
> index 0f5837d48..2514bc22a 100644
> --- a/git-gui/po/README
> +++ b/git-gui/po/README
> @@ -165,7 +165,7 @@ to contribute an update.  This may be because you wou=
ld want to improve
>  the translation of existing messages, or because the git-gui software
>  itself was updated and there are new messages that need translation.
>
> -In any case, make sure you are up-to-date before starting your work:
> +In any case, make sure you are up to date before starting your work:
>
>         $ git checkout master
>         $ git pull
> diff --git a/git-p4.py b/git-p4.py
> index 2fa581789..76859b453 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -3614,7 +3614,7 @@ class P4Rebase(Command):
>
>      def rebase(self):
>          if os.system("git update-index --refresh") !=3D 0:
> -            die("Some files in your working directory are modified and d=
ifferent than what is in your index. You can use git update-index <filename=
> to bring the index up-to-date or stash away all your changes with git sta=
sh.");
> +            die("Some files in your working directory are modified and d=
ifferent than what is in your index. You can use git update-index <filename=
> to bring the index up to date or stash away all your changes with git sta=
sh.");
>          if len(read_pipe("git diff-index HEAD --")) > 0:
>              die("You have uncommitted changes. Please commit them before=
 rebasing or stash them away with git stash.");
>
> diff --git a/templates/hooks--pre-rebase.sample b/templates/hooks--pre-re=
base.sample
> index b7f81c198..db5feab8a 100755
> --- a/templates/hooks--pre-rebase.sample
> +++ b/templates/hooks--pre-rebase.sample
> @@ -58,7 +58,7 @@ then
>         not_in_topic=3D`git rev-list "^$topic" master`
>         if test -z "$not_in_topic"
>         then
> -               echo >&2 "$topic is already up-to-date with master"
> +               echo >&2 "$topic is already up to date with master"
>                 exit 1 ;# we could allow it, but there is no point.
>         else
>                 exit 0
> --
> 2.14.1.151.g45c1275a3.dirty
>
