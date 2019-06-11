Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4819E1F462
	for <e@80x24.org>; Tue, 11 Jun 2019 18:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391200AbfFKS2j (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 14:28:39 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:48615 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389490AbfFKS2j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 14:28:39 -0400
Received: by mail-pg1-f202.google.com with SMTP id z10so9633084pgf.15
        for <git@vger.kernel.org>; Tue, 11 Jun 2019 11:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=LrrwU62hMAiKQYl05rD5OIdYsUu1Aoidw2ckevrJiu8=;
        b=fhp9OQMnylQDbHnp2h95dnv5hWLdYfoVRU2ii08O6EipaO6H+ztShzWdyUTD0XYmVP
         mpZJmP8h89GmBnfo93JGPxbKYxESg7vKztRy11qUNAX7UpxIJDMMGNvR5rPbLYc97pB5
         TDkVUH1KnZiXYWXOvP4IKLxCxQr2wI1xzVcxXb2oE1AaayqncC4niIaESkZBV8nr6MVu
         ROm+ad0D37gXz97QpRAwXZDwR1sJCIA+rztea0QigsFU1POtXQG6kloSJgs8hFTDjzer
         YrhK0MJ1Egp/ueZC4pymN0X1uOcgpLfrGe/r/Lnii/qgPn1a/q5ce9/yE0vCNPzvfjRY
         4sIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=LrrwU62hMAiKQYl05rD5OIdYsUu1Aoidw2ckevrJiu8=;
        b=GNN1aogxhv8A2VAOKpvKy6HRMrvMPtGJVNLVvXSFrGTCenRzwFmgJWZTuk1f2xfazE
         rt8hoO24Ik4ofxfsIUMvQgGrQt15xw8/f5xf6wqeZYTbf48D/CpqrfR2gtuynZW4TYtQ
         Tlk8RcuW9YJ02O21Hc/2wK9ztKL7fZuuWtyHD/zVB4yRx+acKAfrnS59QglCKkUA2NJ1
         vBK0Oi9c8pax2k+t88x+LTD4HycbzcdB2Oym/UiJLYyu5+Omn8LUBYm84s6flVaQeMt+
         H/HkDTtjKPkxOLJAA0/J9IAlTB01RWRLNtUTnLkQjr1QqJ7YMcGykBcTKApZYkHdZ/Qe
         xO9Q==
X-Gm-Message-State: APjAAAXiULZbs0LXlYFvoozMAfy9+mXdNtQfFQsCAqCTEUQQMKWhObxq
        OvDNIXxdCEUSjQUAz6zjCcHADZvKp6ERle/i8Hh2pNLGlpkLPD44mLqECVbKCK4Ve7FEAa8gci1
        fgGtePWnFyFuFNTzXwTzwYINcAodPUaXWdRVU0M9p/qcaKGTGB+xnjqK5utc=
X-Google-Smtp-Source: APXvYqwryQbdbJrpkgnQ+/zyi0KSuEmx5ac0I4vZ57YY6KVLvFvUcO0D8kMy7H1w7ryltGk1EUiqG5FSoWnE
X-Received: by 2002:a63:4001:: with SMTP id n1mr20403665pga.382.1560277717997;
 Tue, 11 Jun 2019 11:28:37 -0700 (PDT)
Date:   Tue, 11 Jun 2019 11:28:18 -0700
In-Reply-To: <cover.1560277373.git.matvore@google.com>
Message-Id: <cf0246a5cce6cbd9b4a1fd1eefa0f5cbc2cfcaf0.1560277373.git.matvore@google.com>
Mime-Version: 1.0
References: <faaa9a3d6ba66d77cc2a8eab438d1bfc8f762fa1.1559857032.git.matvore@google.com>
 <cover.1560277373.git.matvore@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v2 1/1] ref-filter: sort detached HEAD lines firstly
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, avarab@gmail.com,
        git@matthieu-moy.fr, olyatelezhnaya@gmail.com,
        samuel.maftoul@gmail.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, karthik.188@gmail.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        emilyshaffer@google.com, jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before this patch, "git branch" would put "(HEAD detached...)" and "(no
branch, rebasing...)" lines before all the other branches *in most
cases* and only because of the fact that "(" is a low codepoint. This
would not hold in the Chinese locale, which uses a full-width "(" symbol
(codepoint FF08). This meant that the detached HEAD line would appear
after all local refs and even after the remote refs if there were any.

Deliberately sort the detached HEAD refs before other refs when sorting
by refname rather than rely on codepoint subtleties.

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Matthew DeVore <matvore@google.com>
---
 ref-filter.c           | 20 ++++++++++++++++----
 t/lib-gettext.sh       | 22 +++++++++++++++++++---
 t/t3207-branch-intl.sh | 41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 7 deletions(-)
 create mode 100755 t/t3207-branch-intl.sh

diff --git a/ref-filter.c b/ref-filter.c
index 8500671bc6..056d21d666 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2157,25 +2157,37 @@ static int cmp_ref_sorting(struct ref_sorting *s, s=
truct ref_array_item *a, stru
 	cmp_type cmp_type =3D used_atom[s->atom].type;
 	int (*cmp_fn)(const char *, const char *);
 	struct strbuf err =3D STRBUF_INIT;
=20
 	if (get_ref_atom_value(a, s->atom, &va, &err))
 		die("%s", err.buf);
 	if (get_ref_atom_value(b, s->atom, &vb, &err))
 		die("%s", err.buf);
 	strbuf_release(&err);
 	cmp_fn =3D s->ignore_case ? strcasecmp : strcmp;
-	if (s->version)
+	if (s->version) {
 		cmp =3D versioncmp(va->s, vb->s);
-	else if (cmp_type =3D=3D FIELD_STR)
-		cmp =3D cmp_fn(va->s, vb->s);
-	else {
+	} else if (cmp_type =3D=3D FIELD_STR) {
+		const int a_detached =3D a->kind & FILTER_REFS_DETACHED_HEAD;
+
+		/*
+		 * When sorting by name, we should put "detached" head lines,
+		 * which are all the lines in parenthesis, before all others.
+		 * This usually is automatic, since "(" is before "refs/" and
+		 * "remotes/", but this does not hold for zh_CN, which uses
+		 * full-width parenthesis, so make the ordering explicit.
+		 */
+		if (a_detached !=3D (b->kind & FILTER_REFS_DETACHED_HEAD))
+			cmp =3D a_detached ? -1 : 1;
+		else
+			cmp =3D cmp_fn(va->s, vb->s);
+	} else {
 		if (va->value < vb->value)
 			cmp =3D -1;
 		else if (va->value =3D=3D vb->value)
 			cmp =3D cmp_fn(a->refname, b->refname);
 		else
 			cmp =3D 1;
 	}
=20
 	return (s->reverse) ? -cmp : cmp;
 }
diff --git a/t/lib-gettext.sh b/t/lib-gettext.sh
index 2139b427ca..1adf1d4c31 100644
--- a/t/lib-gettext.sh
+++ b/t/lib-gettext.sh
@@ -25,23 +25,29 @@ then
 		p
 		q
 	}')
 	# is_IS.ISO8859-1 on Solaris and FreeBSD, is_IS.iso88591 on Debian
 	is_IS_iso_locale=3D$(locale -a 2>/dev/null |
 		sed -n '/^is_IS\.[iI][sS][oO]8859-*1$/{
 		p
 		q
 	}')
=20
-	# Export them as an environment variable so the t0202/test.pl Perl
-	# test can use it too
-	export is_IS_locale is_IS_iso_locale
+	zh_CN_locale=3D$(locale -a 2>/dev/null |
+		sed -n '/^zh_CN\.[uU][tT][fF]-*8$/{
+		p
+		q
+	}')
+
+	# Export them as environment variables so other tests can use them
+	# too
+	export is_IS_locale is_IS_iso_locale zh_CN_locale
=20
 	if test -n "$is_IS_locale" &&
 		test $GIT_INTERNAL_GETTEXT_SH_SCHEME !=3D "fallthrough"
 	then
 		# Some of the tests need the reference Icelandic locale
 		test_set_prereq GETTEXT_LOCALE
=20
 		# Exporting for t0202/test.pl
 		GETTEXT_LOCALE=3D1
 		export GETTEXT_LOCALE
@@ -53,11 +59,21 @@ then
 	if test -n "$is_IS_iso_locale" &&
 		test $GIT_INTERNAL_GETTEXT_SH_SCHEME !=3D "fallthrough"
 	then
 		# Some of the tests need the reference Icelandic locale
 		test_set_prereq GETTEXT_ISO_LOCALE
=20
 		say "# lib-gettext: Found '$is_IS_iso_locale' as an is_IS ISO-8859-1 loc=
ale"
 	else
 		say "# lib-gettext: No is_IS ISO-8859-1 locale available"
 	fi
+
+	if test -n "$zh_CN_locale" &&
+		test $GIT_INTERNAL_GETTEXT_SH_SCHEME !=3D "fallthrough"
+	then
+		test_set_prereq GETTEXT_ZH_LOCALE
+
+		say "# lib-gettext: Found '$zh_CN_locale' as a zh_CN UTF-8 locale"
+	else
+		say "# lib-gettext: No zh_CN UTF-8 locale available"
+	fi
 fi
diff --git a/t/t3207-branch-intl.sh b/t/t3207-branch-intl.sh
new file mode 100755
index 0000000000..a46538188c
--- /dev/null
+++ b/t/t3207-branch-intl.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+
+test_description=3D'git branch internationalization tests'
+
+. ./lib-gettext.sh
+
+test_expect_success 'init repo' '
+	git init r1 &&
+	test_commit -C r1 first
+'
+
+test_expect_success GETTEXT_ZH_LOCALE 'detached head sorts before branches=
' '
+	# Ref sorting logic should put detached heads before the other
+	# branches, but this is not automatic when a branch name sorts
+	# lexically before "(" or the full-width "(" (Unicode codepoint FF08).
+	# The latter case is nearly guaranteed for the Chinese locale.
+
+	test_when_finished "git -C r1 checkout master" &&
+
+	git -C r1 checkout HEAD^{} -- &&
+	LC_ALL=3D$zh_CN_locale LC_MESSAGES=3D$zh_CN_locale \
+		git -C r1 branch >actual &&
+
+	head -n 1 actual >first &&
+	# The first line should be enclosed by full-width parenthesis.
+	grep "=EF=BC=88.*=EF=BC=89" first &&
+	grep master actual
+'
+
+test_expect_success 'detached head honors reverse sorting' '
+	test_when_finished "git -C r1 checkout master" &&
+
+	git -C r1 checkout HEAD^{} -- &&
+	git -C r1 branch --sort=3D-refname >actual &&
+
+	head -n 1 actual >first &&
+	grep master first &&
+	test_i18ngrep "HEAD detached" actual
+'
+
+test_done
--=20
2.21.0

