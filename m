Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C176AC2BA2B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 14:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBDF20679
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 14:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ig3Iwcas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgDJOeY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 10:34:24 -0400
Received: from mout.gmx.net ([212.227.17.21]:55755 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbgDJOeX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 10:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586529256;
        bh=CyKBCxpdT66adgU2hLt9oPyVl3tAfqE/NfVJObKu9aM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ig3IwcasKPAMlfddJtp5+TDaAriiXgGKT4ZqYw6w2N4b7UgVoH+N5lTXFPTzG6C98
         cLwFSx3asYgroxkieHfzNMxedzbfbXYV/gMZh2ffjrR0MO6wrAwZIOnP8+T5TdaCqa
         Esb/g6EBgyxJ0xP/CvMePWkky5o3cTNG4F3ls49I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.215.97]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MG9g4-1jUg5z41YS-00GXUu; Fri, 10 Apr 2020 16:34:16 +0200
Date:   Fri, 10 Apr 2020 16:34:15 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 00/12] ci: replace our Azure Pipeline by GitHub
 Actions
In-Reply-To: <xmqqpncgmk5z.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2004101604210.46@tvgsbejvaqbjf.bet>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>        <cover.1586309211.git.congdanhqx@gmail.com> <xmqqpncgmk5z.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1173611662-1586529256=:46"
X-Provags-ID: V03:K1:EOCFqYzaKcQSiTWzghJSnf2/z/uYTS+euKihmXtpQs7e0LPlyJi
 qTwqAwyvvfZnyluGSEppApbGPAuNEvXUk29aCS4oHVQzZOCgCKAFAw0pf+FPsTBzo/fm6Sp
 sWDZ8SRoWfDX2exflgcrHh62oLMhcnj9t5KNEnTN41VS9P6cJMYQjV73eJbA/IF+6+hFwq9
 L4sfie3vahAJxvH482h3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jukEz+kFiVI=:vIhaOFYUYUgHDVtGkAfajN
 D6GzVNVVG+3biJl6Eti1VAKil4/bKxMJ4NCNdFCAKUt/XKoE4ab+VdwevMru0lZ66AtT3S2ik
 bINOwn5k+aiDPE+yR7TSpbGF/2KSIFYFMKIGkyy17hIYI+8g/v4oabIqHrAFyeaTGNrGe3GwO
 yeRId2SkGoPI2wyB/ev4kB5XWFCP6u8ucXlk9XjwzhJ8x5cJtXx2cCubMR01oNjoQU0VTnR1E
 0i0M5Fs11DitjDMXPoUUTJsEDI9BKwI4OQRaIgkNkHWj42+BmuF0CkLDPDief2dnoxA+6Yyvo
 35BFRfEwrQC+xD73liClrW+5Fe2qVp4XUcnG8akU7eymCUtqjWU2yC3JKv+l05vyTnYXTJUiX
 mHQDPo08ZiWZMj5XvzT5Ut1eh41eG19KqBmXVbItTaPzkNOyr85AwH0AgkTaAbqrKp4MPsUJo
 NT2068RfyOJjUXF5R/3TEFelgQx0ccrX3JG7LpfYUiaDkzo38zTlWG+8sSRbcmY29Z2QSrioR
 8lWKexm61QIyu8kokJ93nFfUAyOeUqZPb0sPvmXPbQGd6AhHCPJXlhxI9bauKR3Ye+rtC0YqT
 cczjaas4UspHPVqlFPl9i3S3OBkinHAnWO8sd5cBAESNV0MFoLWkCCSYpzLTKMOGhDuspzfAj
 HXuB+AIdvTsWSrsC2rkdwncyYUJqvrE6Zf6C0P9zlmvAYyOXz8UlVJ9QJ8qnFXpD4Wu79Yfmo
 kew0DBNf8+HGIpY+DWtMMhREbkxc7JWIgHFYLUVJiGsQnUNZyfw6acx6ttF2X3ri+0k0c/xeA
 lg3T/l1ciDQDQFsHHUjrnHkH6qtm/EV1kZbZacdyTxWCA2zWhWHGCxRYwAdz4SCtOkWScTfsr
 dBhh1ej3Ty1gni+kVkiS22Z0CejvW/Ei+R3HJbuWl+wN2sAzlVUEX+NItaKJ6cqZIMiwXdSWP
 YyUPbuc9mQHgbhNNXWWlWFYilYm4IFpHVXGibbEB0Pi0nHcAdobmr2udrh5izrT9BZcHwyBbO
 tRpvUq2Mimq1uoqWQwaulkml3T75/5assqnlh+d28ljUWHMSUlBQmbzjpz9+V7HpCtaBsio+O
 MG/pd3OXKfcEs8ZjJKURnp2ThVtrhyPXMC2L9S4Z6W5V28QVzYbZh1K63HRG7KViE+ZVgSO2n
 8rZxd4u4KnB3XmtUWQ83P+ek1Gjv7C1v23TUJpDtNjA933rU8Qxc8oLJpjEWOtuRcvpHAjkJX
 m/Za4L98mTX69KWpq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1173611662-1586529256=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Thu, 9 Apr 2020, Junio C Hamano wrote:

> =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> write=
s:
>
> > Our Azure Pipeline has served us well over the course of the past year=
 or
> > so, steadily catching issues before the respective patches hit the nex=
t
> > branch.
> >
> > There is a GitHub-native CI system now, though, called "GitHub Actions=
"
> > [https://github.com/features/actions] which is essentially on par with=
 Azure
> > Pipelines as far as our needs are concerned, and it brings a couple of
> > advantages:
> >
> >  * It is substantially easier to set up than Azure Pipelines: all you =
need
> >    is to add the YAML-based build definition, push to your fork on Git=
Hub,
> >    and that's it.
> >  * The syntax is a bit easier to read than Azure Pipelines'.
> >  * We get more concurrent jobs (Azure Pipelines is limited to 10 concu=
rrent
> >    jobs).
> >
> > With this change, users also no longer need to open a PR at
> > https://github.com/git/git or at https://github.com/gitgitgadget/git j=
ust to
> > get the benefit of a CI build.
> >
> > Sample run on top of dd/ci-musl-libc with dd/test-with-busybox merged:
> > https://github.com/sgn/git/actions/runs/73179413
> >
> > Sample run when this series applied into git-for-windows
> > https://github.com/git-for-windows/git/runs/568625109
> >
> > Change from v3:
> > - Use build matrix
> > - All dependencies are install by scripts
> > - stop repeating environment variables
> > - build failure's artifacts will be uploaded
>
> I did not see any particular thing that is bad in any of the three
> series involved; do people have further comments?

FWIW I consider this work good enough that I already merged it into Git
for Windows. It should make it easier for contributors to test their
branches "privately", in their own forks, before opening a PR (most people
do not like to have relatively trivial issues pointed out by fellow human
beings, but are much more okay with machines telling them what needs to be
improved).

Please mark this up as a vote of confidence from my side.

> I am not exactly happy that these had to be queued on top of a merge
> of two topics in flight, which makes it cumbersome to deal with a
> breakage in these two other topics, though, but that would be a pain
> only until these two topics prove to be stable enough to build on.

Yes, and the fact that `ci-musl-libc` was _not_ based on top of
`test-with-busybox` makes it a bit more awkward. I, for one, had totally
missed that the latter patch series is _required_ in order to make the
former work correctly. Hunting for the cause for almost an hour until Danh
kindly pointed out that he had fixed all the issues in `test-with-busybox`
already.

> Judging from two CI runs for 'pu' ([*1*] and [*2*]), among the
> topics that are cooking, there are only a few topics that these
> tests are unhappy about.  Perhaps those on Windows can help these
> topics to pass these tests?

I would like to point out that there is only one single topic that is
cause for sorrow here, and it is the reftable one.

Before going further, let me point out that the `pu` branch has been
broken for quite a long time now, primarily because of `bugreport` and...
of course because of `reftable`. Whenever `pu` included `reftable`, the CI
builds failed. So these `reftable` problems are not a good reason, in my
mind, to hold up the GitHub workflow patches from advancing.

Seeing the short stat `35 files changed, 6719 insertions(+)` of even a
single patch in the `reftable` patch series _really_ does not entice me to
spend time even looking at it, certainly not at a time when I am short on
time, let alone to try to find time to fix it.

However, since you asked so nicely, I did start to look into it. First,
let me present you the less controversial of two patches I want to show
you:

=2D- snip --
=46rom 5f42a3f6ef9cf7d90bd274e55539b145cae40e28 Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Fri, 10 Apr 2020 14:23:40 +0200
Subject: [PATCH] fixup??? Reftable support for git-core

As I had already pointed out over a month ago in
https://github.com/gitgitgadget/git/pull/539#issuecomment-589157008 this
C code violates the C standard, and MS Visual C is not as lenient as
GCC/clang on it: `struct`s cannot be initialized with `=3D {}`.

Compile errors aside, while this code conforms to the C syntax, it feels
more like Java when it initializes e.g. `struct object_id` only to
_immediately_ overwrite the contents.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 refs/reftable-backend.c | 52 ++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 6e845e9c649..20c94bb403b 100644
=2D-- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -31,7 +31,7 @@ static void clear_reftable_log_record(struct reftable_lo=
g_record *log)
 static void fill_reftable_log_record(struct reftable_log_record *log)
 {
 	const char *info =3D git_committer_info(0);
-	struct ident_split split =3D {};
+	struct ident_split split =3D { NULL };
 	int result =3D split_ident_line(&split, info, strlen(info));
 	int sign =3D 1;
 	assert(0 =3D=3D result);
@@ -230,7 +230,7 @@ static int reftable_transaction_abort(struct ref_store=
 *ref_store,
 static int reftable_check_old_oid(struct ref_store *refs, const char *ref=
name,
 				  struct object_id *want_oid)
 {
-	struct object_id out_oid =3D {};
+	struct object_id out_oid;
 	int out_flags =3D 0;
 	const char *resolved =3D refs_resolve_ref_unsafe(
 		refs, refname, RESOLVE_REF_READING, &out_oid, &out_flags);
@@ -287,14 +287,14 @@ static int write_transaction_table(struct reftable_w=
riter *writer, void *arg)
 		log->message =3D u->msg;

 		if (u->flags & REF_HAVE_NEW) {
-			struct object_id out_oid =3D {};
+			struct object_id out_oid;
 			int out_flags =3D 0;
 			/* Memory owned by refs_resolve_ref_unsafe, no need to
 			 * free(). */
 			const char *resolved =3D refs_resolve_ref_unsafe(
 				transaction->ref_store, u->refname, 0, &out_oid,
 				&out_flags);
-			struct reftable_ref_record ref =3D {};
+			struct reftable_ref_record ref =3D { NULL };
 			ref.ref_name =3D
 				(char *)(resolved ? resolved : u->refname);
 			log->ref_name =3D ref.ref_name;
@@ -376,8 +376,8 @@ static int write_delete_refs_table(struct reftable_wri=
ter *writer, void *argv)
 	}

 	for (int i =3D 0; i < arg->refnames->nr; i++) {
-		struct reftable_log_record log =3D {};
-		struct reftable_ref_record current =3D {};
+		struct reftable_log_record log =3D { NULL };
+		struct reftable_ref_record current =3D { NULL };
 		fill_reftable_log_record(&log);
 		log.message =3D xstrdup(arg->logmsg);
 		log.new_hash =3D NULL;
@@ -455,10 +455,10 @@ static int write_create_symref_table(struct reftable=
_writer *writer, void *arg)
 	}

 	{
-		struct reftable_log_record log =3D {};
-		struct object_id new_oid =3D {};
-		struct object_id old_oid =3D {};
-		struct reftable_ref_record current =3D {};
+		struct reftable_log_record log =3D { NULL };
+		struct object_id new_oid;
+		struct object_id old_oid;
+		struct reftable_ref_record current =3D { NULL };
 		reftable_stack_read_ref(create->refs->stack, create->refname, &current)=
;

 		fill_reftable_log_record(&log);
@@ -513,7 +513,7 @@ static int write_rename_table(struct reftable_writer *=
writer, void *argv)
 {
 	struct write_rename_arg *arg =3D (struct write_rename_arg *)argv;
 	uint64_t ts =3D reftable_stack_next_update_index(arg->stack);
-	struct reftable_ref_record ref =3D {};
+	struct reftable_ref_record ref =3D { NULL };
 	int err =3D reftable_stack_read_ref(arg->stack, arg->oldname, &ref);

 	if (err) {
@@ -531,7 +531,7 @@ static int write_rename_table(struct reftable_writer *=
writer, void *argv)
 	ref.update_index =3D ts;

 	{
-		struct reftable_ref_record todo[2] =3D {};
+		struct reftable_ref_record todo[2] =3D { { NULL } };
 		todo[0].ref_name =3D (char *)arg->oldname;
 		todo[0].update_index =3D ts;
 		/* leave todo[0] empty */
@@ -545,7 +545,7 @@ static int write_rename_table(struct reftable_writer *=
writer, void *argv)
 	}

 	if (ref.value !=3D NULL) {
-		struct reftable_log_record todo[2] =3D {};
+		struct reftable_log_record todo[2] =3D { { NULL } };
 		fill_reftable_log_record(&todo[0]);
 		fill_reftable_log_record(&todo[1]);

@@ -688,12 +688,12 @@ reftable_for_each_reflog_ent_newest_first(struct ref=
_store *ref_store,
 					  const char *refname,
 					  each_reflog_ent_fn fn, void *cb_data)
 {
-	struct reftable_iterator it =3D {};
+	struct reftable_iterator it =3D { NULL };
 	struct git_reftable_ref_store *refs =3D
 		(struct git_reftable_ref_store *)ref_store;
 	struct reftable_merged_table *mt =3D NULL;
 	int err =3D 0;
-	struct reftable_log_record log =3D {};
+	struct reftable_log_record log =3D { NULL };

 	if (refs->err < 0) {
 		return refs->err;
@@ -712,8 +712,8 @@ reftable_for_each_reflog_ent_newest_first(struct ref_s=
tore *ref_store,
 		}

 		{
-			struct object_id old_oid =3D {};
-			struct object_id new_oid =3D {};
+			struct object_id old_oid;
+			struct object_id new_oid;
 			const char *full_committer =3D "";

 			hashcpy(old_oid.hash, log.old_hash);
@@ -744,7 +744,7 @@ reftable_for_each_reflog_ent_oldest_first(struct ref_s=
tore *ref_store,
 					  const char *refname,
 					  each_reflog_ent_fn fn, void *cb_data)
 {
-	struct reftable_iterator it =3D {};
+	struct reftable_iterator it =3D { NULL };
 	struct git_reftable_ref_store *refs =3D
 		(struct git_reftable_ref_store *)ref_store;
 	struct reftable_merged_table *mt =3D NULL;
@@ -760,7 +760,7 @@ reftable_for_each_reflog_ent_oldest_first(struct ref_s=
tore *ref_store,
 	err =3D reftable_merged_table_seek_log(mt, &it, refname);

 	while (err =3D=3D 0) {
-		struct reftable_log_record log =3D {};
+		struct reftable_log_record log =3D { NULL };
 		err =3D reftable_iterator_next_log(it, &log);
 		if (err !=3D 0) {
 			break;
@@ -780,8 +780,8 @@ reftable_for_each_reflog_ent_oldest_first(struct ref_s=
tore *ref_store,

 	for (int i =3D len; i--;) {
 		struct reftable_log_record *log =3D &logs[i];
-		struct object_id old_oid =3D {};
-		struct object_id new_oid =3D {};
+		struct object_id old_oid;
+		struct object_id new_oid;
 		const char *full_committer =3D "";

 		hashcpy(old_oid.hash, log->old_hash);
@@ -903,8 +903,8 @@ static int reftable_reflog_expire(struct ref_store *re=
f_store,
 	struct reflog_expiry_arg arg =3D {
 		.refs =3D refs,
 	};
-	struct reftable_log_record log =3D {};
-	struct reftable_iterator it =3D {};
+	struct reftable_log_record log =3D { NULL };
+	struct reftable_iterator it =3D { NULL };
 	int err =3D 0;
 	if (refs->err < 0) {
 		return refs->err;
@@ -917,8 +917,8 @@ static int reftable_reflog_expire(struct ref_store *re=
f_store,
 	}

 	while (1) {
-		struct object_id ooid =3D {};
-		struct object_id noid =3D {};
+		struct object_id ooid;
+		struct object_id noid;

 		int err =3D reftable_iterator_next_log(it, &log);
 		if (err < 0) {
@@ -950,7 +950,7 @@ static int reftable_read_raw_ref(struct ref_store *ref=
_store,
 {
 	struct git_reftable_ref_store *refs =3D
 		(struct git_reftable_ref_store *)ref_store;
-	struct reftable_ref_record ref =3D {};
+	struct reftable_ref_record ref =3D { NULL };
 	int err =3D 0;
 	if (refs->err < 0) {
 		return refs->err;
=2D- snap --

This patch should fix the `vs-build` job in the Azure Pipeline as well as
in the GitHub workflow.

However, it does _not_ fix the test failure on Windows. When I tried to
investigate this, I wanted to compare the results between Windows and
Linux (WSL, of course, it is a major time saver for me these days because
I don't have to power up a VM, and I can access WSL files from Windows and
vice versa), and it turns out that the `000000000002-000000000002.ref`
file is different, it even has different sizes (242 bytes on Windows
instead of 268 bytes on Linux), and notably it contains the string `HEAD`
on Windows and `refs/heads/master` on Linux, but not vice versa.

So I dug a bit deeper and was stopped rudely by the fact that the
t0031-reftable.sh script produces different output every time it runs.
Because it does not even use `test_commit`.

Therefore, let me present you with this patch (whose commit message
conveys a rather alarming indication that this endeavor of fixing
`reftable` could become a major time sink):

=2D- snip -
=46rom 6ba47e70a2eb8efe2116c12eb950ddb90c473d11 Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Fri, 10 Apr 2020 16:10:53 +0200
Subject: [PATCH] fixup??? Reftable support for git-core

The test for the reftable functionality should use the convenience
functions we provide for test scripts. Using `test_commit` in particular
does help with reproducible output (otherwise the SHA-1s will change
together with the time the tests were run).

Currently, this here seemingly innocuous change causes quite a few
warnings throughout the test, though, e.g. this slur of warnings when
committing the last commit in the test script:

	warning: bad replace ref name: e
	warning: bad replace ref name: ber-1
	warning: bad replace ref name: ber-2
	warning: bad replace ref name: ber-3
	warning: bad replace ref name: ber-4
	warning: bad replace ref name: ber-5
	warning: bad replace ref name: ber-6
	warning: bad replace ref name: ber-7
	warning: bad replace ref name: ber-8
	warning: bad replace ref name: ber-9

This is notably _not_ a problem that was introduced by this here patch,
of course, but a very real concern about the reftable patches, most
likely the big one that introduces the reftable library in one fell
swoop.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 t/t0031-reftable.sh | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/t/t0031-reftable.sh b/t/t0031-reftable.sh
index 3ebf13c2f42..4bc7bd8167f 100755
=2D-- a/t/t0031-reftable.sh
+++ b/t/t0031-reftable.sh
@@ -8,28 +8,26 @@ test_description=3D'reftable basics'
 . ./test-lib.sh

 test_expect_success 'basic operation of reftable storage' '
-	git init --ref-storage=3Dreftable repo && (
-	cd repo &&
-	echo "hello" >world.txt &&
-	git add world.txt &&
-	git commit -m "first post" &&
-	test_write_lines HEAD refs/heads/master >expect &&
+	rm -rf .git &&
+	git init --ref-storage=3Dreftable &&
+	mv .git/hooks .git/hooks-disabled &&
+	test_commit file &&
+	test_write_lines HEAD refs/heads/master refs/tags/file >expect &&
 	git show-ref &&
 	git show-ref | cut -f2 -d" " > actual &&
 	test_cmp actual expect &&
 	for count in $(test_seq 1 10)
 	do
-		echo "hello" >>world.txt
-		git commit -m "number ${count}" world.txt ||
+		test_commit "number $count" file.t $count number-$count ||
 		return 1
 	done &&
 	git gc &&
-	nfiles=3D$(ls -1 .git/reftable | wc -l ) &&
-	test ${nfiles} =3D "2" &&
+	ls -1 .git/reftable >table-files &&
+	test_line_count =3D 2 table-files &&
 	git reflog refs/heads/master >output &&
 	test_line_count =3D 11 output &&
 	grep "commit (initial): first post" output &&
-	grep "commit: number 10" output )
+	grep "commit: number 10" output
 '

 test_done
=2D- snap --

While I am very happy with the post-image of this diff, I am super unhappy
about the output of it. It makes me believe that this `reftable` patch
series is in serious need of being "incrementalized" _after the fact_.
Otherwise it will be simply impossible to build enough confidence in the
correctness of it, especially given the fact that it obviously does some
incorrect things right now (see the "bad replace ref name" warning
mentioned above).

I'll take a break from this now, but I would like to encourage you to
apply both patches as `SQUASH???` on top of `hn/reftable` for the time
being.

Ciao,
Dscho

>
>
> [References]
>
> *1* https://github.com/git/git/actions/runs/74687673 is 'pu' with
>  all cooking topics.
>
> *2* https://github.com/git/git/actions/runs/74741625 is 'pu' with
>  some topics excluded.
>
>

--8323328-1173611662-1586529256=:46--
