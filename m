Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC071BDC3
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLwRxAyn"
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46CBBB
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 08:41:29 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-27d18475ed4so1828498a91.0
        for <git@vger.kernel.org>; Fri, 13 Oct 2023 08:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697211689; x=1697816489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewnGFLaciX0lUKdXBLxvbXeXpn8azIB8iZVUZ1DckPQ=;
        b=YLwRxAynzXazvtiwe2Mqozc7ZuB3M/BNYt4kWopFqryOkS30cESG0pOSGuZAdAdh8l
         zluXnmsOljCNT+Hxoj2a/JZGc3uqiu4feKN9Phl/418R9y1rahCAV67/gUWjIzKWKWSe
         ppr19iEGsJvRzie2INDCpyow0XrQ7+I0eXebwl0I5sSQKK3XLMU/WwkPbEI8qnoe3Z9d
         qw8xez8cK9/3BW5NNM5mjc0CgDwB5ZI7tHpoLnSPBLFRYG4LyWVIdCR051MNjM2QqLe1
         ozoeSKCtD0lExawT5J1BpZZOKQkQWwTO/5V5slsbUbUhPtUo8iT3ZXNKq734Jd9+lu0a
         n+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697211689; x=1697816489;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ewnGFLaciX0lUKdXBLxvbXeXpn8azIB8iZVUZ1DckPQ=;
        b=GZivW48INyZOJ27EDz67dg0/G3V7p+Vt/N3HhXX5U4G16DgzSl1R2bUDqGPwpuIZ3A
         BpbUwNiZ2Wxl/hLp9XzU9+E8I7ssVq6xjlszLXCN2inN/5GGCc8MdZSRmBFEP7CnxyHt
         ApB8FVddRbl1iv/ca0wkibwRSwv5Kvx+VvDJQcsIKxZrBOoCCvLHyJEd8Qx28TIZ/Rf3
         iTRimQc3VRiiKa5kIcY8qbFw6T3FilWp3uVNZLqhcza6tGFRbMjO9rU7MTXy7nkD1fn8
         M+oWHjasWuffFJth4qag/a+NUHQ2tLGyfmm/z1oXzqxXDaCBGR8JUUmslfzBFWe+PA5s
         HFCw==
X-Gm-Message-State: AOJu0YzVL4JTKxbrTc1zu+VQZZBaOYzcq+ZLgm5VFwSXRpZR+D0PNFE7
	RmKK4XH8TbjQed1DE+iWe2RlGMgZVuXUIPe/nEVGWCl4z5VyJw==
X-Google-Smtp-Source: AGHT+IE/eEgi1g7n0Azf6c9WivTLjyg1OtjCkLPRIGjhx+EQutJ0H+bp2KQ3QWsraIN1X1UbaOG3HCBn7RKlgN/gnrU=
X-Received: by 2002:a17:90a:bc0b:b0:27d:c35:7f3 with SMTP id
 w11-20020a17090abc0b00b0027d0c3507f3mr7235844pjr.8.1697211688944; Fri, 13 Oct
 2023 08:41:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1590.git.git.1697211227.gitgitgadget@gmail.com> <91e4ad3984147fcc277254a3f6836bf79f5c9550.1697211227.git.gitgitgadget@gmail.com>
In-Reply-To: <91e4ad3984147fcc277254a3f6836bf79f5c9550.1697211227.git.gitgitgadget@gmail.com>
From: Isoken Ibizugbe <isokenjune@gmail.com>
Date: Fri, 13 Oct 2023 16:40:01 +0100
Message-ID: <CAJHH8bE15VotFy7QQ-Npmfk9ePvf=-h5SP+Q8phrDBRj8Ti=hQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] branch.c: adjust error messages to coding guidelines
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MISSING_HEADERS,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 4:33=E2=80=AFPM Isoken June Ibizugbe via GitGitGadg=
et
<gitgitgadget@gmail.com> wrote:
>
> From: Isoken June Ibizugbe <isokenjune@gmail.com>
>
> Signed-off-by: Isoken June Ibizugbe <isokenjune@gmail.com>
> ---
>  builtin/branch.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index a756543d644..e7ee9bd0f15 100644
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
> @@ -630,17 +630,17 @@ static void copy_or_rename_branch(const char *oldna=
me, const char *newname, int
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
> -               die(_("branch renamed to %s, but HEAD is not updated!"), =
newname);
> +               die(_("branch renamed to %s, but HEAD is not updated"), n=
ewname);
>
>         strbuf_release(&logmsg);
>
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
> @@ -893,7 +893,7 @@ int cmd_branch(int argc, const char **argv, const cha=
r *prefix)
>                         die(_("branch name required"));
>                 else if ((argc =3D=3D 1) && filter.detached)
>                         die(copy? _("cannot copy the current branch while=
 not on any")
> -                               : _("cannot rename the current branch whi=
le not on any."));
> +                               : _("cannot rename the current branch whi=
le not on any"));
>                 else if (argc =3D=3D 1)
>                         copy_or_rename_branch(head, argv[0], copy, copy +=
 rename > 1);
>                 else if (argc =3D=3D 2)
> @@ -965,7 +965,7 @@ int cmd_branch(int argc, const char **argv, const cha=
r *prefix)
>                 const char *start_name =3D argc =3D=3D 2 ? argv[1] : head=
;
>
>                 if (filter.kind !=3D FILTER_REFS_BRANCHES)
> -                       die(_("the -a, and -r, options to 'git branch' do=
 not take a branch name\n"
> +                       die(_("the -a, and -r, options to 'git branch' do=
 not take a branch name.\n"
>                                   "Did you mean to use: -a|-r --list <pat=
tern>?"));
>
>                 if (track =3D=3D BRANCH_TRACK_OVERRIDE)
> --
> gitgitgadget
I am sorry if I made any mistakes, It's my first time using
gitgitgadget. This commit was already sent before through git-send
email. The patch was intended to submit the revisions.
