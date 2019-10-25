Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BE5D1F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 12:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440369AbfJYMln (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 08:41:43 -0400
Received: from mout.gmx.net ([212.227.15.15]:38963 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440360AbfJYMll (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 08:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572007298;
        bh=TeiN674ij1NbmVFFT3h5rUtod8dHDsP21XYHZPQUFYg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=j8Gr1muWRc8vjFKChQkhepAUtwVeX6tqU3iWdg8++3s3csi9s2pzgg6AtsIS1K4Fi
         1Ut/mr+sgwSFnzRYw5cFzBJuN5huTeujxG+92YsL7pLkLlod5NfGOEKDQNnfxEiNcp
         T1glXsVCU7E5TOM8V9N/E+atXRCOL3mfYLlZkpUw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLR1V-1ifEoL03Tn-00IRAY; Fri, 25
 Oct 2019 14:41:38 +0200
Date:   Fri, 25 Oct 2019 14:41:22 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Aleksey Mikhaylov <almikhailov@plesk.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Issue: "Could not access submodule" error when pulling recursively
 with Git 2.22.0
In-Reply-To: <20191023100449.GH4348@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1910251415560.46@tvgsbejvaqbjf.bet>
References: <AM5PR0902MB1953988602B657C3D0BB9B17A36B0@AM5PR0902MB1953.eurprd09.prod.outlook.com> <20191023100449.GH4348@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1117635432-1572007298=:46"
X-Provags-ID: V03:K1:la0RxycnJZk25gW19Uhmj7FhuS+ubj8/Zrtfk4a7aRM9Xs0CsJI
 XlM9nLh6kdotXf2gFKLA5gJlz4TL5YQM7uCucQN5YA3yVQ5pV4Rex2KlB9DR1k2I1Ce9Ikv
 +3/uPWYhRS48+OvxeZzLBO3DHTJ5axLC5/T9bNSFJUJWwdvQYOg9XihJU5KX6sRWdKYo9qh
 m3uJ1q1IybUMdXdybJYQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:83ZX4lBq0xo=:NvRk3zXDVyjQDffxG+ibTQ
 2dy5e1u/wMtl7tqB8JOx4OSiS95j8xBAgdbnMzwI1AGS4mWvtBFQqVy0wo0kWwmvJS0Nb4JOn
 w2xdre2wHuc3u9hI0tABuqYF0yr7/fMSFCh9U+pqyKHfkStX3rekIsqkNboakI1CSeSrr3msi
 cFEfrIXUwGeNom4NPAmG27tn2hl2CyMci+fHbdHw/WLzQID6Zb0DvYuVIgRc09/Y5mOgvgz2e
 tw8S5RBRnDapOBMGVShs7vikFTS5lmbDgHzO2CFnoKVIBi51xxFcnIVNfW4WYA/g1cDWG2m3y
 Nnm5KU+JHYuzWm3FqdzHrXCR5gYSrcA+tZHksHExPz4+yKU16CtyvFCyEXBZSNLSRdBhlPF+K
 FpVjHrqbIfNJr/1gzP48pBe0XNOX7kRnV/wqLzkuoNhrm8QaGX4Mz4jE46FHr+cnJmxCaI+S1
 vzB8dsqjQnSOm+W84z1dTk2w4J9azVN27eechsglGuICEVUMJCQ6LFRS2W4TBEWr0hCC1N8O4
 F4FRRiOZeVOBS7ROKQWPw9XSqSxPAXvREUiS8tln0p3PZmNwasis+VsIJD31FmMfwhdi5Bprq
 8ZIqGOpQ8hOcLFp3IybO1hgHFwBeXxmNs0045Jkldd7+u9RatflbHGjSpE5HjCVcH+yURwvPI
 7zaWdMoTx+bPLhJwT0ZiLS84x0wKIyPyDHRtottRqbuX3fuRFHftE9JrKp4jig6ylIM/9kUd8
 5x+fVtraITZbg8Z7ia1gqj3YWDv1GxUoFb3S33BPHe1as40vGbDkTIhvHINIpyrAULfw/5VN8
 YeC7kOO2ffuIGItCr3HQXOuG7UcTCMVvQVTMFvGKHQ5uA1tLNkKB7Yy4HrEzPVPJb9lcF6YIB
 X9waNjC9kao0YPykjcbE0vt2kCTA7WI299WTZGIWybUA/ajh7j1rVcJOoC0Am3I6oW0X7HjGH
 RglvmWEcTmcnP7vXILIRB3yd/d8w9PCLopShW8sb3NFBpOvSTjPqznr4DEkLxkH0wFdpIEsJK
 hNcaFx9N1ZeJkn7UgOXMp5jXdahJ3qYL093BSLuBhSqKt0Fvc9KizOxcTi1GTrtgVgeXl9umK
 q6mGYPPlOpQMiMN3Zc6ORkoOtZofA0nD0QaDNNdz286T0uvKlmKJs4pSd4maRv0XCcHL+bLmd
 1Vx4fbyYHQlng0dveHYpN0Owj9K2VX/5yrTXzfZiG132ZGRUY2TXg54CSWY12zcV2vt2nCOxE
 64MSBJQapaRHRXQbQw8zxLPr4pxL86gesLIFabd8Dk8k64Q4pyUj1txQhwpA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1117635432-1572007298=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Wed, 23 Oct 2019, SZEDER G=C3=A1bor wrote:

> On Wed, Oct 23, 2019 at 07:22:12AM +0000, Aleksey Mikhaylov wrote:
> > "Could not access submodule" error when pulling recursively with Git 2=
.22.0.
> > This issue causes if there is submodule in submodule.
>
> > Please use my simple test repository to reproduce the problem:
> > https://github.com/agmikhailov/example2361.git
> >
> > It is just an empty repository with one submodule (https://github.com/=
agmikhailov/example2361M1.git)
> > and one submodule of submodule (https://github.com/agmikhailov/example=
2361M2.git):
> >
> > git clone https://github.com/agmikhailov/example2361.git
> > cd example2361/
> > git submodule init
>
> According to the docs of 'git submodule init', it "initializes the
> submodules recorded in the index".  Therefore, it can only initialize
> the submodule in 'example2361M1', because at this point we have no
> idea that there is a nested submodule in there.
>
>   $ git submodule init
>   Submodule 'example2361M1' (https://github.com/agmikhailov/example2361M=
1.git) registered for path 'example2361M1'

Indeed, `git submodule init` is not recursive.

> > git submodule update
>
> This command clones 'example2361M1':
>
>   $ git submodule update --recursive
>   Cloning into '/tmp/example2361/example2361M1'...
>   Submodule path 'example2361M1': checked out '6a9be24a1c0ebd44d91ae4dcf=
1fd62580b936540'
>
> Only at this point can we finally see that there is a nested
> submodule, and can initialize and clone it with:
>
>   $ cd example2361M1
>   $ git submodule init
>   Submodule 'example2361M2' (https://github.com/agmikhailov/example2361M=
2.git) registered for path 'example2361M2'
>   $ git submodule update
>   Cloning into '/tmp/example2361/example2361M1/example2361M2'...
>   Submodule path 'example2361M2': checked out '9ed39cf1fe0a8cf34e72d2e7e=
bff1ea9d4a63ac1'

I concur.

> > git pull --recurse-submodules=3Dtrue
>
> And after that:
>
>   $ cd ../..
>   $ git pull --recurse-submodules=3Dtrue
>   Fetching submodule example2361M1
>   Fetching submodule example2361M1/example2361M2
>   Already up to date.

Yes, I agree that _probably_ what the user wanted is to initialize the
submodules recursively.

Having said that, I vaguely remember that e.g. Boost has this insane
forest of submodules, and I am almost certain that no sane person wants
to clone them all. _I_ wouldn't.

> > ACTUAL RESULT
> >
> > "git --recurse-submodules=3Dtrue" command fails with message "Could no=
t access submodule":
> >
> > $ git --recurse-submodules=3Dtrue
> > Fetching submodule example2361M1
> > Could not access submodule 'example2361M2'
> >
> > EXPECTED RESULT
> >
> > All submodules are successfully updated by "git --recurse-submodules=
=3Dtrue" command.
> >
> > ADDITIONAL INFORMATION
> >
> > Git version 2.20.1 does not have this problem.
> > So we had to downgrade Git to work with submodules.
>
> The behavior was indeed different with v2.20.1, but that version
> didn't show the behavior you expected.  When running your commands
> with v2.20.1 I get:
>
>   $ ~/src/git/bin-wrappers/git pull --recurse-submodules=3Dtrue
>   Fetching submodule example2361M1
>   Already up to date.
>   $ find example2361M1/example2361M2/
>   example2361M1/example2361M2/
>
> So while that 'git pull' didn't error out, it didn't even look at the
> nested submodule, which is still uninitialized and empty.

I would actually argue that this is what is expected: the entire _point_
of submodules is that they can be inactive.

Coming back to the Boost example, what I would want Git to do when only
a fraction of the submodules is active is to skip the inactive ones
during a `git pull --recurse-submodules=3Dtrue`.

Which v2.20.1 apparently did, and I would call the current behavior a
regression.

> FWIW, bisecting shows that the behavior changed with commit
> a62387b3fc,

Thanks for digging this out!

> but, unfortunately, the commit message doesn't seem to be very helpful
> to me, but perhaps others with more experience with submodules can
> make something out of it.
>
> commit a62387b3fc9f5aeeb04a2db278121d33a9caafa7
> Author: Stefan Beller <sbeller@google.com>
> Date:   Wed Nov 28 16:27:55 2018 -0800
>
>     submodule.c: fetch in submodules git directory instead of in worktre=
e
>
>     Keep the properties introduced in 10f5c52656 (submodule: avoid
>     auto-discovery in prepare_submodule_repo_env(), 2016-09-01), by fixa=
ting
>     the git directory of the submodule.
>
>     Signed-off-by: Stefan Beller <sbeller@google.com>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
>  submodule.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

To me, this commit message suggests that the bahvior should not have
changed in the reported manner.

Let's look at the diff:

=2D- snip --
diff --git a/submodule.c b/submodule.c
index 77ace5e784a..d1b6646f42d 100644
=2D-- a/submodule.c
+++ b/submodule.c
@@ -494,6 +494,12 @@ void prepare_submodule_repo_env(struct argv_array *ou=
t)
 			 DEFAULT_GIT_DIR_ENVIRONMENT);
 }

+static void prepare_submodule_repo_env_in_gitdir(struct argv_array *out)
+{
+	prepare_submodule_repo_env_no_git_dir(out);
+	argv_array_pushf(out, "%s=3D.", GIT_DIR_ENVIRONMENT);
+}
+
 /* Helper function to display the submodule header line prior to the full
  * summary output. If it can locate the submodule objects directory it wi=
ll
  * attempt to lookup both the left and right commits and put them into th=
e
@@ -1327,8 +1333,8 @@ static int get_next_submodule(struct child_process *=
cp,
 		repo =3D get_submodule_repo_for(spf->r, submodule);
 		if (repo) {
 			child_process_init(cp);
-			cp->dir =3D xstrdup(repo->worktree);
-			prepare_submodule_repo_env(&cp->env_array);
+			cp->dir =3D xstrdup(repo->gitdir);
+			prepare_submodule_repo_env_in_gitdir(&cp->env_array);
 			cp->git_cmd =3D 1;
 			if (!spf->quiet)
 				strbuf_addf(err, "Fetching submodule %s%s\n",
=2D- snap --

The obvious difference in behavior is that we no longer let Git
discover the `.git` file/directory, but we define it (because we can).

But actually, we cannot, not if the submodule is not checked out!
Because in this case, there is no `.git` file and Git then tries to
initialize the repository and the worktree, and fails rather miserably
in the reported manner.

Side note: I think there is something spooky going on where we try to
fetch submodules twice when the first time failed, and somehow slip into
the `else` arm of this code:

=2D- snip --
		task->repo =3D get_submodule_repo_for(spf->r, task->sub);
		if (task->repo) {
			struct strbuf submodule_prefix =3D STRBUF_INIT;
			child_process_init(cp);
			cp->dir =3D task->repo->gitdir;
			prepare_submodule_repo_env_in_gitdir(&cp->env_array);
			cp->git_cmd =3D 1;
			if (!spf->quiet)
				strbuf_addf(err, "Fetching submodule %s%s\n",
					    spf->prefix, ce->name);
			argv_array_init(&cp->args);
			argv_array_pushv(&cp->args, spf->args.argv);
			argv_array_push(&cp->args, default_argv);
			argv_array_push(&cp->args, "--submodule-prefix");

			strbuf_addf(&submodule_prefix, "%s%s/",
						       spf->prefix,
						       task->sub->path);
			argv_array_push(&cp->args, submodule_prefix.buf);

			spf->count++;
			*task_cb =3D task;

			strbuf_release(&submodule_prefix);
			return 1;
		} else {

			fetch_task_release(task);
			free(task);

			/*
			 * An empty directory is normal,
			 * the submodule is not initialized
			 */
			if (S_ISGITLINK(ce->ce_mode) &&
			    !is_empty_dir(ce->name)) {
				spf->result =3D 1;
				strbuf_addf(err,
					    _("Could not access submodule '%s'"),
					    ce->name);
			}
		}
=2D- snap --

As you can see, at that point, `is_empty_dir()` indicates that it is _no
longer empty_, which means that the recursive pull actually tried to
initialize it, and left things in a half-consistent state.

BTW I also think that Stefan's commit just made a bug very obvious that
had not mattered all that much before: it would seem that before that
commit, when the code tried to fetch a submodule, it would actually
fetch the super project (because it would discover the .git
file/directory, and as the inactive submodule does not have any, it
would have found the super project's).

In essence, I think that the report points out a very real bug, and this
bug should be fixed.

I _could_ imagine that it would be as easy as applying this patch (and
turning the provided reproducer into a regression test), then polishing
this with a nice commit message:

=2D- snip --
diff --git a/submodule.c b/submodule.c
index 0f199c51378..5694905610a 100644
=2D-- a/submodule.c
+++ b/submodule.c
@@ -1443,6 +1443,12 @@ static int get_next_submodule(struct child_process =
*cp,
 		task->repo =3D get_submodule_repo_for(spf->r, task->sub);
 		if (task->repo) {
 			struct strbuf submodule_prefix =3D STRBUF_INIT;
+
+			/* skip uninitialized submodule */
+			if (!file_exists(task->repo->gitdir) ||
+			    is_empty_dir(task->repo->gitdir))
+				continue;
+
 			child_process_init(cp);
 			cp->dir =3D task->repo->gitdir;
 			prepare_submodule_repo_env_in_gitdir(&cp->env_array);
=2D- snap --

Any takers?

Ciao,
Johannes

--8323328-1117635432-1572007298=:46--
