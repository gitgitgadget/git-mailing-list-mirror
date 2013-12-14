From: Tran Ngoc Quan <vnwildman@gmail.com>
Subject: [PATCH] l10n:gitk: Init Vietnamese translation
Date: Sat, 14 Dec 2013 09:42:02 +0700
Message-ID: <1386988922-10199-1-git-send-email-vnwildman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tran Ngoc Quan <vnwildman@gmail.com>
To: git-malling-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 14 03:43:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrfCc-0000IF-27
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 03:43:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879Ab3LNCnQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Dec 2013 21:43:16 -0500
Received: from mail-pb0-f65.google.com ([209.85.160.65]:44293 "EHLO
	mail-pb0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958Ab3LNCnO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Dec 2013 21:43:14 -0500
Received: by mail-pb0-f65.google.com with SMTP id rq2so1937711pbb.4
        for <git@vger.kernel.org>; Fri, 13 Dec 2013 18:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=LsQBIwlnGvZPeXshFRJl7zvRz/n0DubTGnNioRNqTVs=;
        b=Jm50MPmW2+Gr8j7b785pLAcYEmcfyx/zj6wGnTAvyYMD1pnb2fic7YjOG/9wBTzsR2
         0QQXjaoSdYe1KcHSNWkFxf/8yT7uJuWOnp6ppAYCmIzvbqi1Re6RwwfMuS+waUDlpIHu
         1SxDSwyxRpYorjx7cHcQrdbe/Ldpt9zqBhmrWwvA66SemdKmKC7RI8TdMYqI6H7LqwhT
         3Chq4UBKdfn/HaWq8RrCoW8+t4npbtcsR0ZIkN2VhxTYVxue2LIa3DVyiF7NlSO5dGaX
         4OUSszfET0TY9llIekdW+Q7IFJPYOyn3QCmaFFNKL+O+RpahSRYzV9M8RnCPclBu0yjv
         qUeg==
X-Received: by 10.66.189.229 with SMTP id gl5mr7001591pac.47.1386988993395;
        Fri, 13 Dec 2013 18:43:13 -0800 (PST)
Received: from gmail.com ([113.168.11.119])
        by mx.google.com with ESMTPSA id pl3sm8365007pbc.13.2013.12.13.18.43.09
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 13 Dec 2013 18:43:11 -0800 (PST)
X-Mailer: git-send-email 1.8.5.1.19.gdaad3aa.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239276>

Signed-off-by: Tran Ngoc Quan <vnwildman@gmail.com>
---
 gitk-git/po/vi.po | 1350 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 po/vi.po          |  594 +++++++++++------------
 2 files changed, 1648 insertions(+), 296 deletions(-)
 create mode 100644 gitk-git/po/vi.po

diff --git a/gitk-git/po/vi.po b/gitk-git/po/vi.po
new file mode 100644
index 0000000..7c56995
--- /dev/null
+++ b/gitk-git/po/vi.po
@@ -0,0 +1,1350 @@
+# Vietnamese translations for gitk package.
+# B=E1=BA=A3n d=E1=BB=8Bch ti=E1=BA=BFng Vi=E1=BB=87t cho g=C3=B3i git=
k.
+# This file is distributed under the same license as the gitk package.
+# Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n <vnwildman@gmail.com>, 2013.
+#
+msgid ""
+msgstr ""
+"Project-Id-Version: gitk @@GIT_VERSION@@\n"
+"Report-Msgid-Bugs-To: \n"
+"POT-Creation-Date: 2013-12-14 09:24+0700\n"
+"PO-Revision-Date: 2013-12-14 09:25+0700\n"
+"Last-Translator: Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n <vnwildman@gmail=
=2Ecom>\n"
+"Language-Team: Vietnamese\n"
+"Language: vi\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+"Plural-Forms: nplurals=3D1; plural=3D0;\n"
+
+#: gitk:140
+msgid "Couldn't get list of unmerged files:"
+msgstr "Kh=C3=B4ng th=E1=BB=83 l=E1=BA=A5y danh s=C3=A1ch c=C3=A1c t=E1=
=BA=ADp-tin ch=C6=B0a =C4=91=C6=B0=E1=BB=A3c h=C3=B2a tr=E1=BB=99n:"
+
+#: gitk:212 gitk:2353
+msgid "Color words"
+msgstr "T=C3=B4 m=C3=A0u ch=E1=BB=AF"
+
+#: gitk:217 gitk:2353 gitk:8103 gitk:8136
+msgid "Markup words"
+msgstr "=C4=90=C3=A1nh d=E1=BA=A5u ch=E1=BB=AF"
+
+#: gitk:322
+msgid "Error parsing revisions:"
+msgstr "G=E1=BA=B7p l=E1=BB=97i khi ph=C3=A2n t=C3=ADch =C4=91i=E1=BB=83=
m x=C3=A9t duy=E1=BB=87t:"
+
+#: gitk:378
+msgid "Error executing --argscmd command:"
+msgstr "G=E1=BA=B7p l=E1=BB=97i khi th=E1=BB=B1c hi=E1=BB=87n l=E1=BB=87=
nh --argscmd:"
+
+#: gitk:391
+msgid "No files selected: --merge specified but no files are unmerged.=
"
+msgstr ""
+"Ch=C6=B0a ch=E1=BB=8Dn t=E1=BA=ADp tin: --merge =C4=91=C3=A3 ch=E1=BB=
=89 =C4=91=E1=BB=8Bnh nh=C6=B0ng kh=C3=B4ng c=C3=B3 t=E1=BA=ADp tin ch=C6=
=B0a h=C3=B2a tr=E1=BB=99n."
+
+#: gitk:394
+msgid ""
+"No files selected: --merge specified but no unmerged files are within=
 file "
+"limit."
+msgstr ""
+"Ch=C6=B0a ch=E1=BB=8Dn t=E1=BA=ADp tin: --merge =C4=91=C3=A3 ch=E1=BB=
=89 =C4=91=E1=BB=8Bnh nh=C6=B0ng kh=C3=B4ng c=C3=B3 t=E1=BA=ADp tin ch=C6=
=B0a h=C3=B2a tr=E1=BB=99n "
+"trong gi=E1=BB=9Bi h=E1=BA=A1n t=E1=BA=ADp tin."
+
+#: gitk:416 gitk:564
+msgid "Error executing git log:"
+msgstr "G=E1=BA=B7p l=E1=BB=97i khi th=E1=BB=B1c hi=E1=BB=87n l=E1=BB=87=
nh git log:"
+
+#: gitk:434 gitk:580
+msgid "Reading"
+msgstr "=C4=90ang =C4=91=E1=BB=8Dc"
+
+#: gitk:494 gitk:4429
+msgid "Reading commits..."
+msgstr "=C4=90ang =C4=91=E1=BB=8Dc c=C3=A1c l=E1=BA=A7n chuy=E1=BB=83n=
 giao..."
+
+#: gitk:497 gitk:1635 gitk:4432
+msgid "No commits selected"
+msgstr "Ch=C6=B0a ch=E1=BB=8Dn c=C3=A1c l=E1=BA=A7n chuy=E1=BB=83n gia=
o"
+
+#: gitk:1509
+msgid "Can't parse git log output:"
+msgstr "Kh=C3=B4ng th=E1=BB=83 ph=C3=A2n t=C3=ADch k=E1=BA=BFt xu=E1=BA=
=A5t t=E1=BB=AB l=E1=BB=87nh git log:"
+
+#: gitk:1738
+msgid "No commit information available"
+msgstr "Kh=C3=B4ng c=C3=B3 th=C3=B4ng tin v=E1=BB=81 l=E1=BA=A7n chuy=E1=
=BB=83n giao n=C3=A0o"
+
+#: gitk:1895
+msgid "mc"
+msgstr "mc"
+
+#: gitk:1930 gitk:4222 gitk:9552 gitk:11122 gitk:11401
+msgid "OK"
+msgstr "=C4=90=E1=BB=93ng =C3=BD"
+
+#: gitk:1932 gitk:4224 gitk:9079 gitk:9158 gitk:9274 gitk:9323 gitk:95=
54
+#: gitk:11123 gitk:11402
+msgid "Cancel"
+msgstr "Th=C3=B4i"
+
+#: gitk:2067
+msgid "Update"
+msgstr "C=E1=BA=ADp nh=E1=BA=ADt"
+
+#: gitk:2068
+msgid "Reload"
+msgstr "T=E1=BA=A3i l=E1=BA=A1i"
+
+#: gitk:2069
+msgid "Reread references"
+msgstr "=C4=90=E1=BB=8Dc l=E1=BA=A1i tham chi=E1=BA=BFu"
+
+#: gitk:2070
+msgid "List references"
+msgstr "Li=E1=BB=87t k=C3=AA c=C3=A1c tham chi=E1=BA=BFu"
+
+#: gitk:2072
+msgid "Start git gui"
+msgstr "Kh=E1=BB=9Fi ch=E1=BA=A1y git gui"
+
+#: gitk:2074
+msgid "Quit"
+msgstr "Tho=C3=A1t"
+
+#: gitk:2066
+msgid "File"
+msgstr "Ch=C3=ADnh"
+
+#: gitk:2078
+msgid "Preferences"
+msgstr "C=C3=A1 nh=C3=A2n h=C3=B3a"
+
+#: gitk:2077
+msgid "Edit"
+msgstr "Ch=E1=BB=89nh s=E1=BB=ADa"
+
+#: gitk:2082
+msgid "New view..."
+msgstr "Th=C3=AAm tr=C3=ACnh b=C3=A0y m=E1=BB=9Bi..."
+
+#: gitk:2083
+msgid "Edit view..."
+msgstr "S=E1=BB=ADa c=C3=A1ch tr=C3=ACnh b=C3=A0y..."
+
+#: gitk:2084
+msgid "Delete view"
+msgstr "X=C3=B3a c=C3=A1ch tr=C3=ACnh b=C3=A0y"
+
+#: gitk:2086
+msgid "All files"
+msgstr "M=E1=BB=8Di t=E1=BA=ADp tin"
+
+#: gitk:2081 gitk:3975
+msgid "View"
+msgstr "Tr=C3=ACnh b=C3=A0y"
+
+#: gitk:2091 gitk:2101 gitk:2945
+msgid "About gitk"
+msgstr "Gi=E1=BB=9Bi thi=E1=BB=87u v=E1=BB=81 gitk"
+
+#: gitk:2092 gitk:2106
+msgid "Key bindings"
+msgstr "T=E1=BB=95 h=E1=BB=A3p ph=C3=ADm"
+
+#: gitk:2090 gitk:2105
+msgid "Help"
+msgstr "Tr=E1=BB=A3 gi=C3=BAp"
+
+#: gitk:2183 gitk:8535
+msgid "SHA1 ID:"
+msgstr "SHA1 ID:"
+
+#: gitk:2227
+msgid "Row"
+msgstr "H=C3=A0ng"
+
+#: gitk:2265
+msgid "Find"
+msgstr "T=C3=ACm"
+
+#: gitk:2266
+msgid "next"
+msgstr "ti=E1=BA=BFp"
+
+#: gitk:2267
+msgid "prev"
+msgstr "tr=C6=B0=E1=BB=9Bc"
+
+#: gitk:2268
+msgid "commit"
+msgstr "commit"
+
+#: gitk:2271 gitk:2273 gitk:4590 gitk:4613 gitk:4637 gitk:6653 gitk:67=
25
+#: gitk:6810
+msgid "containing:"
+msgstr "c=C3=B3 ch=E1=BB=A9a:"
+
+#: gitk:2274 gitk:3457 gitk:3462 gitk:4666
+msgid "touching paths:"
+msgstr "=C4=91ang ch=E1=BA=A1m =C4=91=C6=B0=E1=BB=9Dng d=E1=BA=ABn:"
+
+#: gitk:2275 gitk:4680
+msgid "adding/removing string:"
+msgstr "th=C3=AAm/g=E1=BB=A1 b=E1=BB=8F chu=E1=BB=97i:"
+
+#: gitk:2276 gitk:4682
+msgid "changing lines matching:"
+msgstr "nh=E1=BB=AFng d=C3=B2ng thay =C4=91=E1=BB=95i kh=E1=BB=9Bp m=E1=
=BA=ABu:"
+
+#: gitk:2285 gitk:2287 gitk:4669
+msgid "Exact"
+msgstr "Ch=C3=ADnh x=C3=A1c"
+
+#: gitk:2287 gitk:4757 gitk:6621
+msgid "IgnCase"
+msgstr "BquaHt"
+
+#: gitk:2287 gitk:4639 gitk:4755 gitk:6617
+msgid "Regexp"
+msgstr "BTCQ"
+
+#: gitk:2289 gitk:2290 gitk:4777 gitk:4807 gitk:4814 gitk:6746 gitk:68=
14
+msgid "All fields"
+msgstr "M=E1=BB=8Di tr=C6=B0=E1=BB=9Dng"
+
+#: gitk:2290 gitk:4774 gitk:4807 gitk:6684
+msgid "Headline"
+msgstr "N=E1=BB=99i dung ch=C3=ADnh"
+
+#: gitk:2291 gitk:4774 gitk:6684 gitk:6814 gitk:7283
+msgid "Comments"
+msgstr "Ghi ch=C3=BA"
+
+#: gitk:2291 gitk:4774 gitk:4779 gitk:4814 gitk:6684 gitk:7218 gitk:87=
13
+#: gitk:8728
+msgid "Author"
+msgstr "T=C3=A1c gi=E1=BA=A3"
+
+#: gitk:2291 gitk:4774 gitk:6684 gitk:7220
+msgid "Committer"
+msgstr "Ng=C6=B0=E1=BB=9Di chuy=E1=BB=83n giao"
+
+#: gitk:2322
+msgid "Search"
+msgstr "T=C3=ACm ki=E1=BA=BFm"
+
+#: gitk:2330
+msgid "Diff"
+msgstr "Diff"
+
+#: gitk:2332
+msgid "Old version"
+msgstr "Phi=C3=AAn b=E1=BA=A3n c=C5=A9"
+
+#: gitk:2334
+msgid "New version"
+msgstr "Phi=C3=AAn b=E1=BA=A3n m=E1=BB=9Bi"
+
+#: gitk:2336
+msgid "Lines of context"
+msgstr "C=C3=A1c d=C3=B2ng c=E1=BB=A7a n=E1=BB=99i dung"
+
+#: gitk:2346
+msgid "Ignore space change"
+msgstr "Kh=C3=B4ng x=C3=A9t =C4=91=E1=BA=BFn thay =C4=91=E1=BB=95i do =
kho=E1=BA=A3ng tr=E1=BA=AFng"
+
+#: gitk:2350 gitk:2352 gitk:7842 gitk:8089
+msgid "Line diff"
+msgstr "Diff theo d=C3=B2ng"
+
+#: gitk:2417
+msgid "Patch"
+msgstr "V=C3=A1"
+
+#: gitk:2419
+msgid "Tree"
+msgstr "C=C3=A2y"
+
+#: gitk:2577 gitk:2597
+msgid "Diff this -> selected"
+msgstr "Diff c=C3=A1i n=C3=A0y -> c=C3=A1i =C4=91=C3=A3 ch=E1=BB=8Dn"
+
+#: gitk:2578 gitk:2598
+msgid "Diff selected -> this"
+msgstr "Diff c=C3=A1i =C4=91=C3=A3 ch=E1=BB=8Dn -> c=C3=A1i n=C3=A0y"
+
+#: gitk:2579 gitk:2599
+msgid "Make patch"
+msgstr "T=E1=BA=A1o mi=E1=BA=BFng v=C3=A1"
+
+#: gitk:2580 gitk:9137
+msgid "Create tag"
+msgstr "T=E1=BA=A1o th=E1=BA=BB"
+
+#: gitk:2581 gitk:9254
+msgid "Write commit to file"
+msgstr "Ghi l=E1=BA=A7n chuy=E1=BB=83n giao ra t=E1=BA=ADp tin"
+
+#: gitk:2582 gitk:9311
+msgid "Create new branch"
+msgstr "T=E1=BA=A1o nh=C3=A1nh m=E1=BB=9Bi"
+
+#: gitk:2583
+msgid "Cherry-pick this commit"
+msgstr "Cherry-pick l=E1=BA=A7n commit n=C3=A0y"
+
+#: gitk:2584
+msgid "Reset HEAD branch to here"
+msgstr "=C4=90=E1=BA=B7t l=E1=BA=A1i HEAD c=E1=BB=A7a nh=C3=A1nh v=C3=A0=
o =C4=91=C3=A2y"
+
+#: gitk:2585
+msgid "Mark this commit"
+msgstr "=C4=90=C3=A1nh d=E1=BA=A5u l=E1=BA=A7n chuy=E1=BB=83n giao n=C3=
=A0y"
+
+#: gitk:2586
+msgid "Return to mark"
+msgstr "Quay l=E1=BA=A1i v=E1=BB=8B tr=C3=AD d=E1=BA=A5u"
+
+#: gitk:2587
+msgid "Find descendant of this and mark"
+msgstr "T=C3=ACm con ch=C3=A1u c=E1=BB=A7a c=C3=A1i n=C3=A0y v=C3=A0 c=
=C3=A1i =C4=91=C3=A3 =C4=91=C3=A1nh d=E1=BA=A5u"
+
+#: gitk:2588
+msgid "Compare with marked commit"
+msgstr "So s=C3=A1nh v=E1=BB=9Bi l=E1=BA=A7n chuy=E1=BB=83n giao =C4=91=
=C3=A3 =C4=91=C3=A1nh d=E1=BA=A5u"
+
+#: gitk:2589 gitk:2600
+msgid "Diff this -> marked commit"
+msgstr "Diff c=C3=A1i n=C3=A0y -> l=E1=BA=A7n commit =C4=91=C3=A3 =C4=91=
=C3=A1nh d=E1=BA=A5u"
+
+#: gitk:2590 gitk:2601
+msgid "Diff marked commit -> this"
+msgstr "Diff l=E1=BA=A7n commit =C4=91=C3=A3 =C4=91=C3=A1nh d=E1=BA=A5=
u -> c=C3=A1i n=C3=A0y"
+
+#: gitk:2591
+msgid "Revert this commit"
+msgstr "Ho=C3=A0n l=E1=BA=A1i l=E1=BA=A7n commit n=C3=A0y"
+
+#: gitk:2607
+msgid "Check out this branch"
+msgstr "Checkout nh=C3=A1nh n=C3=A0y"
+
+#: gitk:2608
+msgid "Remove this branch"
+msgstr "G=E1=BB=A1 b=E1=BB=8F nh=C3=A1nh n=C3=A0y"
+
+#: gitk:2615
+msgid "Highlight this too"
+msgstr "C=C5=A9ng t=C3=B4 s=C3=A1ng n=C3=B3"
+
+#: gitk:2616
+msgid "Highlight this only"
+msgstr "Ch=E1=BB=89 t=C3=B4 s=C3=A1ng c=C3=A1i n=C3=A0y"
+
+#: gitk:2617
+msgid "External diff"
+msgstr "diff t=E1=BB=AB b=C3=AAn ngo=C3=A0i"
+
+#: gitk:2618
+msgid "Blame parent commit"
+msgstr "Xem c=C3=B4ng tr=E1=BA=A1ng l=E1=BA=A7n chuy=E1=BB=83n giao ch=
a m=E1=BA=B9"
+
+#: gitk:2625
+msgid "Show origin of this line"
+msgstr "Hi=E1=BB=83n th=E1=BB=8B nguy=C3=AAn g=E1=BB=91c c=E1=BB=A7a d=
=C3=B2ng n=C3=A0y"
+
+#: gitk:2626
+msgid "Run git gui blame on this line"
+msgstr "Ch=E1=BA=A1y l=E1=BB=87nh git gui blame cho d=C3=B2ng n=C3=A0y=
"
+
+#: gitk:2947
+msgid ""
+"\n"
+"Gitk - a commit viewer for git\n"
+"\n"
+"Copyright =C2=A9 2005-2011 Paul Mackerras\n"
+"\n"
+"Use and redistribute under the terms of the GNU General Public Licens=
e"
+msgstr ""
+"\n"
+"Gitk - ph=E1=BA=A7n m=E1=BB=81m xem c=C3=A1c l=E1=BA=A7n commit d=C3=A0=
nh cho git\n"
+"\n"
+"B=E1=BA=A3n quy=E1=BB=81n =C2=A9 2005-2011 Paul Mackerras\n"
+"\n"
+"D=C3=B9ng v=C3=A0 ph=C3=A2n ph=E1=BB=91i l=E1=BA=A1i ph=E1=BA=A7n m=E1=
=BB=81m n=C3=A0y theo c=C3=A1c =C4=91i=E1=BB=81u kho=E1=BA=A3n c=E1=BB=A7=
a Gi=E1=BA=A5y Ph=C3=A9p C=C3=B4ng GNU"
+
+#: gitk:2955 gitk:3020 gitk:9738
+msgid "Close"
+msgstr "=C4=90=C3=B3ng"
+
+#: gitk:2976
+msgid "Gitk key bindings"
+msgstr "T=E1=BB=95 h=E1=BB=A3p ph=C3=ADm gitk"
+
+#: gitk:2979
+msgid "Gitk key bindings:"
+msgstr "T=E1=BB=95 h=E1=BB=A3p ph=C3=ADm gitk:"
+
+#: gitk:2981
+#, tcl-format
+msgid "<%s-Q>\t\tQuit"
+msgstr "<%s-Q>\t\tTho=C3=A1t"
+
+#: gitk:2982
+#, tcl-format
+msgid "<%s-W>\t\tClose window"
+msgstr "<%s-W>\t\t=C4=90=C3=B3ng c=E1=BB=ADa s=E1=BB=95"
+
+#: gitk:2983
+msgid "<Home>\t\tMove to first commit"
+msgstr "<Home>\t\tChuy=E1=BB=83n =C4=91=E1=BA=BFn l=E1=BA=A7n commit =C4=
=91=E1=BA=A7u ti=C3=AAn"
+
+#: gitk:2984
+msgid "<End>\t\tMove to last commit"
+msgstr "<End>\t\tChuy=E1=BB=83n =C4=91=E1=BA=BFn l=E1=BA=A7n commit cu=
=E1=BB=91i"
+
+#: gitk:2985
+msgid "<Up>, p, k\tMove up one commit"
+msgstr "<Up>, p, k\tDi chuy=E1=BB=83n l=C3=AAn m=E1=BB=99t l=E1=BA=A7n=
 commit"
+
+#: gitk:2986
+msgid "<Down>, n, j\tMove down one commit"
+msgstr "<Down>, n, j\tDi chuy=E1=BB=83n xu=E1=BB=91ng m=E1=BB=99t l=E1=
=BA=A7n commit"
+
+#: gitk:2987
+msgid "<Left>, z, h\tGo back in history list"
+msgstr "<Left>, z, h\tQuay tr=E1=BB=9F l=E1=BA=A1i danh s=C3=A1ch l=E1=
=BB=8Bch s=E1=BB=AD"
+
+#: gitk:2988
+msgid "<Right>, x, l\tGo forward in history list"
+msgstr "<Right>, x, l\tDi chuy=E1=BB=83n ti=E1=BA=BFp trong danh s=C3=A1=
ch l=E1=BB=8Bch s=E1=BB=AD"
+
+#: gitk:2989
+msgid "<PageUp>\tMove up one page in commit list"
+msgstr "<PageUp>\tDi chuy=E1=BB=83n l=C3=AAn m=E1=BB=99t trang trong d=
anh s=C3=A1ch commit"
+
+#: gitk:2990
+msgid "<PageDown>\tMove down one page in commit list"
+msgstr "<PageDown>\tDi chuy=E1=BB=83n xu=E1=BB=91ng m=E1=BB=99t trang =
trong danh s=C3=A1ch commit"
+
+#: gitk:2991
+#, tcl-format
+msgid "<%s-Home>\tScroll to top of commit list"
+msgstr "<%s-Home>\tCu=E1=BB=99n l=C3=AAn tr=C3=AAn c=C3=B9ng c=E1=BB=A7=
a danh s=C3=A1ch commit"
+
+#: gitk:2992
+#, tcl-format
+msgid "<%s-End>\tScroll to bottom of commit list"
+msgstr "<%s-End>\tCu=E1=BB=99n xu=E1=BB=91ng d=C6=B0=E1=BB=9Bi c=C3=B9=
ng c=E1=BB=A7a danh s=C3=A1ch commit"
+
+#: gitk:2993
+#, tcl-format
+msgid "<%s-Up>\tScroll commit list up one line"
+msgstr "<%s-Up>\tCu=E1=BB=99n danh s=C3=A1ch commit l=C3=AAn m=E1=BB=99=
t d=C3=B2ng"
+
+#: gitk:2994
+#, tcl-format
+msgid "<%s-Down>\tScroll commit list down one line"
+msgstr "<%s-Down>\tCu=E1=BB=99n danh s=C3=A1ch commit xu=E1=BB=91ng m=E1=
=BB=99t d=C3=B2ng"
+
+#: gitk:2995
+#, tcl-format
+msgid "<%s-PageUp>\tScroll commit list up one page"
+msgstr "<%s-PageUp>\tCu=E1=BB=99n danh s=C3=A1ch commit l=C3=AAn m=E1=BB=
=99t trang"
+
+#: gitk:2996
+#, tcl-format
+msgid "<%s-PageDown>\tScroll commit list down one page"
+msgstr "<%s-PageDown>\tCu=E1=BB=99n danh s=C3=A1ch commit xu=E1=BB=91n=
g m=E1=BB=99t trang"
+
+#: gitk:2997
+msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
+msgstr "<Shift-Up>\tT=C3=ACm v=E1=BB=81 ph=C3=ADa sau (h=C6=B0=E1=BB=9B=
ng l=C3=AAn tr=C3=AAn, commit sau n=C3=A0y)"
+
+#: gitk:2998
+msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
+msgstr "<Shift-Down>\tT=C3=ACm v=E1=BB=81 ph=C3=ADa tr=C6=B0=E1=BB=9Bc=
 (h=C6=B0=E1=BB=9Bng xu=E1=BB=91ng d=C6=B0=E1=BB=9Bi, commit tr=C6=B0=E1=
=BB=9Bc =C4=91=C3=A2y)"
+
+#: gitk:2999
+msgid "<Delete>, b\tScroll diff view up one page"
+msgstr "<Delete>, b\tCu=E1=BB=99n ph=E1=BA=A7n tr=C3=ACnh b=C3=A0y dif=
f l=C3=AAn m=E1=BB=99t trang"
+
+#: gitk:3000
+msgid "<Backspace>\tScroll diff view up one page"
+msgstr "<Backspace>\tCu=E1=BB=99n ph=E1=BA=A7n tr=C3=ACnh b=C3=A0y dif=
f l=C3=AAn m=E1=BB=99t trang"
+
+#: gitk:3001
+msgid "<Space>\t\tScroll diff view down one page"
+msgstr "<Space>\t\tCu=E1=BB=99n ph=E1=BA=A7n tr=C3=ACnh b=C3=A0y diff =
xu=E1=BB=91ng m=E1=BB=99t trang"
+
+#: gitk:3002
+msgid "u\t\tScroll diff view up 18 lines"
+msgstr "u\t\tCu=E1=BB=99n ph=E1=BA=A7n tr=C3=ACnh b=C3=A0y diff l=C3=AA=
n 18 d=C3=B2ng"
+
+#: gitk:3003
+msgid "d\t\tScroll diff view down 18 lines"
+msgstr "d\t\tCu=E1=BB=99n ph=E1=BA=A7n tr=C3=ACnh b=C3=A0y diff xu=E1=BB=
=91ng 18 d=C3=B2ng"
+
+#: gitk:3004
+#, tcl-format
+msgid "<%s-F>\t\tFind"
+msgstr "<%s-F>\t\tT=C3=ACm ki=E1=BA=BFm"
+
+#: gitk:3005
+#, tcl-format
+msgid "<%s-G>\t\tMove to next find hit"
+msgstr "<%s-G>\t\tDi chuy=E1=BB=83n =C4=91=E1=BA=BFn ch=E1=BB=97 g=E1=BA=
=B7p k=E1=BA=BF ti=E1=BA=BFp"
+
+#: gitk:3006
+msgid "<Return>\tMove to next find hit"
+msgstr "<Return>\t\tDi chuy=E1=BB=83n =C4=91=E1=BA=BFn ch=E1=BB=97 g=E1=
=BA=B7p k=E1=BA=BF ti=E1=BA=BFp"
+
+#: gitk:3007
+msgid "/\t\tFocus the search box"
+msgstr "/\t\t=C4=90=C6=B0a con tr=E1=BB=8F chu=E1=BB=99t v=C3=A0o =C3=B4=
 t=C3=ACm ki=E1=BA=BFm"
+
+#: gitk:3008
+msgid "?\t\tMove to previous find hit"
+msgstr "?\t\tDi chuy=E1=BB=83n =C4=91=E1=BA=BFn ch=E1=BB=97 g=E1=BA=B7=
p k=E1=BA=BF tr=C6=B0=E1=BB=9Bc"
+
+#: gitk:3009
+msgid "f\t\tScroll diff view to next file"
+msgstr "f\t\tCu=E1=BB=99n ph=E1=BA=A7n tr=C3=ACnh b=C3=A0y diff sang t=
=E1=BA=ADp-tin k=E1=BA=BF"
+
+#: gitk:3010
+#, tcl-format
+msgid "<%s-S>\t\tSearch for next hit in diff view"
+msgstr "<%s-S>\t\tT=C3=ACm =C4=91=E1=BA=BFn ch=E1=BB=97 kh=C3=A1c bi=E1=
=BB=87t k=E1=BA=BF ti=E1=BA=BFp"
+
+#: gitk:3011
+#, tcl-format
+msgid "<%s-R>\t\tSearch for previous hit in diff view"
+msgstr "<%s-R>\t\tT=C3=ACm =C4=91=E1=BA=BFn ch=E1=BB=97 kh=C3=A1c bi=E1=
=BB=87t k=E1=BA=BF tr=C6=B0=E1=BB=9Bc"
+
+#: gitk:3012
+#, tcl-format
+msgid "<%s-KP+>\tIncrease font size"
+msgstr "<%s-KP+>\tT=C4=83ng c=E1=BB=A1 ch=E1=BB=AF"
+
+#: gitk:3013
+#, tcl-format
+msgid "<%s-plus>\tIncrease font size"
+msgstr "<%s-plus>\tT=C4=83ng c=E1=BB=A1 ch=E1=BB=AF"
+
+#: gitk:3014
+#, tcl-format
+msgid "<%s-KP->\tDecrease font size"
+msgstr "<%s-KP->\tGi=E1=BA=A3m c=E1=BB=A1 ch=E1=BB=AF"
+
+#: gitk:3015
+#, tcl-format
+msgid "<%s-minus>\tDecrease font size"
+msgstr "<%s-minus>\tGi=E1=BA=A3m c=E1=BB=A1 ch=E1=BB=AF"
+
+#: gitk:3016
+msgid "<F5>\t\tUpdate"
+msgstr "<F5>\t\tC=E1=BA=ADp nh=E1=BA=ADt"
+
+#: gitk:3471 gitk:3480
+#, tcl-format
+msgid "Error creating temporary directory %s:"
+msgstr "G=E1=BA=B7p l=E1=BB=97i khi t=E1=BA=A1o th=C6=B0 m=E1=BB=A5c t=
=E1=BA=A1m %s:"
+
+#: gitk:3493
+#, tcl-format
+msgid "Error getting \"%s\" from %s:"
+msgstr "L=E1=BB=97i ch=C3=A0o h=E1=BB=8Fi \"%s\" t=E1=BB=AB %s:"
+
+#: gitk:3556
+msgid "command failed:"
+msgstr "l=E1=BB=87nh g=E1=BA=B7p l=E1=BB=97i:"
+
+#: gitk:3705
+msgid "No such commit"
+msgstr "Kh=C3=B4ng c=C3=B3 commit nh=C6=B0 v=E1=BA=ADy"
+
+#: gitk:3719
+msgid "git gui blame: command failed:"
+msgstr "git gui blame: l=E1=BB=87nh g=E1=BA=B7p l=E1=BB=97i:"
+
+#: gitk:3750
+#, tcl-format
+msgid "Couldn't read merge head: %s"
+msgstr "Kh=C3=B4ng th=E1=BB=83 =C4=91=E1=BB=99c =C4=91=E1=BA=A7u c=E1=BB=
=A7a h=C3=B2a tr=E1=BB=99n: %s"
+
+# tcl-format
+#: gitk:3758
+#, tcl-format
+msgid "Error reading index: %s"
+msgstr "G=E1=BA=B7p l=E1=BB=97i khi =C4=91=E1=BB=8Dc ch=E1=BB=89 m=E1=BB=
=A5c: %s"
+
+#: gitk:3783
+#, tcl-format
+msgid "Couldn't start git blame: %s"
+msgstr "Kh=C3=B4ng th=E1=BB=83 kh=E1=BB=9Fi ch=E1=BA=A1y git blame: %s=
"
+
+#: gitk:3786 gitk:6652
+msgid "Searching"
+msgstr "=C4=90ang t=C3=ACm ki=E1=BA=BFm"
+
+#: gitk:3818
+#, tcl-format
+msgid "Error running git blame: %s"
+msgstr "G=E1=BA=B7p l=E1=BB=97i khi ch=E1=BA=A1y git blame: %s"
+
+#: gitk:3846
+#, tcl-format
+msgid "That line comes from commit %s,  which is not in this view"
+msgstr "D=C3=B2ng =C4=91=E1=BA=BFn t=E1=BB=AB l=E1=BA=A7n chuy=E1=BB=83=
n giao %s, c=C3=A1i m=C3=A0 kh=C3=B4ng trong tr=C3=ACnh b=C3=A0y n=C3=A0=
y"
+
+#: gitk:3860
+msgid "External diff viewer failed:"
+msgstr "B=E1=BB=99 tr=C3=ACnh b=C3=A0y diff t=E1=BB=AB b=C3=AAn ngo=C3=
=A0i g=E1=BA=B7p l=E1=BB=97i:"
+
+#: gitk:3978
+msgid "Gitk view definition"
+msgstr "=C4=90=E1=BB=8Bnh ngh=C4=A9a c=C3=A1ch tr=C3=ACnh b=C3=A0y git=
k"
+
+#: gitk:3982
+msgid "Remember this view"
+msgstr "Nh=E1=BB=9B c=C3=A1ch tr=C3=ACnh b=C3=A0y n=C3=A0y"
+
+#: gitk:3983
+msgid "References (space separated list):"
+msgstr "Tham chi=E1=BA=BFu (danh s=C3=A1ch ng=C4=83n c=C3=A1ch b=E1=BA=
=B1ng d=E1=BA=A5u c=C3=A1ch):"
+
+#: gitk:3984
+msgid "Branches & tags:"
+msgstr "Nh=C3=A1nh & th=E1=BA=BB:"
+
+#: gitk:3985
+msgid "All refs"
+msgstr "M=E1=BB=8Di tham chi=E1=BA=BFu"
+
+#: gitk:3986
+msgid "All (local) branches"
+msgstr "M=E1=BB=8Di nh=C3=A1nh (n=E1=BB=99i b=E1=BB=99)"
+
+#: gitk:3987
+msgid "All tags"
+msgstr "M=E1=BB=8Di th=E1=BA=BB"
+
+#: gitk:3988
+msgid "All remote-tracking branches"
+msgstr "M=E1=BB=8Di nh=C3=A1nh remote-tracking"
+
+#: gitk:3989
+msgid "Commit Info (regular expressions):"
+msgstr "Th=C3=B4ng tin chuy=E1=BB=83n giao (bi=E1=BB=83u th=E1=BB=A9c =
ch=C3=ADnh quy):"
+
+#: gitk:3990
+msgid "Author:"
+msgstr "T=C3=A1c gi=E1=BA=A3:"
+
+#: gitk:3991
+msgid "Committer:"
+msgstr "Ng=C6=B0=E1=BB=9Di g=E1=BB=ADi:"
+
+#: gitk:3992
+msgid "Commit Message:"
+msgstr "Ch=C3=BA th=C3=ADch c=E1=BB=A7a commit:"
+
+#: gitk:3993
+msgid "Matches all Commit Info criteria"
+msgstr "Kh=E1=BB=9Bp m=E1=BB=8Di =C4=91i=E1=BB=81u ki=E1=BB=87n Th=C3=B4=
ng tin Chuy=E1=BB=83n giao"
+
+#: gitk:3994
+msgid "Changes to Files:"
+msgstr "=C4=90=E1=BB=95i th=C3=A0nh T=E1=BA=ADp tin:"
+
+#: gitk:3995
+msgid "Fixed String"
+msgstr "Chu=E1=BB=97i c=E1=BB=91 =C4=91=E1=BB=8Bnh"
+
+#: gitk:3996
+msgid "Regular Expression"
+msgstr "Bi=E1=BB=83u th=E1=BB=A9c ch=C3=ADnh quy"
+
+#: gitk:3997
+msgid "Search string:"
+msgstr "Chu=E1=BB=97i t=C3=ACm ki=E1=BA=BFm:"
+
+#: gitk:3998
+msgid ""
+"Commit Dates (\"2 weeks ago\", \"2009-03-17 15:27:38\", \"March 17, 2=
009 "
+"15:27:38\"):"
+msgstr ""
+"Ng=C3=A0y chuy=E1=BB=83n giao (\"2 weeks ago\", \"2009-03-17 15:27:38=
\", \"March 17, 2009 "
+"15:27:38\"):"
+
+#: gitk:3999
+msgid "Since:"
+msgstr "K=E1=BB=83 t=E1=BB=AB:"
+
+#: gitk:4000
+msgid "Until:"
+msgstr "=C4=90=E1=BA=BFn:"
+
+#: gitk:4001
+msgid "Limit and/or skip a number of revisions (positive integer):"
+msgstr "Gi=E1=BB=9Bi h=E1=BA=A1n v=C3=A0/ho=E1=BA=B7c b=E1=BB=8F s=E1=BB=
=91 c=E1=BB=A7a =C4=91i=E1=BB=83m x=C3=A9t (s=E1=BB=91 nguy=C3=AAn =C3=A2=
m):"
+
+#: gitk:4002
+msgid "Number to show:"
+msgstr "S=E1=BB=91 l=C6=B0=E1=BB=A3ng hi=E1=BB=83n th=E1=BB=8B:"
+
+#: gitk:4003
+msgid "Number to skip:"
+msgstr "S=E1=BB=91 l=C6=B0=E1=BB=A3ng s=E1=BA=BD b=E1=BB=8F qua:"
+
+#: gitk:4004
+msgid "Miscellaneous options:"
+msgstr "Tu=E1=BB=B3 ch=E1=BB=8Dn h=E1=BB=97n h=E1=BB=A3p:"
+
+#: gitk:4005
+msgid "Strictly sort by date"
+msgstr "S=E1=BA=AFp x=E1=BA=BFp ch=E1=BA=B7t ch=E1=BA=BD theo ng=C3=A0=
y"
+
+#: gitk:4006
+msgid "Mark branch sides"
+msgstr "=C4=90=C3=A1nh d=E1=BA=A5u c=C3=A1c c=E1=BA=A1nh nh=C3=A1nh"
+
+#: gitk:4007
+msgid "Limit to first parent"
+msgstr "Gi=E1=BB=9Bi h=E1=BA=A1n th=C3=A0nh cha m=E1=BA=B9 =C4=91=E1=BA=
=A7u ti=C3=AAn"
+
+#: gitk:4008
+msgid "Simple history"
+msgstr "L=E1=BB=8Bch s=E1=BB=AD d=E1=BA=A1ng =C4=91=C6=A1n gi=E1=BA=A3=
n"
+
+#: gitk:4009
+msgid "Additional arguments to git log:"
+msgstr "=C4=90=E1=BB=91i s=E1=BB=91 b=E1=BB=95 xung cho l=E1=BB=87nh g=
it log:"
+
+#: gitk:4010
+msgid "Enter files and directories to include, one per line:"
+msgstr "Nh=E1=BA=ADp v=C3=A0o c=C3=A1c t=E1=BA=ADp tin v=C3=A0 th=C6=B0=
 m=E1=BB=A5c bao g=E1=BB=93m, m=E1=BB=97i d=C3=B2ng m=E1=BB=99t c=C3=A1=
i:"
+
+#: gitk:4011
+msgid "Command to generate more commits to include:"
+msgstr "L=E1=BB=87nh t=E1=BA=A1o ra nhi=E1=BB=81u l=E1=BA=A7n chuy=E1=BB=
=83n giao h=C6=A1n bao g=E1=BB=93m:"
+
+#: gitk:4135
+msgid "Gitk: edit view"
+msgstr "Gitk: s=E1=BB=ADa c=C3=A1ch tr=C3=ACnh b=C3=A0y"
+
+#: gitk:4143
+msgid "-- criteria for selecting revisions"
+msgstr "-- ti=C3=AAu chu=E1=BA=A9n =C4=91i=E1=BB=83m x=C3=A9t =C4=91=C3=
=A3 ch=E1=BB=8Dn"
+
+#: gitk:4148
+msgid "View Name"
+msgstr "T=C3=AAn c=C3=A1ch tr=C3=ACnh b=C3=A0y"
+
+#: gitk:4223
+msgid "Apply (F5)"
+msgstr "=C3=81p d=E1=BB=A5ng (F5)"
+
+#: gitk:4261
+msgid "Error in commit selection arguments:"
+msgstr "L=E1=BB=97i trong c=C3=A1c =C4=91=E1=BB=91i s=E1=BB=91 ch=E1=BB=
=8Dn chuy=E1=BB=83n giao:"
+
+#: gitk:4314 gitk:4366 gitk:4827 gitk:4841 gitk:6107 gitk:12184 gitk:1=
2185
+msgid "None"
+msgstr "Kh=C3=B4ng"
+
+#: gitk:4924 gitk:4929
+msgid "Descendant"
+msgstr "Con ch=C3=A1u"
+
+#: gitk:4925
+msgid "Not descendant"
+msgstr "Kh=C3=B4ng c=C3=B3 con ch=C3=A1u"
+
+#: gitk:4932 gitk:4937
+msgid "Ancestor"
+msgstr "T=E1=BB=95 ti=C3=AAn chung"
+
+#: gitk:4933
+msgid "Not ancestor"
+msgstr "Kh=C3=B4ng c=C3=B3 chung t=E1=BB=95 ti=C3=AAn"
+
+#: gitk:5223
+msgid "Local changes checked in to index but not committed"
+msgstr ""
+"C=C3=B3 thay =C4=91=E1=BB=95i n=E1=BB=99i b=E1=BB=99 =C4=91=C3=A3 =C4=
=91=C6=B0=E1=BB=A3c =C4=91=C6=B0a v=C3=A0o b=E1=BA=A3ng m=E1=BB=A5c l=E1=
=BB=A5c, nh=C6=B0ng ch=C6=B0a =C4=91=C6=B0=E1=BB=A3c chuy=E1=BB=83n gia=
o"
+
+#: gitk:5259
+msgid "Local uncommitted changes, not checked in to index"
+msgstr "C=C3=B3 thay =C4=91=E1=BB=95i n=E1=BB=99i b=E1=BB=99, nh=C6=B0=
ng ch=C6=B0a =C4=91=C6=B0=E1=BB=A3c =C4=91=C6=B0a v=C3=A0o b=E1=BA=A3ng=
 m=E1=BB=A5c l=E1=BB=A5c"
+
+#: gitk:7032
+msgid "and many more"
+msgstr "v=C3=A0 nhi=E1=BB=81u n=E1=BB=AFa"
+
+#: gitk:7035
+msgid "many"
+msgstr "nhi=E1=BB=81u"
+
+#: gitk:7222
+msgid "Tags:"
+msgstr "Th=E1=BA=BB:"
+
+#: gitk:7239 gitk:7245 gitk:8708
+msgid "Parent"
+msgstr "Cha"
+
+#: gitk:7250
+msgid "Child"
+msgstr "Con"
+
+#: gitk:7259
+msgid "Branch"
+msgstr "Nh=C3=A1nh"
+
+#: gitk:7262
+msgid "Follows"
+msgstr "=C4=90=E1=BB=A9ng sau"
+
+#: gitk:7265
+msgid "Precedes"
+msgstr "=C4=90=E1=BB=A9ng tr=C6=B0=E1=BB=9Bc"
+
+# tcl-format
+#: gitk:7849
+#, tcl-format
+msgid "Error getting diffs: %s"
+msgstr "L=E1=BB=97i l=E1=BA=A5y diff: %s"
+
+#: gitk:8533
+msgid "Goto:"
+msgstr "Nh=E1=BA=A3y t=E1=BB=9Bi:"
+
+#: gitk:8554
+#, tcl-format
+msgid "Short SHA1 id %s is ambiguous"
+msgstr "=C4=90=E1=BB=8Bnh danh SHA1 d=E1=BA=A1ng ng=E1=BA=AFn %s l=C3=A0=
 ch=C6=B0a =C4=91=E1=BB=A7 r=C3=B5 r=C3=A0ng"
+
+#: gitk:8561
+#, tcl-format
+msgid "Revision %s is not known"
+msgstr "Kh=C3=B4ng hi=E1=BB=83u =C4=91i=E1=BB=83m x=C3=A9t duy=E1=BB=87=
t %s"
+
+#: gitk:8571
+#, tcl-format
+msgid "SHA1 id %s is not known"
+msgstr "Kh=C3=B4ng hi=E1=BB=83u =C4=91=E1=BB=8Bnh danh SHA1 %s"
+
+#: gitk:8573
+#, tcl-format
+msgid "Revision %s is not in the current view"
+msgstr "=C4=90i=E1=BB=83m %s kh=C3=B4ng =E1=BB=9F trong ph=E1=BA=A7n h=
i=E1=BB=83n th=E1=BB=8B hi=E1=BB=87n "
+
+#: gitk:8715 gitk:8730
+msgid "Date"
+msgstr "Ng=C3=A0y"
+
+#: gitk:8718
+msgid "Children"
+msgstr "Con ch=C3=A1u"
+
+#: gitk:8781
+#, tcl-format
+msgid "Reset %s branch to here"
+msgstr "=C4=90=E1=BA=B7t l=E1=BA=A1i nh=C3=A1nh %s =E1=BB=9F =C4=91=C3=
=A2y"
+
+#: gitk:8783
+msgid "Detached head: can't reset"
+msgstr "Head =C4=91=C3=A3 b=E1=BB=8B t=C3=A1ch r=E1=BB=9Di: kh=C3=B4ng=
 th=E1=BB=83 =C4=91=E1=BA=B7t l=E1=BA=A1i"
+
+#: gitk:8888 gitk:8894
+msgid "Skipping merge commit "
+msgstr "B=E1=BB=8F qua l=E1=BA=A7n chuy=E1=BB=83n giao h=C3=B2a tr=E1=BB=
=99n"
+
+#: gitk:8903 gitk:8908
+msgid "Error getting patch ID for "
+msgstr "G=E1=BA=B7p l=E1=BB=97i khi l=E1=BA=A5y ID mi=E1=BA=BFng v=C3=A1=
"
+
+#: gitk:8904 gitk:8909
+msgid " - stopping\n"
+msgstr " - d=E1=BB=ABng\n"
+
+#: gitk:8914 gitk:8917 gitk:8925 gitk:8939 gitk:8948
+msgid "Commit "
+msgstr "Commit "
+
+#: gitk:8918
+msgid ""
+" is the same patch as\n"
+"       "
+msgstr ""
+" l=C3=A0 c=C3=B9ng m=E1=BB=99t mi=E1=BA=BFng v=C3=A0 v=E1=BB=9Bi\n"
+"       "
+
+#: gitk:8926
+msgid ""
+" differs from\n"
+"       "
+msgstr ""
+" c=C3=A1c kh=C3=A1c bi=E1=BB=87t t=E1=BB=AB\n"
+"       "
+
+#: gitk:8928
+msgid ""
+"Diff of commits:\n"
+"\n"
+msgstr ""
+"Diff c=E1=BB=A7a l=E1=BA=A7n chuy=E1=BB=83n giao (commit):\n"
+"\n"
+
+#: gitk:8940 gitk:8949
+#, tcl-format
+msgid " has %s children - stopping\n"
+msgstr " c=C3=B3 %s con - d=E1=BB=ABng\n"
+
+#: gitk:8968
+#, tcl-format
+msgid "Error writing commit to file: %s"
+msgstr "G=E1=BA=B7p l=E1=BB=97i trong qu=C3=A1 tr=C3=ACnh ghi commit v=
=C3=A0o t=E1=BA=ADp tin: %s"
+
+#: gitk:8974
+#, tcl-format
+msgid "Error diffing commits: %s"
+msgstr "G=E1=BA=B7p l=E1=BB=97i khi so s=C3=A1nh s=E1=BB=B1 kh=C3=A1c =
bi=E1=BB=87t gi=E1=BB=AFa c=C3=A1c l=E1=BA=A7n chuy=E1=BB=83n giao: %s"
+
+#: gitk:9020
+msgid "Top"
+msgstr "=C4=90=E1=BB=89nh"
+
+#: gitk:9021
+msgid "From"
+msgstr "T=E1=BB=AB"
+
+#: gitk:9026
+msgid "To"
+msgstr "=C4=90=E1=BA=BFn"
+
+#: gitk:9050
+msgid "Generate patch"
+msgstr "T=E1=BA=A1o mi=E1=BA=BFng v=C3=A1"
+
+#: gitk:9052
+msgid "From:"
+msgstr "T=E1=BB=AB:"
+
+#: gitk:9061
+msgid "To:"
+msgstr "=C4=90=E1=BA=BFn:"
+
+#: gitk:9070
+msgid "Reverse"
+msgstr "=C4=90=E1=BA=A3o ng=C6=B0=E1=BB=A3c"
+
+#: gitk:9072 gitk:9268
+msgid "Output file:"
+msgstr "T=E1=BA=ADp tin k=E1=BA=BFt xu=E1=BA=A5t:"
+
+#: gitk:9078
+msgid "Generate"
+msgstr "T=E1=BA=A1o"
+
+#: gitk:9116
+msgid "Error creating patch:"
+msgstr "G=E1=BA=B7p l=E1=BB=97i khi t=E1=BA=A1o mi=E1=BA=BFng v=C3=A1:=
"
+
+#: gitk:9139 gitk:9256 gitk:9313
+msgid "ID:"
+msgstr "ID:"
+
+#: gitk:9148
+msgid "Tag name:"
+msgstr "T=C3=AAn th=E1=BA=BB:"
+
+#: gitk:9151
+msgid "Tag message is optional"
+msgstr "Ghi ch=C3=BA th=E1=BA=BB ch=E1=BB=89 l=C3=A0 t=C3=B9y ch=E1=BB=
=8Dn"
+
+#: gitk:9153
+msgid "Tag message:"
+msgstr "Ghi ch=C3=BA cho th=E1=BA=BB:"
+
+#: gitk:9157 gitk:9322
+msgid "Create"
+msgstr "T=E1=BA=A1o"
+
+#: gitk:9175
+msgid "No tag name specified"
+msgstr "Ch=C6=B0a ch=E1=BB=89 ra t=C3=AAn c=E1=BB=A7a th=E1=BA=BB"
+
+#: gitk:9179
+#, tcl-format
+msgid "Tag \"%s\" already exists"
+msgstr "Th=E1=BA=BB =E2=80=9C%s=E2=80=9D =C4=91=C3=A3 c=C3=B3 s=E1=BA=B5=
n r=E1=BB=93i"
+
+#: gitk:9189
+msgid "Error creating tag:"
+msgstr "G=E1=BA=B7p l=E1=BB=97i khi t=E1=BA=A1o th=E1=BA=BB:"
+
+#: gitk:9265
+msgid "Command:"
+msgstr "L=E1=BB=87nh:"
+
+#: gitk:9273
+msgid "Write"
+msgstr "Ghi"
+
+#: gitk:9291
+msgid "Error writing commit:"
+msgstr "G=E1=BA=B7p l=E1=BB=97i trong qu=C3=A1 tr=C3=ACnh ghi commit:"
+
+#: gitk:9318
+msgid "Name:"
+msgstr "T=C3=AAn:"
+
+#: gitk:9341
+msgid "Please specify a name for the new branch"
+msgstr "Vui l=C3=B2ng ch=E1=BB=89 =C4=91=E1=BB=8Bnh t=C3=AAn cho nh=C3=
=A1nh m=E1=BB=9Bi"
+
+#: gitk:9346
+#, tcl-format
+msgid "Branch '%s' already exists. Overwrite?"
+msgstr "Nh=C3=A1nh =E2=80=9C%s=E2=80=9D =C4=91=C3=A3 c=C3=B3 t=E1=BB=AB=
 tr=C6=B0=E1=BB=9Bc r=E1=BB=93i. Ghi =C4=91=C3=A8?"
+
+#: gitk:9413
+#, tcl-format
+msgid "Commit %s is already included in branch %s -- really re-apply i=
t?"
+msgstr ""
+"L=E1=BA=A7n chuy=E1=BB=83n giao %s =C4=91=C3=A3 s=E1=BA=B5n =C4=91=C6=
=B0=E1=BB=A3c bao g=E1=BB=93m trong nh=C3=A1nh %s -- b=E1=BA=A1n c=C3=B3=
 th=E1=BB=B1c s=E1=BB=B1 mu=E1=BB=91n "
+"=C3=A1p d=E1=BB=A5ng l=E1=BA=A1i n=C3=B3 kh=C3=B4ng?"
+
+#: gitk:9418
+msgid "Cherry-picking"
+msgstr "=C4=90ang cherry-pick"
+
+#: gitk:9427
+#, tcl-format
+msgid ""
+"Cherry-pick failed because of local changes to file '%s'.\n"
+"Please commit, reset or stash your changes and try again."
+msgstr ""
+"Cherry-pick g=E1=BA=B7p l=E1=BB=97i b=E1=BB=9Fi v=C3=AC c=C3=A1c thay=
 =C4=91=E1=BB=95i n=E1=BB=99i b=E1=BB=99 t=E1=BA=ADp tin =E2=80=9C%s=E2=
=80=9D.\n"
+"Xin h=C3=A3y chuy=E1=BB=83n giao, reset hay stash c=C3=A1c thay =C4=91=
=E1=BB=95i c=E1=BB=A7a b=E1=BA=A1n sau =C4=91=C3=B3 th=E1=BB=AD l=E1=BA=
=A1i."
+
+#: gitk:9433
+msgid ""
+"Cherry-pick failed because of merge conflict.\n"
+"Do you wish to run git citool to resolve it?"
+msgstr ""
+"Cherry-pick g=E1=BA=B7p l=E1=BB=97i b=E1=BB=9Fi v=C3=AC xung =C4=91=E1=
=BB=99t trong h=C3=B2a tr=E1=BB=99n.\n"
+"B=E1=BA=A1n c=C3=B3 mu=E1=BB=91n ch=E1=BA=A1y l=E1=BB=87nh =E2=80=9Cg=
it citool=E2=80=9D =C4=91=E1=BB=83 gi=E1=BA=A3i quy=E1=BA=BFt v=E1=BA=A5=
n =C4=91=E1=BB=81 n=C3=A0y kh=C3=B4ng?"
+
+#: gitk:9449 gitk:9507
+msgid "No changes committed"
+msgstr "Kh=C3=B4ng c=C3=B3 thay =C4=91=E1=BB=95i n=C3=A0o c=E1=BA=A7n =
chuy=E1=BB=83n giao"
+
+#: gitk:9476
+#, tcl-format
+msgid "Commit %s is not included in branch %s -- really revert it?"
+msgstr ""
+"L=E1=BA=A7n chuy=E1=BB=83n giao %s kh=C3=B4ng =C4=91=C6=B0=E1=BB=A3c =
bao g=E1=BB=93m trong nh=C3=A1nh %s -- b=E1=BA=A1n c=C3=B3 th=E1=BB=B1c=
 s=E1=BB=B1 mu=E1=BB=91n "
+"=E2=80=9Crevert=E2=80=9D n=C3=B3 kh=C3=B4ng?"
+
+#: gitk:9481
+msgid "Reverting"
+msgstr "=C4=90ang ho=C3=A0n t=C3=A1c"
+
+#: gitk:9489
+#, tcl-format
+msgid ""
+"Revert failed because of local changes to the following files:%s Plea=
se "
+"commit, reset or stash  your changes and try again."
+msgstr ""
+"Revert g=E1=BA=B7p l=E1=BB=97i b=E1=BB=9Fi v=C3=AC t=E1=BA=ADp tin sa=
u =C4=91=C3=A3 =C4=91=C6=B0=E1=BB=A3c thay =C4=91=E1=BB=95i n=E1=BB=99i=
 b=E1=BB=99:%s\n"
+"Xin h=C3=A3y =E2=80=9Ccommit=E2=80=9D, =E2=80=9Creset=E2=80=9D ho=E1=BA=
=B7c =E2=80=9Cstash=E2=80=9D c=C3=A1c thay =C4=91=E1=BB=95i c=E1=BB=A7a=
 b=E1=BA=A1n r=E1=BB=93i th=E1=BB=AD l=E1=BA=A1i."
+
+#: gitk:9493
+msgid ""
+"Revert failed because of merge conflict.\n"
+" Do you wish to run git citool to resolve it?"
+msgstr ""
+"Revert g=E1=BA=B7p l=E1=BB=97i b=E1=BB=9Fi v=C3=AC xung =C4=91=E1=BB=99=
t h=C3=B2a tr=E1=BB=99n.\n"
+" B=E1=BA=A1n c=C3=B3 mu=E1=BB=91n ch=E1=BA=A1y l=E1=BB=87nh =E2=80=9C=
git citool=E2=80=9D =C4=91=E1=BB=83 ph=C3=A2n gi=E1=BA=A3i n=C3=B3 kh=C3=
=B4ng?"
+
+#: gitk:9536
+msgid "Confirm reset"
+msgstr "X=C3=A1c nh=E1=BA=ADt =C4=91=E1=BA=B7t l=E1=BA=A1i"
+
+#: gitk:9538
+#, tcl-format
+msgid "Reset branch %s to %s?"
+msgstr "=C4=90=E1=BA=B7t l=E1=BA=A1i nh=C3=A1nh =E2=80=9C%s=E2=80=9D t=
h=C3=A0nh =E2=80=9C%s=E2=80=9D?"
+
+#: gitk:9540
+msgid "Reset type:"
+msgstr "Ki=E1=BB=83u =C4=91=E1=BA=B7t l=E1=BA=A1i:"
+
+#: gitk:9543
+msgid "Soft: Leave working tree and index untouched"
+msgstr "M=E1=BB=81m: Kh=C3=B4ng =C4=91=E1=BB=99ng =C4=91=E1=BA=BFn th=C6=
=B0 m=E1=BB=A5c l=C3=A0m vi=E1=BB=87c v=C3=A0 b=E1=BA=A3ng m=E1=BB=A5c =
l=E1=BB=A5c"
+
+#: gitk:9546
+msgid "Mixed: Leave working tree untouched, reset index"
+msgstr ""
+"Pha tr=E1=BB=99n: Kh=C3=B4ng =C4=91=E1=BB=99ng ch=E1=BA=A1m =C4=91=E1=
=BA=BFn th=C6=B0 m=E1=BB=A5c l=C3=A0m vi=E1=BB=87c nh=C6=B0ng =C4=91=E1=
=BA=B7t l=E1=BA=A1i b=E1=BA=A3ng m=E1=BB=A5c l=E1=BB=A5c"
+
+#: gitk:9549
+msgid ""
+"Hard: Reset working tree and index\n"
+"(discard ALL local changes)"
+msgstr ""
+"Hard: =C4=90=E1=BA=B7t l=E1=BA=A1i c=C3=A2y l=C3=A0m vi=E1=BB=87c v=C3=
=A0 m=E1=BB=A5c l=E1=BB=A5c\n"
+"(h=E1=BB=A7y b=E1=BB=8F M=E1=BB=8CI thay =C4=91=E1=BB=95i n=E1=BB=99i=
 b=E1=BB=99)"
+
+#: gitk:9566
+msgid "Resetting"
+msgstr "=C4=90ang =C4=91=E1=BA=B7t l=E1=BA=A1i"
+
+#: gitk:9626
+msgid "Checking out"
+msgstr "=C4=90ang checkout"
+
+#: gitk:9679
+msgid "Cannot delete the currently checked-out branch"
+msgstr "Kh=C3=B4ng th=E1=BB=83 x=C3=B3a nh=C3=A1nh hi=E1=BB=87n t=E1=BA=
=A1i =C4=91ang =C4=91=C6=B0=E1=BB=A3c l=E1=BA=A5y "
+
+#: gitk:9685
+#, tcl-format
+msgid ""
+"The commits on branch %s aren't on any other branch.\n"
+"Really delete branch %s?"
+msgstr ""
+"C=C3=A1c l=E1=BA=A7n chuy=E1=BB=83n giao tr=C3=AAn nh=C3=A1nh %s kh=C3=
=B4ng =E1=BB=9F tr=C3=AAn nh=C3=A1nh kh=C3=A1c.\n"
+"Th=E1=BB=B1c s=E1=BB=B1 mu=E1=BB=91n x=C3=B3a nh=C3=A1nh %s?"
+
+#: gitk:9716
+#, tcl-format
+msgid "Tags and heads: %s"
+msgstr "Th=E1=BA=BB v=C3=A0 =C4=90=E1=BA=A7u: %s"
+
+#: gitk:9731
+msgid "Filter"
+msgstr "B=E1=BB=99 l=E1=BB=8Dc"
+
+#: gitk:10027
+msgid ""
+"Error reading commit topology information; branch and preceding/follo=
wing "
+"tag information will be incomplete."
+msgstr ""
+"G=E1=BA=B7p l=E1=BB=97i khi =C4=91=E1=BB=8Dc th=C3=B4ng tin h=C3=ACnh=
 h=E1=BB=8Dc l=E1=BA=A7n chuy=E1=BB=83n giao; th=C3=B4ng tin nh=C3=A1nh=
 v=C3=A0 th=E1=BA=BB "
+"tr=C6=B0=E1=BB=9Bc/sau s=E1=BA=BD kh=C3=B4ng ho=C3=A0n thi=E1=BB=87n.=
"
+
+#: gitk:11004
+msgid "Tag"
+msgstr "Th=E1=BA=BB"
+
+#: gitk:11008
+msgid "Id"
+msgstr "Id"
+
+#: gitk:11091
+msgid "Gitk font chooser"
+msgstr "B=E1=BB=99 ch=E1=BB=8Dn ph=C3=B4ng Gitk"
+
+#: gitk:11108
+msgid "B"
+msgstr "B"
+
+#: gitk:11111
+msgid "I"
+msgstr "I"
+
+#: gitk:11229
+msgid "Commit list display options"
+msgstr "C=C3=A1c t=C3=B9y ch=E1=BB=8Dn v=E1=BB=81 hi=E1=BB=83n th=E1=BB=
=8B danh s=C3=A1ch commit"
+
+#: gitk:11232
+msgid "Maximum graph width (lines)"
+msgstr "=C4=90=E1=BB=99 r=E1=BB=99ng bi=E1=BB=83u =C4=91=E1=BB=93 t=E1=
=BB=91i =C4=91a (d=C3=B2ng)"
+
+#: gitk:11235
+#, tcl-format
+msgid "Maximum graph width (% of pane)"
+msgstr "=C4=90=E1=BB=99 r=E1=BB=99ng bi=E1=BB=83u =C4=91=E1=BB=93 t=E1=
=BB=91i =C4=91a (% c=E1=BB=A7a b=E1=BA=A3ng hi=E1=BB=83n)"
+
+#: gitk:11238
+msgid "Show local changes"
+msgstr "Hi=E1=BB=83n th=E1=BB=8B c=C3=A1c thay =C4=91=E1=BB=95i n=E1=BB=
=99i b=E1=BB=99"
+
+#: gitk:11241
+msgid "Auto-select SHA1 (length)"
+msgstr "T=E1=BB=B1 ch=E1=BB=8Dn SHA1 (=C4=91=E1=BB=99 d=C3=A0i)"
+
+#: gitk:11245
+msgid "Hide remote refs"
+msgstr "=E1=BA=A8n tham chi=E1=BA=BFu =C4=91=E1=BA=BFn m=C3=A1y ch=E1=BB=
=A7"
+
+#: gitk:11249
+msgid "Diff display options"
+msgstr "C=C3=A1c t=C3=B9y ch=E1=BB=8Dn hi=E1=BB=83n th=E1=BB=8B diff"
+
+#: gitk:11251
+msgid "Tab spacing"
+msgstr "Kho=E1=BA=A3ng c=C3=A1ch tab"
+
+#: gitk:11254
+msgid "Display nearby tags/heads"
+msgstr "Hi=E1=BB=83n th=E1=BB=8B c=C3=A1c th=E1=BA=BB/=C4=91=E1=BA=A7u=
 xung quanh"
+
+#: gitk:11257
+msgid "Maximum # tags/heads to show"
+msgstr "S=E1=BB=91 l=C6=B0=E1=BB=A3ng th=E1=BA=BB/=C4=91=E1=BA=A7u t=E1=
=BB=91i =C4=91a s=E1=BA=BD hi=E1=BB=83n th=E1=BB=8B"
+
+#: gitk:11260
+msgid "Limit diffs to listed paths"
+msgstr "Gi=E1=BB=9Bi h=E1=BA=A1n c=C3=A1c kh=C3=A1c bi=E1=BB=87t cho =C4=
=91=C6=B0=E1=BB=9Dng d=E1=BA=ABn =C4=91=C3=A3 li=E1=BB=87t k=C3=AA"
+
+#: gitk:11263
+msgid "Support per-file encodings"
+msgstr "H=E1=BB=97 tr=E1=BB=A3 m=C3=A3 h=C3=B3a m=E1=BB=97i-d=C3=B2ng"
+
+#: gitk:11269 gitk:11416
+msgid "External diff tool"
+msgstr "C=C3=B4ng c=E1=BB=A5 diff t=E1=BB=AB b=C3=AAn ngo=C3=A0i"
+
+#: gitk:11270
+msgid "Choose..."
+msgstr "Ch=E1=BB=8Dn..."
+
+#: gitk:11275
+msgid "General options"
+msgstr "C=C3=A1c t=C3=B9y ch=E1=BB=8Dn chung"
+
+#: gitk:11278
+msgid "Use themed widgets"
+msgstr "D=C3=B9ng c=C3=A1c widget ch=E1=BB=A7 =C4=91=E1=BB=81"
+
+#: gitk:11280
+msgid "(change requires restart)"
+msgstr "(=C4=91=E1=BB=83 thay =C4=91=E1=BB=95i c=E1=BA=A7n kh=E1=BB=9F=
i =C4=91=E1=BB=99ng l=E1=BA=A1i)"
+
+#: gitk:11282
+msgid "(currently unavailable)"
+msgstr "(hi=E1=BB=87n t=E1=BA=A1i kh=C3=B4ng s=E1=BA=B5n s=C3=A0ng)"
+
+#: gitk:11293
+msgid "Colors: press to choose"
+msgstr "M=C3=A0u: b=E1=BA=A5m =C4=91=E1=BB=83 ch=E1=BB=8Dn"
+
+#: gitk:11296
+msgid "Interface"
+msgstr "Giao di=E1=BB=87n"
+
+#: gitk:11297
+msgid "interface"
+msgstr "giao di=E1=BB=87n"
+
+#: gitk:11300
+msgid "Background"
+msgstr "N=E1=BB=81n"
+
+#: gitk:11301 gitk:11331
+msgid "background"
+msgstr "n=E1=BB=81n"
+
+#: gitk:11304
+msgid "Foreground"
+msgstr "Ti=E1=BB=81n c=E1=BA=A3nh"
+
+#: gitk:11305
+msgid "foreground"
+msgstr "ti=E1=BB=81n c=E1=BA=A3nh"
+
+#: gitk:11308
+msgid "Diff: old lines"
+msgstr "Diff: d=C3=B2ng c=C5=A9"
+
+#: gitk:11309
+msgid "diff old lines"
+msgstr "diff d=C3=B2ng m=E1=BB=9Bi"
+
+#: gitk:11313
+msgid "Diff: new lines"
+msgstr "Diff: d=C3=B2ng m=E1=BB=9Bi"
+
+#: gitk:11314
+msgid "diff new lines"
+msgstr "diff d=C3=B2ng m=E1=BB=9Bi"
+
+#: gitk:11318
+msgid "Diff: hunk header"
+msgstr "Diff: ph=E1=BA=A7n =C4=91=E1=BA=A7u kh=C3=BAc"
+
+#: gitk:11320
+msgid "diff hunk header"
+msgstr "diff ph=E1=BA=A7n =C4=91=E1=BA=A7u kh=C3=BAc"
+
+#: gitk:11324
+msgid "Marked line bg"
+msgstr "N=E1=BB=81n d=C3=B2ng =C4=91=C3=A1nh d=E1=BA=A5u"
+
+#: gitk:11326
+msgid "marked line background"
+msgstr "n=E1=BB=81n d=C3=B2ng =C4=91=C6=B0=E1=BB=A3c =C4=91=C3=A1nh d=E1=
=BA=A5u"
+
+#: gitk:11330
+msgid "Select bg"
+msgstr "Ch=E1=BB=8Dn n=E1=BB=81n"
+
+#: gitk:11339
+msgid "Fonts: press to choose"
+msgstr "Ph=C3=B4ng: b=E1=BA=A5m v=C3=A0o =C4=91=C3=A2y =C4=91=E1=BB=83=
 ch=E1=BB=8Dn"
+
+#: gitk:11341
+msgid "Main font"
+msgstr "C=E1=BB=A1 ph=C3=B4ng ch=E1=BB=AF ch=C3=ADnh"
+
+#: gitk:11342
+msgid "Diff display font"
+msgstr "Ph=C3=B4ng ch=E1=BB=AF tr=C3=ACnh b=C3=A0y diff"
+
+#: gitk:11343
+msgid "User interface font"
+msgstr "Ph=C3=B4ng giao di=E1=BB=87n ng=C6=B0=E1=BB=9Di d=C3=B9ng"
+
+#: gitk:11365
+msgid "Gitk preferences"
+msgstr "C=C3=A1 nh=C3=A2n h=C3=B3a c=C3=A1c c=C3=A0i =C4=91=E1=BA=B7t =
cho Gitk"
+
+#: gitk:11374
+msgid "General"
+msgstr "Chung"
+
+#: gitk:11375
+msgid "Colors"
+msgstr "M=C3=A0u s=E1=BA=AFc"
+
+#: gitk:11376
+msgid "Fonts"
+msgstr "Ph=C3=B4ng ch=E1=BB=AF"
+
+#: gitk:11426
+#, tcl-format
+msgid "Gitk: choose color for %s"
+msgstr "Gitk: ch=E1=BB=8Dn m=C3=A0u cho %s"
+
+#: gitk:12080
+msgid "Cannot find a git repository here."
+msgstr "Kh=C3=B4ng th=E1=BB=83 t=C3=ACm th=E1=BA=A5y kho git =E1=BB=9F=
 =C4=91=C3=A2y."
+
+#: gitk:12127
+#, tcl-format
+msgid "Ambiguous argument '%s': both revision and filename"
+msgstr "=C4=90=E1=BB=91i s=E1=BB=91 =E2=80=9C%s=E2=80=9D ch=C6=B0a r=C3=
=B5 r=C3=A0ng: v=E1=BB=ABa l=C3=A0 =C4=91i=E1=BB=83m x=C3=A9t duy=E1=BB=
=87t v=E1=BB=ABa l=C3=A0 t=C3=AAn t=E1=BA=ADp tin"
+
+#: gitk:12139
+msgid "Bad arguments to gitk:"
+msgstr "=C4=90=E1=BB=91i s=E1=BB=91 kh=C3=B4ng h=E1=BB=A3p l=E1=BB=87 =
cho gitk:"
+
+#: gitk:12242
+msgid "Command line"
+msgstr "D=C3=B2ng l=E1=BB=87nh"
diff --git a/po/vi.po b/po/vi.po
index 05420eb..d6b219b 100644
--- a/po/vi.po
+++ b/po/vi.po
@@ -8,8 +8,8 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-v1.8.5-rc0-24-g727b957\n"
 "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
-"POT-Creation-Date: 2013-11-02 08:06+0800\n"
-"PO-Revision-Date: 2013-11-02 13:15+0700\n"
+"POT-Creation-Date: 2013-11-02 09:02+0800\n"
+"PO-Revision-Date: 2013-11-22 09:13+0700\n"
 "Last-Translator: Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n <vnwildman@gmail=
=2Ecom>\n"
 "Language-Team: Vietnamese <translation-team-vi@lists.sourceforge.net>=
\n"
 "Language: vi\n"
@@ -22,7 +22,7 @@ msgstr ""
 "X-Poedit-Basepath: ../\n"
 "X-Generator: Poedit 1.5.5\n"
=20
-#: advice.c:57
+#: advice.c:55
 #, c-format
 msgid "hint: %.*s\n"
 msgstr "t=C3=ACm th=E1=BA=A5y: %.*s\n"
@@ -31,7 +31,7 @@ msgstr "t=C3=ACm th=E1=BA=A5y: %.*s\n"
 #. * Message used both when 'git commit' fails and when
 #. * other commands doing a merge do.
 #.
-#: advice.c:87
+#: advice.c:85
 msgid ""
 "Fix them up in the work tree,\n"
 "and then use 'git add/rm <file>' as\n"
@@ -62,7 +62,7 @@ msgstr ""
 msgid "git archive --remote <repo> [--exec <cmd>] --list"
 msgstr "git archive --remote <kho> [--exec <l=E1=BB=87nh>] --list"
=20
-#: archive.c:242 builtin/add.c:240 builtin/add.c:556 builtin/rm.c:328
+#: archive.c:242 builtin/add.c:136 builtin/add.c:427 builtin/rm.c:328
 #, c-format
 msgid "pathspec '%s' did not match any files"
 msgstr "=C4=91=E1=BA=B7c t=E1=BA=A3 =C4=91=C6=B0=E1=BB=9Dng d=E1=BA=AB=
n =E2=80=9C%s=E2=80=9D kh=C3=B4ng kh=E1=BB=9Bp v=E1=BB=9Bi b=E1=BA=A5t =
k=E1=BB=B3 t=E1=BA=ADp tin n=C3=A0o"
@@ -83,8 +83,8 @@ msgstr "ti=E1=BB=81n t=E1=BB=91"
 msgid "prepend prefix to each pathname in the archive"
 msgstr "n=E1=BB=91i th=C3=AAm ti=E1=BB=81n t=E1=BB=91 v=C3=A0o t=E1=BB=
=ABng =C4=91=C6=B0=E1=BB=9Dng d=E1=BA=ABn t=E1=BA=ADp tin trong kho l=C6=
=B0u"
=20
-#: archive.c:330 builtin/archive.c:88 builtin/blame.c:2264
-#: builtin/blame.c:2265 builtin/config.c:58 builtin/fast-export.c:680
+#: archive.c:330 builtin/archive.c:88 builtin/blame.c:2265
+#: builtin/blame.c:2266 builtin/config.c:58 builtin/fast-export.c:680
 #: builtin/fast-export.c:682 builtin/grep.c:716 builtin/hash-object.c:=
77
 #: builtin/ls-files.c:486 builtin/ls-files.c:489 builtin/notes.c:408
 #: builtin/notes.c:565 builtin/read-tree.c:108 parse-options.h:154
@@ -332,7 +332,7 @@ msgstr "T=E1=BB=AB ch=E1=BB=91i t=E1=BA=A1o m=E1=BB=
=99t bundle tr=E1=BB=91ng r=E1=BB=97ng."
=20
 #: bundle.c:398
 msgid "Could not spawn pack-objects"
-msgstr "Kh=C3=B4ng th=E1=BB=83 s=E1=BA=A3n sinh pack-objects"
+msgstr "Kh=C3=B4ng th=E1=BB=83 s=E1=BA=A3n sinh =C4=91=E1=BB=91i t=C6=B0=
=E1=BB=A3ng g=C3=B3i"
=20
 #: bundle.c:416
 msgid "pack-objects died"
@@ -770,7 +770,7 @@ msgstr "=C4=90=C3=A3 b=E1=BB=8F qua %s (=C4=91=C3=A3=
 c=C3=B3 s=E1=BA=B5n l=E1=BA=A7n h=C3=B2a tr=E1=BB=99n n=C3=A0y)"
 msgid "Auto-merging %s"
 msgstr "T=E1=BB=B1-=C4=91=E1=BB=99ng-h=C3=B2a-tr=E1=BB=99n %s"
=20
-#: merge-recursive.c:1634 git-submodule.sh:1125
+#: merge-recursive.c:1634 git-submodule.sh:1130
 msgid "submodule"
 msgstr "m=C3=B4-=C4=91un-con"
=20
@@ -912,36 +912,36 @@ msgstr ""
 "c=C3=A0i =C4=91=E1=BA=B7t =C4=91=E1=BA=B7c t=E1=BA=A3 =C4=91=C6=B0=E1=
=BB=9Dng d=E1=BA=ABn =E2=80=9Cliteral=E2=80=9D to=C3=A0n c=E1=BB=A5c l=C3=
=A0 xung kh=E1=BA=AFc v=E1=BB=9Bi c=C3=A1c c=C3=A0i =C4=91=E1=BA=B7t =C4=
=91=E1=BA=B7c "
 "t=E1=BA=A3 =C4=91=C6=B0=E1=BB=9Dng d=E1=BA=ABn to=C3=A0n c=E1=BB=A5c =
kh=C3=A1c"
=20
-#: pathspec.c:158
+#: pathspec.c:162
 msgid "invalid parameter for pathspec magic 'prefix'"
 msgstr "tham s=E1=BB=91 kh=C3=B4ng h=E1=BB=A3p l=E1=BB=87 cho =E2=80=9C=
ti=E1=BB=81n t=E1=BB=91=E2=80=9D m=C3=A0u nhi=E1=BB=87m =C4=91=E1=BA=B7=
c t=E1=BA=A3 =C4=91=C6=B0=E1=BB=9Dng =C4=91=E1=BA=ABn"
=20
-#: pathspec.c:164
+#: pathspec.c:168
 #, c-format
 msgid "Invalid pathspec magic '%.*s' in '%s'"
 msgstr "S=E1=BB=91 m=C3=A0u nhi=E1=BB=87m =C4=91=E1=BA=B7c t=E1=BA=A3 =
=C4=91=C6=B0=E1=BB=9Dng d=E1=BA=ABn kh=C3=B4ng h=E1=BB=A3p l=E1=BB=87 =E2=
=80=9C%.*s=E2=80=9D trong =E2=80=9C%s=E2=80=9D"
=20
-#: pathspec.c:168
+#: pathspec.c:172
 #, c-format
 msgid "Missing ')' at the end of pathspec magic in '%s'"
 msgstr "Thi=E1=BA=BFu =E2=80=9C)=E2=80=9D t=E1=BA=A1i cu=E1=BB=91i c=E1=
=BB=A7a s=E1=BB=91 m=C3=A0u nhi=E1=BB=87m =C4=91=E1=BA=B7c t=E1=BA=A3 =C4=
=91=C6=B0=E1=BB=9Dng d=E1=BA=ABn trong =E2=80=9C%s=E2=80=9D"
=20
-#: pathspec.c:186
+#: pathspec.c:190
 #, c-format
 msgid "Unimplemented pathspec magic '%c' in '%s'"
 msgstr "Ch=C6=B0a vi=E1=BA=BFt m=C3=A3 cho s=E1=BB=91 m=C3=A0u nhi=E1=BB=
=87m =C4=91=E1=BA=B7c t=E1=BA=A3 =C4=91=C6=B0=E1=BB=9Dng d=E1=BA=ABn =E2=
=80=9C%c=E2=80=9D trong =E2=80=9C%s=E2=80=9D"
=20
-#: pathspec.c:211
+#: pathspec.c:215
 #, c-format
 msgid "%s: 'literal' and 'glob' are incompatible"
 msgstr "%s: =E2=80=9Cliteral=E2=80=9D v=C3=A0 =E2=80=9Cglob=E2=80=9D x=
ung kh=E1=BA=AFc nhau"
=20
-#: pathspec.c:222
+#: pathspec.c:226
 #, c-format
 msgid "%s: '%s' is outside repository"
 msgstr "%s: =E2=80=9C%s=E2=80=9D ngo=C3=A0i m=E1=BB=99t kho ch=E1=BB=A9=
a"
=20
-#: pathspec.c:278
+#: pathspec.c:282
 #, c-format
 msgid "Pathspec '%s' is in submodule '%.*s'"
 msgstr "=C4=90=E1=BA=B7c t=E1=BA=A3 =C4=91=C6=B0=E1=BB=9Dng d=E1=BA=AB=
n =E2=80=9C%s=E2=80=9D th=C3=AC =E1=BB=9F trong m=C3=B4-=C4=91un-con =E2=
=80=9C%.*s=E2=80=9D"
@@ -951,12 +951,12 @@ msgstr "=C4=90=E1=BA=B7c t=E1=BA=A3 =C4=91=C6=B0=E1=
=BB=9Dng d=E1=BA=ABn =E2=80=9C%s=E2=80=9D th=C3=AC =E1=BB=9F trong m=C3=
=B4-=C4=91un-con =E2=80=9C%.*s
 #. * name. E.g. when add--interactive dies when running
 #. * "checkout -p"
 #.
-#: pathspec.c:340
+#: pathspec.c:344
 #, c-format
 msgid "%s: pathspec magic not supported by this command: %s"
 msgstr "%s: s=E1=BB=91 m=E1=BA=A7u nhi=E1=BB=87m =C4=91=E1=BA=B7c t=E1=
=BA=A3 =C4=91=C6=B0=E1=BB=9Dng d=E1=BA=ABn ch=C6=B0a =C4=91=C6=B0=E1=BB=
=A3c h=E1=BB=97 tr=E1=BB=A3 b=E1=BB=9Fi l=E1=BB=87nh n=C3=A0y: %s"
=20
-#: pathspec.c:415
+#: pathspec.c:422
 #, c-format
 msgid "pathspec '%s' is beyond a symbolic link"
 msgstr "=C4=91=E1=BA=B7c t=E1=BA=A3 =C4=91=C6=B0=E1=BB=9Dng d=E1=BA=AB=
n =E2=80=9C%s=E2=80=9D v=C6=B0=E1=BB=A3t ra ngo=C3=A0i li=C3=AAn k=E1=BA=
=BFt m=E1=BB=81m"
@@ -1309,21 +1309,21 @@ msgstr ""
 "n=C3=A0y\n"
 "b=E1=BA=B1ng c=C3=A1ch ch=E1=BA=A1y l=E1=BB=87nh \"git config advice.=
objectNameWarning false\""
=20
-#: sha1_name.c:1112
+#: sha1_name.c:1110
 msgid "HEAD does not point to a branch"
 msgstr "HEAD kh=C3=B4ng ch=E1=BB=89 =C4=91=E1=BA=BFn m=E1=BB=99t nh=C3=
=A1nh n=C3=A0o c=E1=BA=A3"
=20
-#: sha1_name.c:1115
+#: sha1_name.c:1113
 #, c-format
 msgid "No such branch: '%s'"
 msgstr "Kh=C3=B4ng c=C3=B3 nh=C3=A1nh n=C3=A0o nh=C6=B0 th=E1=BA=BF: =E2=
=80=9C%s=E2=80=9D"
=20
-#: sha1_name.c:1117
+#: sha1_name.c:1115
 #, c-format
 msgid "No upstream configured for branch '%s'"
 msgstr "Kh=C3=B4ng c=C3=B3 th=C6=B0=E1=BB=A3ng ngu=E1=BB=93n (upstream=
) =C4=91=C6=B0=E1=BB=A3c c=E1=BA=A5u h=C3=ACnh cho nh=C3=A1nh =E2=80=9C=
%s=E2=80=9D"
=20
-#: sha1_name.c:1121
+#: sha1_name.c:1119
 #, c-format
 msgid "Upstream branch '%s' not stored as a remote-tracking branch"
 msgstr ""
@@ -1899,230 +1899,156 @@ msgstr "b=E1=BB=8F li=C3=AAn k=E1=BA=BFt (unl=
ink) %s kh=C3=B4ng th=C3=A0nh c=C3=B4ng"
 msgid "git add [options] [--] <pathspec>..."
 msgstr "git add [c=C3=A1c-t=C3=B9y-ch=E1=BB=8Dn] [--]  <pathspec>..."
=20
-#.
-#. * To be consistent with "git add -p" and most Git
-#. * commands, we should default to being tree-wide, but
-#. * this is not the original behavior and can't be
-#. * changed until users trained themselves not to type
-#. * "git add -u" or "git add -A". For now, we warn and
-#. * keep the old behavior. Later, the behavior can be changed
-#. * to tree-wide, keeping the warning for a while, and
-#. * eventually we can drop the warning.
-#.
-#: builtin/add.c:58
-#, c-format
-msgid ""
-"The behavior of 'git add %s (or %s)' with no path argument from a\n"
-"subdirectory of the tree will change in Git 2.0 and should not be use=
d "
-"anymore.\n"
-"To add content for the whole tree, run:\n"
-"\n"
-"  git add %s :/\n"
-"  (or git add %s :/)\n"
-"\n"
-"To restrict the command to the current directory, run:\n"
-"\n"
-"  git add %s .\n"
-"  (or git add %s .)\n"
-"\n"
-"With the current Git version, the command is restricted to the curren=
t "
-"directory.\n"
-msgstr ""
-"C=C3=A1ch =E1=BB=A9ng x=E1=BB=AD c=E1=BB=A7a l=E1=BB=87nh =E2=80=9Cgi=
t add %s (hay %s)=E2=80=9D khi kh=C3=B4ng c=C3=B3 tham s=E1=BB=91 =C4=91=
=C6=B0=E1=BB=9Dng d=E1=BA=ABn "
-"t=E1=BB=AB\n"
-"th=C6=B0-m=E1=BB=A5c con c=E1=BB=A7a c=C3=A2y s=E1=BA=BD thay =C4=91=E1=
=BB=95i k=E1=BB=83 t=E1=BB=AB Git 2.0 v=C3=A0 kh=C3=B4ng th=E1=BB=83 s=E1=
=BB=AD d=E1=BB=A5ng nh=C6=B0 th=E1=BA=BF "
-"n=E1=BB=AFa.\n"
-"=C4=90=E1=BB=83 th=C3=AAm n=E1=BB=99i dung cho to=C3=A0n b=E1=BB=99 c=
=C3=A2y, ch=E1=BA=A1y:\n"
-"\n"
-"  git add %s :/\n"
-"  (hay git add %s :/)\n"
-"\n"
-"=C4=90=E1=BB=83 h=E1=BA=A1n ch=E1=BA=BF l=E1=BB=87nh cho th=C6=B0-m=E1=
=BB=A5c hi=E1=BB=87n t=E1=BA=A1i, ch=E1=BA=A1y:\n"
-"\n"
-"  git add %s .\n"
-"  (hay git add %s .)\n"
-"\n"
-"V=E1=BB=9Bi phi=C3=AAn b=E1=BA=A3n hi=E1=BB=87n t=E1=BA=A1i c=E1=BB=A7=
a Git, l=E1=BB=87nh b=E1=BB=8B h=E1=BA=A1n ch=E1=BA=BF cho th=C6=B0-m=E1=
=BB=A5c hi=E1=BB=87n t=E1=BA=A1i.\n"
-
-#: builtin/add.c:100
-#, c-format
-msgid ""
-"You ran 'git add' with neither '-A (--all)' or '--ignore-removal',\n"
-"whose behaviour will change in Git 2.0 with respect to paths you remo=
ved.\n"
-"Paths like '%s' that are\n"
-"removed from your working tree are ignored with this version of Git.\=
n"
-"\n"
-"* 'git add --ignore-removal <pathspec>', which is the current default=
,\n"
-"  ignores paths you removed from your working tree.\n"
-"\n"
-"* 'git add --all <pathspec>' will let you also record the removals.\n=
"
-"\n"
-"Run 'git status' to check the paths you removed from your working tre=
e.\n"
-msgstr ""
-"B=E1=BA=A1n ch=E1=BA=A1y =E2=80=9Cgit add=E2=80=9D m=C3=A0 kh=C3=B4ng=
 c=C3=B3 =E2=80=9C-A (--all)=E2=80=9D c=C5=A9ng kh=C3=B4ng =E2=80=9C--i=
gnore-removal=E2=80=9D,\n"
-"c=C3=A1ch =E1=BB=A9ng x=E1=BB=AD c=E1=BB=A7a n=C3=B3 s=E1=BA=BD thay =
=C4=91=E1=BB=95i k=E1=BB=83 t=E1=BB=AB Git 2.0: n=C3=B3 quan t=C3=A2m =C4=
=91=E1=BA=BFn c=C3=A1c =C4=91=C6=B0=E1=BB=9Dng d=E1=BA=ABn "
-"m=C3=A0\n"
-"b=E1=BA=A1n =C4=91=C3=A3 g=E1=BB=A1 b=E1=BB=8F. C=C3=A1c =C4=91=C6=B0=
=E1=BB=9Dng d=E1=BA=ABn nh=C6=B0 l=C3=A0 =E2=80=9C%s=E2=80=9D c=C3=A1i =
m=C3=A0\n"
-"b=E1=BB=8B g=E1=BB=A1 b=E1=BB=8F t=E1=BB=AB c=C3=A2y l=C3=A0m vi=E1=BB=
=87c c=E1=BB=A7a b=E1=BA=A1n th=C3=AC b=E1=BB=8B b=E1=BB=8F qua v=E1=BB=
=9Bi phi=C3=AAn b=E1=BA=A3n n=C3=A0y c=E1=BB=A7a Git.\n"
-"\n"
-"* =E2=80=9Cgit add --ignore-removal <pathspec>=E2=80=9D, c=C3=A1i hi=E1=
=BB=87n t=E1=BA=A1i l=C3=A0 m=E1=BA=B7c =C4=91=E1=BB=8Bnh,\n"
-"  b=E1=BB=8F qua c=C3=A1c =C4=91=C6=B0=E1=BB=9Dng d=E1=BA=ABn b=E1=BA=
=A1n =C4=91=C3=A3 g=E1=BB=A1 b=E1=BB=8F t=E1=BB=AB c=C3=A2y l=C3=A0m vi=
=E1=BB=87c c=E1=BB=A7a b=E1=BA=A1n.\n"
-"\n"
-"* =E2=80=9Cgit add --all <pathspec>=E2=80=9D s=E1=BA=BD =C4=91=E1=BB=93=
ng th=E1=BB=9Di gi=C3=BAp b=E1=BA=A1n ghi l=E1=BA=A1i vi=E1=BB=87c d=E1=
=BB=9Di =C4=91i.\n"
-"\n"
-"Ch=E1=BA=A1y =E2=80=9Cgit status=E2=80=9D =C4=91=E1=BB=83 ki=E1=BB=83=
m tra c=C3=A1c =C4=91=C6=B0=E1=BB=9Dng d=E1=BA=ABn b=E1=BA=A1n =C4=91=C3=
=A3 g=E1=BB=A1 b=E1=BB=8F t=E1=BB=AB c=C3=A2y l=C3=A0m vi=E1=BB=87c c=E1=
=BB=A7a "
-"b=E1=BA=A1n.\n"
-
-#: builtin/add.c:144
+#: builtin/add.c:63
 #, c-format
 msgid "unexpected diff status %c"
 msgstr "tr=E1=BA=A1ng th=C3=A1i l=E1=BB=87nh diff kh=C3=B4ng nh=C6=B0 =
mong =C4=91=E1=BB=A3i %c"
=20
-#: builtin/add.c:149 builtin/commit.c:260
+#: builtin/add.c:68 builtin/commit.c:260
 msgid "updating files failed"
 msgstr "C=E1=BA=ADp nh=E1=BA=ADt t=E1=BA=ADp tin g=E1=BA=B7p l=E1=BB=97=
i"
=20
-#: builtin/add.c:163
+#: builtin/add.c:78
 #, c-format
 msgid "remove '%s'\n"
 msgstr "g=E1=BB=A1 b=E1=BB=8F =E2=80=9C%s=E2=80=9D\n"
=20
-#: builtin/add.c:237
+#: builtin/add.c:133
 msgid "Unstaged changes after refreshing the index:"
 msgstr ""
 "C=C3=A1c thay =C4=91=E1=BB=95i kh=C3=B4ng =C4=91=C6=B0=E1=BB=A3c l=C6=
=B0u tr=E1=BA=A1ng th=C3=A1i sau khi l=C3=A0m t=C6=B0=C6=A1i m=E1=BB=9B=
i l=E1=BA=A1i b=E1=BA=A3ng m=E1=BB=A5c l=E1=BB=A5c:"
=20
-#: builtin/add.c:299
+#: builtin/add.c:195
 msgid "Could not read the index"
 msgstr "Kh=C3=B4ng th=E1=BB=83 =C4=91=E1=BB=8Dc b=E1=BA=A3ng m=E1=BB=A5=
c l=E1=BB=A5c"
=20
-#: builtin/add.c:310
+#: builtin/add.c:206
 #, c-format
 msgid "Could not open '%s' for writing."
 msgstr "Kh=C3=B4ng th=E1=BB=83 m=E1=BB=9F =E2=80=9C%s=E2=80=9D =C4=91=E1=
=BB=83 ghi."
=20
-#: builtin/add.c:314
+#: builtin/add.c:210
 msgid "Could not write patch"
 msgstr "Kh=C3=B4ng th=E1=BB=83 ghi ra mi=E1=BA=BFng v=C3=A1"
=20
-#: builtin/add.c:319
+#: builtin/add.c:215
 #, c-format
 msgid "Could not stat '%s'"
 msgstr "kh=C3=B4ng th=E1=BB=83 l=E1=BA=A5y tr=E1=BA=A1ng th=C3=A1i v=E1=
=BB=81 =E2=80=9C%s=E2=80=9D"
=20
-#: builtin/add.c:321
+#: builtin/add.c:217
 msgid "Empty patch. Aborted."
 msgstr "Mi=E1=BA=BFng v=C3=A1 tr=E1=BB=91ng r=E1=BB=97ng. =C4=90=C3=A3=
 b=E1=BB=8F qua."
=20
-#: builtin/add.c:327
+#: builtin/add.c:223
 #, c-format
 msgid "Could not apply '%s'"
 msgstr "Kh=C3=B4ng th=E1=BB=83 apply (=C3=A1p d=E1=BB=A5ng mi=E1=BA=BF=
ng v=C3=A1) =E2=80=9C%s=E2=80=9D"
=20
-#: builtin/add.c:337
+#: builtin/add.c:233
 msgid "The following paths are ignored by one of your .gitignore files=
:\n"
 msgstr ""
 "C=C3=A1c =C4=91=C6=B0=E1=BB=9Dng d=E1=BA=ABn theo sau =C4=91=C3=A2y s=
=E1=BA=BD b=E1=BB=8B l=E1=BB=9D =C4=91i b=E1=BB=9Fi m=E1=BB=99t trong c=
=C3=A1c t=E1=BA=ADp tin .gitignore "
 "c=E1=BB=A7a b=E1=BA=A1n:\n"
=20
-#: builtin/add.c:354 builtin/clean.c:875 builtin/fetch.c:92 builtin/mv=
=2Ec:66
-#: builtin/prune-packed.c:73 builtin/push.c:459 builtin/remote.c:1253
+#: builtin/add.c:250 builtin/clean.c:875 builtin/fetch.c:92 builtin/mv=
=2Ec:66
+#: builtin/prune-packed.c:73 builtin/push.c:442 builtin/remote.c:1253
 #: builtin/rm.c:269
 msgid "dry run"
 msgstr "ch=E1=BA=A1y th=E1=BB=AD"
=20
-#: builtin/add.c:355 builtin/apply.c:4410 builtin/check-ignore.c:19
+#: builtin/add.c:251 builtin/apply.c:4410 builtin/check-ignore.c:19
 #: builtin/commit.c:1249 builtin/count-objects.c:95 builtin/fsck.c:612
 #: builtin/log.c:1592 builtin/mv.c:65 builtin/read-tree.c:113
 msgid "be verbose"
 msgstr "chi ti=E1=BA=BFt"
=20
-#: builtin/add.c:357
+#: builtin/add.c:253
 msgid "interactive picking"
 msgstr "s=E1=BB=ADa b=E1=BA=B1ng c=C3=A1ch t=C6=B0=C6=A1ng t=C3=A1c"
=20
-#: builtin/add.c:358 builtin/checkout.c:1109 builtin/reset.c:272
+#: builtin/add.c:254 builtin/checkout.c:1109 builtin/reset.c:272
 msgid "select hunks interactively"
 msgstr "ch=E1=BB=8Dn =E2=80=9Chunks=E2=80=9D m=E1=BB=99t c=C3=A1ch t=C6=
=B0=C6=A1ng t=C3=A1c"
=20
-#: builtin/add.c:359
+#: builtin/add.c:255
 msgid "edit current diff and apply"
 msgstr "s=E1=BB=ADa diff hi=E1=BB=87n nay v=C3=A0 =C3=A1p d=E1=BB=A5ng=
 n=C3=B3"
=20
-#: builtin/add.c:360
+#: builtin/add.c:256
 msgid "allow adding otherwise ignored files"
 msgstr "cho ph=C3=A9p th=C3=AAm c=C3=A1c t=E1=BA=ADp tin b=E1=BB=8B b=E1=
=BB=8F qua kh=C3=A1c"
=20
-#: builtin/add.c:361
+#: builtin/add.c:257
 msgid "update tracked files"
 msgstr "c=E1=BA=ADp nh=E1=BA=ADt c=C3=A1c t=E1=BA=ADp tin =C4=91=C6=B0=
=E1=BB=A3c theo v=E1=BA=BFt"
=20
-#: builtin/add.c:362
+#: builtin/add.c:258
 msgid "record only the fact that the path will be added later"
 msgstr "ch=E1=BB=89 ghi l=E1=BA=A1i s=E1=BB=B1 vi=E1=BB=87c m=C3=A0 =C4=
=91=C6=B0=E1=BB=9Dng d=E1=BA=ABn s=E1=BA=BD =C4=91=C6=B0=E1=BB=A3c th=C3=
=AAm v=C3=A0o sau"
=20
-#: builtin/add.c:363
+#: builtin/add.c:259
 msgid "add changes from all tracked and untracked files"
 msgstr ""
 "th=C3=AAm c=C3=A1c thay =C4=91=E1=BB=95i t=E1=BB=AB t=E1=BA=A5t c=E1=BA=
=A3 c=C3=A1c t=E1=BA=ADp tin c=C3=B3 c=C5=A9ng nh=C6=B0 kh=C3=B4ng =C4=91=
=C6=B0=E1=BB=A3c theo d=C3=B5i d=E1=BA=A5u "
 "v=E1=BA=BFt"
=20
 #. takes no arguments
-#: builtin/add.c:366
+#: builtin/add.c:262
 msgid "ignore paths removed in the working tree (same as --no-all)"
 msgstr ""
 "l=E1=BB=9D =C4=91i c=C3=A1c =C4=91=C6=B0=E1=BB=9Dng d=E1=BA=ABn b=E1=BB=
=8B g=E1=BB=A1 b=E1=BB=8F trong c=C3=A2y th=C6=B0 m=E1=BB=A5c l=C3=A0m =
vi=E1=BB=87c (gi=E1=BB=91ng v=E1=BB=9Bi --no-all)"
=20
-#: builtin/add.c:368
+#: builtin/add.c:264
 msgid "don't add, only refresh the index"
 msgstr "kh=C3=B4ng th=C3=AAm, ch=E1=BB=89 l=C3=A0m t=C6=B0=C6=A1i m=E1=
=BB=9Bi b=E1=BA=A3ng m=E1=BB=A5c l=E1=BB=A5c"
=20
-#: builtin/add.c:369
+#: builtin/add.c:265
 msgid "just skip files which cannot be added because of errors"
 msgstr "chie b=E1=BB=8F qua nh=E1=BB=AFng t=E1=BA=ADp tin m=C3=A0 n=C3=
=B3 kh=C3=B4ng th=E1=BB=83 =C4=91=C6=B0=E1=BB=A3c th=C3=AAm v=C3=A0o b=E1=
=BB=9Fi v=C3=AC g=E1=BA=B7p l=E1=BB=97i"
=20
-#: builtin/add.c:370
+#: builtin/add.c:266
 msgid "check if - even missing - files are ignored in dry run"
 msgstr ""
 "ki=E1=BB=83m tra xem - th=E1=BA=ADm ch=C3=AD thi=E1=BA=BFu - t=E1=BA=AD=
p tin b=E1=BB=8B b=E1=BB=8F qua trong qu=C3=A1 tr=C3=ACnh ch=E1=BA=A1y =
th=E1=BB=AD"
=20
-#: builtin/add.c:392
+#: builtin/add.c:288
 #, c-format
 msgid "Use -f if you really want to add them.\n"
 msgstr "S=E1=BB=AD d=E1=BB=A5ng t=C3=B9y ch=E1=BB=8Dn -f n=E1=BA=BFu b=
=E1=BA=A1n th=E1=BB=B1c s=E1=BB=B1 mu=E1=BB=91n th=C3=AAm ch=C3=BAng v=C3=
=A0o.\n"
=20
-#: builtin/add.c:393
+#: builtin/add.c:289
 msgid "no files added"
 msgstr "ch=C6=B0a c=C3=B3 t=E1=BA=ADp tin n=C3=A0o =C4=91=C6=B0=E1=BB=A3=
c th=C3=AAm v=C3=A0o"
=20
-#: builtin/add.c:399
+#: builtin/add.c:295
 msgid "adding files failed"
 msgstr "th=C3=AAm t=E1=BA=ADp tin g=E1=BA=B7p l=E1=BB=97i"
=20
-#: builtin/add.c:438
+#: builtin/add.c:332
 msgid "-A and -u are mutually incompatible"
 msgstr "-A v=C3=A0 -u xung kh=E1=BA=AFc nhau"
=20
-#: builtin/add.c:456
+#: builtin/add.c:339
 msgid "Option --ignore-missing can only be used together with --dry-ru=
n"
 msgstr "T=C3=B9y ch=E1=BB=8Dn --ignore-missing ch=E1=BB=89 c=C3=B3 th=E1=
=BB=83 =C4=91=C6=B0=E1=BB=A3c d=C3=B9ng c=C3=B9ng v=E1=BB=9Bi --dry-run=
"
=20
-#: builtin/add.c:486
+#: builtin/add.c:360
 #, c-format
 msgid "Nothing specified, nothing added.\n"
 msgstr "Kh=C3=B4ng c=C3=B3 g=C3=AC =C4=91=C6=B0=E1=BB=A3c ch=E1=BB=89 =
ra, kh=C3=B4ng c=C3=B3 g=C3=AC =C4=91=C6=B0=E1=BB=A3c th=C3=AAm v=C3=A0=
o.\n"
=20
-#: builtin/add.c:487
+#: builtin/add.c:361
 #, c-format
 msgid "Maybe you wanted to say 'git add .'?\n"
 msgstr "C=C3=B3 l=E1=BA=BD b=E1=BA=A1n mu=E1=BB=91n l=C3=A0 =E2=80=9Cg=
it add .=E2=80=9D ph=E1=BA=A3i kh=C3=B4ng?\n"
=20
-#: builtin/add.c:492 builtin/check-ignore.c:172 builtin/clean.c:919
+#: builtin/add.c:366 builtin/check-ignore.c:172 builtin/clean.c:919
 #: builtin/commit.c:320 builtin/mv.c:86 builtin/reset.c:224 builtin/rm=
=2Ec:299
 msgid "index file corrupt"
 msgstr "t=E1=BA=ADp tin ghi b=E1=BA=A3ng m=E1=BB=A5c l=E1=BB=A5c b=E1=BB=
=8B h=E1=BB=8Fng"
=20
-#: builtin/add.c:589 builtin/apply.c:4506 builtin/mv.c:259 builtin/rm.=
c:432
+#: builtin/add.c:447 builtin/apply.c:4506 builtin/mv.c:259 builtin/rm.=
c:432
 msgid "Unable to write new index file"
 msgstr "Kh=C3=B4ng th=E1=BB=83 ghi t=E1=BA=ADp tin l=C6=B0u b=E1=BA=A3=
ng m=E1=BB=A5c l=E1=BB=A5c m=E1=BB=9Bi"
=20
@@ -2664,97 +2590,97 @@ msgstr "git blame [c=C3=A1c-t=C3=B9y-ch=E1=BB=8D=
n] [rev-opts] [rev] [--] t=E1=BA=ADp-tin"
 msgid "[rev-opts] are documented in git-rev-list(1)"
 msgstr "[rev-opts] =C4=91=C6=B0=E1=BB=A3c m=C3=B4 t=E1=BA=A3 trong git=
-rev-list(1)"
=20
-#: builtin/blame.c:2248
+#: builtin/blame.c:2249
 msgid "Show blame entries as we find them, incrementally"
 msgstr "Hi=E1=BB=83n th=E1=BB=8B c=C3=A1c m=E1=BB=A5c =E2=80=9Cblame=E2=
=80=9D nh=C6=B0 l=C3=A0 ch=C3=BAng ta th=E1=BA=A5y ch=C3=BAng, t=C4=83n=
g d=E1=BA=A7n"
=20
-#: builtin/blame.c:2249
+#: builtin/blame.c:2250
 msgid "Show blank SHA-1 for boundary commits (Default: off)"
 msgstr ""
 "Hi=E1=BB=83n th=E1=BB=8B SHA-1 tr=E1=BA=AFng cho nh=E1=BB=AFng l=E1=BA=
=A7n chuy=E1=BB=83n giao bi=C3=AAn gi=E1=BB=9Bi (M=E1=BA=B7c =C4=91=E1=BB=
=8Bnh: off)"
=20
-#: builtin/blame.c:2250
+#: builtin/blame.c:2251
 msgid "Do not treat root commits as boundaries (Default: off)"
 msgstr "Kh=C3=B4ng coi c=C3=A1c l=E1=BA=A7n chuy=E1=BB=83n giao g=E1=BB=
=91c l=C3=A0 gi=E1=BB=9Bi h=E1=BA=A1n (M=E1=BA=B7c =C4=91=E1=BB=8Bnh: o=
ff)"
=20
-#: builtin/blame.c:2251
+#: builtin/blame.c:2252
 msgid "Show work cost statistics"
 msgstr "Hi=E1=BB=83n th=E1=BB=8B th=E1=BB=91ng k=C3=AA c=C3=B4ng s=E1=BB=
=A9c l=C3=A0m vi=E1=BB=87c"
=20
-#: builtin/blame.c:2252
+#: builtin/blame.c:2253
 msgid "Show output score for blame entries"
 msgstr "Hi=E1=BB=83n th=E1=BB=8B k=E1=BA=BFt xu=E1=BA=A5t =C4=91i=E1=BB=
=83m s=E1=BB=91 c=C3=B3 c=C3=A1c m=E1=BB=A5c tin =E2=80=9Cblame=E2=80=9D=
"
=20
-#: builtin/blame.c:2253
+#: builtin/blame.c:2254
 msgid "Show original filename (Default: auto)"
 msgstr "Hi=E1=BB=83n th=E1=BB=8B t=C3=AAn t=E1=BA=ADp tin g=E1=BB=91c =
(M=E1=BA=B7c =C4=91=E1=BB=8Bnh: auto)"
=20
-#: builtin/blame.c:2254
+#: builtin/blame.c:2255
 msgid "Show original linenumber (Default: off)"
 msgstr "Hi=E1=BB=83n th=E1=BB=8B s=E1=BB=91 d=C3=B2ng g=E1=BB=91c (M=E1=
=BA=B7c =C4=91=E1=BB=8Bnh: off)"
=20
-#: builtin/blame.c:2255
+#: builtin/blame.c:2256
 msgid "Show in a format designed for machine consumption"
 msgstr "Hi=E1=BB=83n th=E1=BB=8B =E1=BB=9F =C4=91=E1=BB=8Bnh d=E1=BA=A1=
ng =C4=91=C3=A3 thi=E1=BA=BFt k=E1=BA=BF cho s=E1=BB=B1 ti=C3=AAu d=C3=B9=
ng b=E1=BA=B1ng m=C3=A1y"
=20
-#: builtin/blame.c:2256
+#: builtin/blame.c:2257
 msgid "Show porcelain format with per-line commit information"
 msgstr "Hi=E1=BB=83n th=E1=BB=8B =C4=91=E1=BB=8Bnh d=E1=BA=A1ng =E2=80=
=9Cporcelain=E2=80=9D v=E1=BB=9Bi th=C3=B4ng tin chuy=E1=BB=83n giao m=E1=
=BB=97i d=C3=B2ng"
=20
-#: builtin/blame.c:2257
+#: builtin/blame.c:2258
 msgid "Use the same output mode as git-annotate (Default: off)"
 msgstr "D=C3=B9ng c=C3=B9ng ch=E1=BA=BF =C4=91=E1=BB=99 xu=E1=BA=A5t r=
a v=C3=B3igit-annotate (M=E1=BA=B7c =C4=91=E1=BB=8Bnh: off)"
=20
-#: builtin/blame.c:2258
+#: builtin/blame.c:2259
 msgid "Show raw timestamp (Default: off)"
 msgstr "Hi=E1=BB=83n th=E1=BB=8B d=E1=BA=A5u v=E1=BA=BFt th=E1=BB=9Di =
gian d=E1=BA=A1ng th=C3=B4 (M=E1=BA=B7c =C4=91=E1=BB=8Bnh: off)"
=20
-#: builtin/blame.c:2259
+#: builtin/blame.c:2260
 msgid "Show long commit SHA1 (Default: off)"
 msgstr "Hi=E1=BB=83n th=E1=BB=8B SHA1 c=E1=BB=A7a l=E1=BA=A7n chuy=E1=BB=
=83n giao (commit) d=E1=BA=A1ng d=C3=A0i (M=E1=BA=B7c =C4=91=E1=BB=8Bnh=
: off)"
=20
-#: builtin/blame.c:2260
+#: builtin/blame.c:2261
 msgid "Suppress author name and timestamp (Default: off)"
 msgstr "Kh=C3=B4ng hi=E1=BB=83n th=E1=BB=8B t=C3=AAn t=C3=A1c gi=E1=BA=
=A3 v=C3=A0 d=E1=BA=A5u v=E1=BA=BFt th=E1=BB=9Di gian (M=E1=BA=B7c =C4=91=
=E1=BB=8Bnh: off)"
=20
-#: builtin/blame.c:2261
+#: builtin/blame.c:2262
 msgid "Show author email instead of name (Default: off)"
 msgstr "Hi=E1=BB=83n th=E1=BB=8B th=C6=B0 =C4=91i=E1=BB=87n t=E1=BB=AD=
 c=E1=BB=A7a t=C3=A1c gi=E1=BA=A3 thay v=C3=AC t=C3=AAn (M=E1=BA=B7c =C4=
=91=E1=BB=8Bnh: off)"
=20
-#: builtin/blame.c:2262
+#: builtin/blame.c:2263
 msgid "Ignore whitespace differences"
 msgstr "B=E1=BB=8F qua c=C3=A1c kh=C3=A1c bi=E1=BB=87t do kho=E1=BA=A3=
ng tr=E1=BA=AFng g=C3=A2y ra"
=20
-#: builtin/blame.c:2263
+#: builtin/blame.c:2264
 msgid "Spend extra cycles to find better match"
 msgstr "Ti=C3=AAu th=E1=BB=A5 th=C3=AAm n=C4=83ng t=C3=A0i nguy=C3=AAn=
 m=C3=A1y m=C3=B3c =C4=91=E1=BB=83 t=C3=ACm ki=E1=BA=BFm t=E1=BB=91t h=C6=
=A1n n=E1=BB=AFa"
=20
-#: builtin/blame.c:2264
+#: builtin/blame.c:2265
 msgid "Use revisions from <file> instead of calling git-rev-list"
 msgstr ""
 "S=E1=BB=AD d=E1=BB=A5ng =C4=91i=E1=BB=83m x=C3=A9t duy=E1=BB=87t (rev=
ision) t=E1=BB=AB <t=E1=BA=ADp tin> thay v=C3=AC g=E1=BB=8Di =E2=80=9Cg=
it-rev-list=E2=80=9D"
=20
-#: builtin/blame.c:2265
+#: builtin/blame.c:2266
 msgid "Use <file>'s contents as the final image"
 msgstr "S=E1=BB=AD d=E1=BB=A5ng n=E1=BB=99i dung c=E1=BB=A7a <t=E1=BA=AD=
p tin> nh=C6=B0 l=C3=A0 =E1=BA=A3nh cu=E1=BB=91i c=C3=B9ng"
=20
-#: builtin/blame.c:2266 builtin/blame.c:2267
+#: builtin/blame.c:2267 builtin/blame.c:2268
 msgid "score"
 msgstr "=C4=91i=E1=BB=83m s=E1=BB=91"
=20
-#: builtin/blame.c:2266
+#: builtin/blame.c:2267
 msgid "Find line copies within and across files"
 msgstr "T=C3=ACm c=C3=A1c b=E1=BA=A3n sao ch=C3=A9p d=C3=B2ng trong v=C3=
=A0 ngang qua t=E1=BA=ADp tin"
=20
-#: builtin/blame.c:2267
+#: builtin/blame.c:2268
 msgid "Find line movements within and across files"
 msgstr "T=C3=ACm c=C3=A1c di chuy=E1=BB=83n d=C3=B2ng trong v=C3=A0 ng=
ang qua t=E1=BA=ADp tin"
=20
-#: builtin/blame.c:2268
+#: builtin/blame.c:2269
 msgid "n,m"
 msgstr "n,m"
=20
-#: builtin/blame.c:2268
+#: builtin/blame.c:2269
 msgid "Process only line range n,m, counting from 1"
 msgstr "X=E1=BB=AD l=C3=BD ch=E1=BB=89 d=C3=B2ng v=C3=B9ng n,m, t=C3=AD=
nh t=E1=BB=AB 1"
=20
@@ -3727,7 +3653,7 @@ msgstr "H=E1=BA=A3 (%s)?"
 #: builtin/clean.c:659
 #, c-format
 msgid "Input ignore patterns>> "
-msgstr "M=E1=BA=ABu =C4=91=E1=BB=83 l=E1=BB=8Dc c=C3=A1c t=E1=BA=ADp t=
in c=E1=BA=A7n l=E1=BB=9D =C4=91i =C4=91=E1=BA=A7u v=C3=A0o>>"
+msgstr "M=E1=BA=ABu =C4=91=E1=BB=83 l=E1=BB=8Dc c=C3=A1c t=E1=BA=ADp t=
in =C4=91=E1=BA=A7u v=C3=A0o c=E1=BA=A7n l=E1=BB=9D =C4=91i>> "
=20
 #: builtin/clean.c:696
 #, c-format
@@ -3741,7 +3667,7 @@ msgstr "Ch=E1=BB=8Dn m=E1=BB=A5c mu=E1=BB=91n x=C3=
=B3a"
 #: builtin/clean.c:757
 #, c-format
 msgid "remove %s? "
-msgstr "g=E1=BB=A1 b=E1=BB=8F =E2=80=9C%s=E2=80=9D?"
+msgstr "g=E1=BB=A1 b=E1=BB=8F =E2=80=9C%s=E2=80=9D? "
=20
 #: builtin/clean.c:782
 msgid "Bye."
@@ -3800,7 +3726,7 @@ msgid "remove whole directories"
 msgstr "g=E1=BB=A1 b=E1=BB=8F to=C3=A0n b=E1=BB=99 th=C6=B0 m=E1=BB=A5=
c"
=20
 #: builtin/clean.c:880 builtin/describe.c:420 builtin/grep.c:718
-#: builtin/ls-files.c:483 builtin/name-rev.c:315 builtin/show-ref.c:18=
5
+#: builtin/ls-files.c:483 builtin/name-rev.c:314 builtin/show-ref.c:18=
5
 msgid "pattern"
 msgstr "m=E1=BA=ABu"
=20
@@ -3841,7 +3767,7 @@ msgid "git clone [options] [--] <repo> [<dir>]"
 msgstr "git clone [c=C3=A1c-t=C3=B9y-ch=E1=BB=8Dn] [--] <kho> [<t.m=E1=
=BB=A5c>]"
=20
 #: builtin/clone.c:64 builtin/fetch.c:96 builtin/merge.c:229
-#: builtin/push.c:474
+#: builtin/push.c:457
 msgid "force progress reporting"
 msgstr "=C3=A9p bu=E1=BB=99c b=C3=A1o c=C3=A1o ti=E1=BA=BFn tr=C3=ACnh=
"
=20
@@ -3987,7 +3913,7 @@ msgstr "Kh=C3=B4ng t=C3=ACm th=E1=BA=A5y nh=C3=A1=
nh m=C3=A1y ch=E1=BB=A7 %s =C4=91=E1=BB=83 nh=C3=A2n b=E1=BA=A3n (clone=
)."
 #: builtin/clone.c:554
 #, c-format
 msgid "Checking connectivity... "
-msgstr "=C4=90ang ki=E1=BB=83m tra k=E1=BA=BFt n=E1=BB=91i..."
+msgstr "=C4=90ang ki=E1=BB=83m tra k=E1=BA=BFt n=E1=BB=91i... "
=20
 #: builtin/clone.c:557
 msgid "remote did not send all necessary objects"
@@ -4166,7 +4092,7 @@ msgid ""
 msgstr ""
 "L=E1=BA=A7n cherry-pick tr=C6=B0=E1=BB=9Bc hi=E1=BB=87n nay tr=E1=BB=91=
ng r=E1=BB=97ng, c=C3=B3 l=E1=BA=BD l=C3=A0 b=E1=BB=9Fi v=C3=AC s=E1=BB=
=B1 ph=C3=A2n gi=E1=BA=A3i xung "
 "=C4=91=E1=BB=99t.\n"
-"N=E1=BA=BFu b=E1=BA=A1n v=E1=BA=ABn mu=E1=BB=91n chuy=E1=BB=83n giao =
n=C3=B3 cho d=C3=B9 th=E1=BA=BF n=C3=A0o =C4=91i n=E1=BB=AFa, s=E1=BB=AD=
 d=E1=BB=A5ng:\n"
+"N=E1=BA=BFu b=E1=BA=A1n v=E1=BA=ABn mu=E1=BB=91n chuy=E1=BB=83n giao =
n=C3=B3 cho d=C3=B9 th=E1=BA=BF n=C3=A0o =C4=91i n=E1=BB=AFa, h=C3=A3y =
d=C3=B9ng:\n"
 "\n"
 "    git commit --allow-empty\n"
 "\n"
@@ -4444,7 +4370,7 @@ msgstr "hi=E1=BB=83n th=E1=BB=8B tr=E1=BA=A1ng th=
=C3=A1i =E1=BB=9F d=E1=BA=A1ng s=C3=BAc t=C3=ADch"
 msgid "show branch information"
 msgstr "hi=E1=BB=83n th=E1=BB=8B th=C3=B4ng tin nh=C3=A1nh"
=20
-#: builtin/commit.c:1255 builtin/commit.c:1486 builtin/push.c:460
+#: builtin/commit.c:1255 builtin/commit.c:1486 builtin/push.c:443
 msgid "machine-readable output"
 msgstr "k=E1=BA=BFt xu=E1=BA=A5t d=E1=BA=A1ng m=C3=A1y-c=C3=B3-th=E1=BB=
=83-=C4=91=E1=BB=8Dc"
=20
@@ -4962,7 +4888,7 @@ msgstr "coi nh=C6=B0  <n> th=E1=BA=BB g=E1=BA=A7n=
 =C4=91=C3=A2y nh=E1=BA=A5t (m=E1=BA=B7c =C4=91=E1=BB=8Bnh: 10)"
 msgid "only consider tags matching <pattern>"
 msgstr "ch=E1=BB=89 c=C3=A2n nh=E1=BA=AFc =C4=91=E1=BA=BFn nh=E1=BB=AF=
ng th=E1=BA=BB kh=E1=BB=9Bp v=E1=BB=9Bi  <m=E1=BA=ABu>"
=20
-#: builtin/describe.c:423 builtin/name-rev.c:322
+#: builtin/describe.c:423 builtin/name-rev.c:321
 msgid "show abbreviated commit object as fallback"
 msgstr "hi=E1=BB=83n th=E1=BB=8B =C4=91=E1=BB=91i t=C6=B0=E1=BB=A3ng c=
huy=E1=BB=83n giao v=E1=BA=AFn t=E1=BA=AFt nh=C6=B0 l=C3=A0 fallback"
=20
@@ -5312,7 +5238,7 @@ msgstr ""
 "git fmt-merge-msg [-m <th=C3=B4ng =C4=91i=E1=BB=87p>] [--log[=3D<n>]|=
--no-log] [--file <t=E1=BA=ADp-tin>]"
=20
 #: builtin/fmt-merge-msg.c:663 builtin/fmt-merge-msg.c:666 builtin/gre=
p.c:702
-#: builtin/merge.c:203 builtin/show-branch.c:655 builtin/show-ref.c:17=
8
+#: builtin/merge.c:203 builtin/show-branch.c:654 builtin/show-ref.c:17=
8
 #: builtin/tag.c:446 parse-options.h:135 parse-options.h:245
 msgid "n"
 msgstr "n"
@@ -7058,38 +6984,46 @@ msgstr ""
 "H=C3=B2a tr=E1=BB=99n t=E1=BB=B1 =C4=91=E1=BB=99ng =C4=91=C3=A3 tr=E1=
=BB=9F n=C3=AAn t=E1=BB=91t; b=E1=BB=8B d=E1=BB=ABng tr=C6=B0=E1=BB=9Bc=
 khi vi=E1=BB=87c chuy=E1=BB=83n giao =C4=91=C6=B0=E1=BB=A3c y=C3=AAu "
 "c=E1=BA=A7u\n"
=20
-#: builtin/merge-base.c:26
+#: builtin/merge-base.c:29
 msgid "git merge-base [-a|--all] <commit> <commit>..."
 msgstr "git merge-base [-a|--all] <commit> <commit>..."
=20
-#: builtin/merge-base.c:27
+#: builtin/merge-base.c:30
 msgid "git merge-base [-a|--all] --octopus <commit>..."
 msgstr "git merge-base [-a|--all] --octopus <l=E1=BA=A7n commit>..."
=20
-#: builtin/merge-base.c:28
+#: builtin/merge-base.c:31
 msgid "git merge-base --independent <commit>..."
 msgstr "git merge-base --independent <l=E1=BA=A7n commit>..."
=20
-#: builtin/merge-base.c:29
+#: builtin/merge-base.c:32
 msgid "git merge-base --is-ancestor <commit> <commit>"
 msgstr "git merge-base --is-ancestor <commit> <commit>"
=20
-#: builtin/merge-base.c:98
+#: builtin/merge-base.c:33
+msgid "git merge-base --fork-point <ref> [<commit>]"
+msgstr "git merge-base --fork-point <tham-chi=E1=BA=BFu> [<commit>]"
+
+#: builtin/merge-base.c:197
 msgid "output all common ancestors"
 msgstr "xu=E1=BA=A5t ra t=E1=BA=A5t c=E1=BA=A3 c=C3=A1c =C3=B4ng b=C3=A0=
, t=E1=BB=95 ti=C3=AAn chung"
=20
-#: builtin/merge-base.c:99
+#: builtin/merge-base.c:199
 msgid "find ancestors for a single n-way merge"
 msgstr "t=C3=ACm t=E1=BB=95 ti=C3=AAn c=E1=BB=A7a h=C3=B2a tr=E1=BB=99=
n n-way =C4=91=C6=A1n"
=20
-#: builtin/merge-base.c:100
+#: builtin/merge-base.c:201
 msgid "list revs not reachable from others"
 msgstr "li=E1=BB=87t k=C3=AA c=C3=A1c =E2=80=9Crev=E2=80=9D m=C3=A0 n=C3=
=B3 kh=C3=B4ng th=E1=BB=83 =C4=91=E1=BB=8Dc =C4=91=C6=B0=E1=BB=A3c t=E1=
=BB=AB c=C3=A1i kh=C3=A1c"
=20
-#: builtin/merge-base.c:102
+#: builtin/merge-base.c:203
 msgid "is the first one ancestor of the other?"
 msgstr "l=C3=A0 cha m=E1=BA=B9 =C4=91=E1=BA=A7u ti=C3=AAn c=E1=BB=A7a =
c=C3=A1i kh=C3=A1c?"
=20
+#: builtin/merge-base.c:205
+msgid "find where <commit> forked from reflog of <ref>"
+msgstr "t=C3=ACm xem <commit> =C4=91=C6=B0=E1=BB=A3c r=E1=BA=BD nh=C3=A1=
nh =E1=BB=9F =C4=91=C3=A2u t=E1=BB=AB reflog c=E1=BB=A7a <th.chi=E1=BA=BF=
u>"
+
 #: builtin/merge-file.c:8
 msgid ""
 "git merge-file [options] [-L name1 [-L orig [-L name2]]] file1 orig_f=
ile "
@@ -7231,44 +7165,44 @@ msgstr "=C4=90=E1=BB=95i t=C3=AAn %s th=C3=A0nh=
 %s\n"
 msgid "renaming '%s' failed"
 msgstr "=C4=91=E1=BB=95i t=C3=AAn %s g=E1=BA=B7p l=E1=BB=97i"
=20
-#: builtin/name-rev.c:259
+#: builtin/name-rev.c:258
 msgid "git name-rev [options] <commit>..."
 msgstr "git name-rev [c=C3=A1c-t=C3=B9y-ch=E1=BB=8Dn] <commit>..."
=20
-#: builtin/name-rev.c:260
+#: builtin/name-rev.c:259
 msgid "git name-rev [options] --all"
 msgstr "git name-rev [c=C3=A1c-t=C3=B9y-ch=E1=BB=8Dn] --all"
=20
-#: builtin/name-rev.c:261
+#: builtin/name-rev.c:260
 msgid "git name-rev [options] --stdin"
 msgstr "git name-rev [c=C3=A1c-t=C3=B9y-ch=E1=BB=8Dn] --stdin"
=20
-#: builtin/name-rev.c:313
+#: builtin/name-rev.c:312
 msgid "print only names (no SHA-1)"
 msgstr "ch=E1=BB=89 hi=E1=BB=83n th=E1=BB=8B t=C3=AAn (kh=C3=B4ng SHA-=
1)"
=20
-#: builtin/name-rev.c:314
+#: builtin/name-rev.c:313
 msgid "only use tags to name the commits"
 msgstr "ch=E1=BB=89 d=C3=B9ng c=C3=A1c th=E1=BA=BB =C4=91=E1=BB=83 =C4=
=91=E1=BA=B7t t=C3=AAn cho c=C3=A1c l=E1=BA=A7n chuy=E1=BB=83n giao"
=20
-#: builtin/name-rev.c:316
+#: builtin/name-rev.c:315
 msgid "only use refs matching <pattern>"
 msgstr "ch=E1=BB=89 s=E1=BB=AD d=E1=BB=A5ng c=C3=A1c tham chi=E1=BA=BF=
u (refs) kh=E1=BB=9Bp v=E1=BB=9Bi <m=E1=BA=ABu>"
=20
-#: builtin/name-rev.c:318
+#: builtin/name-rev.c:317
 msgid "list all commits reachable from all refs"
 msgstr ""
 "li=E1=BB=87t k=C3=AA t=E1=BA=A5t c=E1=BA=A3 c=C3=A1c l=E1=BA=A7n chuy=
=E1=BB=83n giao c=C3=B3 th=E1=BB=83 =C4=91=E1=BB=8Dc =C4=91=C6=B0=E1=BB=
=A3c t=E1=BB=AB t=E1=BA=A5t c=E1=BA=A3 c=C3=A1c tham chi=E1=BA=BFu"
=20
-#: builtin/name-rev.c:319
+#: builtin/name-rev.c:318
 msgid "read from stdin"
 msgstr "=C4=91=E1=BB=8Dc t=E1=BB=AB =C4=91=E1=BA=A7u v=C3=A0o ti=C3=AA=
u chu=E1=BA=A9n"
=20
-#: builtin/name-rev.c:320
+#: builtin/name-rev.c:319
 msgid "allow to print `undefined` names (default)"
 msgstr "cho ph=C3=A9p in c=C3=A1c t=C3=AAn =E2=80=9Cch=C6=B0a =C4=91=E1=
=BB=8Bnh ngh=C4=A9a=E2=80=9D (m=E1=BA=B7c =C4=91=E1=BB=8Bnh)"
=20
-#: builtin/name-rev.c:326
+#: builtin/name-rev.c:325
 msgid "dereference tags in the input (internal use)"
 msgstr "b=C3=A3i b=E1=BB=8F tham chi=E1=BA=BFu c=C3=A1c th=E1=BA=BB tr=
ong =C4=91=E1=BA=A7u v=C3=A0o (d=C3=B9ng n=E1=BB=99i b=E1=BB=99)"
=20
@@ -7792,15 +7726,15 @@ msgstr "c=C3=A1c =C4=91=E1=BB=91i t=C6=B0=E1=BB=
=A3ng h=E1=BA=BFt h=E1=BA=A1n c=C5=A9 h=C6=A1n kho=E1=BA=A3ng <th=E1=BB=
=9Di gian>"
 msgid "git push [<options>] [<repository> [<refspec>...]]"
 msgstr "git push [<c=C3=A1c-t=C3=B9y-ch=E1=BB=8Dn>] [<kho-ch=E1=BB=A9a=
> [<refspec>...]]"
=20
-#: builtin/push.c:47
+#: builtin/push.c:46
 msgid "tag shorthand without <tag>"
 msgstr "d=C3=B9ng t=E1=BB=91c k=C3=BD tag kh=C3=B4ng c=C3=B3 <th=E1=BA=
=BB>"
=20
-#: builtin/push.c:66
+#: builtin/push.c:65
 msgid "--delete only accepts plain target ref names"
 msgstr "--delete ch=E1=BB=89 ch=E1=BA=A5p nh=E1=BA=ADn c=C3=A1c t=C3=AA=
n tham chi=E1=BA=BFu (ref) d=E1=BA=A1ng th=C6=B0=E1=BB=9Dng"
=20
-#: builtin/push.c:101
+#: builtin/push.c:100
 msgid ""
 "\n"
 "To choose either option permanently, see push.default in 'git help co=
nfig'."
@@ -7809,7 +7743,7 @@ msgstr ""
 "=C4=90=E1=BB=83 ch=E1=BB=8Dn m=E1=BB=97i t=C3=B9y ch=E1=BB=8Dn m=E1=BB=
=99t c=C3=A1ch c=E1=BB=91 =C4=91=E1=BB=8Bnh, xem push.default trong =E2=
=80=9Cgit help "
 "config=E2=80=9D."
=20
-#: builtin/push.c:104
+#: builtin/push.c:103
 #, c-format
 msgid ""
 "The upstream branch of your current branch does not match\n"
@@ -7834,7 +7768,7 @@ msgstr ""
 "    git push %s %s\n"
 "%s"
=20
-#: builtin/push.c:119
+#: builtin/push.c:118
 #, c-format
 msgid ""
 "You are not currently on a branch.\n"
@@ -7849,7 +7783,7 @@ msgstr ""
 "\n"
 "    git push %s HEAD:<t=C3=AAn-c=E1=BB=A7a-nh=C3=A1nh-m=C3=A1y-ch=E1=BB=
=A7>\n"
=20
-#: builtin/push.c:133
+#: builtin/push.c:132
 #, c-format
 msgid ""
 "The current branch %s has no upstream branch.\n"
@@ -7863,12 +7797,12 @@ msgstr ""
 "\n"
 "    git push --set-upstream %s %s\n"
=20
-#: builtin/push.c:141
+#: builtin/push.c:140
 #, c-format
 msgid "The current branch %s has multiple upstream branches, refusing =
to push."
 msgstr "Nh=C3=A1nh hi=E1=BB=87n t=E1=BA=A1i %s c=C3=B3 =C4=91a nh=C3=A1=
nh th=C6=B0=E1=BB=A3ng ngu=E1=BB=93n (upstream), t=E1=BB=AB ch=E1=BB=91=
i push."
=20
-#: builtin/push.c:144
+#: builtin/push.c:143
 #, c-format
 msgid ""
 "You are pushing to remote '%s', which is not the upstream of\n"
@@ -7880,11 +7814,11 @@ msgstr ""
 "nh=C3=A1nh hi=E1=BB=87n t=E1=BA=A1i =E2=80=9C%s=E2=80=9D c=E1=BB=A7a =
b=E1=BA=A1n, m=C3=A0 kh=C3=B4ng b=C3=A1o cho t=C3=B4i bi=E1=BA=BFt l=C3=
=A0 c=C3=A1i g=C3=AC =C4=91=C6=B0=E1=BB=A3c push\n"
 "=C4=91=E1=BB=83 c=E1=BA=ADp nh=E1=BA=ADt nh=C3=A1nh m=C3=A1y ch=E1=BB=
=A7 n=C3=A0o."
=20
-#: builtin/push.c:167
+#: builtin/push.c:166
 msgid ""
-"push.default is unset; its implicit value is changing in\n"
+"push.default is unset; its implicit value has changed in\n"
 "Git 2.0 from 'matching' to 'simple'. To squelch this message\n"
-"and maintain the current behavior after the default changes, use:\n"
+"and maintain the traditional behavior, use:\n"
 "\n"
 "  git config --global push.default matching\n"
 "\n"
@@ -7899,12 +7833,12 @@ msgid ""
 msgstr ""
 "bi=E1=BA=BFn push.default ch=C6=B0a =C4=91=C6=B0=E1=BB=A3c =C4=91=E1=BA=
=B7t; gi=C3=A1 tr=E1=BB=8B ng=E1=BA=A7m =C4=91=E1=BB=8Bnh c=E1=BB=A7a n=
=C3=B3\n"
 "=C4=91=C3=A3 =C4=91=C6=B0=E1=BB=A3c thay =C4=91=E1=BB=95i trong Git 2=
=2E0 t=E1=BB=AB =E2=80=9Cmatching=E2=80=9D th=C3=A0nh =E2=80=9Csimple=E2=
=80=9D.\n"
-"=C4=90=E1=BB=83 kh=C3=B4ng hi=E1=BB=83n th=E1=BB=8B nh=E1=BA=AFc nh=E1=
=BB=9F n=C3=A0y v=C3=A0 duy tr=C3=AC c=C3=A1ch x=E1=BB=AD l=C3=BD sau\n=
"
-"nh=E1=BB=AFng thay =C4=91=E1=BB=95i m=E1=BA=B7c =C4=91=E1=BB=8Bnh n=C3=
=A0y, h=C3=A3y ch=E1=BA=A1y l=E1=BB=87nh:\n"
+"=C4=90=E1=BB=83 kh=C3=B4ng hi=E1=BB=83n th=E1=BB=8B nh=E1=BA=AFc nh=E1=
=BB=9F n=C3=A0y v=C3=A0 duy tr=C3=AC c=C3=A1ch x=E1=BB=AD l=C3=BD c=E1=BB=
=95 =C4=91i=E1=BB=83n,\n"
+"h=C3=A3y ch=E1=BA=A1y l=E1=BB=87nh:\n"
 "\n"
 "  git config --global push.default matching\n"
 "\n"
-"=C4=90=E1=BB=83 kh=C3=B4ng hi=E1=BB=83n th=E1=BB=8B nh=E1=BA=AFc nh=E1=
=BB=9F n=C3=A0y v=C3=A0 =C3=A1p d=E1=BB=A5ng c=C3=A1ch x=E1=BB=AD l=C3=BD=
 m=E1=BB=9Bi, h=C3=A3y ch=E1=BA=A1y l=E1=BB=87nh:\n"
+"=C4=90=E1=BB=83 kh=C3=B4ng hi=E1=BB=83n th=E1=BB=8B nh=E1=BA=AFc nh=E1=
=BB=9F n=C3=A0y v=C3=A0 =C3=A1p d=E1=BB=A5ng c=C3=A1ch =E1=BB=A9ng x=E1=
=BB=AD m=E1=BB=9Bi, h=C3=A3y ch=E1=BA=A1y l=E1=BB=87nh:\n"
 "\n"
 "  git config --global push.default simple\n"
 "\n"
@@ -7913,14 +7847,14 @@ msgstr ""
 "t=E1=BB=B1\n"
 "=E2=80=9Ccurrent=E2=80=9D thay v=C3=AC =E2=80=9Csimple=E2=80=9D n=E1=BA=
=BFu b=E1=BA=A1n th=E1=BB=89nh tho=E1=BA=A3ng ph=E1=BA=A3i s=E1=BB=AD d=
=E1=BB=A5ng b=E1=BA=A3n Git c=C5=A9)"
=20
-#: builtin/push.c:227
+#: builtin/push.c:226
 msgid ""
 "You didn't specify any refspecs to push, and push.default is \"nothin=
g\"."
 msgstr ""
 "B=E1=BA=A1n =C4=91=C3=A3 kh=C3=B4ng ch=E1=BB=89 ra m=E1=BB=99t refspe=
cs n=C3=A0o =C4=91=E1=BB=83 push, v=C3=A0 push.default l=C3=A0 \"kh=C3=B4=
ng l=C3=A0 "
 "g=C3=AC c=E1=BA=A3\"."
=20
-#: builtin/push.c:234
+#: builtin/push.c:233
 msgid ""
 "Updates were rejected because the tip of your current branch is behin=
d\n"
 "its remote counterpart. Integrate the remote changes (e.g.\n"
@@ -7934,22 +7868,7 @@ msgstr ""
 "Xem =E2=80=9CNote about fast-forwards=E2=80=9D t=E1=BB=AB l=E1=BB=87n=
h =E2=80=9Cgit push --help=E2=80=9D =C4=91=E1=BB=83 c=C3=B3 th=C3=B4ng =
tin chi "
 "ti=E1=BA=BFt."
=20
-#: builtin/push.c:240
-msgid ""
-"Updates were rejected because a pushed branch tip is behind its remot=
e\n"
-"counterpart. If you did not intend to push that branch, you may want =
to\n"
-"specify branches to push or set the 'push.default' configuration vari=
able\n"
-"to 'simple', 'current' or 'upstream' to push only the current branch.=
"
-msgstr ""
-"Vi=E1=BB=87c c=E1=BA=ADp nh=E1=BA=ADt b=E1=BB=8B t=E1=BB=AB ch=E1=BB=91=
i b=E1=BB=9Fi v=C3=AC =C4=91=E1=BA=A7u m=C3=BAt c=E1=BB=A7a nh=C3=A1nh =
=C4=91=C6=B0=E1=BB=A3c push n=E1=BA=B1m =C4=91=E1=BA=B1ng sau b=E1=BB=99=
\n"
-"ph=E1=BA=ADn t=C6=B0=C6=A1ng =E1=BB=A9ng c=E1=BB=A7a m=C3=A1y ch=E1=BB=
=A7. N=E1=BA=BFu b=E1=BA=A1n kh=C3=B4ng c=C3=B3 =C3=BD =C4=91=E1=BB=8Bn=
h push nh=C3=A1nh =C4=91=C3=B3, b=E1=BA=A1n c=C3=B3 l=E1=BA=BD "
-"mu=E1=BB=91n\n"
-"ch=E1=BB=89 =C4=91=E1=BB=8Bnh c=C3=A1c nh=C3=A1nh =C4=91=E1=BB=83 pus=
h ho=E1=BA=B7t l=C3=A0 =C4=91=E1=BA=B7t n=E1=BB=99i dung cho bi=E1=BA=BF=
n c=E1=BA=A5u h=C3=ACnh =E2=80=9Cpush."
-"default=E2=80=9D\n"
-"th=C3=A0nh =E2=80=9Csimple=E2=80=9D, =E2=80=9Ccurrent=E2=80=9D ho=E1=BA=
=B7c =E2=80=9Cupstream=E2=80=9D =C4=91=E1=BB=83 ch=E1=BB=89 push nh=C3=A1=
nh hi=E1=BB=87n h=C3=A0nh m=C3=A0 "
-"th=C3=B4i."
-
-#: builtin/push.c:246
+#: builtin/push.c:239
 msgid ""
 "Updates were rejected because a pushed branch tip is behind its remot=
e\n"
 "counterpart. Check out this branch and integrate the remote changes\n=
"
@@ -7963,7 +7882,7 @@ msgstr ""
 "Xem =E2=80=9CNote about fast-forwards=E2=80=9D t=E1=BB=AB l=E1=BB=87n=
h =E2=80=9Cgit push --help=E2=80=9D =C4=91=E1=BB=83 c=C3=B3 th=C3=B4ng =
tin chi "
 "ti=E1=BA=BFt."
=20
-#: builtin/push.c:252
+#: builtin/push.c:245
 msgid ""
 "Updates were rejected because the remote contains work that you do\n"
 "not have locally. This is usually caused by another repository pushin=
g\n"
@@ -7978,11 +7897,11 @@ msgstr ""
 "Xem =E2=80=9CNote about fast-forwards=E2=80=9D t=E1=BB=AB l=E1=BB=87n=
h =E2=80=9Cgit push --help=E2=80=9D =C4=91=E1=BB=83 c=C3=B3 th=C3=B4ng =
tin chi "
 "ti=E1=BA=BFt."
=20
-#: builtin/push.c:259
+#: builtin/push.c:252
 msgid "Updates were rejected because the tag already exists in the rem=
ote."
 msgstr "Vi=E1=BB=87c c=E1=BA=ADp nh=E1=BA=ADt b=E1=BB=8B t=E1=BB=AB ch=
=E1=BB=91i b=E1=BB=9Fi v=C3=AC th=E1=BA=BB =C4=91=C3=A3 s=E1=BA=B5n c=C3=
=B3 t=E1=BB=AB tr=C6=B0=E1=BB=9Bc tr=C3=AAn m=C3=A1y ch=E1=BB=A7."
=20
-#: builtin/push.c:262
+#: builtin/push.c:255
 msgid ""
 "You cannot update a remote ref that points at a non-commit object,\n"
 "or update a remote ref to make it point at a non-commit object,\n"
@@ -7994,22 +7913,22 @@ msgstr ""
 "t=C6=B0=E1=BB=A3ng\n"
 "kh=C3=B4ng ph=E1=BA=A3i chuy=E1=BB=83n giao, m=C3=A0 kh=C3=B4ng s=E1=BB=
=AD d=E1=BB=A5ng t=C3=B9y ch=E1=BB=8Dn =E2=80=9C--force=E2=80=9D.\n"
=20
-#: builtin/push.c:328
+#: builtin/push.c:314
 #, c-format
 msgid "Pushing to %s\n"
 msgstr "=C4=90ang push (=C4=91=E1=BA=A9y) l=C3=AAn %s\n"
=20
-#: builtin/push.c:332
+#: builtin/push.c:318
 #, c-format
 msgid "failed to push some refs to '%s'"
 msgstr "g=E1=BA=B7p l=E1=BB=97i khi push (=C4=91=E1=BA=A9y l=C3=AAn) m=
=E1=BB=99t s=E1=BB=91 tham chi=E1=BA=BFu (ref) =C4=91=E1=BA=BFn =E2=80=9C=
%s=E2=80=9D"
=20
-#: builtin/push.c:365
+#: builtin/push.c:348
 #, c-format
 msgid "bad repository '%s'"
 msgstr "repository (kho) sai =E2=80=9C%s=E2=80=9D"
=20
-#: builtin/push.c:366
+#: builtin/push.c:349
 msgid ""
 "No configured push destination.\n"
 "Either specify the URL from the command-line or configure a remote "
@@ -8030,96 +7949,96 @@ msgstr ""
 "\n"
 "    git push <t=C3=AAn>\n"
=20
-#: builtin/push.c:381
+#: builtin/push.c:364
 msgid "--all and --tags are incompatible"
 msgstr "--all v=C3=A0 --tags xung kh=E1=BA=AFc nhau"
=20
-#: builtin/push.c:382
+#: builtin/push.c:365
 msgid "--all can't be combined with refspecs"
 msgstr "--all kh=C3=B4ng th=E1=BB=83 =C4=91=C6=B0=E1=BB=A3c t=E1=BB=95=
 h=E1=BB=A3p c=C3=B9ng v=E1=BB=9Bi =C4=91=E1=BA=B7c t=E1=BA=A3 =C4=91=C6=
=B0=E1=BB=9Dng d=E1=BA=ABn"
=20
-#: builtin/push.c:387
+#: builtin/push.c:370
 msgid "--mirror and --tags are incompatible"
 msgstr "--mirror v=C3=A0 --tags xung kh=E1=BA=AFc nhau"
=20
-#: builtin/push.c:388
+#: builtin/push.c:371
 msgid "--mirror can't be combined with refspecs"
 msgstr "--mirror kh=C3=B4ng th=E1=BB=83 =C4=91=C6=B0=E1=BB=A3c t=E1=BB=
=95 h=E1=BB=A3p c=C3=B9ng v=E1=BB=9Bi =C4=91=E1=BA=B7c t=E1=BA=A3 =C4=91=
=C6=B0=E1=BB=9Dng d=E1=BA=ABn"
=20
-#: builtin/push.c:393
+#: builtin/push.c:376
 msgid "--all and --mirror are incompatible"
 msgstr "--all v=C3=A0 --mirror xung kh=E1=BA=AFc nhau"
=20
-#: builtin/push.c:453
+#: builtin/push.c:436
 msgid "repository"
 msgstr "kho"
=20
-#: builtin/push.c:454
+#: builtin/push.c:437
 msgid "push all refs"
 msgstr "push t=E1=BA=A5t c=E1=BA=A3 refs"
=20
-#: builtin/push.c:455
+#: builtin/push.c:438
 msgid "mirror all refs"
 msgstr "mirror t=E1=BA=A5t c=E1=BA=A3 c=C3=A1c tham chi=E1=BA=BFu"
=20
-#: builtin/push.c:457
+#: builtin/push.c:440
 msgid "delete refs"
 msgstr "x=C3=B3a refs"
=20
-#: builtin/push.c:458
+#: builtin/push.c:441
 msgid "push tags (can't be used with --all or --mirror)"
 msgstr ""
 "c=C3=A1c th=E1=BA=BB push (kh=C3=B4ng th=E1=BB=83 s=E1=BB=AD d=E1=BB=A5=
ng c=C3=B9ng v=E1=BB=9Bi c=C3=A1c t=C3=B9y ch=E1=BB=8Dn --all hay --mir=
ror)"
=20
-#: builtin/push.c:461
+#: builtin/push.c:444
 msgid "force updates"
 msgstr "=C3=A9p bu=E1=BB=99c c=E1=BA=ADp nh=E1=BA=ADt"
=20
-#: builtin/push.c:463
+#: builtin/push.c:446
 msgid "refname>:<expect"
 msgstr "t=C3=AAn-tham-chi=E1=BA=BFu>:<c=E1=BA=A7n"
=20
-#: builtin/push.c:464
+#: builtin/push.c:447
 msgid "require old value of ref to be at this value"
 msgstr "y=C3=AAu c=E1=BA=A7u gi=C3=A1-tr=E1=BB=8B c=C5=A9 c=E1=BB=A7a =
tham chi=E1=BA=BFu th=C3=AC l=C3=A0 gi=C3=A1-tr=E1=BB=8B n=C3=A0y"
=20
-#: builtin/push.c:466
+#: builtin/push.c:449
 msgid "check"
 msgstr "ki=E1=BB=83m tra"
=20
-#: builtin/push.c:467
+#: builtin/push.c:450
 msgid "control recursive pushing of submodules"
 msgstr "=C4=91i=E1=BB=81u khi=E1=BB=83n vi=E1=BB=87c =C4=91=E1=BA=A9y =
l=C3=AAn (push) =C4=91=E1=BB=87 qui c=E1=BB=A7a m=C3=B4-=C4=91un-con"
=20
-#: builtin/push.c:469
+#: builtin/push.c:452
 msgid "use thin pack"
 msgstr "t=E1=BA=A1o g=C3=B3i nh=E1=BA=B9"
=20
-#: builtin/push.c:470 builtin/push.c:471
+#: builtin/push.c:453 builtin/push.c:454
 msgid "receive pack program"
 msgstr "nh=E1=BA=ADn v=E1=BB=81 ch=C6=B0=C6=A1ng tr=C3=ACnh pack"
=20
-#: builtin/push.c:472
+#: builtin/push.c:455
 msgid "set upstream for git pull/status"
 msgstr "=C4=91=E1=BA=B7t th=C6=B0=E1=BB=A3ng ngu=E1=BB=93n (upstream) =
cho git pull/status"
=20
-#: builtin/push.c:475
+#: builtin/push.c:458
 msgid "prune locally removed refs"
 msgstr "prune (c=E1=BA=AFt c=E1=BB=A5t) nh=E1=BB=AFng tham chi=E1=BA=BF=
u (refs) b=E1=BB=8B g=E1=BB=A1 b=E1=BB=8F"
=20
-#: builtin/push.c:477
+#: builtin/push.c:460
 msgid "bypass pre-push hook"
 msgstr "v=C3=B2ng qua =E2=80=9Cpre-push hook=E2=80=9D"
=20
-#: builtin/push.c:478
+#: builtin/push.c:461
 msgid "push missing but relevant tags"
 msgstr "push b=E1=BB=8B tr=C6=B0=E1=BB=A3t nh=C6=B0ng c=C3=A1c th=E1=BA=
=BB th=C3=ADch h=E1=BB=A3p"
=20
-#: builtin/push.c:488
+#: builtin/push.c:471
 msgid "--delete is incompatible with --all, --mirror and --tags"
 msgstr "--delete l=C3=A0 xung kh=E1=BA=AFc v=E1=BB=9Bi c=C3=A1c t=C3=B9=
y ch=E1=BB=8Dn --all, --mirror v=C3=A0 --tags"
=20
-#: builtin/push.c:490
+#: builtin/push.c:473
 msgid "--delete doesn't make sense without any refs"
 msgstr "--delete kh=C3=B4ng h=E1=BB=A3p l=C3=BD n=E1=BA=BFu kh=C3=B4ng=
 c=C3=B3 b=E1=BA=A5t k=E1=BB=B3 tham chi=E1=BA=BFu (refs) n=C3=A0o"
=20
@@ -8927,19 +8846,23 @@ msgstr "Kh=C3=B4ng th=E1=BB=83 =C4=91=E1=BA=B7t=
 l=E1=BA=A1i (reset) b=E1=BA=A3ng m=E1=BB=A5c l=E1=BB=A5c th=C3=A0nh =C4=
=91i=E1=BB=83m x=C3=A9t
 msgid "Could not write new index file."
 msgstr "Kh=C3=B4ng th=E1=BB=83 ghi t=E1=BA=ADp tin l=C6=B0u b=E1=BA=A3=
ng m=E1=BB=A5c l=E1=BB=A5c m=E1=BB=9Bi."
=20
-#: builtin/rev-parse.c:345
+#: builtin/rev-parse.c:350
 msgid "git rev-parse --parseopt [options] -- [<args>...]"
 msgstr "git rev-parse --parseopt [c=C3=A1c-t=C3=B9y-ch=E1=BB=8Dn] -- [=
<th.s=E1=BB=91>...]"
=20
-#: builtin/rev-parse.c:350
+#: builtin/rev-parse.c:355
 msgid "keep the `--` passed as an arg"
 msgstr "gi=E1=BB=AF =E2=80=9C--=E2=80=9C chuy=E1=BB=83n qua l=C3=A0m t=
ham s=E1=BB=91"
=20
-#: builtin/rev-parse.c:352
+#: builtin/rev-parse.c:357
 msgid "stop parsing after the first non-option argument"
 msgstr "d=E1=BB=ABng ph=C3=A2n t=C3=ADch sau =C4=91=E1=BB=91i s=E1=BB=91=
 =C4=91=E1=BA=A7u ti=C3=AAn kh=C3=B4ng c=C3=B3 t=C3=B9y ch=E1=BB=8Dn"
=20
-#: builtin/rev-parse.c:470
+#: builtin/rev-parse.c:360
+msgid "output in stuck long form"
+msgstr "k=E1=BA=BFt xu=E1=BA=A5t trong =C4=91=E1=BB=8Bnh d=E1=BA=A1ng =
g=E1=BA=ADy d=C3=A0i"
+
+#: builtin/rev-parse.c:477
 msgid ""
 "git rev-parse --parseopt [options] -- [<args>...]\n"
 "   or: git rev-parse --sq-quote [<arg>...]\n"
@@ -9186,67 +9109,67 @@ msgstr ""
 msgid "git show-branch (-g|--reflog)[=3D<n>[,<base>]] [--list] [<ref>]=
"
 msgstr "git show-branch (-g|--reflog)[=3D<n>[,<n=E1=BB=81n>]] [--list]=
 [<ref>]"
=20
-#: builtin/show-branch.c:650
+#: builtin/show-branch.c:649
 msgid "show remote-tracking and local branches"
 msgstr "hi=E1=BB=83n th=E1=BB=8B c=C3=A1c nh=C3=A1nh remote-tracking v=
=C3=A0 n=E1=BB=99i b=E1=BB=99"
=20
-#: builtin/show-branch.c:652
+#: builtin/show-branch.c:651
 msgid "show remote-tracking branches"
 msgstr "hi=E1=BB=83n th=E1=BB=8B c=C3=A1c nh=C3=A1nh remote-tracking"
=20
-#: builtin/show-branch.c:654
+#: builtin/show-branch.c:653
 msgid "color '*!+-' corresponding to the branch"
 msgstr "m=C3=A0u =E2=80=9C*!+-=E2=80=9D t=C6=B0=C6=A1ng =E1=BB=A9ng v=E1=
=BB=9Bi nh=C3=A1nh"
=20
-#: builtin/show-branch.c:656
+#: builtin/show-branch.c:655
 msgid "show <n> more commits after the common ancestor"
 msgstr "hi=E1=BB=83n th=E1=BB=8B th=C3=AAm <n> l=E1=BA=A7n chuy=E1=BB=83=
n giao sau cha m=E1=BA=B9 chung"
=20
-#: builtin/show-branch.c:658
+#: builtin/show-branch.c:657
 msgid "synonym to more=3D-1"
 msgstr "=C4=91=E1=BB=93ng ngh=C4=A9a v=E1=BB=9Bi more=3D-1"
=20
-#: builtin/show-branch.c:659
+#: builtin/show-branch.c:658
 msgid "suppress naming strings"
 msgstr "ch=E1=BA=B7n c=C3=A1c chu=E1=BB=97i =C4=91=E1=BA=B7t t=C3=AAn"
=20
-#: builtin/show-branch.c:661
+#: builtin/show-branch.c:660
 msgid "include the current branch"
 msgstr "bao g=E1=BB=93m nh=C3=A1nh hi=E1=BB=87n h=C3=A0nh"
=20
-#: builtin/show-branch.c:663
+#: builtin/show-branch.c:662
 msgid "name commits with their object names"
 msgstr "=C4=91=E1=BA=B7t t=C3=AAn c=C3=A1c l=E1=BA=A7n chuy=E1=BB=83n =
giao b=E1=BA=B1ng c=C3=A1c t=C3=AAn c=E1=BB=A7a =C4=91=E1=BB=91i t=C6=B0=
=E1=BB=A3ng c=E1=BB=A7a ch=C3=BAng"
=20
-#: builtin/show-branch.c:665
+#: builtin/show-branch.c:664
 msgid "show possible merge bases"
 msgstr "hi=E1=BB=83n th=E1=BB=8B m=E1=BB=8Di c=C6=A1 s=E1=BB=9F c=C3=B3=
 th=E1=BB=83 d=C3=B9ng =C4=91=E1=BB=83 h=C3=B2a tr=E1=BB=99n"
=20
-#: builtin/show-branch.c:667
+#: builtin/show-branch.c:666
 msgid "show refs unreachable from any other ref"
 msgstr "hi=E1=BB=83n th=E1=BB=8B c=C3=A1c tham chi=E1=BA=BFu kh=C3=B4n=
g th=E1=BB=83 =C4=91=C6=B0=E1=BB=A3c =C4=91=E1=BB=8Dc b=E1=BB=9Fi b=E1=BA=
=A5t k=E1=BB=B3 tham chi=E1=BA=BFu kh=C3=A1c"
=20
-#: builtin/show-branch.c:669
+#: builtin/show-branch.c:668
 msgid "show commits in topological order"
 msgstr "hi=E1=BB=83n th=E1=BB=8B c=C3=A1c l=E1=BA=A7n chuy=E1=BB=83n g=
iao theo th=E1=BB=A9 t=E1=BB=B1 t=C3=B4p=C3=B4"
=20
-#: builtin/show-branch.c:672
+#: builtin/show-branch.c:671
 msgid "show only commits not on the first branch"
 msgstr "ch=E1=BB=89 hi=E1=BB=83n th=E1=BB=8B c=C3=A1c l=E1=BA=A7n chuy=
=E1=BB=83n giao kh=C3=B4ng n=E1=BA=B1m tr=C3=AAn nh=C3=A1nh =C4=91=E1=BA=
=A7u ti=C3=AAn"
=20
-#: builtin/show-branch.c:674
+#: builtin/show-branch.c:673
 msgid "show merges reachable from only one tip"
 msgstr "hi=E1=BB=83n th=E1=BB=8B c=C3=A1c l=E1=BA=A7n h=C3=B2a tr=E1=BB=
=99n c=C3=B3 th=E1=BB=83 =C4=91=E1=BB=8Dc =C4=91=C6=B0=E1=BB=A3c ch=E1=BB=
=89 t=E1=BB=AB m=E1=BB=99t =C4=91=E1=BA=A7u m=C3=BAt"
=20
-#: builtin/show-branch.c:676
+#: builtin/show-branch.c:675
 msgid "topologically sort, maintaining date order where possible"
 msgstr "s=E1=BA=AFp x=E1=BA=BFp h=C3=ACnh th=C3=A1i h=E1=BB=8Dc, b=E1=BA=
=A3o tr=C3=AC th=E1=BB=A9 t=E1=BB=B1 ng=C3=A0y n=E1=BA=BFu c=C3=B3 th=E1=
=BB=83"
=20
-#: builtin/show-branch.c:679
+#: builtin/show-branch.c:678
 msgid "<n>[,<base>]"
 msgstr "<n>[,<c=C6=A1 s=E1=BB=9F>]"
=20
-#: builtin/show-branch.c:680
+#: builtin/show-branch.c:679
 msgid "show <n> most recent ref-log entries starting at base"
 msgstr "hi=E1=BB=83n th=E1=BB=8B <n> c=C3=A1c m=E1=BB=A5c =E2=80=9Cref=
-log=E2=80=9D g=E1=BA=A7n nh=E1=BA=A5t k=E1=BB=83 t=E1=BB=AB n=E1=BB=81=
n (base)"
=20
@@ -10644,45 +10567,45 @@ msgstr "G=E1=BA=B7p l=E1=BB=97i khi =C4=91=C4=
=83ng k=C3=BD v=E1=BB=9Bi h=E1=BB=87 th=E1=BB=91ng m=C3=B4-=C4=91un-con=
 =E2=80=9C$sm_path
 msgid "Entering '$prefix$displaypath'"
 msgstr "=C4=90ang v=C3=A0o =E2=80=9C$prefix$displaypath=E2=80=9D"
=20
-#: git-submodule.sh:554
+#: git-submodule.sh:559
 #, sh-format
 msgid "Stopping at '$prefix$displaypath'; script returned non-zero sta=
tus."
 msgstr ""
 "D=E1=BB=ABng l=E1=BA=A1i t=E1=BA=A1i =E2=80=9C$prefix$displaypath=E2=80=
=9D; script tr=E1=BA=A3 v=E1=BB=81 tr=E1=BA=A1ng th=C3=A1i kh=C3=A1c kh=
=C3=B4ng."
=20
-#: git-submodule.sh:600
+#: git-submodule.sh:605
 #, sh-format
 msgid "No url found for submodule path '$displaypath' in .gitmodules"
 msgstr ""
 "Kh=C3=B4ng t=C3=ACm th=E1=BA=A5y url cho =C4=91=C6=B0=E1=BB=9Dng d=E1=
=BA=ABn m=C3=B4-=C4=91un-con =E2=80=9C$displaypath=E2=80=9D trong .gitm=
odules"
=20
-#: git-submodule.sh:609
+#: git-submodule.sh:614
 #, sh-format
 msgid "Failed to register url for submodule path '$displaypath'"
 msgstr "G=E1=BA=B7p l=E1=BB=97i khi =C4=91=C4=83ng k=C3=BD url cho =C4=
=91=C6=B0=E1=BB=9Dng d=E1=BA=ABn m=C3=B4-=C4=91un-con =E2=80=9C$display=
path=E2=80=9D"
=20
-#: git-submodule.sh:611
+#: git-submodule.sh:616
 #, sh-format
 msgid "Submodule '$name' ($url) registered for path '$displaypath'"
 msgstr "M=C3=B4-=C4=91un-con =E2=80=9C$name=E2=80=9D ($url) =C4=91=C6=B0=
=E1=BB=A3c =C4=91=C4=83ng k=C3=BD cho =C4=91=C6=B0=E1=BB=9Dng d=E1=BA=AB=
n =E2=80=9C$displaypath=E2=80=9D"
=20
-#: git-submodule.sh:619
+#: git-submodule.sh:624
 #, sh-format
 msgid "Failed to register update mode for submodule path '$displaypath=
'"
 msgstr ""
 "G=E1=BA=B7p l=E1=BB=97i khi =C4=91=C4=83ng k=C3=BD ch=E1=BA=BF =C4=91=
=E1=BB=99 c=E1=BA=ADp nh=E1=BA=ADt cho =C4=91=C6=B0=E1=BB=9Dng d=E1=BA=AB=
n m=C3=B4-=C4=91un-con =E2=80=9C$displaypath=E2=80=9D"
=20
-#: git-submodule.sh:656
+#: git-submodule.sh:661
 #, sh-format
 msgid "Use '.' if you really want to deinitialize all submodules"
 msgstr "D=C3=B9ng =E2=80=9C.=E2=80=9D n=E1=BA=BFu b=E1=BA=A1n th=E1=BB=
=B1c s=E1=BB=B1 mu=E1=BB=91n g=E1=BB=A1 b=E1=BB=8F m=E1=BB=8Di m=C3=B4-=
=C4=91un-con"
=20
-#: git-submodule.sh:673
+#: git-submodule.sh:678
 #, sh-format
 msgid "Submodule work tree '$displaypath' contains a .git directory"
 msgstr "C=C3=A2y l=C3=A0m vi=E1=BB=87c m=C3=B4-=C4=91un-con =E2=80=9C$=
displaypath=E2=80=9D c=C3=B3 ch=E1=BB=A9a th=C6=B0 m=E1=BB=A5c .git"
=20
-#: git-submodule.sh:674
+#: git-submodule.sh:679
 #, sh-format
 msgid ""
 "(use 'rm -rf' if you really want to remove it including all of its hi=
story)"
@@ -10690,7 +10613,7 @@ msgstr ""
 "(d=C3=B9ng =E2=80=9Crm -rf=E2=80=9D n=E1=BA=BFu b=E1=BA=A1n th=E1=BB=B1=
c s=E1=BB=B1 mu=E1=BB=91n g=E1=BB=A1 b=E1=BB=8F n=C3=B3 c=C3=B9ng v=E1=BB=
=9Bi t=E1=BA=A5t c=E1=BA=A3 l=E1=BB=8Bch s=E1=BB=AD c=E1=BB=A7a "
 "ch=C3=BAng)"
=20
-#: git-submodule.sh:680
+#: git-submodule.sh:685
 #, sh-format
 msgid ""
 "Submodule work tree '$displaypath' contains local modifications; use =
'-f' to "
@@ -10699,27 +10622,27 @@ msgstr ""
 "C=C3=A2y l=C3=A0m vi=E1=BB=87c m=C3=B4-=C4=91un-con =E2=80=9C$display=
path=E2=80=9D ch=E1=BB=A9a c=C3=A1c thay =C4=91=E1=BB=95i n=E1=BB=99i b=
=E1=BB=99; h=C3=A3y d=C3=B9ng =E2=80=9C-"
 "f=E2=80=9D =C4=91=E1=BB=83 lo=E1=BA=A1i b=E1=BB=8F ch=C3=BAng =C4=91i=
"
=20
-#: git-submodule.sh:683
+#: git-submodule.sh:688
 #, sh-format
 msgid "Cleared directory '$displaypath'"
 msgstr "=C4=90=C3=A3 t=E1=BA=A1o th=C6=B0 m=E1=BB=A5c =E2=80=9C$displa=
ypath=E2=80=9D"
=20
-#: git-submodule.sh:684
+#: git-submodule.sh:689
 #, sh-format
 msgid "Could not remove submodule work tree '$displaypath'"
 msgstr "Kh=C3=B4ng th=E1=BB=83 g=E1=BB=A1 b=E1=BB=8F c=C3=A2y l=C3=A0m=
 vi=E1=BB=87c m=C3=B4-=C4=91un-con =E2=80=9C$displaypath=E2=80=9D"
=20
-#: git-submodule.sh:687
+#: git-submodule.sh:692
 #, sh-format
 msgid "Could not create empty submodule directory '$displaypath'"
 msgstr "Kh=C3=B4ng th=E1=BB=83 t=E1=BA=A1o th=C6=B0 m=E1=BB=A5c m=C3=B4=
-=C4=91un-con r=E1=BB=97ng =E2=80=9C$displaypath=E2=80=9D"
=20
-#: git-submodule.sh:696
+#: git-submodule.sh:701
 #, sh-format
 msgid "Submodule '$name' ($url) unregistered for path '$displaypath'"
 msgstr "M=C3=B4-=C4=91un-con =E2=80=9C$name=E2=80=9D ($url) =C4=91=C6=B0=
=E1=BB=A3c b=E1=BB=8F =C4=91=C4=83ng k=C3=BD cho =C4=91=C6=B0=E1=BB=9Dn=
g d=E1=BA=ABn =E2=80=9C$displaypath=E2=80=9D"
=20
-#: git-submodule.sh:811
+#: git-submodule.sh:816
 #, sh-format
 msgid ""
 "Submodule path '$displaypath' not initialized\n"
@@ -10728,45 +10651,45 @@ msgstr ""
 "=C4=90=C6=B0=E1=BB=9Dng d=E1=BA=ABn m=C3=B4-=C4=91un-con =E2=80=9C$di=
splaypath=E2=80=9D ch=C6=B0a =C4=91=C6=B0=E1=BB=A3c kh=E1=BB=9Fi t=E1=BA=
=A1o.\n"
 "C=C3=B3 l=E1=BA=BD b=E1=BA=A1n mu=E1=BB=91n s=E1=BB=AD d=E1=BB=A5ng l=
=E1=BB=87nh =E2=80=9Cupdate --init=E2=80=9D?"
=20
-#: git-submodule.sh:824
+#: git-submodule.sh:829
 #, sh-format
 msgid "Unable to find current revision in submodule path '$displaypath=
'"
 msgstr ""
 "Kh=C3=B4ng t=C3=ACm th=E1=BA=A5y =C4=91i=E1=BB=83m x=C3=A9t duy=E1=BB=
=87t hi=E1=BB=87n h=C3=A0nh trong =C4=91=C6=B0=E1=BB=9Dng d=E1=BA=ABn m=
=C3=B4-=C4=91un-con "
 "=E2=80=9C$displaypath=E2=80=9D"
=20
-#: git-submodule.sh:833
+#: git-submodule.sh:838
 #, sh-format
 msgid "Unable to fetch in submodule path '$sm_path'"
 msgstr "Kh=C3=B4ng th=E1=BB=83 l=E1=BA=A5y v=E1=BB=81 (fetch) trong =C4=
=91=C6=B0=E1=BB=9Dng d=E1=BA=ABn m=C3=B4-=C4=91un-con =E2=80=9C$sm_path=
=E2=80=9D"
=20
-#: git-submodule.sh:857
+#: git-submodule.sh:862
 #, sh-format
 msgid "Unable to fetch in submodule path '$displaypath'"
 msgstr "Kh=C3=B4ng th=E1=BB=83 l=E1=BA=A5y v=E1=BB=81 (fetch) trong =C4=
=91=C6=B0=E1=BB=9Dng d=E1=BA=ABn m=C3=B4-=C4=91un-con =E2=80=9C$display=
path=E2=80=9D"
=20
-#: git-submodule.sh:871
+#: git-submodule.sh:876
 #, sh-format
 msgid "Unable to rebase '$sha1' in submodule path '$displaypath'"
 msgstr "Kh=C3=B4ng th=E1=BB=83 rebase =E2=80=9C$sha1=E2=80=9D trong =C4=
=91=C6=B0=E1=BB=9Dng d=E1=BA=ABn m=C3=B4-=C4=91un-con =E2=80=9C$display=
path=E2=80=9D"
=20
-#: git-submodule.sh:872
+#: git-submodule.sh:877
 #, sh-format
 msgid "Submodule path '$displaypath': rebased into '$sha1'"
 msgstr "=C4=90=C6=B0=E1=BB=9Dng d=E1=BA=ABn m=C3=B4-=C4=91un-con =E2=80=
=9C$displaypath=E2=80=9D: =C4=91=C6=B0=E1=BB=A3c rebase v=C3=A0o trong =
=E2=80=9C$sha1=E2=80=9D"
=20
-#: git-submodule.sh:877
+#: git-submodule.sh:882
 #, sh-format
 msgid "Unable to merge '$sha1' in submodule path '$displaypath'"
 msgstr ""
 "Kh=C3=B4ng th=E1=BB=83 h=C3=B2a tr=E1=BB=99n (merge) =E2=80=9C$sha1=E2=
=80=9D trong =C4=91=C6=B0=E1=BB=9Dng d=E1=BA=ABn m=C3=B4-=C4=91un-con =E2=
=80=9C$displaypath=E2=80=9D"
=20
-#: git-submodule.sh:878
+#: git-submodule.sh:883
 #, sh-format
 msgid "Submodule path '$displaypath': merged in '$sha1'"
 msgstr "=C4=90=C6=B0=E1=BB=9Dng d=E1=BA=ABn m=C3=B4-=C4=91un-con =E2=80=
=9C$displaypath=E2=80=9D: =C4=91=C6=B0=E1=BB=A3c h=C3=B2a tr=E1=BB=99n =
v=C3=A0o =E2=80=9C$sha1=E2=80=9D"
=20
-#: git-submodule.sh:883
+#: git-submodule.sh:888
 #, sh-format
 msgid ""
 "Execution of '$command $sha1' failed in submodule  path '$prefix$sm_p=
ath'"
@@ -10774,69 +10697,148 @@ msgstr ""
 "Th=E1=BB=B1c hi=E1=BB=87n kh=C3=B4ng th=C3=A0nh c=C3=B4ng l=E1=BB=87n=
h =E2=80=9C$command $sha1=E2=80=9D trong =C4=91=C6=B0=E1=BB=9Dng d=E1=BA=
=ABn m=C3=B4-=C4=91un-con "
 "=E2=80=9C$prefix$sm_path=E2=80=9D"
=20
-#: git-submodule.sh:884
+#: git-submodule.sh:889
 #, sh-format
 msgid "Submodule path '$prefix$sm_path': '$command $sha1'"
 msgstr "=C4=90=C6=B0=E1=BB=9Dng d=E1=BA=ABn m=C3=B4-=C4=91un-con =E2=80=
=9C$prefix$sm_path=E2=80=9D: =E2=80=9C$command $sha1=E2=80=9D"
=20
-#: git-submodule.sh:889
+#: git-submodule.sh:894
 #, sh-format
 msgid "Unable to checkout '$sha1' in submodule path '$displaypath'"
 msgstr "Kh=C3=B4ng th=E1=BB=83 checkout =E2=80=9C$sha1=E2=80=9D trong =
=C4=91=C6=B0=E1=BB=9Dng d=E1=BA=ABn m=C3=B4-=C4=91un-con =E2=80=9C$disp=
laypath=E2=80=9D"
=20
-#: git-submodule.sh:890
+#: git-submodule.sh:895
 #, sh-format
 msgid "Submodule path '$displaypath': checked out '$sha1'"
 msgstr "=C4=90=C6=B0=E1=BB=9Dng d=E1=BA=ABn m=C3=B4-=C4=91un-con =E2=80=
=9C$displaypath=E2=80=9D: =C4=91=C3=A3 checkout =E2=80=9C$sha1=E2=80=9D=
"
=20
-#: git-submodule.sh:917
+#: git-submodule.sh:922
 #, sh-format
 msgid "Failed to recurse into submodule path '$displaypath'"
 msgstr "G=E1=BA=B7p l=E1=BB=97i khi =C4=91=E1=BB=87 quy v=C3=A0o trong=
 =C4=91=C6=B0=E1=BB=9Dng d=E1=BA=ABn m=C3=B4-=C4=91un-con =E2=80=9C$dis=
playpath=E2=80=9D"
=20
-#: git-submodule.sh:1025
+#: git-submodule.sh:1030
 msgid "The --cached option cannot be used with the --files option"
 msgstr "T=C3=B9y ch=E1=BB=8Dn --cached kh=C3=B4ng th=E1=BB=83 d=C3=B9n=
g c=C3=B9ng v=E1=BB=9Bi t=C3=B9y ch=E1=BB=8Dn --files"
=20
 #. unexpected type
-#: git-submodule.sh:1073
+#: git-submodule.sh:1078
 #, sh-format
 msgid "unexpected mode $mod_dst"
 msgstr "ch=E1=BA=BF =C4=91=E1=BB=99 kh=C3=B4ng nh=C6=B0 mong ch=E1=BB=9D=
 $mod_dst"
=20
-#: git-submodule.sh:1093
+#: git-submodule.sh:1098
 #, sh-format
 msgid "  Warn: $display_name doesn't contain commit $sha1_src"
 msgstr ""
 "  C=E1=BA=A3nh b=C3=A1o: $display_name kh=C3=B4ng ch=E1=BB=A9a l=E1=BA=
=A7n chuy=E1=BB=83n giao (commit) $sha1_src"
=20
-#: git-submodule.sh:1096
+#: git-submodule.sh:1101
 #, sh-format
 msgid "  Warn: $display_name doesn't contain commit $sha1_dst"
 msgstr ""
 "  C=E1=BA=A3nh b=C3=A1o: $display_name kh=C3=B4ng ch=E1=BB=A9a l=E1=BA=
=A7n chuy=E1=BB=83n giao (commit) $sha1_dst"
=20
-#: git-submodule.sh:1099
+#: git-submodule.sh:1104
 #, sh-format
 msgid "  Warn: $display_name doesn't contain commits $sha1_src and $sh=
a1_dst"
 msgstr ""
 "  C=E1=BA=A3nh b=C3=A1o: $display_name kh=C3=B4ng ch=E1=BB=A9a nh=E1=BB=
=AFng l=E1=BA=A7n chuy=E1=BB=83n giao (commit) "
 "$sha1_src v=C3=A0 $sha1_dst"
=20
-#: git-submodule.sh:1124
+#: git-submodule.sh:1129
 msgid "blob"
 msgstr "blob"
=20
-#: git-submodule.sh:1238
+#: git-submodule.sh:1243
 #, sh-format
 msgid "Failed to recurse into submodule path '$sm_path'"
 msgstr "G=E1=BA=B7p l=E1=BB=97i khi =C4=91=E1=BB=87 quy v=C3=A0o trong=
 =C4=91=C6=B0=E1=BB=9Dng d=E1=BA=ABn m=C3=B4-=C4=91un-con =E2=80=9C$sm_=
path=E2=80=9D"
=20
-#: git-submodule.sh:1302
+#: git-submodule.sh:1307
 #, sh-format
 msgid "Synchronizing submodule url for '$displaypath'"
 msgstr "Url M=C3=B4-=C4=91un-con =C4=91=E1=BB=93ng b=E1=BB=99 h=C3=B3a=
 cho =E2=80=9C$displaypath=E2=80=9D"
=20
+#~ msgid ""
+#~ "The behavior of 'git add %s (or %s)' with no path argument from a\=
n"
+#~ "subdirectory of the tree will change in Git 2.0 and should not be =
used "
+#~ "anymore.\n"
+#~ "To add content for the whole tree, run:\n"
+#~ "\n"
+#~ "  git add %s :/\n"
+#~ "  (or git add %s :/)\n"
+#~ "\n"
+#~ "To restrict the command to the current directory, run:\n"
+#~ "\n"
+#~ "  git add %s .\n"
+#~ "  (or git add %s .)\n"
+#~ "\n"
+#~ "With the current Git version, the command is restricted to the cur=
rent "
+#~ "directory.\n"
+#~ msgstr ""
+#~ "C=C3=A1ch =E1=BB=A9ng x=E1=BB=AD c=E1=BB=A7a l=E1=BB=87nh =E2=80=9C=
git add %s (hay %s)=E2=80=9D khi kh=C3=B4ng c=C3=B3 tham s=E1=BB=91 =C4=
=91=C6=B0=E1=BB=9Dng d=E1=BA=ABn "
+#~ "t=E1=BB=AB\n"
+#~ "th=C6=B0-m=E1=BB=A5c con c=E1=BB=A7a c=C3=A2y s=E1=BA=BD thay =C4=91=
=E1=BB=95i k=E1=BB=83 t=E1=BB=AB Git 2.0 v=C3=A0 kh=C3=B4ng th=E1=BB=83=
 s=E1=BB=AD d=E1=BB=A5ng nh=C6=B0 "
+#~ "th=E1=BA=BF n=E1=BB=AFa.\n"
+#~ "=C4=90=E1=BB=83 th=C3=AAm n=E1=BB=99i dung cho to=C3=A0n b=E1=BB=99=
 c=C3=A2y, ch=E1=BA=A1y:\n"
+#~ "\n"
+#~ "  git add %s :/\n"
+#~ "  (hay git add %s :/)\n"
+#~ "\n"
+#~ "=C4=90=E1=BB=83 h=E1=BA=A1n ch=E1=BA=BF l=E1=BB=87nh cho th=C6=B0-=
m=E1=BB=A5c hi=E1=BB=87n t=E1=BA=A1i, ch=E1=BA=A1y:\n"
+#~ "\n"
+#~ "  git add %s .\n"
+#~ "  (hay git add %s .)\n"
+#~ "\n"
+#~ "V=E1=BB=9Bi phi=C3=AAn b=E1=BA=A3n hi=E1=BB=87n t=E1=BA=A1i c=E1=BB=
=A7a Git, l=E1=BB=87nh b=E1=BB=8B h=E1=BA=A1n ch=E1=BA=BF cho th=C6=B0-=
m=E1=BB=A5c hi=E1=BB=87n t=E1=BA=A1i.\n"
+
+#~ msgid ""
+#~ "You ran 'git add' with neither '-A (--all)' or '--ignore-removal',=
\n"
+#~ "whose behaviour will change in Git 2.0 with respect to paths you "
+#~ "removed.\n"
+#~ "Paths like '%s' that are\n"
+#~ "removed from your working tree are ignored with this version of Gi=
t.\n"
+#~ "\n"
+#~ "* 'git add --ignore-removal <pathspec>', which is the current defa=
ult,\n"
+#~ "  ignores paths you removed from your working tree.\n"
+#~ "\n"
+#~ "* 'git add --all <pathspec>' will let you also record the removals=
=2E\n"
+#~ "\n"
+#~ "Run 'git status' to check the paths you removed from your working =
tree.\n"
+#~ msgstr ""
+#~ "B=E1=BA=A1n ch=E1=BA=A1y =E2=80=9Cgit add=E2=80=9D m=C3=A0 kh=C3=B4=
ng c=C3=B3 =E2=80=9C-A (--all)=E2=80=9D c=C5=A9ng kh=C3=B4ng =E2=80=9C-=
-ignore-"
+#~ "removal=E2=80=9D,\n"
+#~ "c=C3=A1ch =E1=BB=A9ng x=E1=BB=AD c=E1=BB=A7a n=C3=B3 s=E1=BA=BD th=
ay =C4=91=E1=BB=95i k=E1=BB=83 t=E1=BB=AB Git 2.0: n=C3=B3 quan t=C3=A2=
m =C4=91=E1=BA=BFn c=C3=A1c =C4=91=C6=B0=E1=BB=9Dng "
+#~ "d=E1=BA=ABn m=C3=A0\n"
+#~ "b=E1=BA=A1n =C4=91=C3=A3 g=E1=BB=A1 b=E1=BB=8F. C=C3=A1c =C4=91=C6=
=B0=E1=BB=9Dng d=E1=BA=ABn nh=C6=B0 l=C3=A0 =E2=80=9C%s=E2=80=9D c=C3=A1=
i m=C3=A0\n"
+#~ "b=E1=BB=8B g=E1=BB=A1 b=E1=BB=8F t=E1=BB=AB c=C3=A2y l=C3=A0m vi=E1=
=BB=87c c=E1=BB=A7a b=E1=BA=A1n th=C3=AC b=E1=BB=8B b=E1=BB=8F qua v=E1=
=BB=9Bi phi=C3=AAn b=E1=BA=A3n n=C3=A0y c=E1=BB=A7a "
+#~ "Git.\n"
+#~ "\n"
+#~ "* =E2=80=9Cgit add --ignore-removal <pathspec>=E2=80=9D, c=C3=A1i =
hi=E1=BB=87n t=E1=BA=A1i l=C3=A0 m=E1=BA=B7c =C4=91=E1=BB=8Bnh,\n"
+#~ "  b=E1=BB=8F qua c=C3=A1c =C4=91=C6=B0=E1=BB=9Dng d=E1=BA=ABn b=E1=
=BA=A1n =C4=91=C3=A3 g=E1=BB=A1 b=E1=BB=8F t=E1=BB=AB c=C3=A2y l=C3=A0m=
 vi=E1=BB=87c c=E1=BB=A7a b=E1=BA=A1n.\n"
+#~ "\n"
+#~ "* =E2=80=9Cgit add --all <pathspec>=E2=80=9D s=E1=BA=BD =C4=91=E1=BB=
=93ng th=E1=BB=9Di gi=C3=BAp b=E1=BA=A1n ghi l=E1=BA=A1i vi=E1=BB=87c d=
=E1=BB=9Di =C4=91i.\n"
+#~ "\n"
+#~ "Ch=E1=BA=A1y =E2=80=9Cgit status=E2=80=9D =C4=91=E1=BB=83 ki=E1=BB=
=83m tra c=C3=A1c =C4=91=C6=B0=E1=BB=9Dng d=E1=BA=ABn b=E1=BA=A1n =C4=91=
=C3=A3 g=E1=BB=A1 b=E1=BB=8F t=E1=BB=AB c=C3=A2y l=C3=A0m vi=E1=BB=87c =
"
+#~ "c=E1=BB=A7a b=E1=BA=A1n.\n"
+
+#~ msgid ""
+#~ "Updates were rejected because a pushed branch tip is behind its re=
mote\n"
+#~ "counterpart. If you did not intend to push that branch, you may wa=
nt to\n"
+#~ "specify branches to push or set the 'push.default' configuration "
+#~ "variable\n"
+#~ "to 'simple', 'current' or 'upstream' to push only the current bran=
ch."
+#~ msgstr ""
+#~ "Vi=E1=BB=87c c=E1=BA=ADp nh=E1=BA=ADt b=E1=BB=8B t=E1=BB=AB ch=E1=BB=
=91i b=E1=BB=9Fi v=C3=AC =C4=91=E1=BA=A7u m=C3=BAt c=E1=BB=A7a nh=C3=A1=
nh =C4=91=C6=B0=E1=BB=A3c push n=E1=BA=B1m =C4=91=E1=BA=B1ng sau "
+#~ "b=E1=BB=99\n"
+#~ "ph=E1=BA=ADn t=C6=B0=C6=A1ng =E1=BB=A9ng c=E1=BB=A7a m=C3=A1y ch=E1=
=BB=A7. N=E1=BA=BFu b=E1=BA=A1n kh=C3=B4ng c=C3=B3 =C3=BD =C4=91=E1=BB=8B=
nh push nh=C3=A1nh =C4=91=C3=B3, b=E1=BA=A1n c=C3=B3 "
+#~ "l=E1=BA=BD mu=E1=BB=91n\n"
+#~ "ch=E1=BB=89 =C4=91=E1=BB=8Bnh c=C3=A1c nh=C3=A1nh =C4=91=E1=BB=83 =
push ho=E1=BA=B7t l=C3=A0 =C4=91=E1=BA=B7t n=E1=BB=99i dung cho bi=E1=BA=
=BFn c=E1=BA=A5u h=C3=ACnh =E2=80=9Cpush."
+#~ "default=E2=80=9D\n"
+#~ "th=C3=A0nh =E2=80=9Csimple=E2=80=9D, =E2=80=9Ccurrent=E2=80=9D ho=E1=
=BA=B7c =E2=80=9Cupstream=E2=80=9D =C4=91=E1=BB=83 ch=E1=BB=89 push nh=C3=
=A1nh hi=E1=BB=87n h=C3=A0nh m=C3=A0 "
+#~ "th=C3=B4i."
+
 #~ msgid "done\n"
 #~ msgstr "xong\n"
=20
--=20
1.8.5.1.19.gdaad3aa.dirty
