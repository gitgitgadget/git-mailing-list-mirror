From: Caleb Thompson <caleb@calebthompson.io>
Subject: Re: [PATCH v4 4/4] commit: support commit.verbose and --no-verbose
Date: Thu, 12 Jun 2014 09:36:10 -0500
Message-ID: <20140612143610.GA38048@sirius.local>
References: <1402511079-17735-1-git-send-email-caleb@calebthompson.io>
 <1402511079-17735-5-git-send-email-caleb@calebthompson.io>
 <5398BEDE.1040305@web.de>
 <20140611212247.GB30119@sirius.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jeremiah Mahler <jmmahler@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Kastrup <dak@gnu.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 16:36:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv676-0005XB-7R
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 16:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933435AbaFLOgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 10:36:19 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:33611 "EHLO
	new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933399AbaFLOgQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jun 2014 10:36:16 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 95E1B641;
	Thu, 12 Jun 2014 10:36:11 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Thu, 12 Jun 2014 10:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=calebthompson.io;
	 h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=mesmtp; bh=2+HSQ9Z/8iMyNgBeieJhchE7
	XyM=; b=RqhxTjmCrXCgRi9C2KB9zxBW+FAZyHPXV7LU51ET7cPWz82fJsyIMBMo
	d0sdYgrZ85408lBtH5nuEt4xVbAMoVfLsECXE0ZNElp0XS8fnJ9FtVgS15AYS6Wk
	T37APNd4lb5mFb4H5NefQuMRQ1qjjZbLVaInNqkgjfz8G1FLIuU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=smtpout;
	 bh=2+HSQ9Z/8iMyNgBeieJhchE7XyM=; b=eY9Cvshr51nUIt/G0VlY/fwtPNVT
	VpdHHk2tEadvaUbsCejKp3G5N4ZuX2UiVurz5jKnfBf/2OJFJWsV+Ej4YVMBAE3j
	3BRyMGDCVt+K6aKNR2toX0nCjinaxrV8VO9JGJ8YJ/4vsA/l+DgiQA631ri2/9x4
	d65iMes2qgoYc08=
X-Sasl-enc: h49vLcyXwm+Xd07hrX0tC4+bVjXtiKTDEy2sUSwPItRP 1402583770
Received: from localhost (unknown [67.78.97.126])
	by mail.messagingengine.com (Postfix) with ESMTPA id CD255680156;
	Thu, 12 Jun 2014 10:36:10 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20140611212247.GB30119@sirius.local>
X-PGP-Key: fp="B432 C068 2FD1 C2D0 6A8B 3951 1621 ADC2 A0AC E70A";
 id="0xA0ACE70A"; get=<http://calebthompson.io/pubkey.asc>;
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251408>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Another update to also use quotes around the check-for-no-diff script body.

If I don't get any more feedback in the next few hours I'll send another full
version of the patch.

Caleb Thompson

------------------------ >8 ------------------------

Add a new configuration variable commit.verbose to implicitly pass
`--verbose` to `git-commit`. Add `--no-verbose` to commit to negate that
setting.

Signed-off-by: Caleb Thompson <caleb@calebthompson.io>
---
 Documentation/config.txt               |  5 +++++
 Documentation/git-commit.txt           |  8 +++++++-
 builtin/commit.c                       |  4 ++++
 contrib/completion/git-completion.bash |  1 +
 t/t7507-commit-verbose.sh              | 36 ++++++++++++++++++++++++++++++++++
 5 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index cd2d651..ec51e1c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1017,6 +1017,11 @@ commit.template::
  "`~/`" is expanded to the value of `$HOME` and "`~user/`" to the
  specified user's home directory.

+commit.verbose::
+ A boolean to enable/disable inclusion of diff information in the
+ commit message template when using an editor to prepare the commit
+ message.  Defaults to false.
+
 credential.helper::
  Specify an external helper to be called when a username or
  password credential is needed; the helper may consult external
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 0bbc8f5..8cb3439 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -282,7 +282,13 @@ configuration variable documented in linkgit:git-config[1].
  Show unified diff between the HEAD commit and what
  would be committed at the bottom of the commit message
  template.  Note that this diff output doesn't have its
- lines prefixed with '#'.
+ lines prefixed with '#'.  The `commit.verbose` configuration
+ variable can be set to true to implicitly send this option.
+
+--no-verbose::
+ Do not show the unified diff at the bottom of the commit message
+ template.  This is the default behavior, but can be used to override
+ the `commit.verbose` configuration variable.

 -q::
 --quiet::
diff --git a/builtin/commit.c b/builtin/commit.c
index 99c2044..c782388 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1489,6 +1489,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
    sign_commit = git_config_bool(k, v) ? "" : NULL;
    return 0;
  }
+ if (!strcmp(k, "commit.verbose")) {
+   verbose = git_config_bool(k, v);
+   return 0;
+ }

  status = git_gpg_config(k, v, NULL);
  if (status)
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2c59a76..b8f4b94 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1976,6 +1976,7 @@ _git_config ()
    color.ui
    commit.status
    commit.template
+   commit.verbose
    core.abbrev
    core.askpass
    core.attributesfile
diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index 35a4d06..402d6a1 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -7,6 +7,10 @@ write_script check-for-diff <<-'EOF'
  exec grep '^diff --git' "$1"
 EOF

+write_script check-for-no-diff <<-'EOF'
+ exec grep -v '^diff --git' "$1"
+EOF
+
 cat >message <<'EOF'
 subject

@@ -48,6 +52,38 @@ test_expect_success 'verbose diff is stripped out (mnemonicprefix)' '
  check_message message
 '

+test_expect_success 'commit shows verbose diff with commit.verbose true' '
+ echo morecontent >>file &&
+ git add file &&
+ test_config commit.verbose true &&
+ test_set_editor "$PWD/check-for-diff" &&
+ git commit --amend
+'
+
+test_expect_success 'commit --verbose overrides commit.verbose false' '
+ echo evenmorecontent >>file &&
+ git add file &&
+ test_config commit.verbose false  &&
+ test_set_editor "$PWD/check-for-diff" &&
+ git commit --amend --verbose
+'
+
+test_expect_success 'commit does not show verbose diff with commit.verbose false' '
+ echo evenmorecontent >>file &&
+ git add file &&
+ test_config commit.verbose false &&
+ test_set_editor "$PWD/check-for-no-diff" &&
+ git commit --amend
+'
+
+test_expect_success 'commit --no-verbose overrides commit.verbose true' '
+ echo evenmorecontent >>file &&
+ git add file &&
+ test_config commit.verbose true &&
+ test_set_editor "$PWD/check-for-no-diff" &&
+ git commit --amend --no-verbose
+'
+
 cat >diff <<'EOF'
 This is an example commit message that contains a diff.

--
2.0.0

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJTmbraAAoJEBYhrcKgrOcKzugH/i3kUi33YAM+8IxKN0O9Fq3o
wtDCdrsF9Uf56B5Okrl/lIlXKNhqGj21kukT3cq9ZS5C7XKbSwvTxcE6X3SdZ/DK
BLWnQnvrOX1DCkX/sPA/qvhbmO2JTijQ0sk4BC4O8r3zS/7Zsaaxf+TLmWVCFz4i
5iw5lq2uNJn72r/ldCsYa/juJmfeQA2r9d78V8n1acR8wd/GHtVcl71F5Gj+gbgM
lDakK2So5STKGzjuC2/cAUm2otXNKy81fdVotEqdER78haPtH4S7FCJwir1kJTPZ
obkwxvGfucd3i5q4KsiizVEXGH7eDN4VrNBN4HiroV1wCB40H57D4MC7gYQsGiE=
=K2xQ
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
