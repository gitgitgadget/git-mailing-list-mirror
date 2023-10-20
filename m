Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1271C38
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 04:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOBwZL65"
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6588513E
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 21:28:12 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5ab94fc098cso277614a12.1
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 21:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697776092; x=1698380892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5u89v8UWPAW9qABUlOcBs8QKMXnyCVeJz7aLo2QA23U=;
        b=QOBwZL65klny8+gQSpDUHBDet8NvIh+kpH+GyzRghj5zFKVqybZePAT3de0Ri4ue2i
         /GCvTpJRB1V6zuIKUsaSgOh3yJjs3sJlcfj8cF/kmaJp+YIaqJJfC78E3eYX385gAR9r
         9tyRlnmZv9hS9M02/J5J5dStaLSQ8OlndvmhfI7+zIyGTraU/FMpk65Q8N2bEKbrEwVF
         bDfV9/OI/FDJc3POQV2rOJ972cnPatrUqO9n5iK0ZUEi75kclG+WzuG4+WVhDjLJNfec
         G1Pd8QnAztmK1FDgpov/6/WDklq83sq6VP28YZxGRmXxDXg/rox/W3GTuveeXpRaVS5Q
         9Rqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697776092; x=1698380892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5u89v8UWPAW9qABUlOcBs8QKMXnyCVeJz7aLo2QA23U=;
        b=eISkjDrkCsNKFXqixbazSroi6rW5tyh/jYILGsuKZfOc6YQyZTIGB13rpBMU5HIDpm
         fCqYEFN6feJchm9nUqn3TyurYJ4EWjF8ISRAksW1XupwzJmGbJQ5TC0E2M7lLK6/s6cP
         tR8vX5MFEXtHHgyZkUjKDQOhPiKqs/RjohEji9KHzhyOrmE3J+DCyDWAbvYVh2xtpcWK
         3lb7Kc0uuaHqr6u53AYRCm0JUVZqH/MMn4CKkJCLjoPv/PB9iYgAcpr6b6l5SyUYsGdE
         RuafOCy5axNIm5ZOMUWSDBcurqUGFxNpVtrB9MZ/3r8Fplseu9px3JcJ56hsLXbpsyYR
         pJpA==
X-Gm-Message-State: AOJu0YzpAvJV4CAeURPOAn42f5R1X0e8UV5UjzRy+aaoGGVyzbB8oS7k
	yfr9aIMM7i7SQ7TcrGWfRpLFTvqfIMXlDP+GNCRxIhcRsPB3fA==
X-Google-Smtp-Source: AGHT+IF/syS3O1jbgKJ6O2qhYgjaLIZpQkELzWTl7eaBMSNJZjyYj0DB0Ct/xm7kyDP3gE1+7Q3sCCcBI93p46OP3QY=
X-Received: by 2002:a17:90a:f0c6:b0:27d:20ca:1156 with SMTP id
 fa6-20020a17090af0c600b0027d20ca1156mr734843pjb.34.1697776091325; Thu, 19 Oct
 2023 21:28:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e08b2ec4-786a-4c18-b7af-0a6a250ae0f0@gmail.com> <20231019084052.567922-1-isokenjune@gmail.com>
In-Reply-To: <20231019084052.567922-1-isokenjune@gmail.com>
From: Isoken Ibizugbe <isokenjune@gmail.com>
Date: Fri, 20 Oct 2023 05:26:41 +0100
Message-ID: <CAJHH8bFXVnFgjoCD+JU2uw77JAWUiKU+G=ub9Xg7xYJ_MwXPQQ@mail.gmail.com>
Subject: Re: [PATCH v2] builtin/branch.c: adjust error messages to coding guidelines
To: git@vger.kernel.org
Cc: gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 9:41=E2=80=AFAM Isoken June Ibizugbe
<isokenjune@gmail.com> wrote:
>
> As per the CodingGuidelines document, it is recommended that a single-lin=
e
> message provided to error messages such as die(), error() and warning(),
> should start with a lowercase letter and should not end with a period.
> Also this patch fixes the tests broken by the changes.
>
> Signed-off-by: Isoken June Ibizugbe <isokenjune@gmail.com>
> ---
>  builtin/branch.c          | 66 +++++++++++++++++++--------------------
>  t/t2407-worktree-heads.sh |  2 +-
>  t/t3200-branch.sh         | 16 +++++-----
>  t/t3202-show-branch.sh    | 10 +++---
>  4 files changed, 47 insertions(+), 47 deletions(-)
Hello Junio, I would appreciate your comment on this.
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 2ec190b14a..e7ee9bd0f1 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -173,11 +173,11 @@ static int branch_merged(int kind, const char *name=
,
>             (head_rev ? repo_in_merge_bases(the_repository, rev, head_rev=
) : 0) !=3D merged) {
>                 if (merged)
>                         warning(_("deleting branch '%s' that has been mer=
ged to\n"
> -                               "         '%s', but not yet merged to HEA=
D."),
> +                               "         '%s', but not yet merged to HEA=
D"),
>                                 name, reference_name);
>                 else
>                         warning(_("not deleting branch '%s' that is not y=
et merged to\n"
> -                               "         '%s', even though it is merged =
to HEAD."),
> +                               "         '%s', even though it is merged =
to HEAD"),
>                                 name, reference_name);
>         }
>         free(reference_name_to_free);
> @@ -190,13 +190,13 @@ static int check_branch_commit(const char *branchna=
me, const char *refname,
>  {
>         struct commit *rev =3D lookup_commit_reference(the_repository, oi=
d);
>         if (!force && !rev) {
> -               error(_("Couldn't look up commit object for '%s'"), refna=
me);
> +               error(_("couldn't look up commit object for '%s'"), refna=
me);
>                 return -1;
>         }
>         if (!force && !branch_merged(kinds, branchname, rev, head_rev)) {
> -               error(_("The branch '%s' is not fully merged.\n"
> +               error(_("the branch '%s' is not fully merged.\n"
>                       "If you are sure you want to delete it, "
> -                     "run 'git branch -D %s'."), branchname, branchname)=
;
> +                     "run 'git branch -D %s'"), branchname, branchname);
>                 return -1;
>         }
>         return 0;
> @@ -207,7 +207,7 @@ static void delete_branch_config(const char *branchna=
me)
>         struct strbuf buf =3D STRBUF_INIT;
>         strbuf_addf(&buf, "branch.%s", branchname);
>         if (git_config_rename_section(buf.buf, NULL) < 0)
> -               warning(_("Update of config-file failed"));
> +               warning(_("update of config-file failed"));
>         strbuf_release(&buf);
>  }
>
> @@ -260,7 +260,7 @@ static int delete_branches(int argc, const char **arg=
v, int force, int kinds,
>                 if (kinds =3D=3D FILTER_REFS_BRANCHES) {
>                         const char *path;
>                         if ((path =3D branch_checked_out(name))) {
> -                               error(_("Cannot delete branch '%s' "
> +                               error(_("cannot delete branch '%s' "
>                                         "used by worktree at '%s'"),
>                                       bname.buf, path);
>                                 ret =3D 1;
> @@ -275,7 +275,7 @@ static int delete_branches(int argc, const char **arg=
v, int force, int kinds,
>                                         &oid, &flags);
>                 if (!target) {
>                         if (remote_branch) {
> -                               error(_("remote-tracking branch '%s' not =
found."), bname.buf);
> +                               error(_("remote-tracking branch '%s' not =
found"), bname.buf);
>                         } else {
>                                 char *virtual_name =3D mkpathdup(fmt_remo=
tes, bname.buf);
>                                 char *virtual_target =3D resolve_refdup(v=
irtual_name,
> @@ -290,7 +290,7 @@ static int delete_branches(int argc, const char **arg=
v, int force, int kinds,
>                                                 "Did you forget --remote?=
"),
>                                                 bname.buf);
>                                 else
> -                                       error(_("branch '%s' not found.")=
, bname.buf);
> +                                       error(_("branch '%s' not found"),=
 bname.buf);
>                                 FREE_AND_NULL(virtual_target);
>                         }
>                         ret =3D 1;
> @@ -518,11 +518,11 @@ static void reject_rebase_or_bisect_branch(struct w=
orktree **worktrees,
>                         continue;
>
>                 if (is_worktree_being_rebased(wt, target))
> -                       die(_("Branch %s is being rebased at %s"),
> +                       die(_("branch %s is being rebased at %s"),
>                             target, wt->path);
>
>                 if (is_worktree_being_bisected(wt, target))
> -                       die(_("Branch %s is being bisected at %s"),
> +                       die(_("branch %s is being bisected at %s"),
>                             target, wt->path);
>         }
>  }
> @@ -578,7 +578,7 @@ static void copy_or_rename_branch(const char *oldname=
, const char *newname, int
>                 if (ref_exists(oldref.buf))
>                         recovery =3D 1;
>                 else
> -                       die(_("Invalid branch name: '%s'"), oldname);
> +                       die(_("invalid branch name: '%s'"), oldname);
>         }
>
>         for (int i =3D 0; worktrees[i]; i++) {
> @@ -594,9 +594,9 @@ static void copy_or_rename_branch(const char *oldname=
, const char *newname, int
>
>         if ((copy || !(oldref_usage & IS_HEAD)) && !ref_exists(oldref.buf=
)) {
>                 if (oldref_usage & IS_HEAD)
> -                       die(_("No commit on branch '%s' yet."), oldname);
> +                       die(_("no commit on branch '%s' yet"), oldname);
>                 else
> -                       die(_("No branch named '%s'."), oldname);
> +                       die(_("no branch named '%s'"), oldname);
>         }
>
>         /*
> @@ -624,32 +624,32 @@ static void copy_or_rename_branch(const char *oldna=
me, const char *newname, int
>
>         if (!copy && !(oldref_usage & IS_ORPHAN) &&
>             rename_ref(oldref.buf, newref.buf, logmsg.buf))
> -               die(_("Branch rename failed"));
> +               die(_("branch rename failed"));
>         if (copy && copy_existing_ref(oldref.buf, newref.buf, logmsg.buf)=
)
> -               die(_("Branch copy failed"));
> +               die(_("branch copy failed"));
>
>         if (recovery) {
>                 if (copy)
> -                       warning(_("Created a copy of a misnamed branch '%=
s'"),
> +                       warning(_("created a copy of a misnamed branch '%=
s'"),
>                                 interpreted_oldname);
>                 else
> -                       warning(_("Renamed a misnamed branch '%s' away"),
> +                       warning(_("renamed a misnamed branch '%s' away"),
>                                 interpreted_oldname);
>         }
>
>         if (!copy && (oldref_usage & IS_HEAD) &&
>             replace_each_worktree_head_symref(worktrees, oldref.buf, newr=
ef.buf,
>                                               logmsg.buf))
> -               die(_("Branch renamed to %s, but HEAD is not updated!"), =
newname);
> +               die(_("branch renamed to %s, but HEAD is not updated"), n=
ewname);
>
>         strbuf_release(&logmsg);
>
>         strbuf_addf(&oldsection, "branch.%s", interpreted_oldname);
>         strbuf_addf(&newsection, "branch.%s", interpreted_newname);
>         if (!copy && git_config_rename_section(oldsection.buf, newsection=
.buf) < 0)
> -               die(_("Branch is renamed, but update of config-file faile=
d"));
> +               die(_("branch is renamed, but update of config-file faile=
d"));
>         if (copy && strcmp(interpreted_oldname, interpreted_newname) && g=
it_config_copy_section(oldsection.buf, newsection.buf) < 0)
> -               die(_("Branch is copied, but update of config-file failed=
"));
> +               die(_("branch is copied, but update of config-file failed=
"));
>         strbuf_release(&oldref);
>         strbuf_release(&newref);
>         strbuf_release(&oldsection);
> @@ -773,7 +773,7 @@ int cmd_branch(int argc, const char **argv, const cha=
r *prefix)
>
>         head =3D resolve_refdup("HEAD", 0, &head_oid, NULL);
>         if (!head)
> -               die(_("Failed to resolve HEAD as a valid ref."));
> +               die(_("failed to resolve HEAD as a valid ref"));
>         if (!strcmp(head, "HEAD"))
>                 filter.detached =3D 1;
>         else if (!skip_prefix(head, "refs/heads/", &head))
> @@ -866,7 +866,7 @@ int cmd_branch(int argc, const char **argv, const cha=
r *prefix)
>
>                 if (!argc) {
>                         if (filter.detached)
> -                               die(_("Cannot give description to detache=
d HEAD"));
> +                               die(_("cannot give description to detache=
d HEAD"));
>                         branch_name =3D head;
>                 } else if (argc =3D=3D 1) {
>                         strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH=
_LOCAL);
> @@ -878,8 +878,8 @@ int cmd_branch(int argc, const char **argv, const cha=
r *prefix)
>                 strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
>                 if (!ref_exists(branch_ref.buf))
>                         error((!argc || branch_checked_out(branch_ref.buf=
))
> -                             ? _("No commit on branch '%s' yet.")
> -                             : _("No branch named '%s'."),
> +                             ? _("no commit on branch '%s' yet")
> +                             : _("no branch named '%s'"),
>                               branch_name);
>                 else if (!edit_branch_description(branch_name))
>                         ret =3D 0; /* happy */
> @@ -892,8 +892,8 @@ int cmd_branch(int argc, const char **argv, const cha=
r *prefix)
>                 if (!argc)
>                         die(_("branch name required"));
>                 else if ((argc =3D=3D 1) && filter.detached)
> -                       die(copy? _("cannot copy the current branch while=
 not on any.")
> -                               : _("cannot rename the current branch whi=
le not on any."));
> +                       die(copy? _("cannot copy the current branch while=
 not on any")
> +                               : _("cannot rename the current branch whi=
le not on any"));
>                 else if (argc =3D=3D 1)
>                         copy_or_rename_branch(head, argv[0], copy, copy +=
 rename > 1);
>                 else if (argc =3D=3D 2)
> @@ -916,14 +916,14 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
>                 if (!branch) {
>                         if (!argc || !strcmp(argv[0], "HEAD"))
>                                 die(_("could not set upstream of HEAD to =
%s when "
> -                                     "it does not point to any branch.")=
,
> +                                     "it does not point to any branch"),
>                                     new_upstream);
>                         die(_("no such branch '%s'"), argv[0]);
>                 }
>
>                 if (!ref_exists(branch->refname)) {
>                         if (!argc || branch_checked_out(branch->refname))
> -                               die(_("No commit on branch '%s' yet."), b=
ranch->name);
> +                               die(_("no commit on branch '%s' yet"), br=
anch->name);
>                         die(_("branch '%s' does not exist"), branch->name=
);
>                 }
>
> @@ -946,12 +946,12 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
>                 if (!branch) {
>                         if (!argc || !strcmp(argv[0], "HEAD"))
>                                 die(_("could not unset upstream of HEAD w=
hen "
> -                                     "it does not point to any branch.")=
);
> +                                     "it does not point to any branch"))=
;
>                         die(_("no such branch '%s'"), argv[0]);
>                 }
>
>                 if (!branch_has_merge_config(branch))
> -                       die(_("Branch '%s' has no upstream information"),=
 branch->name);
> +                       die(_("branch '%s' has no upstream information"),=
 branch->name);
>
>                 strbuf_reset(&buf);
>                 strbuf_addf(&buf, "branch.%s.remote", branch->name);
> @@ -965,11 +965,11 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
>                 const char *start_name =3D argc =3D=3D 2 ? argv[1] : head=
;
>
>                 if (filter.kind !=3D FILTER_REFS_BRANCHES)
> -                       die(_("The -a, and -r, options to 'git branch' do=
 not take a branch name.\n"
> +                       die(_("the -a, and -r, options to 'git branch' do=
 not take a branch name.\n"
>                                   "Did you mean to use: -a|-r --list <pat=
tern>?"));
>
>                 if (track =3D=3D BRANCH_TRACK_OVERRIDE)
> -                       die(_("the '--set-upstream' option is no longer s=
upported. Please use '--track' or '--set-upstream-to' instead."));
> +                       die(_("the '--set-upstream' option is no longer s=
upported. Please use '--track' or '--set-upstream-to' instead"));
>
>                 if (recurse_submodules) {
>                         create_branches_recursively(the_repository, branc=
h_name,
> diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
> index 469443d8ae..f6835c91dc 100755
> --- a/t/t2407-worktree-heads.sh
> +++ b/t/t2407-worktree-heads.sh
> @@ -45,7 +45,7 @@ test_expect_success 'refuse to overwrite: checked out i=
n worktree' '
>                 grep "cannot force update the branch" err &&
>
>                 test_must_fail git branch -D wt-$i 2>err &&
> -               grep "Cannot delete branch" err || return 1
> +               grep "cannot delete branch" err || return 1
>         done
>  '
>
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 080e4f24a6..3182abde27 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -291,10 +291,10 @@ test_expect_success 'git branch -M topic topic shou=
ld work when main is checked
>  test_expect_success 'git branch -M and -C fail on detached HEAD' '
>         git checkout HEAD^{} &&
>         test_when_finished git checkout - &&
> -       echo "fatal: cannot rename the current branch while not on any." =
>expect &&
> +       echo "fatal: cannot rename the current branch while not on any" >=
expect &&
>         test_must_fail git branch -M must-fail 2>err &&
>         test_cmp expect err &&
> -       echo "fatal: cannot copy the current branch while not on any." >e=
xpect &&
> +       echo "fatal: cannot copy the current branch while not on any" >ex=
pect &&
>         test_must_fail git branch -C must-fail 2>err &&
>         test_cmp expect err
>  '
> @@ -943,7 +943,7 @@ test_expect_success 'deleting currently checked out b=
ranch fails' '
>         git worktree add -b my7 my7 &&
>         test_must_fail git -C my7 branch -d my7 &&
>         test_must_fail git branch -d my7 2>actual &&
> -       grep "^error: Cannot delete branch .my7. used by worktree at " ac=
tual &&
> +       grep "^error: cannot delete branch .my7. used by worktree at " ac=
tual &&
>         rm -r my7 &&
>         git worktree prune
>  '
> @@ -954,7 +954,7 @@ test_expect_success 'deleting in-use branch fails' '
>         git -C my7 bisect start HEAD HEAD~2 &&
>         test_must_fail git -C my7 branch -d my7 &&
>         test_must_fail git branch -d my7 2>actual &&
> -       grep "^error: Cannot delete branch .my7. used by worktree at " ac=
tual &&
> +       grep "^error: cannot delete branch .my7. used by worktree at " ac=
tual &&
>         rm -r my7 &&
>         git worktree prune
>  '
> @@ -1024,7 +1024,7 @@ test_expect_success '--set-upstream-to fails on mul=
tiple branches' '
>  test_expect_success '--set-upstream-to fails on detached HEAD' '
>         git checkout HEAD^{} &&
>         test_when_finished git checkout - &&
> -       echo "fatal: could not set upstream of HEAD to main when it does =
not point to any branch." >expect &&
> +       echo "fatal: could not set upstream of HEAD to main when it does =
not point to any branch" >expect &&
>         test_must_fail git branch --set-upstream-to main 2>err &&
>         test_cmp expect err
>  '
> @@ -1072,7 +1072,7 @@ test_expect_success 'use --set-upstream-to modify a=
 particular branch' '
>  '
>
>  test_expect_success '--unset-upstream should fail if given a non-existen=
t branch' '
> -       echo "fatal: Branch '"'"'i-dont-exist'"'"' has no upstream inform=
ation" >expect &&
> +       echo "fatal: branch '"'"'i-dont-exist'"'"' has no upstream inform=
ation" >expect &&
>         test_must_fail git branch --unset-upstream i-dont-exist 2>err &&
>         test_cmp expect err
>  '
> @@ -1094,7 +1094,7 @@ test_expect_success 'test --unset-upstream on HEAD'=
 '
>         test_must_fail git config branch.main.remote &&
>         test_must_fail git config branch.main.merge &&
>         # fail for a branch without upstream set
> -       echo "fatal: Branch '"'"'main'"'"' has no upstream information" >=
expect &&
> +       echo "fatal: branch '"'"'main'"'"' has no upstream information" >=
expect &&
>         test_must_fail git branch --unset-upstream 2>err &&
>         test_cmp expect err
>  '
> @@ -1108,7 +1108,7 @@ test_expect_success '--unset-upstream should fail o=
n multiple branches' '
>  test_expect_success '--unset-upstream should fail on detached HEAD' '
>         git checkout HEAD^{} &&
>         test_when_finished git checkout - &&
> -       echo "fatal: could not unset upstream of HEAD when it does not po=
int to any branch." >expect &&
> +       echo "fatal: could not unset upstream of HEAD when it does not po=
int to any branch" >expect &&
>         test_must_fail git branch --unset-upstream 2>err &&
>         test_cmp expect err
>  '
> diff --git a/t/t3202-show-branch.sh b/t/t3202-show-branch.sh
> index b17f388f56..2cdb834b37 100755
> --- a/t/t3202-show-branch.sh
> +++ b/t/t3202-show-branch.sh
> @@ -10,7 +10,7 @@ GIT_TEST_DATE_NOW=3D1251660000; export GIT_TEST_DATE_NO=
W
>  test_expect_success 'error descriptions on empty repository' '
>         current=3D$(git branch --show-current) &&
>         cat >expect <<-EOF &&
> -       error: No commit on branch '\''$current'\'' yet.
> +       error: no commit on branch '\''$current'\'' yet
>         EOF
>         test_must_fail git branch --edit-description 2>actual &&
>         test_cmp expect actual &&
> @@ -21,7 +21,7 @@ test_expect_success 'error descriptions on empty reposi=
tory' '
>  test_expect_success 'fatal descriptions on empty repository' '
>         current=3D$(git branch --show-current) &&
>         cat >expect <<-EOF &&
> -       fatal: No commit on branch '\''$current'\'' yet.
> +       fatal: no commit on branch '\''$current'\'' yet
>         EOF
>         test_must_fail git branch --set-upstream-to=3Dnon-existent 2>actu=
al &&
>         test_cmp expect actual &&
> @@ -224,7 +224,7 @@ done
>
>  test_expect_success 'error descriptions on non-existent branch' '
>         cat >expect <<-EOF &&
> -       error: No branch named '\''non-existent'\'.'
> +       error: no branch named '\''non-existent'\''
>         EOF
>         test_must_fail git branch --edit-description non-existent 2>actua=
l &&
>         test_cmp expect actual
> @@ -238,7 +238,7 @@ test_expect_success 'fatal descriptions on non-existe=
nt branch' '
>         test_cmp expect actual &&
>
>         cat >expect <<-EOF &&
> -       fatal: No branch named '\''non-existent'\''.
> +       fatal: no branch named '\''non-existent'\''
>         EOF
>         test_must_fail git branch -c non-existent new-branch 2>actual &&
>         test_cmp expect actual &&
> @@ -253,7 +253,7 @@ test_expect_success 'error descriptions on orphan bra=
nch' '
>         test_branch_op_in_wt() {
>                 test_orphan_error() {
>                         test_must_fail git $* 2>actual &&
> -                       test_i18ngrep "No commit on branch .orphan-branch=
. yet.$" actual
> +                       test_i18ngrep "no commit on branch .orphan-branch=
. yet$" actual
>                 } &&
>                 test_orphan_error -C wt branch $1 $2 &&                # =
implicit branch
>                 test_orphan_error -C wt branch $1 orphan-branch $2 &&  # =
explicit branch
> --
> 2.42.0.346.g24618a8a3e.dirty
>
