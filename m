Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D2310A3E
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 07:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5f0BHqs"
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2F5109
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 00:50:08 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-27d087c4276so5185937a91.0
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 00:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697701807; x=1698306607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xV4pYd4YceMy9j85frJgpHVBUPXmwjaIPjzjrfZFdJY=;
        b=C5f0BHqsnA5Di6BfDQDHZtLarIpy5NIAhyi9qEW6JRiKPXSNAnuH6FaMjyrBphzHUr
         hr5YF0GwCRpE36oCDMQenR5l+KHlh1X3PpFFVxehfuT+5syq2NcEXNPOb7iTNsABKGDH
         1kwIOvXkRvvI7KD42Xcxdoxq/bbryeOXf1csI2Y3IWP5KNK3ScQmctcd8YfiSiK3W6VJ
         kmfiBA094oEUqz4lObe+hIxajgVPfOfH0D8IbNHanGuOhZZBa7J7ToaKY+e5kgcd0NWP
         D+etDMI5n8k0Hd0bNleatyDQ1oe3ySZJlYvpUZjHXjFFHVGBQf3Cq1dahi4Or/fQaF1T
         QPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697701807; x=1698306607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xV4pYd4YceMy9j85frJgpHVBUPXmwjaIPjzjrfZFdJY=;
        b=oaDjpuo+k+vtKD2Uo8NeBVIlJDrF8MSBrPZDAkbSZczVSHumtwozfQ5Bp0Zem5/M6s
         AYrYJ33blCbST+T7x2dOMZgnL7MOir6c7dQ+MgsJzKLM/GeHy260DqRMtduAEU3TA1bq
         oB+hV/vfcwKLjY4MOUTpLm2isHxc8Yg/6uol2ckptoP+hwlSJZuIHeFvp6cJU0YtBYMc
         s/5IQQSwm7PppU5nbuRwINUGGXzs+gVmm5kzDX/keICjCl5yKvIbnvkV+yQnYEzHh95/
         hOLNYh/ehgte7R3wwBuhLPBKSCuBOscfe4JRyueIh9zdMMwXv95ZNTQEiLKp9CzGYpmC
         3X9g==
X-Gm-Message-State: AOJu0YxNOq/a+R+bDbbSrdxOnZi/zZJ0MWUceSi+PcXf56VE021VJ0bZ
	NI+MYauYjlvAfaZlF5L5Z8Ox6RpZQaSEm6PfEJmoOJxQxQfrk7L0
X-Google-Smtp-Source: AGHT+IFbdVLOk4HAN/+ZkbA2iXIOkl7IpOYK2j2y8JO0OgejFJQ09c3gxsUyvEwuXuTkS1fIPufOOc0VFKjDsSzylnw=
X-Received: by 2002:a17:90b:288c:b0:27d:5562:7e13 with SMTP id
 qc12-20020a17090b288c00b0027d55627e13mr1284068pjb.39.1697701807365; Thu, 19
 Oct 2023 00:50:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231019074126.567638-1-isokenjune@gmail.com>
In-Reply-To: <20231019074126.567638-1-isokenjune@gmail.com>
From: Isoken Ibizugbe <isokenjune@gmail.com>
Date: Thu, 19 Oct 2023 08:48:37 +0100
Message-ID: <CAJHH8bEyHQ0esWDwmGowAeM75V7ZrgLBtgHAq8zcgM_UYAKt=w@mail.gmail.com>
Subject: Re: [Outreachy][PATCH v2] builtin/branch.c: adjust error messages to
 coding guidelines
To: git@vger.kernel.org
Cc: rjusto@gmail.com, christian.couder@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 8:41=E2=80=AFAM Isoken June Ibizugbe
<isokenjune@gmail.com> wrote:
>
> Signed-off-by: Isoken June Ibizugbe <isokenjune@gmail.com>
> ---
>  builtin/branch.c | 66 ++++++++++++++++++++++++------------------------
>  1 file changed, 33 insertions(+), 33 deletions(-)
please ignore this patch. It didn't include the changes for the test files.
thanks
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 2ec190b14a..938c40bfaa 100644
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
 not take a branch name\n"
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
> --
> 2.42.0.346.g24618a8a3e.dirty
>
