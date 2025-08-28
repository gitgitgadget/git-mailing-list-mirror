Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3EF3126C3
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 13:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386788; cv=none; b=tcCoSeVqeMYm2LRRqTQ5gj8W0SDgW6OfsXDMEqKS8py1+tcN7dXq5tBSNHbxM6KZqUBZVV+LLQpsacmfjvVWbyhp0/yEdddXpjtESzNRJ+wVdNPx/1vGICMEE8PMVC3YDpn6aZB3Ne5DktZrKIc4YzzCziavp9yqFnCoe8Hlq80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386788; c=relaxed/simple;
	bh=mbVCEhuxBAYsCEkSoPRJndTgBA4xdTAqW2yA4dN/4o4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HNzaaVUXYK00jFMsFT8Gxt611G9rixPLR8Kk29Y3O+DLmIDxkiRt2QUQxv7TT0TD2xUABQXsFugn2cXIP56gyRuhG6VRSl0xN4pV3PBqZvTz6nUHHDhB9pqwXt0MzCDa+xNgL/7jHoEHGLmEGktE4k8GPTds5TSZQ8URLVqJo3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=hCr275iR; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="hCr275iR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1756386779; x=1756991579;
	i=johannes.schindelin@gmx.de;
	bh=E/h2SeL2OeTtvD8CwqOQJM/YJx2OXmvdJcVH/SCBGss=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hCr275iRVn5JSEzrk9ERAf3WOHolgSMYnj9rIl1hQBIDQoEdJWgcpUNmpT5LZbYD
	 eyLaH6vOUJnwCoZse8wMTzElPtMI27WKGfBew0rXx7bjHcS6HvKcCugXknh/8YYk3
	 EA61a5qNm5LNvN0igeQsFFyQSbJCMO7FPXaK2rOUWjfstLjbQqnzZGu7+Of2mJGgW
	 tFkeeBK3SQR7VcjfvpY/Mvla7UBEmk96QWE3Nsfo77vTP0BvYDldTKV+biMZgDKUk
	 SbsdRXQ+fsAi7dlYSVsTCGTh7aAHajQTTseyTJ+ZjFNCV8OPhabxG9CccjaEoLuHu
	 pDBKiKo4wbIeu5Okwg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.26]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYeQr-1uwnDk1i3H-00W4Ol; Thu, 28
 Aug 2025 15:12:59 +0200
Date: Thu, 28 Aug 2025 15:12:57 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Phillip Wood <phillip.wood@dunelm.org.uk>
cc: git@vger.kernel.org, Wing Huang <huangsen365@gmail.com>
Subject: Re: [PATCH 0/6] breaking changes: switch default initial branch name
 to "main"
In-Reply-To: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
Message-ID: <1260e88d-8e04-2d58-a25e-ac312b79e04f@gmx.de>
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:r5IvrRC8a1mOsd6F0aWp945iThFYcBtXTFEm/b5EuR6rxXwhgM1
 nmnAaQu7l2JFRW+4aNBPRstDLZRVkv3VAMNaLzeOzFYSfi7XnzEaKh+wR22X7eSCDXvQujd
 Qw4bbELLF7mOkQmhwkFw0beAhJd8XFydMdMyXJx8/Y1G1emcqySiQGHWMN8A4TCI+8vEG9D
 SDp0PIE83wP0g8tG8ZMVg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EDO42tg9b5o=;Gs43KNWmr8EtghDH5Ru9Zvp2z9L
 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
 Y
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Wed, 27 Aug 2025, Phillip Wood wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>=20
> This series switches the default branch name from "master" to "main"
> when WITH_BREAKING_CHANGES is enabled. We have been warning that the
> default name will change since 675704c74dd (init: provide useful advice
> about init.defaultBranch, 2020-12-11) and the major git forges have all
> switched their default branch name to "main", so I think it makes sense
> to change the default branch name in git to match the wider ecosystem.
>=20
> The first five patches update tests that currently require a default
> branch name different to "main". The sixth patch then changes the
> default branch "main" and removes GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> when WITH_BREAKING_CHANGES is enabled. Patch 2 is quite large but
> is mechanically generated so it should be possible to review it by
> checking that the changes can be reproduced.
>=20
> This is an alternative to changing the branch name now as suggested in
> https://lore.kernel.org<pull.1961.git.1756183921623.gitgitgadget@gmail.c=
om

This link is slightly broken; The unbroken version is
https://lore.kernel.org/git/pull.1961.git.1756183921623.gitgitgadget@gmail=
.com/

Thank you for picking this effort up! I am impressed by your courage in
face of the way this `master -> main` initiative was received and the
amount of leadership that was put behind it.

The changes all look good to me, and while I have my doubts that Git will
follow the laudable leadership demonstrated by the big Git forges in
trying to be a bit more mindful, I will remain eagerly interested in any
progress that can possibly be made here.

Ciao,
Johannes

>=20
> Base-Commit: f814da676ae46aac5be0a98b99373a76dee6cedb
> Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Finiti=
al-branch-is-main%2Fv1
> View-Changes-At: https://github.com/phillipwood/git/compare/f814da676...=
487d1a331
> Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/initial-br=
anch-is-main/v1
>=20
>=20
> Phillip Wood (6):
>   t0018: switch default branch name to main
>   t4013: switch default branch name to main
>   t9902: switch default branch name to main
>   t0613: stop setting default initial branch
>   t1403: remove dependency on GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>   breaking-changes: switch default branch to main
>=20
>  Documentation/BreakingChanges.adoc            |   5 +
>  Documentation/git-init.adoc                   |  12 +-
>  advice.c                                      |   2 +
>  advice.h                                      |   2 +
>  ci/run-build-and-tests.sh                     |   1 -
>  refs.c                                        |  16 +-
>  t/t0001-init.sh                               |   9 +-
>  t/t0018-advice.sh                             |   8 +-
>  t/t0613-reftable-write-options.sh             |  18 +-
>  t/t1403-show-ref.sh                           |   6 +-
>  t/t4013-diff-various.sh                       | 228 +++++++++---------
>  ...ree_--cc_--patch-with-stat_--summary_main} |   2 +-
>  ...iff.diff-tree_--cc_--patch-with-stat_main} |   2 +-
>  ...r =3D> diff.diff-tree_--cc_--shortstat_main} |   2 +-
>  ...diff.diff-tree_--cc_--stat_--summary_main} |   2 +-
>  ...master =3D> diff.diff-tree_--cc_--stat_main} |   2 +-
>  ...e_--cc_master =3D> diff.diff-tree_--cc_main} |   2 +-
>  ...master =3D> diff.diff-tree_-c_--abbrev_main} |   2 +-
>  ...> diff.diff-tree_-c_--stat_--summary_main} |   2 +-
>  ...t_master =3D> diff.diff-tree_-c_--stat_main} |   2 +-
>  ...-tree_-c_master =3D> diff.diff-tree_-c_main} |   2 +-
>  ...-tree_-m_master =3D> diff.diff-tree_-m_main} |   2 +-
>  ...-p_-m_master =3D> diff.diff-tree_-p_-m_main} |   2 +-
>  t/t4013/diff.diff-tree_-p_main                |   2 +
>  t/t4013/diff.diff-tree_-p_master              |   2 -
>  t/t4013/diff.diff-tree_main                   |   2 +
>  t/t4013/diff.diff-tree_master                 |   2 -
>  t/t4013/diff.diff_--dirstat_--cc_main~1_main  |   3 +
>  .../diff.diff_--dirstat_--cc_master~1_master  |   3 -
>  t/t4013/diff.diff_--dirstat_main~1_main~2     |   3 +
>  t/t4013/diff.diff_--dirstat_master~1_master~2 |   3 -
>  ...ff.diff_--line-prefix=3Dabc_main_main^_side} |   2 +-
>  ...master^_side =3D> diff.diff_main_main^_side} |   2 +-
>  ...mat-patch_--attach_--stdout_initial..main} |   2 +-
>  ...at-patch_--attach_--stdout_initial..main^} |   2 +-
>  ...e_--stdout_--numbered-files_initial..main} |   2 +-
>  ...t_--subject-prefix=3DTESTCASE_initial..main} |   2 +-
>  ...mat-patch_--inline_--stdout_initial..main} |   2 +-
>  ...at-patch_--inline_--stdout_initial..main^} |   2 +-
>  ...t-patch_--inline_--stdout_initial..main^^} |   2 +-
>  ...--stdout_--cover-letter_-n_initial..main^} |   2 +-
>  ...atch_--stdout_--no-numbered_initial..main} |   2 +-
>  ...t-patch_--stdout_--numbered_initial..main} |   2 +-
>  ... diff.format-patch_--stdout_initial..main} |   2 +-
>  ...diff.format-patch_--stdout_initial..main^} |   2 +-
>  ..._-m_-p_master =3D> diff.log_--cc_-m_-p_main} |   2 +-
>  t/t4013/diff.log_--decorate=3Dfull_--all        |   2 +-
>  ..._--decorate=3Dfull_--clear-decorations_--all |   2 +-
>  ...f.log_--decorate=3Dfull_--decorate-all_--all |   2 +-
>  t/t4013/diff.log_--decorate_--all             |   2 +-
>  ...f.log_--decorate_--clear-decorations_--all |   2 +-
>  .../diff.log_--decorate_--decorate-all_--all  |   2 +-
>  ... diff.log_--diff-merges=3Dfirst-parent_main} |   2 +-
>  ..._--diff-merges=3Doff_-p_--first-parent_main} |   2 +-
>  ..._--first-parent_--diff-merges=3Doff_-p_main} |   2 +-
>  ...g_--no-diff-merges_-p_--first-parent_main} |   2 +-
>  ..._--patch-with-stat_--summary_main_--_dir_} |   2 +-
>  ...master =3D> diff.log_--patch-with-stat_main} |   2 +-
>  ...> diff.log_--patch-with-stat_main_--_dir_} |   2 +-
>  ...oot_--cc_--patch-with-stat_--summary_main} |   2 +-
>  ...g_--root_--patch-with-stat_--summary_main} |   2 +-
>  ...=3D> diff.log_--root_--patch-with-stat_main} |   2 +-
>  ...-root_-c_--patch-with-stat_--summary_main} |   2 +-
>  ...root_-p_master =3D> diff.log_--root_-p_main} |   2 +-
>  ...log_--root_master =3D> diff.log_--root_main} |   2 +-
>  ...ter =3D> diff.log_-GF_-p_--pickaxe-all_main} |   2 +-
>  ...log_-GF_-p_master =3D> diff.log_-GF_-p_main} |   2 +-
>  ...{diff.log_-SF_master =3D> diff.log_-GF_main} |   2 +-
>  ...aster =3D> diff.log_-IA_-IB_-I1_-I2_-p_main} |   2 +-
>  ...log_-SF_-p_master =3D> diff.log_-SF_-p_main} |   2 +-
>  ...{diff.log_-GF_master =3D> diff.log_-SF_main} |   2 +-
>  t/t4013/diff.log_-SF_main_--max-count=3D0       |   2 +
>  ...ount=3D2 =3D> diff.log_-SF_main_--max-count=3D1} |   2 +-
>  t/t4013/diff.log_-SF_main_--max-count=3D2       |   7 +
>  t/t4013/diff.log_-SF_master_--max-count=3D0     |   2 -
>  t/t4013/diff.log_-SF_master_--max-count=3D1     |   7 -
>  ...iff.log_-S_F_master =3D> diff.log_-S_F_main} |   2 +-
>  ...cc_-m_-p_master =3D> diff.log_-c_-m_-p_main} |   2 +-
>  ...-m_--raw_master =3D> diff.log_-m_--raw_main} |   2 +-
>  ..._--stat_master =3D> diff.log_-m_--stat_main} |   2 +-
>  ...ter =3D> diff.log_-m_-p_--first-parent_main} |   2 +-
>  ...f.log_-m_-p_master =3D> diff.log_-m_-p_main} |   2 +-
>  ...ff.log_-p_--diff-merges=3Dfirst-parent_main} |   2 +-
>  ...master =3D> diff.log_-p_--first-parent_main} |   2 +-
>  .../{diff.log_-p_master =3D> diff.log_-p_main}  |   2 +-
>  t/t4013/{diff.log_master =3D> diff.log_main}    |   2 +-
>  ...iff.noellipses-diff-tree_-c_--abbrev_main} |   2 +-
>  ...> diff.noellipses-whatchanged_--root_main} |   2 +-
>  ...r =3D> diff.noellipses-whatchanged_-SF_main} |   2 +-
>  ...aster =3D> diff.noellipses-whatchanged_main} |   2 +-
>  ...t_master =3D> diff.show_--first-parent_main} |   2 +-
>  ...{diff.show_-c_master =3D> diff.show_-c_main} |   2 +-
>  ...{diff.show_-m_master =3D> diff.show_-m_main} |   2 +-
>  t/t4013/{diff.show_master =3D> diff.show_main}  |   2 +-
>  ..._--patch-with-stat_--summary_main_--_dir_} |   2 +-
>  ...> diff.whatchanged_--patch-with-stat_main} |   2 +-
>  ...hatchanged_--patch-with-stat_main_--_dir_} |   2 +-
>  ...oot_--cc_--patch-with-stat_--summary_main} |   2 +-
>  ...d_--root_--patch-with-stat_--summary_main} |   2 +-
>  ...whatchanged_--root_--patch-with-stat_main} |   2 +-
>  ...-root_-c_--patch-with-stat_--summary_main} |   2 +-
>  ...master =3D> diff.whatchanged_--root_-p_main} |   2 +-
>  ...ot_master =3D> diff.whatchanged_--root_main} |   2 +-
>  ...-p_master =3D> diff.whatchanged_-SF_-p_main} |   2 +-
>  ...d_-SF_master =3D> diff.whatchanged_-SF_main} |   2 +-
>  ...ged_-p_master =3D> diff.whatchanged_-p_main} |   2 +-
>  ...atchanged_master =3D> diff.whatchanged_main} |   2 +-
>  t/t9902-completion.sh                         |   6 +-
>  t/test-lib.sh                                 |  15 +-
>  109 files changed, 281 insertions(+), 253 deletions(-)
>  rename t/t4013/{diff.diff-tree_--cc_--patch-with-stat_--summary_master =
=3D> diff.diff-tree_--cc_--patch-with-stat_--summary_main} (86%)
>  rename t/t4013/{diff.diff-tree_--cc_--patch-with-stat_master =3D> diff.=
diff-tree_--cc_--patch-with-stat_main} (89%)
>  rename t/t4013/{diff.diff-tree_--cc_--shortstat_master =3D> diff.diff-t=
ree_--cc_--shortstat_main} (65%)
>  rename t/t4013/{diff.diff-tree_-c_--stat_--summary_master =3D> diff.dif=
f-tree_--cc_--stat_--summary_main} (71%)
>  rename t/t4013/{diff.diff-tree_-c_--stat_master =3D> diff.diff-tree_--c=
c_--stat_main} (76%)
>  rename t/t4013/{diff.diff-tree_--cc_master =3D> diff.diff-tree_--cc_mai=
n} (91%)
>  rename t/t4013/{diff.diff-tree_-c_--abbrev_master =3D> diff.diff-tree_-=
c_--abbrev_main} (83%)
>  rename t/t4013/{diff.diff-tree_--cc_--stat_--summary_master =3D> diff.d=
iff-tree_-c_--stat_--summary_main} (70%)
>  rename t/t4013/{diff.diff-tree_--cc_--stat_master =3D> diff.diff-tree_-=
c_--stat_main} (75%)
>  rename t/t4013/{diff.diff-tree_-c_master =3D> diff.diff-tree_-c_main} (=
93%)
>  rename t/t4013/{diff.diff-tree_-m_master =3D> diff.diff-tree_-m_main} (=
96%)
>  rename t/t4013/{diff.diff-tree_-p_-m_master =3D> diff.diff-tree_-p_-m_m=
ain} (97%)
>  create mode 100644 t/t4013/diff.diff-tree_-p_main
>  delete mode 100644 t/t4013/diff.diff-tree_-p_master
>  create mode 100644 t/t4013/diff.diff-tree_main
>  delete mode 100644 t/t4013/diff.diff-tree_master
>  create mode 100644 t/t4013/diff.diff_--dirstat_--cc_main~1_main
>  delete mode 100644 t/t4013/diff.diff_--dirstat_--cc_master~1_master
>  create mode 100644 t/t4013/diff.diff_--dirstat_main~1_main~2
>  delete mode 100644 t/t4013/diff.diff_--dirstat_master~1_master~2
>  rename t/t4013/{diff.diff_--line-prefix=3Dabc_master_master^_side =3D> =
diff.diff_--line-prefix=3Dabc_main_main^_side} (87%)
>  rename t/t4013/{diff.diff_master_master^_side =3D> diff.diff_main_main^=
_side} (89%)
>  rename t/t4013/{diff.format-patch_--attach_--stdout_initial..master =3D=
> diff.format-patch_--attach_--stdout_initial..main} (98%)
>  rename t/t4013/{diff.format-patch_--attach_--stdout_initial..master^ =
=3D> diff.format-patch_--attach_--stdout_initial..main^} (97%)
>  rename t/t4013/{diff.format-patch_--inline_--stdout_--numbered-files_in=
itial..master =3D> diff.format-patch_--inline_--stdout_--numbered-files_in=
itial..main} (99%)
>  rename t/t4013/{diff.format-patch_--inline_--stdout_--subject-prefix=3D=
TESTCASE_initial..master =3D> diff.format-patch_--inline_--stdout_--subjec=
t-prefix=3DTESTCASE_initial..main} (99%)
>  rename t/t4013/{diff.format-patch_--inline_--stdout_initial..master =3D=
> diff.format-patch_--inline_--stdout_initial..main} (98%)
>  rename t/t4013/{diff.format-patch_--inline_--stdout_initial..master^ =
=3D> diff.format-patch_--inline_--stdout_initial..main^} (97%)
>  rename t/t4013/{diff.format-patch_--inline_--stdout_initial..master^^ =
=3D> diff.format-patch_--inline_--stdout_initial..main^^} (95%)
>  rename t/t4013/{diff.format-patch_--stdout_--cover-letter_-n_initial..m=
aster^ =3D> diff.format-patch_--stdout_--cover-letter_-n_initial..main^} (=
96%)
>  rename t/t4013/{diff.format-patch_--stdout_--no-numbered_initial..maste=
r =3D> diff.format-patch_--stdout_--no-numbered_initial..main} (97%)
>  rename t/t4013/{diff.format-patch_--stdout_--numbered_initial..master =
=3D> diff.format-patch_--stdout_--numbered_initial..main} (97%)
>  rename t/t4013/{diff.format-patch_--stdout_initial..master =3D> diff.fo=
rmat-patch_--stdout_initial..main} (97%)
>  rename t/t4013/{diff.format-patch_--stdout_initial..master^ =3D> diff.f=
ormat-patch_--stdout_initial..main^} (96%)
>  rename t/t4013/{diff.log_-c_-m_-p_master =3D> diff.log_--cc_-m_-p_main}=
 (99%)
>  rename t/t4013/{diff.log_--diff-merges=3Dfirst-parent_master =3D> diff.=
log_--diff-merges=3Dfirst-parent_main} (95%)
>  rename t/t4013/{diff.log_--no-diff-merges_-p_--first-parent_master =3D>=
 diff.log_--diff-merges=3Doff_-p_--first-parent_main} (95%)
>  rename t/t4013/{diff.log_--first-parent_--diff-merges=3Doff_-p_master =
=3D> diff.log_--first-parent_--diff-merges=3Doff_-p_main} (95%)
>  rename t/t4013/{diff.log_--diff-merges=3Doff_-p_--first-parent_master =
=3D> diff.log_--no-diff-merges_-p_--first-parent_main} (95%)
>  rename t/t4013/{diff.log_--patch-with-stat_--summary_master_--_dir_ =3D=
> diff.log_--patch-with-stat_--summary_main_--_dir_} (96%)
>  rename t/t4013/{diff.log_--patch-with-stat_master =3D> diff.log_--patch=
-with-stat_main} (98%)
>  rename t/t4013/{diff.log_--patch-with-stat_master_--_dir_ =3D> diff.log=
_--patch-with-stat_main_--_dir_} (96%)
>  rename t/t4013/{diff.log_--root_--cc_--patch-with-stat_--summary_master=
 =3D> diff.log_--root_--cc_--patch-with-stat_--summary_main} (98%)
>  rename t/t4013/{diff.log_--root_--patch-with-stat_--summary_master =3D>=
 diff.log_--root_--patch-with-stat_--summary_main} (98%)
>  rename t/t4013/{diff.log_--root_--patch-with-stat_master =3D> diff.log_=
=2D-root_--patch-with-stat_main} (98%)
>  rename t/t4013/{diff.log_--root_-c_--patch-with-stat_--summary_master =
=3D> diff.log_--root_-c_--patch-with-stat_--summary_main} (98%)
>  rename t/t4013/{diff.log_--root_-p_master =3D> diff.log_--root_-p_main}=
 (98%)
>  rename t/t4013/{diff.log_--root_master =3D> diff.log_--root_main} (96%)
>  rename t/t4013/{diff.log_-GF_-p_--pickaxe-all_master =3D> diff.log_-GF_=
-p_--pickaxe-all_main} (90%)
>  rename t/t4013/{diff.log_-GF_-p_master =3D> diff.log_-GF_-p_main} (91%)
>  rename t/t4013/{diff.log_-SF_master =3D> diff.log_-GF_main} (86%)
>  rename t/t4013/{diff.log_-IA_-IB_-I1_-I2_-p_master =3D> diff.log_-IA_-I=
B_-I1_-I2_-p_main} (97%)
>  rename t/t4013/{diff.log_-SF_-p_master =3D> diff.log_-SF_-p_main} (91%)
>  rename t/t4013/{diff.log_-GF_master =3D> diff.log_-SF_main} (86%)
>  create mode 100644 t/t4013/diff.log_-SF_main_--max-count=3D0
>  rename t/t4013/{diff.log_-SF_master_--max-count=3D2 =3D> diff.log_-SF_m=
ain_--max-count=3D1} (79%)
>  create mode 100644 t/t4013/diff.log_-SF_main_--max-count=3D2
>  delete mode 100644 t/t4013/diff.log_-SF_master_--max-count=3D0
>  delete mode 100644 t/t4013/diff.log_-SF_master_--max-count=3D1
>  rename t/t4013/{diff.log_-S_F_master =3D> diff.log_-S_F_main} (86%)
>  rename t/t4013/{diff.log_--cc_-m_-p_master =3D> diff.log_-c_-m_-p_main}=
 (99%)
>  rename t/t4013/{diff.log_-m_--raw_master =3D> diff.log_-m_--raw_main} (=
98%)
>  rename t/t4013/{diff.log_-m_--stat_master =3D> diff.log_-m_--stat_main}=
 (98%)
>  rename t/t4013/{diff.log_-m_-p_--first-parent_master =3D> diff.log_-m_-=
p_--first-parent_main} (97%)
>  rename t/t4013/{diff.log_-m_-p_master =3D> diff.log_-m_-p_main} (99%)
>  rename t/t4013/{diff.log_-p_--diff-merges=3Dfirst-parent_master =3D> di=
ff.log_-p_--diff-merges=3Dfirst-parent_main} (97%)
>  rename t/t4013/{diff.log_-p_--first-parent_master =3D> diff.log_-p_--fi=
rst-parent_main} (97%)
>  rename t/t4013/{diff.log_-p_master =3D> diff.log_-p_main} (98%)
>  rename t/t4013/{diff.log_master =3D> diff.log_main} (97%)
>  rename t/t4013/{diff.noellipses-diff-tree_-c_--abbrev_master =3D> diff.=
noellipses-diff-tree_-c_--abbrev_main} (81%)
>  rename t/t4013/{diff.noellipses-whatchanged_--root_master =3D> diff.noe=
llipses-whatchanged_--root_main} (96%)
>  rename t/t4013/{diff.noellipses-whatchanged_-SF_master =3D> diff.noelli=
pses-whatchanged_-SF_main} (86%)
>  rename t/t4013/{diff.noellipses-whatchanged_master =3D> diff.noellipses=
-whatchanged_main} (96%)
>  rename t/t4013/{diff.show_--first-parent_master =3D> diff.show_--first-=
parent_main} (92%)
>  rename t/t4013/{diff.show_-c_master =3D> diff.show_-c_main} (95%)
>  rename t/t4013/{diff.show_-m_master =3D> diff.show_-m_main} (98%)
>  rename t/t4013/{diff.show_master =3D> diff.show_main} (96%)
>  rename t/t4013/{diff.whatchanged_--patch-with-stat_--summary_master_--_=
dir_ =3D> diff.whatchanged_--patch-with-stat_--summary_main_--_dir_} (94%)
>  rename t/t4013/{diff.whatchanged_--patch-with-stat_master =3D> diff.wha=
tchanged_--patch-with-stat_main} (97%)
>  rename t/t4013/{diff.whatchanged_--patch-with-stat_master_--_dir_ =3D> =
diff.whatchanged_--patch-with-stat_main_--_dir_} (94%)
>  rename t/t4013/{diff.whatchanged_--root_--cc_--patch-with-stat_--summar=
y_master =3D> diff.whatchanged_--root_--cc_--patch-with-stat_--summary_mai=
n} (97%)
>  rename t/t4013/{diff.whatchanged_--root_--patch-with-stat_--summary_mas=
ter =3D> diff.whatchanged_--root_--patch-with-stat_--summary_main} (97%)
>  rename t/t4013/{diff.whatchanged_--root_--patch-with-stat_master =3D> d=
iff.whatchanged_--root_--patch-with-stat_main} (97%)
>  rename t/t4013/{diff.whatchanged_--root_-c_--patch-with-stat_--summary_=
master =3D> diff.whatchanged_--root_-c_--patch-with-stat_--summary_main} (=
97%)
>  rename t/t4013/{diff.whatchanged_--root_-p_master =3D> diff.whatchanged=
_--root_-p_main} (98%)
>  rename t/t4013/{diff.whatchanged_--root_master =3D> diff.whatchanged_--=
root_main} (97%)
>  rename t/t4013/{diff.whatchanged_-SF_-p_master =3D> diff.whatchanged_-S=
F_-p_main} (89%)
>  rename t/t4013/{diff.whatchanged_-SF_master =3D> diff.whatchanged_-SF_m=
ain} (86%)
>  rename t/t4013/{diff.whatchanged_-p_master =3D> diff.whatchanged_-p_mai=
n} (98%)
>  rename t/t4013/{diff.whatchanged_master =3D> diff.whatchanged_main} (97=
%)
>=20
> --=20
> 2.49.0.897.gfad3eb7d210
>=20
>=20
>=20
