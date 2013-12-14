From: Tran Ngoc Quan <vnwildman@gmail.com>
Subject: [PATCH] l10n:gitk: Init Vietnamese translation
Date: Sat, 14 Dec 2013 09:49:34 +0700
Message-ID: <1386989374-10347-1-git-send-email-vnwildman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tran Ngoc Quan <vnwildman@gmail.com>
To: git-malling-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 14 03:50:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrfIt-0003C1-EX
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 03:50:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098Ab3LNCuA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Dec 2013 21:50:00 -0500
Received: from mail-pb0-f51.google.com ([209.85.160.51]:41231 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378Ab3LNCuA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Dec 2013 21:50:00 -0500
Received: by mail-pb0-f51.google.com with SMTP id up15so3312147pbc.24
        for <git@vger.kernel.org>; Fri, 13 Dec 2013 18:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=Tjzvbklzw0wAK9vgxSr5Kjq5xgQ1u8saEVgTwnaG/ys=;
        b=kV2IcKziA8dPK6f0rsRaAHLeSUvpHom0lH0mc6Ud1S91VePv/7+Uld87wndM/0lypx
         NJ1QTZjg045fnqqtNSTAO9On4fh+RP8KhoTU51GxB8KajN+VnX7bck1gtHYmLwiE7rCH
         UHz4FTQya3be9kjqQkIDqSWIZSxzYxt/ZNdJbDGYuSU/Yw6TuMMG+JAVM/g8cZ5ojciy
         Np7onQtUh7MODPtar0i/RS7gVd7MLKwFlk3eaa5bCrzmtRKgofQZqvCrA/Ab8F7cB9iM
         X1rfZY5+xViivKd/RmBETqQtXOaOldgSa0p0tI6s23W7dcS2eFNS3MTwdCsuRfae9ivu
         nrBQ==
X-Received: by 10.67.3.68 with SMTP id bu4mr7066690pad.144.1386989399523;
        Fri, 13 Dec 2013 18:49:59 -0800 (PST)
Received: from gmail.com ([113.168.11.119])
        by mx.google.com with ESMTPSA id yg3sm11411878pab.16.2013.12.13.18.49.56
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 13 Dec 2013 18:49:58 -0800 (PST)
X-Mailer: git-send-email 1.8.5.1.19.gdaad3aa.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239278>

Signed-off-by: Tran Ngoc Quan <vnwildman@gmail.com>
---
 gitk-git/po/vi.po | 1350 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 1350 insertions(+)
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
--=20
1.8.5.1.19.gdaad3aa.dirty
