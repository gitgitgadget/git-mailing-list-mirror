Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A302EE5FE
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 12:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759493815; cv=none; b=tr50D6pNrtL4uIsKbDRNATtdYJpWiSfkNtNUah/1lbGhQMaT1AnBTqPXjpC9ry6yTz+2xqKKKFpdEjB6MaDt7B1bgFiIwM6RLUZso0EuB0Mg3MeD/E97Evjrqy0Ur5/onvKLoAHTNr1+fNhRBfmBG+97VKEXLDlpFeKFeTUbJHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759493815; c=relaxed/simple;
	bh=R5V0Z85MWMU4G4wijG3gpqEQHmpOyjt+rJsjnQk/ADE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=VfnEqOqy8NCO0GqcvNqPoHfvE6U1/qlBsOshLvW08sauC7oZaXJ2IWOrtfkuB8nuUg5ahiZT6VJmum9nhxzDdPcNLiioOxFJQnsepRpKulrJdr3B5OWbOTX6qJp0TsouE8OAq/KpqvRRHqw5WpH/Ng+17ULQ2d1O7IFuB3nQcmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=TaFGnHk5; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="TaFGnHk5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759493804; x=1760098604; i=l.s.r@web.de;
	bh=wuuGtErXqja6CkIjsQR76/kvTrF/FYbu8aDjoOgAZTI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=TaFGnHk5oG36rMvPwm6YGtzPoL6r6phLIHc035Du3QtvsFWEwvLUgw6ZnspSC8z5
	 KFkHYYvCLYa4YSoGgQRTLf6y49apCsaKph/Y5gwXWGW2uCAgE/JH5gDimpQAKFdQK
	 PlnVEh76xzV4aPvOFS8g3GLbtKLPz1m+wCbWM9eRkuWNK/qqx8JHP7f+XR9Q7uVF4
	 mUg3AMkvbIu49IZuHwqrMbYD1W/ddoGJKbagFoIn+maLxcFYBbmD0zcqUvCkIsVt7
	 nGTKCppK4wLLVYXU1VZUydmLEVxdypJXva9advJs/oo7dvgKJbVhAehM6LPWFqL+e
	 zqrDSNCMp5DKYsu26A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.16.132]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFaui-1v58fy2v9y-003TAk; Fri, 03
 Oct 2025 14:16:44 +0200
Message-ID: <76665b6f-cb92-4694-bc89-5eb21197df34@web.de>
Date: Fri, 3 Oct 2025 14:16:44 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] add-patch: roll over to next undecided hunk
To: "Windl, Ulrich" <u.windl@ukr.de>,
 "git@vger.kernel.org" <git@vger.kernel.org>
References: <c72518099a3b465c8761e41210fe3fcb@ukr.de>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>
In-Reply-To: <c72518099a3b465c8761e41210fe3fcb@ukr.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jrKnO2pTmJXMXmcf1jkAGlLCqAMNYH8OjKDRZvNoiPYxdef3wg6
 ZRroByJmQHqDkegUoYsY/rYOCAn0AsBkXmgXT24JLa7gpJ+5E3PjXVsGRhYMRj+eulyACXI
 0hG8gv63xbwLesIIi1XJiaxo+EUJqafp+RnW7719ysrrGLglq+skXLmxfbWoEICqmKmTMTr
 8PTtzn6EiCES/oNKkQdPA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dKHTLPx2xuQ=;WKbutEUfbh6ubdnVL39scxXut2X
 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

git add --patch presents diff hunks one after the other, asking whether
to add them.  If we mark some as undecided, e.g. with J, then it will
start over after reaching the last hunk.  It always starts over at the
very first hunk, though, even if we already decided on it.  Skip
decided hunks when rolling over instead.

Reported-by: Windl, Ulrich <u.windl@ukr.de>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 add-patch.c                |  9 ++++++++-
 t/t3701-add-interactive.sh | 20 ++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/add-patch.c b/add-patch.c
index b0389c5d5b..42a8394c92 100644
=2D-- a/add-patch.c
+++ b/add-patch.c
@@ -1436,8 +1436,15 @@ static int patch_update_file(struct add_p_state *s,
 	render_diff_header(s, file_diff, colored, &s->buf);
 	fputs(s->buf.buf, stdout);
 	for (;;) {
-		if (hunk_index >=3D file_diff->hunk_nr)
+		if (hunk_index >=3D file_diff->hunk_nr) {
 			hunk_index =3D 0;
+			for (i =3D 0; i < file_diff->hunk_nr; i++) {
+				if (file_diff->hunk[i].use =3D=3D UNDECIDED_HUNK) {
+					hunk_index =3D i;
+					break;
+				}
+			}
+		}
 		hunk =3D file_diff->hunk_nr
 				? file_diff->hunk + hunk_index
 				: &file_diff->head;
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index d9fe289a7a..fa6ec5f835 100755
=2D-- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -1321,6 +1321,26 @@ test_expect_success 'stash accepts -U and --inter-h=
unk-context' '
 	test_grep "@@ -2,20 +2,20 @@" actual
 '
=20
+test_expect_success 'roll over to next undecided (1)' '
+	test_write_lines a b c d e f g h i j k l m n o p q >file &&
+	git add file &&
+	test_write_lines X b c d e f g h X j k l m n o p X >file &&
+	test_write_lines J y y q | git add -p >actual &&
+	test_write_lines 1 2 3 1 >expect &&
+	sed -ne "s-/.*--" -e "s-^(--p" <actual >hunks &&
+	test_cmp expect hunks
+'
+
+test_expect_success 'roll over to next undecided (2)' '
+	test_write_lines a b c d e f g h i j k l m n o p q >file &&
+	git add file &&
+	test_write_lines X b c d e f g h X j k l m n o p X >file &&
+	test_write_lines y J y q | git add -p >actual &&
+	test_write_lines 1 2 3 2 >expect &&
+	sed -ne "s-/.*--" -e "s-^(--p" <actual >hunks &&
+	test_cmp expect hunks
+'
+
 test_expect_success 'set up base for -p color tests' '
 	echo commit >file &&
 	git commit -am "commit state" &&
=2D-=20
2.51.0
