Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6A0C2BBE2
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 14:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440042464E
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 14:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="NKOxVFQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfLFObO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 09:31:14 -0500
Received: from mout.gmx.net ([212.227.15.19]:46731 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfLFObN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 09:31:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575642666;
        bh=G7Bjn5O2vZqv3JIw2IVlGgSA9eW8nuImpLIXfSupi7Q=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NKOxVFQJoKD1P5biuYAYpmixxb7GCppc9HNAlaStJBCow6cLHnyN/hzd2l0hkjBA0
         KFnVyiT3K3BojVdWq8Zo503f7cwAjuSfSVahJp5HDLid8ji0tGWw71lzpfzf/RUMB0
         1NcPlBGzrpbp5i+JCY4fijn1cdJJ52LIsnv3BH6M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDQiS-1iUwd5474o-00AZ5m; Fri, 06
 Dec 2019 15:31:06 +0100
Date:   Fri, 6 Dec 2019 15:30:51 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Alban Gruin <alban.gruin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] rebase -i: extend rebase.missingCommitsCheck
In-Reply-To: <bc1fdd40-0490-eb65-247c-189b16865db5@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1912061529270.31080@tvgsbejvaqbjf.bet>
References: <20191104095449.9964-1-alban.gruin@gmail.com> <20191202234759.26201-1-alban.gruin@gmail.com> <xmqqmuc73gk7.fsf@gitster-ct.c.googlers.com> <580f1a75-be77-8720-b368-e87a70fe8fec@gmail.com> <bc1fdd40-0490-eb65-247c-189b16865db5@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-355704518-1575642667=:31080"
X-Provags-ID: V03:K1:Z7OVyn9J0QzFDQgwENZHBQvk1XN4NmMHlfImY0Ds6daeKwguwJR
 XIJozA1KVt3+//Fn8l6MvwzUlj1woyREr9WX+zpntKCsJBEAQtHbm/1p0VvkYvK0OmY4543
 Z+8uOnYQpFovVsg2x+giY08wxXqxtSye9CZYX10guLF0X2Pzr6DIPPY7weTJUFUFBRdnJiC
 xMhevlsr73k7Karh8DtHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5UdTFJjRa5E=:iXnStWxD85tO0V7u2K4q/x
 2/Q/CstkXpGf69pRidcNUTNl/OzBGBj8GlpYIZivvzvL9olD0IPTtC4ieaeC1YJRA6MJYDndW
 CUbCsWVxIDl4zzLaxAXAID+nxzEp2LO8yjwFAA7XLpHSajSsv7oGJLwXPh9C+/uQGUotMMmzk
 Dza5Vosd3cg3jJPcR3UydztxMTQG7rwsvTFArTeITzj82OXt0BSbw8jX7OiPPNQOUoFxPhJML
 5mVfINkvdII6QDtY+AHcpS0AwdGaejHwaUS7z5QXUQeocC2Plq4StqBTxJ3h66GJpC5PowFDF
 6AkRi81gRvaWrbZJKzccH7egAF+XUx+MDK5jwjlMrIVmwBnCnu8HaxvSIy1JVtCqotemMnSVL
 Uj0Lj2jBdiY7itozYprR9YAGaRI9xiWjY3J1ifn6oH85HMv081f9pa+dABvkElrbn5s0T7x5j
 MT4P8k4srVvYr+rG7uIR9MzsbuF+j0QHVeowxCyElj7GE3yC5RpUssBgpLyeiza9K7bSEPXYo
 vAG7FxKAhK2Y+TGxeYxIqx6e9DkFW4tSdr/m/uqxLsVRDyJWn99zP64qtaUl5p98U6FiQ5nOl
 eC9A3ssNAbipsbKTI+f2rH7v8GEVd7DV8J37dh6Xi//T5B/LX7AAMe8AzVPLoQZnvuX8zvcVU
 h8y3YX0wMucLIiU+er2X7js4qJbiJwEge5NaypTl2V/HnNMrkc7lziC1E6EnlDk1VrGJpztuJ
 8oN17IFKXj09SAvIfFXGxl93iTHYTQ6utXwxo6aEyhoZobDnTG4AUZKORSGBTqpkHrc7n4JuU
 7Uxa7Qrmc2zT4vOlgOGPkRZXTfajyUMzVjahOGdlhzkzoSwe6Ks6UtukrdUq72yHAW+0/JBWR
 QhcC3mvZ/eeW0UowpJ3NuxaXOreb6ukg1KkiEhSR0b+Uqk+dqXkUP4YcoyEXuvTK2qZ6fx0HF
 NYubE2tJXgzo3Ml6VTMgYziz6hqs/TP6kerQDcjTAeaZOCwe/HWF78QIlSrSCH8XexyUzSymg
 GJpwgWmVkopJR6wJGdpcceriYydmglB/p892FynykC7nfZzpEbJSf8B6G+vQwnJCykm4jLhQy
 0JBwB9UPRUHrOuqEfS0I4TPEOLFeEzWutoQE4P6DemusSr/p6FHFZBVoRDC/nrRaeFxggExZv
 Nv5fb1k1IXMYu5a9dodtrFrAXUQ/qiM1Y3aXOVF1WAR2rtSmfaDHTj/DkWlLJQb/B4v8lhe5c
 pk2dbH/2DUm1NH6RoikAPYKZdXzMzlXO2oWm5KCNF4EXhCz/d1VEk1UYbTHI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-355704518-1575642667=:31080
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Alban,

On Fri, 6 Dec 2019, Phillip Wood wrote:

> On 05/12/2019 23:15, Alban Gruin wrote:
> >
> > Le 04/12/2019 =C3=A0 22:51, Junio C Hamano a =C3=A9crit=C2=A0:
> > > Alban Gruin <alban.gruin@gmail.com> writes:
> > >
> > > > To prevent mistakes when editing a branch, rebase features a knob,
> > > > rebase.missingCommitsCheck, to warn the user if a commit was dropp=
ed.
> > > > Unfortunately, this check is only effective for the initial edit, =
which
> > > > means that if you edit the todo list at a later point of the rebas=
e and
> > > > drop a commit, no warnings or errors would be issued.
> > > > ...
> > > >   rebase-interactive.c          | 57 ++++++++++++++++++++----
> > > >   rebase-interactive.h          |  2 +
> > > >   sequencer.c                   | 53 ++++++----------------
> > > >   sequencer.h                   |  1 -
> > > >   t/t3404-rebase-interactive.sh | 83 +++++++++++++++++++++++++++++=
++++++
> > > >   5 files changed, 147 insertions(+), 49 deletions(-)
> > >
> > > This passes the self-test when tested by itself, but when merged
> > > near the tip of 'pu', it breaks t3404.116, it seems.
> > >
> >
> > After a quick investigation, it comes from
> > pw/post-commit-from-sequencer.  Since then, tests are expected to setu=
p
> > the editor and run the commands using it in a subshell.  So the fix is
> > straightforward.
> >
> > Perhaps I should take ag/sequencer-todo-updates, merge
> > pw/post-commit-from-sequencer, rebase this series onto the result, fix
> > the issue, and reroll the series?
>
> If the issue is just using a subshell to set the editor then (assuming y=
ou're
> only adding new tests) I don't think you need to rebase - just change yo=
ur
> tests and it should be fine when Junio merges it into pu. I'm sorry I've=
 not
> looked at the latest version yet, I'll try and get round to it next week=
.

Just squash this in:

=2D- snipsnap --
Subject: [PATCH] fixup??? rebase-interactive: warn if commit is dropped wi=
th
 `rebase --edit-todo'

This is required to appease the interaction with
`pw/post-commit-from-sequencer`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 t/t3404-rebase-interactive.sh | 74 +++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 34 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index e3f64bc2a59..72718d0d839 100755
=2D-- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1453,10 +1453,12 @@ test_expect_success 'rebase -i respects rebase.mis=
singCommitsCheck =3D error' '
 test_expect_success 'rebase --edit-todo respects rebase.missingCommitsChe=
ck =3D ignore' '
 	test_config rebase.missingCommitsCheck ignore &&
 	rebase_setup_and_clean missing-commit &&
-	set_fake_editor &&
-	FAKE_LINES=3D"break 1 2 3 4 5" git rebase -i --root &&
-	FAKE_LINES=3D"1 2 3 4" git rebase --edit-todo 2>actual &&
-	git rebase --continue 2>actual &&
+	(
+		set_fake_editor &&
+		FAKE_LINES=3D"break 1 2 3 4 5" git rebase -i --root &&
+		FAKE_LINES=3D"1 2 3 4" git rebase --edit-todo 2>actual &&
+		git rebase --continue 2>actual
+	) &&
 	test D =3D $(git cat-file commit HEAD | sed -ne \$p) &&
 	test_i18ngrep \
 		"Successfully rebased and updated refs/heads/missing-commit" \
@@ -1474,18 +1476,20 @@ test_expect_success 'rebase --edit-todo respects r=
ebase.missingCommitsCheck =3D wa
 	tail -n4 expect >expect.2 &&
 	test_config rebase.missingCommitsCheck warn &&
 	rebase_setup_and_clean missing-commit &&
-	set_fake_editor &&
-	test_must_fail env FAKE_LINES=3D"bad 1 2 3 4 5" \
-		git rebase -i --root &&
-	cp .git/rebase-merge/git-rebase-todo.backup orig &&
-	FAKE_LINES=3D"2 3 4" git rebase --edit-todo 2>actual.2 &&
-	head -n5 actual.2 >actual &&
-	test_i18ncmp expect actual &&
-	cp orig .git/rebase-merge/git-rebase-todo &&
-	FAKE_LINES=3D"1 2 3 4" git rebase --edit-todo 2>actual.2 &&
-	head -n4 actual.2 >actual &&
-	test_i18ncmp expect.2 actual &&
-	git rebase --continue 2>actual &&
+	(
+		set_fake_editor &&
+		test_must_fail env FAKE_LINES=3D"bad 1 2 3 4 5" \
+			git rebase -i --root &&
+		cp .git/rebase-merge/git-rebase-todo.backup orig &&
+		FAKE_LINES=3D"2 3 4" git rebase --edit-todo 2>actual.2 &&
+		head -n5 actual.2 >actual &&
+		test_i18ncmp expect actual &&
+		cp orig .git/rebase-merge/git-rebase-todo &&
+		FAKE_LINES=3D"1 2 3 4" git rebase --edit-todo 2>actual.2 &&
+		head -n4 actual.2 >actual &&
+		test_i18ncmp expect.2 actual &&
+		git rebase --continue 2>actual
+	) &&
 	test D =3D $(git cat-file commit HEAD | sed -ne \$p) &&
 	test_i18ngrep \
 		"Successfully rebased and updated refs/heads/missing-commit" \
@@ -1509,24 +1513,26 @@ test_expect_success 'rebase --edit-todo respects r=
ebase.missingCommitsCheck =3D er
 	tail -n10 expect >expect.2 &&
 	test_config rebase.missingCommitsCheck error &&
 	rebase_setup_and_clean missing-commit &&
-	set_fake_editor &&
-	test_must_fail env FAKE_LINES=3D"bad 1 2 3 4 5" \
-		git rebase -i --root &&
-	cp .git/rebase-merge/git-rebase-todo.backup orig &&
-	test_must_fail env FAKE_LINES=3D"2 3 4" \
-		git rebase --edit-todo 2>actual &&
-	test_i18ncmp expect actual &&
-	test_must_fail git rebase --continue 2>actual &&
-	test_i18ncmp expect actual &&
-	cp orig .git/rebase-merge/git-rebase-todo &&
-	test_must_fail env FAKE_LINES=3D"1 2 3 4" \
-		git rebase --edit-todo 2>actual &&
-	test_i18ncmp expect.2 actual &&
-	test_must_fail git rebase --continue 2>actual &&
-	test_i18ncmp expect.2 actual &&
-	cp orig .git/rebase-merge/git-rebase-todo &&
-	FAKE_LINES=3D"1 2 3 4 drop 5" git rebase --edit-todo &&
-	git rebase --continue 2>actual &&
+	(
+		set_fake_editor &&
+		test_must_fail env FAKE_LINES=3D"bad 1 2 3 4 5" \
+			git rebase -i --root &&
+		cp .git/rebase-merge/git-rebase-todo.backup orig &&
+		test_must_fail env FAKE_LINES=3D"2 3 4" \
+			git rebase --edit-todo 2>actual &&
+		test_i18ncmp expect actual &&
+		test_must_fail git rebase --continue 2>actual &&
+		test_i18ncmp expect actual &&
+		cp orig .git/rebase-merge/git-rebase-todo &&
+		test_must_fail env FAKE_LINES=3D"1 2 3 4" \
+			git rebase --edit-todo 2>actual &&
+		test_i18ncmp expect.2 actual &&
+		test_must_fail git rebase --continue 2>actual &&
+		test_i18ncmp expect.2 actual &&
+		cp orig .git/rebase-merge/git-rebase-todo &&
+		FAKE_LINES=3D"1 2 3 4 drop 5" git rebase --edit-todo &&
+		git rebase --continue 2>actual
+	) &&
 	test D =3D $(git cat-file commit HEAD | sed -ne \$p) &&
 	test_i18ngrep \
 		"Successfully rebased and updated refs/heads/missing-commit" \
=2D-
2.24.0.windows.2.611.ge9aced84530

--8323328-355704518-1575642667=:31080--
