Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55CF71F453
	for <e@80x24.org>; Wed, 30 Jan 2019 15:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbfA3PB6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 10:01:58 -0500
Received: from mout.web.de ([217.72.192.78]:38603 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727162AbfA3PB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 10:01:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1548860514;
        bh=Nth11bSruLzlefYBCoY/gi0nYEzkC3nHY0x/hsZdNpc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Vq3PIbSpoCaM/odzVuddDj6vp7Yf8ueFEFzC0juEikcSDz0GLuBxlRVrWkQWfeBvl
         F4fYWCy+46Z0ChEaYJRHyPe90eIOKXz6FU38izoGvAS9EPh3/UgFotJEvWEvWtGz6r
         XZD55PAGY2ibQmprXz8Ila6gVQw8/U3uM5LFiOZE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([195.198.252.176]) by smtp.web.de
 (mrweb103 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MNLNt-1gmMPI48Cn-006v1s; Wed, 30 Jan 2019 16:01:54 +0100
From:   tboegi@web.de
To:     git@vger.kernel.org, adrigibal@gmail.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v3 1/1] Support working-tree-encoding "UTF-16LE-BOM"
Date:   Wed, 30 Jan 2019 16:01:52 +0100
Message-Id: <20190130150152.23040-1-tboegi@web.de>
X-Mailer: git-send-email 2.20.1.2.gb21ebb671
In-Reply-To: <CADN+U_PUfnYWb-wW6drRANv-ZaYBEk3gWHc7oJtxohA5Vc3NEg@mail.gmail.com>
References: <CADN+U_PUfnYWb-wW6drRANv-ZaYBEk3gWHc7oJtxohA5Vc3NEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OebAfuMDGsoowdROqOINgxNCY+KsSBn5v11wdkoP4FN82MpCX/6
 Z52yBnBDKZFIMHrtMffYNmCvM47rIKEOteI0QR5PQy97L6Kn0VbqR1xt5X5xzMFO+BOJNnB
 bq9fiNDzK1BvFzArtBkfNQCrzSBgWZHWT54jkyQ+y/eSDWKXvudiEc1iYGerQXY1z1NEpTU
 AWfoFgrmA6kdPp/rxNliQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gs3TSlyhDsU=:s+4huTHtdlwsFCfh60hZdS
 PupbzAmLcBbC79sp+daPtO48IpdxQBnQKDkHVbkg4o0w2uS7sPV9VVypxduDz6b2uTlFRxVoZ
 EBMMKe9HNR7iwT4B0SVdM5scQ1bdyDfeCFi56NtMLPwbS/U1X6GeCFcODnnidkjUr/PdVU2vx
 wdO4DYOWJrjFUxwWfrqbOg8oEVCAFzp1J+ckrzmMC90xQVsVu0UWhYsNQaT8hoXMYWNWl8jnF
 pPL0ZP4PhShjfB9G2cIpUt+9pKgV5QKChkQIaXTIPDbawFKGFVKD6K/3q0YmFSIGE4iVxAyCG
 ES1vfhvfty9oLyaTjIpAx+pdDt3+xbDCcfQNcrZ241p40Dz+fMhJ/ReWZJ820mEQQFwoMzwjr
 UGagJVlPHN1GCPytA+T+a0g8flkNz5VbBpsoQ3x5cQcVBHiHcGwZ+H+38czGYSRHnNQ1Tbkz1
 hfsskn9Yrb5jmRBr1rX41hTKUUrjyfsLJafq2yo9E51GaWDqRe/z9t/NSj5jXV8WhhSfoBFRX
 4kkwtObAAVZIW8bISrjY0vs1FyZosKEEYqmC6KIiImGaxnUfOEYAjvcBLf97ymNIAh9yRDlWj
 R7VP4lY6i/dEM01r4fnqNMaK9tKjb+Olev/k0/WWAQIJuDhKrHQiswOFaSj9eXzyCb/DtWqM+
 xEaZp+i1TnB3CBGnHSlIEanLz6EBpO8jn5v0LajuXV8rc39Wl46bifJXcgl9vm8x9oEamVhuP
 IiIyuf7VeAeCW5Q66XAmSfMISY1kwA02lCNLk/SRCidM4azfjgeAIiS26M6+h9YQ35d/5xNnV
 zfldZwa/iMqhJAJ6Hmvzm/lFUSkG6J/+t3CHeyJuJOl9nsotfxVorMVQRTwfZeFR93hT0cqAs
 psjRVXCCdcbHVo6irhyWts6xlKBk0MKtwZN0KdgFSSRRwbef8Nw5Umg1qXz6Ef
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten B=C3=B6gershausen <tboegi@web.de>

Users who want UTF-16 files in the working tree set the .gitattributes
like this:
test.txt working-tree-encoding=3DUTF-16

The unicode standard itself defines 3 allowed ways how to encode UTF-16.
The following 3 versions convert all back to 'g' 'i' 't' in UTF-8:

a) UTF-16, without BOM, big endian:
$ printf "\000g\000i\000t" | iconv -f UTF-16 -t UTF-8 | od -c
0000000    g   i   t

b) UTF-16, with BOM, little endian:
$ printf "\377\376g\000i\000t\000" | iconv -f UTF-16 -t UTF-8 | od -c
0000000    g   i   t

c) UTF-16, with BOM, big endian:
$ printf "\376\377\000g\000i\000t" | iconv -f UTF-16 -t UTF-8 | od -c
0000000    g   i   t

Git uses libiconv to convert from UTF-8 in the index into ITF-16 in the
working tree.
After a checkout, the resulting file has a BOM and is encoded in "UTF-16",
in the version (c) above.
This is what iconv generates, more details follow below.

iconv (and libiconv) can generate UTF-16, UTF-16LE or UTF-16BE:

d) UTF-16
$ printf 'git' | iconv -f UTF-8 -t UTF-16 | od -c
0000000  376 377  \0   g  \0   i  \0   t

e) UTF-16LE
$ printf 'git' | iconv -f UTF-8 -t UTF-16LE | od -c
0000000    g  \0   i  \0   t  \0

f)  UTF-16BE
$ printf 'git' | iconv -f UTF-8 -t UTF-16BE | od -c
0000000   \0   g  \0   i  \0   t

There is no way to generate version (b) from above in a Git working tree,
but that is what some applications need.
(All fully unicode aware applications should be able to read all 3 variant=
s,
but in practise we are not there yet).

When producing UTF-16 as an output, iconv generates the big endian version
with a BOM. (big endian is probably chosen for historical reasons).

iconv can produce UTF-16 files with little endianess by using "UTF-16LE"
as encoding, and that file does not have a BOM.

Not all users (especially under Windows) are happy with this.
Some tools are not fully unicode aware and can only handle version (b).

Today there is no way to produce version (b) with iconv (or libiconv).
Looking into the history of iconv, it seems as if version (c) will
be used in all future iconv versions (for compatibility reasons).

Solve this dilemma and introduce a Git-specific "UTF-16LE-BOM".
libiconv can not handle the encoding, so Git pick it up, handles the BOM
and uses libiconv to convert the rest of the stream.
(UTF-16BE-BOM is added for consistency)

Rported-by: Adri=C3=A1n Gimeno Balaguer <adrigibal@gmail.com>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--

Changes since v2:
  Update the commit message (s/possible/allowed/)
  Update the documentation, as suggested by Junio:
  ...wonder if the following,
     instead of the above hunk, would work better..
  Yes, it does.

Documentation/gitattributes.txt  |  4 ++-
 compat/precompose_utf8.c         |  2 +-
 t/t0028-working-tree-encoding.sh | 12 ++++++++-
 utf8.c                           | 42 ++++++++++++++++++++++++--------
 utf8.h                           |  2 +-
 5 files changed, 48 insertions(+), 14 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes=
.txt
index b8392fc330..a2310fb920 100644
=2D-- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -344,7 +344,9 @@ automatic line ending conversion based on your platfor=
m.

 Use the following attributes if your '*.ps1' files are UTF-16 little
 endian encoded without BOM and you want Git to use Windows line endings
-in the working directory. Please note, it is highly recommended to
+in the working directory (use `UTF-16-LE-BOM` instead of `UTF-16LE` if
+you want UTF-16 little endian with BOM).
+Please note, it is highly recommended to
 explicitly define the line endings with `eol` if the `working-tree-encodi=
ng`
 attribute is used to avoid ambiguity.

diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index de61c15d34..136250fbf6 100644
=2D-- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -79,7 +79,7 @@ void precompose_argv(int argc, const char **argv)
 		size_t namelen;
 		oldarg =3D argv[i];
 		if (has_non_ascii(oldarg, (size_t)-1, &namelen)) {
-			newarg =3D reencode_string_iconv(oldarg, namelen, ic_precompose, NULL)=
;
+			newarg =3D reencode_string_iconv(oldarg, namelen, ic_precompose, 0, NU=
LL);
 			if (newarg)
 				argv[i] =3D newarg;
 		}
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encod=
ing.sh
index 7e87b5a200..e58ecbfc44 100755
=2D-- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -11,9 +11,12 @@ test_expect_success 'setup test files' '

 	text=3D"hallo there!\ncan you read me?" &&
 	echo "*.utf16 text working-tree-encoding=3Dutf-16" >.gitattributes &&
+	echo "*.utf16lebom text working-tree-encoding=3DUTF-16LE-BOM" >>.gitattr=
ibutes &&
 	printf "$text" >test.utf8.raw &&
 	printf "$text" | iconv -f UTF-8 -t UTF-16 >test.utf16.raw &&
 	printf "$text" | iconv -f UTF-8 -t UTF-32 >test.utf32.raw &&
+	printf "\377\376"                         >test.utf16lebom.raw &&
+	printf "$text" | iconv -f UTF-8 -t UTF-32LE >>test.utf16lebom.raw &&

 	# Line ending tests
 	printf "one\ntwo\nthree\n" >lf.utf8.raw &&
@@ -32,7 +35,8 @@ test_expect_success 'setup test files' '
 	# Add only UTF-16 file, we will add the UTF-32 file later
 	cp test.utf16.raw test.utf16 &&
 	cp test.utf32.raw test.utf32 &&
-	git add .gitattributes test.utf16 &&
+	cp test.utf16lebom.raw test.utf16lebom &&
+	git add .gitattributes test.utf16 test.utf16lebom &&
 	git commit -m initial
 '

@@ -51,6 +55,12 @@ test_expect_success 're-encode to UTF-16 on checkout' '
 	test_cmp_bin test.utf16.raw test.utf16
 '

+test_expect_success 're-encode to UTF-16-LE-BOM on checkout' '
+	rm test.utf16lebom &&
+	git checkout test.utf16lebom &&
+	test_cmp_bin test.utf16lebom.raw test.utf16lebom
+'
+
 test_expect_success 'check $GIT_DIR/info/attributes support' '
 	test_when_finished "rm -f test.utf32.git" &&
 	test_when_finished "git reset --hard HEAD" &&
diff --git a/utf8.c b/utf8.c
index eb78587504..83824dc2f4 100644
=2D-- a/utf8.c
+++ b/utf8.c
@@ -4,6 +4,11 @@

 /* This code is originally from http://www.cl.cam.ac.uk/~mgk25/ucs/ */

+static const char utf16_be_bom[] =3D {'\xFE', '\xFF'};
+static const char utf16_le_bom[] =3D {'\xFF', '\xFE'};
+static const char utf32_be_bom[] =3D {'\0', '\0', '\xFE', '\xFF'};
+static const char utf32_le_bom[] =3D {'\xFF', '\xFE', '\0', '\0'};
+
 struct interval {
 	ucs_char_t first;
 	ucs_char_t last;
@@ -470,16 +475,17 @@ int utf8_fprintf(FILE *stream, const char *format, .=
..)
 #else
 	typedef char * iconv_ibp;
 #endif
-char *reencode_string_iconv(const char *in, size_t insz, iconv_t conv, si=
ze_t *outsz_p)
+char *reencode_string_iconv(const char *in, size_t insz, iconv_t conv,
+			    size_t bom_len, size_t *outsz_p)
 {
 	size_t outsz, outalloc;
 	char *out, *outpos;
 	iconv_ibp cp;

 	outsz =3D insz;
-	outalloc =3D st_add(outsz, 1); /* for terminating NUL */
+	outalloc =3D st_add(outsz, 1 + bom_len); /* for terminating NUL */
 	out =3D xmalloc(outalloc);
-	outpos =3D out;
+	outpos =3D out + bom_len;
 	cp =3D (iconv_ibp)in;

 	while (1) {
@@ -540,10 +546,30 @@ char *reencode_string_len(const char *in, size_t ins=
z,
 {
 	iconv_t conv;
 	char *out;
+	const char *bom_str =3D NULL;
+	size_t bom_len =3D 0;

 	if (!in_encoding)
 		return NULL;

+	/* UTF-16LE-BOM is the same as UTF-16 for reading */
+	if (same_utf_encoding("UTF-16LE-BOM", in_encoding))
+		in_encoding =3D "UTF-16";
+
+	/*
+	 * For writing, UTF-16 iconv typically creates "UTF-16BE-BOM"
+	 * Some users under Windows want the little endian version
+	 */
+	if (same_utf_encoding("UTF-16LE-BOM", out_encoding)) {
+		bom_str =3D utf16_le_bom;
+		bom_len =3D sizeof(utf16_le_bom);
+		out_encoding =3D "UTF-16LE";
+	} else if (same_utf_encoding("UTF-16BE-BOM", out_encoding)) {
+		bom_str =3D utf16_be_bom;
+		bom_len =3D sizeof(utf16_be_bom);
+		out_encoding =3D "UTF-16BE";
+	}
+
 	conv =3D iconv_open(out_encoding, in_encoding);
 	if (conv =3D=3D (iconv_t) -1) {
 		in_encoding =3D fallback_encoding(in_encoding);
@@ -553,9 +579,10 @@ char *reencode_string_len(const char *in, size_t insz=
,
 		if (conv =3D=3D (iconv_t) -1)
 			return NULL;
 	}
-
-	out =3D reencode_string_iconv(in, insz, conv, outsz);
+	out =3D reencode_string_iconv(in, insz, conv, bom_len, outsz);
 	iconv_close(conv);
+	if (out && bom_str && bom_len)
+		memcpy(out, bom_str, bom_len);
 	return out;
 }
 #endif
@@ -566,11 +593,6 @@ static int has_bom_prefix(const char *data, size_t le=
n,
 	return data && bom && (len >=3D bom_len) && !memcmp(data, bom, bom_len);
 }

-static const char utf16_be_bom[] =3D {'\xFE', '\xFF'};
-static const char utf16_le_bom[] =3D {'\xFF', '\xFE'};
-static const char utf32_be_bom[] =3D {'\0', '\0', '\xFE', '\xFF'};
-static const char utf32_le_bom[] =3D {'\xFF', '\xFE', '\0', '\0'};
-
 int has_prohibited_utf_bom(const char *enc, const char *data, size_t len)
 {
 	return (
diff --git a/utf8.h b/utf8.h
index edea55e093..84efbfcb1f 100644
=2D-- a/utf8.h
+++ b/utf8.h
@@ -27,7 +27,7 @@ void strbuf_utf8_replace(struct strbuf *sb, int pos, int=
 width,

 #ifndef NO_ICONV
 char *reencode_string_iconv(const char *in, size_t insz,
-			    iconv_t conv, size_t *outsz);
+			    iconv_t conv, size_t bom_len, size_t *outsz);
 char *reencode_string_len(const char *in, size_t insz,
 			  const char *out_encoding,
 			  const char *in_encoding,
=2D-
2.20.1.2.gb21ebb671

