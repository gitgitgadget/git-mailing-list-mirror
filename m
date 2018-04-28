Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 891CE1F428
	for <e@80x24.org>; Sat, 28 Apr 2018 22:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751974AbeD1WsF (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 18:48:05 -0400
Received: from mout.gmx.net ([212.227.17.20]:40145 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751310AbeD1WsE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 18:48:04 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lmvlg-1eihWT22NI-00h58i; Sun, 29
 Apr 2018 00:47:49 +0200
Date:   Sun, 29 Apr 2018 00:47:30 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [Re-send PATCH v7 00/12] Deprecate .git/info/grafts
In-Reply-To: <cover.1524865158.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1524955439.git.johannes.schindelin@gmx.de>
References: <cover.1524865158.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-495327507-1524955669=:79"
X-Provags-ID: V03:K1:4Q5okOT07HPAJd+21UykwD+cbQox3RPCP04wJIt6cbjU9aPKQwH
 ACNzUU4iGiXtF7TDYl0GUDt420LMtdkDxphTE4Q67fovs8j7L1C2MPVhBXFlyDRay3PBp2M
 xwxyK54vCaEvNGGXe/KYv1qwLAA2E1CCqBXwYG/Ng058o6NQzLfcoCXZrHUEbeedQb3VZom
 25b2bPk+ZXMUBpI1ocTKQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Vatbffi8Yo4=:vrbKEX1QlgH888vIjuVyB/
 L1x7DGSkC5y5qk1rOvUXUuSeWX5V+CQhVSO8tnPxpv72gqxnad18mrjAUossBVFNIZqSrAg1r
 AoNbFFvXkb6KUEWRQb9rJrGNnC/yM6IW23MzBQl9gsAM3uF1UxqQ7i2gDFcdUg2TVFa7vlih4
 UL806kPGc0lrTnDC8rUGWJ+aulsssKZH+/xk29geiV1vwhS1DDUf11uBREvwqNOMdnIZyX5kQ
 hKQ6btkh92LJZxhs3G+jc+i6k6jJuHnh9jMeaXOgQOMnATn0l7/KWUPpyR4/CmlunRbWkyX8k
 qVagyoEbGSqVsFtbuCHcKhcetsZCWZ15nc+QbdggudG7dCMlj6KDIHv6jHY8wVj5acHTZGZQP
 pNUge/o2nW4gbBunFoy+TvCUjogTlPffcG9r9p44jWfNxU4qqqy3yajZ7OBBR8/P9ZRmuDZST
 cFsMUYNveKvLChXoC1H8yMzXJOh48RWMcHFg0/qYGe+o0OluJA72ZmGs61UCHUdYhZqWnYp/U
 PhRgGXUiqkSg2PVjAH5QbjcX+pTlVQrTs69bVXaE9vRPP1rDsc1QK4SFRbt5Lj1NF9ED6KEGW
 8XQfRtJDN7000i67MWexZyDELSrGes/KQL9PMn7OnWrqjFWXD3KV5KzrDqSIBvLRcdMrll6uw
 zLqRSt/Hz6J55jGt9Xqyh+c4/WzHOkpiuPlSiA1NfPcAeuA84aUVHxeLHspo/S/5FFO5UaJKs
 yXhHjSwoT9AfVSPf8gxJT178Kxeaym+o4oGflnlc+xYHmK3TAEceXNkRL7lecFEoacsO085E7
 nhO0Dok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-495327507-1524955669=:79
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

[Resent the cover letter, as I did not see it on public-inbox...]

It is fragile, as there is no way for the revision machinery to say "but
now I want to traverse the graph ignoring the graft file" e.g. when
pushing commits to a remote repository (which, as a consequence, can
miss commits).

And we already have a better solution with `git replace --graft <comit>
[<parent>...]`.

Changes since v6:

- Made --convert-graft-file issue a mere warning (instead of an error) when
  a graft leaves the parents unchanged, and is hence unnecessary.

- Modified the regression test for --convert-graft-file to succeed even whe=
n
  the GPG prerequisite is unmet (thanks, G=C3=A1bor!).

- Reassured by Stefan's feedback, I refrained from reinstating the contrib/
  script.


Johannes Schindelin (12):
  argv_array: offer to split a string by whitespace
  commit: Let the callback of for_each_mergetag return on error
  replace: avoid using die() to indicate a bug
  replace: "libify" create_graft() and callees
  replace: prepare create_graft() for converting graft files wholesale
  replace: introduce --convert-graft-file
  Add a test for `git replace --convert-graft-file`
  Deprecate support for .git/info/grafts
  filter-branch: stop suggesting to use grafts
  technical/shallow: stop referring to grafts
  technical/shallow: describe why shallow cannot use replace refs
  Remove obsolete script to convert grafts to replace refs

 Documentation/git-filter-branch.txt       |   2 +-
 Documentation/git-replace.txt             |  11 +-
 Documentation/technical/shallow.txt       |  20 +-
 advice.c                                  |   2 +
 advice.h                                  |   1 +
 argv-array.c                              |  20 ++
 argv-array.h                              |   2 +
 builtin/replace.c                         | 234 ++++++++++++++++------
 commit.c                                  |  18 +-
 commit.h                                  |   4 +-
 contrib/convert-grafts-to-replace-refs.sh |  28 ---
 log-tree.c                                |  13 +-
 t/t6001-rev-list-graft.sh                 |   9 +
 t/t6050-replace.sh                        |  28 +++
 14 files changed, 274 insertions(+), 118 deletions(-)
 delete mode 100755 contrib/convert-grafts-to-replace-refs.sh


base-commit: 1f1cddd558b54bb0ce19c8ace353fd07b758510d
Published-As: https://github.com/dscho/git/releases/tag/deprecate-grafts-v7
Fetch-It-Via: git fetch https://github.com/dscho/git deprecate-grafts-v7

Interdiff vs v6:
 diff --git a/builtin/replace.c b/builtin/replace.c
 index 35394ec1874..a87fca045be 100644
 --- a/builtin/replace.c
 +++ b/builtin/replace.c
 @@ -429,7 +429,7 @@ static int check_mergetags(struct commit *commit, int =
argc, const char **argv)
  =09return for_each_mergetag(check_one_mergetag, commit, &mergetag_data);
  }
 =20
 -static int create_graft(int argc, const char **argv, int force)
 +static int create_graft(int argc, const char **argv, int force, int gentl=
e)
  {
  =09struct object_id old_oid, new_oid;
  =09const char *old_ref =3D argv[0];
 @@ -471,8 +471,13 @@ static int create_graft(int argc, const char **argv, =
int force)
 =20
  =09strbuf_release(&buf);
 =20
 -=09if (!oidcmp(&old_oid, &new_oid))
 +=09if (!oidcmp(&old_oid, &new_oid)) {
 +=09=09if (gentle) {
 +=09=09=09warning("graft for '%s' unnecessary", oid_to_hex(&old_oid));
 +=09=09=09return 0;
 +=09=09}
  =09=09return error("new commit is the same as the old one: '%s'", oid_to_=
hex(&old_oid));
 +=09}
 =20
  =09return replace_object_oid(old_ref, &old_oid, "replacement", &new_oid, =
force);
  }
 @@ -492,7 +497,7 @@ static int convert_graft_file(int force)
  =09=09=09continue;
 =20
  =09=09argv_array_split(&args, buf.buf);
 -=09=09if (args.argc && create_graft(args.argc, args.argv, force))
 +=09=09if (args.argc && create_graft(args.argc, args.argv, force, 1))
  =09=09=09strbuf_addf(&err, "\n\t%s", buf.buf);
  =09=09argv_array_clear(&args);
  =09}
 @@ -583,7 +588,7 @@ int cmd_replace(int argc, const char **argv, const cha=
r *prefix)
  =09=09if (argc < 1)
  =09=09=09usage_msg_opt("-g needs at least one argument",
  =09=09=09=09      git_replace_usage, options);
 -=09=09return create_graft(argc, argv, force);
 +=09=09return create_graft(argc, argv, force, 0);
 =20
  =09case MODE_CONVERT_GRAFT_FILE:
  =09=09if (argc !=3D 0)
 diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
 index bed86a0af3d..d174bfed309 100755
 --- a/t/t6050-replace.sh
 +++ b/t/t6050-replace.sh
 @@ -445,6 +445,14 @@ test_expect_success GPG '--graft on a commit with a m=
ergetag' '
  '
 =20
  test_expect_success '--convert-graft-file' '
 +=09git checkout -b with-graft-file &&
 +=09test_commit root2 &&
 +=09git reset --hard root2^ &&
 +=09test_commit root1 &&
 +=09test_commit after-root1 &&
 +=09test_tick &&
 +=09git merge -m merge-root2 root2 &&
 +
  =09: add and convert graft file &&
  =09printf "%s\n%s %s\n\n# comment\n%s\n" \
  =09=09$(git rev-parse HEAD^^ HEAD^ HEAD^^ HEAD^2) \
--=20
2.17.0.windows.1.36.gdf4ca5fb72a

--8323328-495327507-1524955669=:79--
