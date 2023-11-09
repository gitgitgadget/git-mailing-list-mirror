Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75477469F
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 07:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y6gtwtwY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="haqs3RFV"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C97211D
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 23:09:51 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 400585C02B0;
	Thu,  9 Nov 2023 02:09:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 09 Nov 2023 02:09:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699513791; x=1699600191; bh=Qc
	nLZ7PeoQXNydCM8mTZhAhzsN2gJAgASSqR7rBMxt4=; b=Y6gtwtwYlR1l78cFuw
	DJ/ehBMHRfq3SbaWkh1qqP4BqYQoegwrfDnjig2A51g59uZOq93cUqhhhRjgu9RI
	ZaogZPZIq7xPTx+B7UuMXyeed/os58i3cVGo2IJvGv7npZbIcrNTPa75TsD6OCyO
	zNK7x9e5r5uqxQRsgSMMtTLOFAGZQPV13CoK8iPJIeUr1W/6WxR30FVXFi6JKkED
	eyJNVsrgMxmVxkZI8Ut5tV+wyo3WOyqStlEWmy4EQtaj7Znqujoo6oLAkctZ/xzB
	g8eoGtTAe3ajqTe4ykXs/p2NXLcHKmrrlWt82ey+gN1SnAIYQLFBpzYXreGc7Fdk
	YiPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699513791; x=1699600191; bh=QcnLZ7PeoQXNy
	dCM8mTZhAhzsN2gJAgASSqR7rBMxt4=; b=haqs3RFVEkiRt4DOpusO7lY2zXHIb
	O4DNHTYE5BjxoXy2xQzKtIAh++CdN9qmig15bxxqIoFeFZCC5a5gIzfT9D3cpCfp
	4Xsd0YLwRalW3+5Ibd/NThZft3T0Wlfsyyde/1Eie1c1co36cis+6t72mgtz23LI
	yrz+F0FLPpB6J0ZYBD6FvcuhOzgLKtTLPHqrZMbDzrsFedEsybNpeS0Q4vDc5tiP
	dCMu+MOlwqqCe3m0JLHLIB+6VmWM9BmGFMBntP1QtNmjSOwSRScLpo77CiSHjQ7j
	J6S4PBmM7aZFYkKGUIj546W2XfHyqrfGEU0Hbgl4BRhm1S9Pw/NW+n4Aw==
X-ME-Sender: <xms:v4VMZUbNc1vRU2VWreq9mzoXNStUhm2uHl-oBqZUEn72dzJSv0w3nQ>
    <xme:v4VMZfZmOTPAJODfkIWuKPWo_I00hWUzpBaSg6umkwtnt8FIMQDDzyZPOPLwA3TYU
    JaHU4Q64F4NPQ3KZQ>
X-ME-Received: <xmr:v4VMZe8yGphjfMTmiLH76Qg8Wy2RldUV3jf6cN8PqRw1Zpp-ZeXiV5StVcbW6-g6bATIoWUFGPMNKdbntXq3U6_wdxG7ID1ZFIf68pFW1B-PD6Pn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvtddguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdehteeggfevueevhedtleelveeigf
    efieduiefgvdfffeegvdeitefgteevveeunecuffhomhgrihhnpehhthhtphgurdhshhen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:v4VMZerVIcjdHesLhu5kpWkan7JuQ5MPZuPKmtVBkgbugF9TZOAw8g>
    <xmx:v4VMZfoUlPgtYfZG5FUR8hdtvVV2GteDb9ejk822K2B5v9RxUux_gg>
    <xmx:v4VMZcQmRIUj_YSBKZWXZHhQWTg_m7r8cSToyLg3CoageskB_-LYeQ>
    <xmx:v4VMZYD0YSzPP4-em3jcyUrYYIjRlt_dd5u8eewk0d4Hm6MpCxT_fQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Nov 2023 02:09:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9df4bb1e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Nov 2023 07:09:22 +0000 (UTC)
Date: Thu, 9 Nov 2023 08:09:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/3] t: improve compatibility with NixOS
Message-ID: <cover.1699513524.git.ps@pks.im>
References: <cover.1699428122.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yLryp0d/ezJPONCm"
Content-Disposition: inline
In-Reply-To: <cover.1699428122.git.ps@pks.im>


--yLryp0d/ezJPONCm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the third version of my patch series to improve compatibility of
our tests with NixOS.

Changes compared to v2:

    - Patch 1: We now check for both httpd and apache2 binaries via
      PATH.

    - Patch 1: We're a bit more defensive and will check whether
      variables are empty before passing them to either `test -d` or
      `test -x`.

    - Patch 3: Clarified why PATH is unset.

    - Patch 3: Instead of writing PATH into the hook we now write it
      into the `hook-env` configuration file read by Subversion.

Patrick

Patrick Steinhardt (3):
  t/lib-httpd: dynamically detect httpd and modules path
  t/lib-httpd: stop using legacy crypt(3) for authentication
  t9164: fix inability to find basename(1) in Subversion hooks

 t/lib-httpd.sh                        | 17 +++++++++++++----
 t/lib-httpd/passwd                    |  2 +-
 t/lib-httpd/proxy-passwd              |  2 +-
 t/t9164-git-svn-dcommit-concurrent.sh |  9 ++++++++-
 4 files changed, 23 insertions(+), 7 deletions(-)

Range-diff against v2:
1:  cee8fbebf84 ! 1:  e4c75c492dd t/lib-httpd: dynamically detect httpd and=
 modules path
    @@ t/lib-httpd.sh: fi
      HTTPD_PARA=3D""
     =20
     -for DEFAULT_HTTPD_PATH in '/usr/sbin/httpd' '/usr/sbin/apache2'
    -+for DEFAULT_HTTPD_PATH in '/usr/sbin/httpd' '/usr/sbin/apache2' "$(co=
mmand -v httpd)"
    ++for DEFAULT_HTTPD_PATH in '/usr/sbin/httpd' \
    ++			  '/usr/sbin/apache2' \
    ++			  "$(command -v httpd)" \
    ++			  "$(command -v apache2)"
      do
    - 	if test -x "$DEFAULT_HTTPD_PATH"
    +-	if test -x "$DEFAULT_HTTPD_PATH"
    ++	if test -n "$DEFAULT_HTTPD_PATH" -a -x "$DEFAULT_HTTPD_PATH"
      	then
    -@@ t/lib-httpd.sh: do
    + 		break
      	fi
      done
     =20
    @@ t/lib-httpd.sh: do
     +				 '/usr/libexec/httpd' \
     +				 "${DETECTED_HTTPD_ROOT:+${DETECTED_HTTPD_ROOT}/modules}"
      do
    - 	if test -d "$DEFAULT_HTTPD_MODULE_PATH"
    +-	if test -d "$DEFAULT_HTTPD_MODULE_PATH"
    ++	if test -n "$DEFAULT_HTTPD_MODULE_PATH" -a -d "$DEFAULT_HTTPD_MODULE=
_PATH"
      	then
    + 		break
    + 	fi
2:  f4c6c754f1e =3D 2:  3dce76da477 t/lib-httpd: stop using legacy crypt(3)=
 for authentication
3:  361f1bd9c88 ! 3:  6891e254155 t9164: fix inability to find basename(1) =
in hooks
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
    =20
      ## Commit message ##
    -    t9164: fix inability to find basename(1) in hooks
    +    t9164: fix inability to find basename(1) in Subversion hooks
    =20
    -    The post-commit hook in t9164 is executed with a default environme=
nt.
    -    To work around this issue we already write the current `PATH` valu=
e into
    -    the hook script. But this is done at a point where we already trie=
d to
    -    execute non-built-in commands, namely basename(1). While this seem=
s to
    -    work alright on most platforms, it fails on NixOS.
    +    Hooks executed by Subversion are spawned with an empty environment=
=2E By
    +    default, not even variables like PATH will be propagated to them. =
In
    +    order to ensure that we're still able to find required executables=
, we
    +    thus write the current PATH variable into the hook script itself a=
nd
    +    then re-export it in t9164.
    =20
    -    Set the `PATH` variable earlier to fix this issue. Note that we do=
 this
    -    via two separate heredocs. This is done because in the first one w=
e do
    -    want to expand variables, whereas in the second one we don't.
    +    This happens too late in the script though, as we already tried to
    +    execute the basename(1) utility before exporting the PATH variable=
=2E This
    +    tends to work on most platforms as the fallback value of PATH for =
Bash
    +    (see `getconf PATH`) is likely to contain this binary. But on more
    +    exotic platforms like NixOS this is not the case, and thus the test
    +    fails.
    +
    +    While we could work around this issue by simply setting PATH earli=
er, it
    +    feels fragile to inject a user-controlled value into the script an=
d have
    +    the shell interpret it. Instead, we can refactor the hook setup to=
 write
    +    a `hooks-env` file that configures PATH for us. Like this, Subvers=
ion
    +    will know to set up the environment as expected for all hooks.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## t/t9164-git-svn-dcommit-concurrent.sh ##
     @@ t/t9164-git-svn-dcommit-concurrent.sh: setup_hook()
    + 			"passed to setup_hook" >&2 ; return 1; }
      	echo "cnt=3D$skip_revs" > "$hook_type-counter"
      	rm -f "$rawsvnrepo/hooks/"*-commit # drop previous hooks
    - 	hook=3D"$rawsvnrepo/hooks/$hook_type"
    --	cat > "$hook" <<- 'EOF1'
    -+	cat >"$hook" <<-EOF
    - 		#!/bin/sh
    - 		set -e
    -+
    -+		PATH=3D\"$PATH\"
    -+		export PATH
    -+	EOF
     +
    -+	cat >>"$hook" <<-'EOF'
    - 		cd "$1/.."  # "$1" is repository location
    - 		exec >> svn-hook.log 2>&1
    - 		hook=3D"$(basename "$0")"
    -@@ t/t9164-git-svn-dcommit-concurrent.sh: setup_hook()
    - 		cnt=3D"$(($cnt - 1))"
    - 		echo "cnt=3D$cnt" > ./$hook-counter
    - 		[ "$cnt" =3D "0" ] || exit 0
    --EOF1
    ++	# Subversion hooks run with an empty environment by default. We thus
    ++	# need to propagate PATH so that we can find executables.
    ++	cat >"$rawsvnrepo/conf/hooks-env" <<-EOF
    ++	[default]
    ++	PATH =3D ${PATH}
     +	EOF
     +
    + 	hook=3D"$rawsvnrepo/hooks/$hook_type"
    + 	cat > "$hook" <<- 'EOF1'
    + 		#!/bin/sh
    +@@ t/t9164-git-svn-dcommit-concurrent.sh: EOF1
      	if [ "$hook_type" =3D "pre-commit" ]; then
      		echo "echo 'commit disallowed' >&2; exit 1" >>"$hook"
      	else

base-commit: dadef801b365989099a9929e995589e455c51fed
--=20
2.42.0


--yLryp0d/ezJPONCm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVMhboACgkQVbJhu7ck
PpSodQ//Zsq24Cw1i7kkVY9N4ndTCtA05Fku3IeOMG8x8HRhrkVSQg3RTgdCWmNf
7Fe8btlWHS5zzQr1mzlY1i1UdSiShYplRQc65QH/CxwKfC4zMS2y0emH+P4ldW5J
Qc86iSz8OPCoZZsu7cfN6GcUCScKggv60RmKnuYHkQFzj1PErNOWvY4DruPjRwqP
ZQE1zkVhhBC0ghJ8lN44w0qw3eDgyWxngAQzlfKbRCDliBgTAkQQd4d+5yO9V82V
8oWb1I9Wov0+GsFBC2UOMJA2GpZpV6Ar1vZVLvQZKqIfYLnB4CjD/fxZ15dSa0O0
3XUgxzTW8aiV5dyRNxNfdrmh++6F4HaD4bnsVLywMFMWUzRJBdugjWdU4sGUtaga
2qhqTPFA24SHMSG7u4nhHDxSI533LS2b5hheqdw1bIqw1jqkYIeXz+ASVC6x3eqj
DgqxyuDVVfESnlPJY5MXyyC/r80BE8RjykNCY17zE6bSGp/LkFupyMCpydqhbFqA
psHnmUlrUEO5tI+N5clbVxCg55IjgEvipm1aM6f9FY2dK2uEiN0zOg/jJL2uG6DH
ZgjRjbVmSVxd11ET35r+vRnuxJdvSJcm2nOQ8S+/5rEbjQx4YpiGFfSiNwu2Pc6k
JTtutZqld+YMCDQO6YetFpWvZ/MIO0HofL01D88Dv6bfR4okNYQ=
=/dhj
-----END PGP SIGNATURE-----

--yLryp0d/ezJPONCm--
