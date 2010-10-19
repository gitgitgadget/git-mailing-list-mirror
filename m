From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Tue, 19 Oct 2010 23:21:12 +0530
Message-ID: <20101019175103.GA28847@kytes>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
 <AANLkTimkovH9OysLSxA+=di89Xi+dTCYL5hRPmNaADDH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thore Husfeldt <thore.husfeldt@gmail.com>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 19:52:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8GMA-0004kI-8V
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 19:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316Ab0JSRwE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Oct 2010 13:52:04 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:49222 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063Ab0JSRwC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 13:52:02 -0400
Received: by gxk21 with SMTP id 21so996212gxk.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 10:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=76m1yAo1F2LZzkCKffKtUw1oY0IYoZ6ah4MCjimTjV8=;
        b=Bv7Zqb3l1wCYr9gwRinVmMoUNV86L5eT4DxC088syBqSx+Hbn2LFtSnOnSajWvfRfG
         bHAQwhjQZNDUk/EQASsVXS0BXx5HW7WS/9donY723ZYOIBy2lu/r/6GOubnjaPNo8DLb
         SelUlvyBHE+5zNjfpq3R+F/DPMvK97tsNFf34=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=DwhQ+nlG+QC2GqJwjZYGNMMb7CtqXS2Gs/nQrm00nzm4WV3NJLfSGGtH1zFt+Bi/v1
         y5RD1w3Vg5boj7ZdTTXJ4XZXe9wXRenuvyqJE6q719xEiHyLdvFKXEjRHVelzL5Lxp7H
         /rnhLcrcyBXSp6kGPWVF3MLIbB5V+G7FG3730=
Received: by 10.42.220.66 with SMTP id hx2mr678241icb.63.1287510721233;
        Tue, 19 Oct 2010 10:52:01 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id e44sm11185852yha.47.2010.10.19.10.51.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 10:51:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimkovH9OysLSxA+=di89Xi+dTCYL5hRPmNaADDH@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159344>

Sverre Rabbelier writes:
> On Mon, Oct 18, 2010 at 15:45, Thore Husfeldt <thore.husfeldt@gmail.c=
om> wrote:
> > The hyphenated *remote-tracking* is a lot better terminology alread=
y
> > (and sometimes even used in the documentation), because at least it
> > doesn't pretend to be a remote branch (`git branch -r`, of course,
> > still does).
>=20
> What do you mean with the last part (about `git branch -r`)? The fact
> that 'refs/remotes' is not immutable?
>=20
> > So that single hyphen already does some good, and should
> > be edited for consistency.
>=20
> If we agree that "remote-tracking" is the way to go, a patch doing
> such editing would be very welcome.

-- 8< --
=46rom a863e58d240956191c2fa9cbe992aaca5786730b Mon Sep 17 00:00:00 200=
1
=46rom: Ramkumar Ramachandra <artagnon@gmail.com>
Date: Tue, 19 Oct 2010 22:42:05 +0530
Subject: [PATCH] Documentation: Consistently use the hyphenated "remote=
-tracking"

Replace instances of the term "remote tracking" with "remote-tracking"
in the documentation for clarity.

Reported-by: Thore Husfeldt <thore.husfeldt@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/config.txt           |    2 +-
 Documentation/fetch-options.txt    |    2 +-
 Documentation/git-gc.txt           |    2 +-
 Documentation/git-log.txt          |    2 +-
 Documentation/git-pull.txt         |    2 +-
 Documentation/git-remote.txt       |    4 ++--
 Documentation/gittutorial.txt      |    6 +++---
 Documentation/rev-list-options.txt |    2 +-
 Documentation/user-manual.txt      |    2 +-
 9 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 71ddb6c..736b22f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -708,7 +708,7 @@ color.diff.<slot>::
 color.decorate.<slot>::
 	Use customized color for 'git log --decorate' output.  `<slot>` is on=
e
 	of `branch`, `remoteBranch`, `tag`, `stash` or `HEAD` for local
-	branches, remote tracking branches, tags, stash and HEAD, respectivel=
y.
+	branches, remote-tracking branches, tags, stash and HEAD, respectivel=
y.
=20
 color.grep::
 	When set to `always`, always highlight matches.  When `false` (or
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-opti=
ons.txt
index 470ac31..a435c23 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -36,7 +36,7 @@ ifndef::git-pull[]
=20
 -p::
 --prune::
-	After fetching, remove any remote tracking branches which
+	After fetching, remove any remote-tracking branches which
 	no longer exist	on the remote.
 endif::git-pull[]
=20
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 315f07e..d6d6833 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -89,7 +89,7 @@ are not part of the current project most users will w=
ant to expire
 them sooner.  This option defaults to '30 days'.
=20
 The above two configuration variables can be given to a pattern.  For
-example, this sets non-default expiry values only to remote tracking
+example, this sets non-default expiry values only to remote-tracking
 branches:
=20
 ------------
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 6d40f00..ff41784 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -116,7 +116,7 @@ git log --follow builtin-rev-list.c::
 git log --branches --not --remotes=3Dorigin::
=20
 	Shows all commits that are in any of local branches but not in
-	any of remote tracking branches for 'origin' (what you have that
+	any of remote-tracking branches for 'origin' (what you have that
 	origin doesn't).
=20
 git log master --not --remotes=3D*/master::
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index c50f7dc..33e8438 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -26,7 +26,7 @@ With `--rebase`, it runs 'git rebase' instead of 'git=
 merge'.
 <repository> should be the name of a remote repository as
 passed to linkgit:git-fetch[1].  <refspec> can name an
 arbitrary remote ref (for example, the name of a tag) or even
-a collection of refs with corresponding remote tracking branches
+a collection of refs with corresponding remote-tracking branches
 (e.g., refs/heads/*:refs/remotes/origin/*), but usually it is
 the name of a branch in the remote repository.
=20
diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.tx=
t
index aa021b0..3143c89 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -75,7 +75,7 @@ was passed.
=20
 'rename'::
=20
-Rename the remote named <old> to <new>. All remote tracking branches a=
nd
+Rename the remote named <old> to <new>. All remote-tracking branches a=
nd
 configuration settings for the remote are updated.
 +
 In case <old> and <new> are the same, and <old> is a file under
@@ -84,7 +84,7 @@ the configuration file format.
=20
 'rm'::
=20
-Remove the remote named <name>. All remote tracking branches and
+Remove the remote named <name>. All remote-tracking branches and
 configuration settings for the remote are removed.
=20
 'set-head'::
diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.=
txt
index 1c16066..0982f74 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -385,7 +385,7 @@ alice$ git fetch bob
=20
 Unlike the longhand form, when Alice fetches from Bob using a
 remote repository shorthand set up with 'git remote', what was
-fetched is stored in a remote tracking branch, in this case
+fetched is stored in a remote-tracking branch, in this case
 `bob/master`.  So after this:
=20
 -------------------------------------
@@ -402,8 +402,8 @@ could merge the changes into her master branch:
 alice$ git merge bob/master
 -------------------------------------
=20
-This `merge` can also be done by 'pulling from her own remote
-tracking branch', like this:
+This `merge` can also be done by 'pulling from her own remote-tracking
+branch', like this:
=20
 -------------------------------------
 alice$ git pull . remotes/bob/master
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-lis=
t-options.txt
index ebc0108..052e64f 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -264,7 +264,7 @@ endif::git-rev-list[]
=20
 	Pretend as if all the refs in `refs/remotes` are listed
 	on the command line as '<commit>'. If `pattern`is given, limit
-	remote tracking branches to ones matching given shell glob.
+	remote-tracking branches to ones matching given shell glob.
 	If pattern lacks '?', '*', or '[', '/*' at the end is implied.
=20
 --glob=3Dglob-pattern::
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.=
txt
index 77eb483..cc65077 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1700,7 +1700,7 @@ may wish to check the original repository for upd=
ates and merge them
 into your own work.
=20
 We have already seen <<Updating-a-repository-With-git-fetch,how to
-keep remote tracking branches up to date>> with linkgit:git-fetch[1],
+keep remote-tracking branches up to date>> with linkgit:git-fetch[1],
 and how to merge two branches.  So you can merge in changes from the
 original repository's master branch with:
=20
--=20
1.7.2.2.409.gdbb11.dirty


> > (Comment: maybe =E2=80=9C... but working directory contains untrack=
ed files.=E2=80=9D
> > I realise that =E2=80=9Cdirectory=E2=80=9D is not quite comprehensi=
ve here, because
> > files can reside in subdirectories.
>=20
> We use "worktree" elsewhere, how about that?

$ git grep "worktree" | wc -l
281
$ git grep "working directory" | wc -l
246
$ git grep "working tree" | wc -l
449

Additionally, "working directory" also really refers to a (current)
working *directory* in many places.

I like "worktree" too, but for consistency I've replaced the
inconsistent usage of "working directory" in the UI with "working
tree". No, I haven't updated the documentation because it's frankly
too painful.

-- 8< --
=46rom 7422c2af1ef40c922d8f628715ad96172e4a5734 Mon Sep 17 00:00:00 200=
1
=46rom: Ramkumar Ramachandra <artagnon@gmail.com>
Date: Tue, 19 Oct 2010 23:16:04 +0530
Subject: [PATCH] UI: Don't say "working directory" when we really mean =
"working tree"

While in some places "working directory" is used to refer to the
(current) working directory, it's incorrectly used in places where Git
actually means "working tree" or worktree. Weed out and replace these
instances in the UI.

Reported-by: Thore Husfeldt <thore.husfeldt@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/apply.c      |    2 +-
 convert.c            |    4 ++--
 git-filter-branch.sh |    2 +-
 git-stash.sh         |    2 +-
 setup.c              |    2 +-
 unpack-trees.c       |    2 +-
 wt-status.c          |    4 ++--
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 23c18c5..9166320 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2934,7 +2934,7 @@ static int check_to_create_blob(const char *new_n=
ame, int ok_if_exists)
 		if (has_symlink_leading_path(new_name, strlen(new_name)))
 			return 0;
=20
-		return error("%s: already exists in working directory", new_name);
+		return error("%s: already exists in working tree", new_name);
 	}
 	else if ((errno !=3D ENOENT) && (errno !=3D ENOTDIR))
 		return error("%s: %s", new_name, strerror(errno));
diff --git a/convert.c b/convert.c
index 01de9a8..441708e 100644
--- a/convert.c
+++ b/convert.c
@@ -131,7 +131,7 @@ static void check_safe_crlf(const char *path, enum =
action action,
 		 */
 		if (stats->crlf) {
 			if (checksafe =3D=3D SAFE_CRLF_WARN)
-				warning("CRLF will be replaced by LF in %s.\nThe file will have it=
s original line endings in your working directory.", path);
+				warning("CRLF will be replaced by LF in %s.\nThe file will have it=
s original line endings in your working tree.", path);
 			else /* i.e. SAFE_CRLF_FAIL */
 				die("CRLF would be replaced by LF in %s.", path);
 		}
@@ -142,7 +142,7 @@ static void check_safe_crlf(const char *path, enum =
action action,
 		 */
 		if (stats->lf !=3D stats->crlf) {
 			if (checksafe =3D=3D SAFE_CRLF_WARN)
-				warning("LF will be replaced by CRLF in %s.\nThe file will have it=
s original line endings in your working directory.", path);
+				warning("LF will be replaced by CRLF in %s.\nThe file will have it=
s original line endings in your working tree.", path);
 			else /* i.e. SAFE_CRLF_FAIL */
 				die("LF would be replaced by CRLF in %s", path);
 		}
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 962a93b..0ab5551 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -110,7 +110,7 @@ OPTIONS_SPEC=3D
 if [ "$(is_bare_repository)" =3D false ]; then
 	git diff-files --ignore-submodules --quiet &&
 	git diff-index --cached --quiet HEAD -- ||
-	die "Cannot rewrite branch(es) with a dirty working directory."
+	die "Cannot rewrite branch(es) with a dirty working tree."
 fi
=20
 tempdir=3D.git-rewrite
diff --git a/git-stash.sh b/git-stash.sh
index 7561b37..86cf24e 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -179,7 +179,7 @@ save_stash () {
=20
 	git update-ref -m "$stash_msg" $ref_stash $w_commit ||
 		die "Cannot save the current status"
-	say Saved working directory and index state "$stash_msg"
+	say Saved working tree and index state "$stash_msg"
=20
 	if test -z "$patch_mode"
 	then
diff --git a/setup.c b/setup.c
index a3b76de..55f8fe3 100644
--- a/setup.c
+++ b/setup.c
@@ -611,7 +611,7 @@ const char *setup_git_directory(void)
 			die_errno ("Could not jump back into original cwd");
 		rel =3D get_relative_cwd(buffer, PATH_MAX, get_git_work_tree());
 		if (rel && *rel && chdir(get_git_work_tree()))
-			die_errno ("Could not jump to working directory");
+			die_errno ("Could not jump to working tree");
 		return rel && *rel ? strcat(rel, "/") : NULL;
 	}
=20
diff --git a/unpack-trees.c b/unpack-trees.c
index 803445a..a70b57c 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -934,7 +934,7 @@ int unpack_trees(unsigned len, struct tree_desc *t,=
 struct unpack_trees_options
=20
 		}
 		if (o->result.cache_nr && empty_worktree) {
-			ret =3D unpack_failed(o, "Sparse checkout leaves no entry on workin=
g directory");
+			ret =3D unpack_failed(o, "Sparse checkout leaves no entry on workin=
g tree");
 			goto done;
 		}
 	}
diff --git a/wt-status.c b/wt-status.c
index fc2438f..89831cb 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -95,7 +95,7 @@ static void wt_status_print_dirty_header(struct wt_st=
atus *s,
 		color_fprintf_ln(s->fp, c, "#   (use \"git add <file>...\" to update=
 what will be committed)");
 	else
 		color_fprintf_ln(s->fp, c, "#   (use \"git add/rm <file>...\" to upd=
ate what will be committed)");
-	color_fprintf_ln(s->fp, c, "#   (use \"git checkout -- <file>...\" to=
 discard changes in working directory)");
+	color_fprintf_ln(s->fp, c, "#   (use \"git checkout -- <file>...\" to=
 discard changes in working tree)");
 	if (has_dirty_submodules)
 		color_fprintf_ln(s->fp, c, "#   (commit or discard the untracked or =
modified content in submodules)");
 	color_fprintf_ln(s->fp, c, "#");
@@ -690,7 +690,7 @@ void wt_status_print(struct wt_status *s)
 				? " (use -u to show untracked files)" : "");
 		else
 			printf("nothing to commit%s\n", advice_status_hints
-				? " (working directory clean)" : "");
+				? " (working tree clean)" : "");
 	}
 }
=20
--=20
1.7.2.2.409.gdbb11.dirty


> > =C2=A0 =C2=A0Changes to be committed:
> > =C2=A0 =C2=A0(use "git reset HEAD <file>..." to unstage)
> >
> > should be
> >
> > =C2=A0 =C2=A0Staged to be committed:
> > =C2=A0 =C2=A0(use "git unstage <file>" to unstage)
>=20
> This would be extra nice since 'git unstage' could also be used in a
> fresh repository.

[`git unstage` patch still cooking]

Sverre: Thanks!
Thore: Thanks for the feedback. Please read
Documentation/SubmittingPatches and submit more patches.

-- Ram
