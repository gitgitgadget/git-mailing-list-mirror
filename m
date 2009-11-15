From: Laszlo Papp <djszapi2@gmail.com>
Subject: [PATCH 2/2] Add gitk-git Hungarian translation
Date: Sun, 15 Nov 2009 12:23:24 +0100
Message-ID: <1258284204-17247-1-git-send-email-djszapi@archlinux.us>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: paulus@samba.org, Laszlo Papp <djszapi@archlinux.us>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 15 12:23:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9dCa-0005W3-Qc
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 12:23:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029AbZKOLWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 06:22:49 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751993AbZKOLWs
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 06:22:48 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:60337 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912AbZKOLWq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 06:22:46 -0500
Received: by bwz27 with SMTP id 27so4769448bwz.21
        for <git@vger.kernel.org>; Sun, 15 Nov 2009 03:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=zOQWpeL4gyIVYSeRiOfBSS2MPEgrFDa3biRnJzOcc28=;
        b=DjoMTrgGoUot+8h3569ZNGbWU8qvUnAosDVphovIPE2i7erlthhMllDAD6oa4bJoCf
         4qF3UbC7e7iC8GRrdCsJ5kU3BarieA+5Y8sk37qJ7+SBwINzM+0ys1wrVVwFpSkJDQW6
         5agFud0l1bijiHbpvoC6sHQPwm0ACW3lY1H5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=DR2Kr+xcWGC0FjEjhQYtT9B9bni/pjrM1aKBTlBRydX6gUBVkmYBtxi/Mn6T9u6bGt
         SaEIYE4B0w/og4j1L3xi4t4YUa352TtJvcAXXIbQ0E9dI8WPracRt/k8OIzD26mc874A
         eIBOTGvd8OJes0Ysl2pDBzbyNp1so+BOgDUmQ=
Received: by 10.204.49.79 with SMTP id u15mr2416468bkf.117.1258284169817;
        Sun, 15 Nov 2009 03:22:49 -0800 (PST)
Received: from localhost (94-21-75-91.pool.digikabel.hu [94.21.75.91])
        by mx.google.com with ESMTPS id 21sm5695162fkx.57.2009.11.15.03.22.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Nov 2009 03:22:49 -0800 (PST)
X-Mailer: git-send-email 1.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132932>

Signed-off-by: Laszlo Papp <djszapi@archlinux.us>
---
 gitk-git/po/hu.po | 1151 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 1151 insertions(+), 0 deletions(-)
 create mode 100755 gitk-git/po/hu.po

diff --git a/gitk-git/po/hu.po b/gitk-git/po/hu.po
new file mode 100755
index 0000000..d281e3c
--- /dev/null
+++ b/gitk-git/po/hu.po
@@ -0,0 +1,1151 @@
+# Translation of gitk to Hungarian.
+# Copyright (C) 2007 Paul Mackerras.
+# This file is distributed under the same license as the gitk package.
+#
+# Laszlo Papp <laszlo.papp@arhungary.hu>, 2009.
+#
+msgid ""
+msgstr ""
+"Project-Id-Version: git-gui\n"
+"Report-Msgid-Bugs-To: \n"
+"POT-Creation-Date: 2009-05-12 21:55+0200\n"
+"PO-Revision-Date: 2009-05-12 22:18+0200\n"
+"Last-Translator: Laszlo Papp <djszapi@archlinux.us>\n"
+"Language-Team: Hungarian\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+
+#: gitk:113
+msgid "Couldn't get list of unmerged files:"
+msgstr "Nem siker=C3=BClt let=C3=B6lteni az unmerged f=C3=A1jl list=C3=
=A1t:"
+
+#: gitk:268
+msgid "Error parsing revisions:"
+msgstr "Hiba t=C3=B6rt=C3=A9nt =C3=A9rtelmez=C3=A9s k=C3=B6zben:"
+
+#: gitk:323
+msgid "Error executing --argscmd command:"
+msgstr "Hiba t=C3=B6rt=C3=A9nt a v=C3=A9grehajt=C3=A1skor --argscmd pa=
rancs:"
+
+#: gitk:336
+msgid "No files selected: --merge specified but no files are unmerged.=
"
+msgstr "Nincsen f=C3=A1jl kiv=C3=A1lasztva: --merge megadve, de egyetl=
en f=C3=A1jl sem unmerged."
+
+#: gitk:339
+msgid ""
+"No files selected: --merge specified but no unmerged files are within=
 file "
+"limit."
+msgstr ""
+"Nincsen f=C3=A1jl kiv=C3=A1lasztva: --merge megadva, de nincsenek unm=
erged f=C3=A1jlok a f=C3=A1jlon
+bel=C3=BCl "
+"limit."
+
+#: gitk:361 gitk:508
+msgid "Error executing git log:"
+msgstr "Hiba t=C3=B6rt=C3=A9nt a git log v=C3=A9grehajt=C3=A1sa k=C3=B6=
zben:"
+
+#: gitk:379 gitk:524
+msgid "Reading"
+msgstr "Olvas=C3=A1s"
+
+#: gitk:439 gitk:4061
+msgid "Reading commits..."
+msgstr "Commitok olvas=C3=A1sa ..."
+
+#: gitk:442 gitk:1560 gitk:4064
+msgid "No commits selected"
+msgstr "Nincsen commit kiv=C3=A1lasztva"
+
+#: gitk:1436
+msgid "Can't parse git log output:"
+msgstr "Nem lehet =C3=A9rtelmezni a git log kimenet=C3=A9t:"
+
+#: gitk:1656
+msgid "No commit information available"
+msgstr "Nincsen el=C3=A9rhet=C5=91 commit inform=C3=A1ci=C3=B3"
+
+#: gitk:1791 gitk:1815 gitk:3854 gitk:8714 gitk:10250 gitk:10422
+msgid "OK"
+msgstr "OK"
+
+#: gitk:1817 gitk:3856 gitk:8311 gitk:8385 gitk:8495 gitk:8544 gitk:87=
16
+#: gitk:10251 gitk:10423
+msgid "Cancel"
+msgstr "Visszavon=C3=A1s"
+
+#: gitk:1917
+msgid "Update"
+msgstr "Frissit=C3=A9s"
+
+#: gitk:1918
+msgid "Reload"
+msgstr "=C3=9Ajrat=C3=B6lt=C3=A9s"
+
+#: gitk:1919
+msgid "Reread references"
+msgstr "Referenci=C3=A1k =C3=BAjraolvas=C3=A1sa"
+
+#: gitk:1920
+msgid "List references"
+msgstr "Referenci=C3=A1k list=C3=A1z=C3=A1sa"
+
+#: gitk:1922
+msgid "Start git gui"
+msgstr "Git gui ind=C3=ADt=C3=A1sa"
+
+#: gitk:1924
+msgid "Quit"
+msgstr "Kil=C3=A9p=C3=A9s"
+
+#: gitk:1916
+msgid "File"
+msgstr "F=C3=A1jl"
+
+#: gitk:1928
+msgid "Preferences"
+msgstr "Be=C3=A1ll=C3=ADt=C3=A1sok"
+
+#: gitk:1927
+msgid "Edit"
+msgstr "Szerkeszt=C3=A9s"
+
+#: gitk:1932
+msgid "New view..."
+msgstr "=C3=9Aj n=C3=A9zet ..."
+
+#: gitk:1933
+msgid "Edit view..."
+msgstr "N=C3=A9zet szerkeszt=C3=A9se ..."
+
+#: gitk:1934
+msgid "Delete view"
+msgstr "N=C3=A9zet t=C3=B6rl=C3=A9se"
+
+#: gitk:1936
+msgid "All files"
+msgstr "Minden f=C3=A1jl"
+
+#: gitk:1931 gitk:3666
+msgid "View"
+msgstr "N=C3=A9zet"
+
+#: gitk:1941 gitk:1951 gitk:2650
+msgid "About gitk"
+msgstr "Gitk n=C3=A9vjegy"
+
+#: gitk:1942 gitk:1956
+msgid "Key bindings"
+msgstr "Billenty=C5=B1kombin=C3=A1ci=C3=B3"
+
+#: gitk:1940 gitk:1955
+msgid "Help"
+msgstr "Seg=C3=ADts=C3=A9g"
+
+#: gitk:2016
+msgid "SHA1 ID: "
+msgstr "SHA1 ID: "
+
+#: gitk:2047
+msgid "Row"
+msgstr "Sor"
+
+#: gitk:2078
+msgid "Find"
+msgstr "Keres=C3=A9s"
+
+#: gitk:2079
+msgid "next"
+msgstr "k=C3=B6vetkez=C5=91"
+
+#: gitk:2080
+msgid "prev"
+msgstr "el=C5=91z=C5=91"
+
+#: gitk:2081
+msgid "commit"
+msgstr "commit"
+
+#: gitk:2084 gitk:2086 gitk:4222 gitk:4245 gitk:4269 gitk:6210 gitk:62=
82
+#: gitk:6366
+msgid "containing:"
+msgstr "tartalmaz=C3=A1s:"
+
+#: gitk:2087 gitk:3158 gitk:3163 gitk:4297
+msgid "touching paths:"
+msgstr "=C3=A9rintend=C5=91 =C3=BAtvonalak:"
+
+#: gitk:2088 gitk:4302
+msgid "adding/removing string:"
+msgstr "string hozz=C3=A1ad=C3=A1sa/t=C3=B6rl=C3=A9se:"
+
+#: gitk:2097 gitk:2099
+msgid "Exact"
+msgstr "Pontos"
+
+#: gitk:2099 gitk:4377 gitk:6178
+msgid "IgnCase"
+msgstr "Kis/nagy bet=C5=B1 nem sz=C3=A1m=C3=ADt"
+
+#: gitk:2099 gitk:4271 gitk:4375 gitk:6174
+msgid "Regexp"
+msgstr "Regexp"
+
+#: gitk:2101 gitk:2102 gitk:4396 gitk:4426 gitk:4433 gitk:6302 gitk:63=
70
+msgid "All fields"
+msgstr "Minden mez=C5=91"
+
+#: gitk:2102 gitk:4394 gitk:4426 gitk:6241
+msgid "Headline"
+msgstr "F=C5=91c=C3=ADm"
+
+#: gitk:2103 gitk:4394 gitk:6241 gitk:6370 gitk:6804
+msgid "Comments"
+msgstr "Megjegyz=C3=A9sek"
+
+#: gitk:2103 gitk:4394 gitk:4398 gitk:4433 gitk:6241 gitk:6739 gitk:79=
91
+#: gitk:8006
+msgid "Author"
+msgstr "Szerz=C5=91"
+
+#: gitk:2103 gitk:4394 gitk:6241 gitk:6741
+msgid "Committer"
+msgstr "Commitol=C3=B3"
+
+#: gitk:2132
+msgid "Search"
+msgstr "Keres=C3=A9s"
+
+#: gitk:2139
+msgid "Diff"
+msgstr "Diff"
+
+#: gitk:2141
+msgid "Old version"
+msgstr "R=C3=A9gi verzi=C3=B3"
+
+#: gitk:2143
+msgid "New version"
+msgstr "=C3=9Aj verzi=C3=B3"
+
+#: gitk:2145
+msgid "Lines of context"
+msgstr "Tartalmi sorok"
+
+#: gitk:2155
+msgid "Ignore space change"
+msgstr "Space v=C3=A1lt=C3=A1s mell=C5=91z=C3=A9se"
+
+#: gitk:2213
+msgid "Patch"
+msgstr "Patch"
+
+#: gitk:2215
+msgid "Tree"
+msgstr "Tree"
+
+#: gitk:2359 gitk:2376
+msgid "Diff this -> selected"
+msgstr "Diff ezeket -> kiv=C3=A1lasztott"
+
+#: gitk:2360 gitk:2377
+msgid "Diff selected -> this"
+msgstr "Diff kiv=C3=A1lasztottakat -> ezt"
+
+#: gitk:2361 gitk:2378
+msgid "Make patch"
+msgstr "Patch k=C3=A9sz=C3=ADt=C3=A9se"
+
+#: gitk:2362 gitk:8369
+msgid "Create tag"
+msgstr "Tag k=C3=A9sz=C3=ADt=C3=A9se"
+
+#: gitk:2363 gitk:8475
+msgid "Write commit to file"
+msgstr "Commit f=C3=A1ljba =C3=ADr=C3=A1sa"
+
+#: gitk:2364 gitk:8532
+msgid "Create new branch"
+msgstr "=C3=9Aj branch k=C3=A9sz=C3=ADt=C3=A9se"
+
+#: gitk:2365
+msgid "Cherry-pick this commit"
+msgstr "Cherry-pick erre a commitra"
+
+#: gitk:2366
+msgid "Reset HEAD branch to here"
+msgstr "HEAD branch =C3=BAjraind=C3=ADt=C3=A1sa ide"
+
+#: gitk:2367
+msgid "Mark this commit"
+msgstr "Ezen commit megjel=C3=B6l=C3=A9se"
+
+#: gitk:2368
+msgid "Return to mark"
+msgstr "Visszat=C3=A9r=C3=A9s a megjel=C3=B6l=C3=A9shez"
+
+#: gitk:2369
+msgid "Find descendant of this and mark"
+msgstr "Tal=C3=A1ld meg ezen ut=C3=B3dokat =C3=A9s jel=C3=B6ld meg"
+
+#: gitk:2370
+msgid "Compare with marked commit"
+msgstr "=C3=96sszehasonl=C3=ADt=C3=A1s a megjel=C3=B6lt commit-tal"
+
+#: gitk:2384
+msgid "Check out this branch"
+msgstr "Check out ezt a branchot"
+
+#: gitk:2385
+msgid "Remove this branch"
+msgstr "T=C3=B6r=C3=B6ld ezt a branch-ot"
+
+#: gitk:2392
+msgid "Highlight this too"
+msgstr "Emeld ki ezt is"
+
+#: gitk:2393
+msgid "Highlight this only"
+msgstr "Csak ezt emeld ki"
+
+#: gitk:2394
+msgid "External diff"
+msgstr "K=C3=BCls=C5=91 diff"
+
+#: gitk:2395
+msgid "Blame parent commit"
+msgstr "Blame sz=C3=BCl=C5=91 kommitra"
+
+#: gitk:2402
+msgid "Show origin of this line"
+msgstr "Mutasd meg ennek a sornak az eredet=C3=A9t"
+
+#: gitk:2403
+msgid "Run git gui blame on this line"
+msgstr "Futtasd a git gui blame-t ezen a soron"
+
+#: gitk:2652
+msgid ""
+"\n"
+"Gitk - a commit viewer for git\n"
+"\n"
+"Copyright =C2=A9 2005-2008 Paul Mackerras\n"
+"\n"
+"Use and redistribute under the terms of the GNU General Public Licens=
e"
+msgstr ""
+"\n"
+"Gitk - commit n=C3=A9zeget=C5=91 a githez\n"
+"\n"
+"Szerz=C5=91i jog =C2=A9 2005-2008 Paul Mackerras\n"
+"\n"
+"Haszn=C3=A1ld =C3=A9s terjeszd a GNU General Public License felt=C3=A9=
telei mellett "
+"Licensz"
+
+#: gitk:2660 gitk:2722 gitk:8897
+msgid "Close"
+msgstr "Bez=C3=A1r=C3=A1s"
+
+#: gitk:2679
+msgid "Gitk key bindings"
+msgstr "Gitk-billenty=C5=B1 hozz=C3=A1rendel=C3=A9s"
+
+#: gitk:2682
+msgid "Gitk key bindings:"
+msgstr "Gitk-billenty=C5=B1 hozza=C3=A1rendel=C3=A9s:"
+
+#: gitk:2684
+#, tcl-format
+msgid "<%s-Q>\t\tQuit"
+msgstr "<%s-Q>\t\tKil=C3=A9p=C3=A9s"
+
+#: gitk:2685
+msgid "<Home>\t\tMove to first commit"
+msgstr "<Pos1>\t\tEls=C5=91 commithoz"
+
+#: gitk:2686
+msgid "<End>\t\tMove to last commit"
+msgstr "<Ende>\t\tUtols=C3=B3 commithoz"
+
+#: gitk:2687
+msgid "<Up>, p, i\tMove up one commit"
+msgstr "<Hoch>, p, i\tEgy committal feljebb"
+
+#: gitk:2688
+msgid "<Down>, n, k\tMove down one commit"
+msgstr "<Runter>, n, k\tEgy committal lejjebb"
+
+#: gitk:2689
+msgid "<Left>, z, j\tGo back in history list"
+msgstr "<Links>, z, j\tVissza a history list=C3=A1ba"
+
+#: gitk:2690
+msgid "<Right>, x, l\tGo forward in history list"
+msgstr "<Rechts>, x, l\tEl=C5=91re a history list=C3=A1ba"
+
+#: gitk:2691
+msgid "<PageUp>\tMove up one page in commit list"
+msgstr "<BildHoch>\tEgy lappal feljebb a commit list=C3=A1ba"
+
+#: gitk:2692
+msgid "<PageDown>\tMove down one page in commit list"
+msgstr "<BildRunter>\tEgy lappal lejjebb a commit list=C3=A1ba"
+
+#: gitk:2693
+#, tcl-format
+msgid "<%s-Home>\tScroll to top of commit list"
+msgstr "<%s-Pos1>\tG=C3=B6rget=C3=A9s a commit lista tetej=C3=A9hez"
+
+#: gitk:2694
+#, tcl-format
+msgid "<%s-End>\tScroll to bottom of commit list"
+msgstr "<%s-Ende>\tG=C3=B6rget=C3=A9s a commit lista alj=C3=A1hoz"
+
+#: gitk:2695
+#, tcl-format
+msgid "<%s-Up>\tScroll commit list up one line"
+msgstr "<%s-Hoch>\tEgy sorral feljebb g=C3=B6rget=C3=A9s a commit list=
=C3=A1ban"
+
+#: gitk:2696
+#, tcl-format
+msgid "<%s-Down>\tScroll commit list down one line"
+msgstr "<%s-Runter>\tEgy sorral lejjebb g=C3=B6rget=C3=A9s a commit li=
st=C3=A1ban"
+
+#: gitk:2697
+#, tcl-format
+msgid "<%s-PageUp>\tScroll commit list up one page"
+msgstr "<%s-BildHoch>\tEgy lappal feljebb g=C3=B6rget=C3=A9s a commit =
list=C3=A1ban"
+
+#: gitk:2698
+#, tcl-format
+msgid "<%s-PageDown>\tScroll commit list down one page"
+msgstr "<%s-BildRunter>\tEgy sorral lejjebb g=C3=B6rget=C3=A9s a commi=
t list=C3=A1ban"
+
+#: gitk:2699
+msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
+msgstr "<Umschalt-Hoch>\tKeres=C3=A9s visszafele (felfele, utols=C3=B3=
 commitok)"
+
+#: gitk:2700
+msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
+msgstr "<Umschalt-Runter>\tKeres=C3=A9s el=C5=91re (lefel=C3=A9; kor=C3=
=A1bbi commitok)"
+
+#: gitk:2701
+msgid "<Delete>, b\tScroll diff view up one page"
+msgstr "<Entf>, b\t\tEgy lappal feljebb g=C3=B6rget=C3=A9s a diff n=C3=
=A9zetben"
+
+#: gitk:2702
+msgid "<Backspace>\tScroll diff view up one page"
+msgstr "<L=C3=B6schtaste>\tEgy lappal feljebb g=C3=B6rget=C3=A9s a dif=
f n=C3=A9zetben"
+
+#: gitk:2703
+msgid "<Space>\t\tScroll diff view down one page"
+msgstr "<Leertaste>\tEgy lappal lejjebb g=C3=B6rget=C3=A9s a diff n=C3=
=A9zetben"
+
+#: gitk:2704
+msgid "u\t\tScroll diff view up 18 lines"
+msgstr "u\t\t18 sorral felfel=C3=A9 g=C3=B6rget=C3=A9s diff n=C3=A9zet=
ben"
+
+#: gitk:2705
+msgid "d\t\tScroll diff view down 18 lines"
+msgstr "d\t\t18 sorral lejjebb g=C3=B6rget=C3=A9s a diff n=C3=A9zetben=
"
+
+#: gitk:2706
+#, tcl-format
+msgid "<%s-F>\t\tFind"
+msgstr "<%s-F>\t\tKeres=C3=A9s"
+
+#: gitk:2707
+#, tcl-format
+msgid "<%s-G>\t\tMove to next find hit"
+msgstr "<%s-G>\t\tK=C3=B6vetkez=C5=91 tal=C3=A1lathoz"
+
+#: gitk:2708
+msgid "<Return>\tMove to next find hit"
+msgstr "<Eingabetaste>\tK=C3=B6vetkez=C5=91 tal=C3=A1lathoz"
+
+#: gitk:2709
+msgid "/\t\tFocus the search box"
+msgstr "/\t\tL=C3=A9pj a keres=C3=A9si mez=C5=91re"
+
+#: gitk:2710
+msgid "?\t\tMove to previous find hit"
+msgstr "?\t\tEl=C5=91z=C5=91 tal=C3=A1lathoz"
+
+#: gitk:2711
+msgid "f\t\tScroll diff view to next file"
+msgstr "f\t\tK=C3=B6vetkez=C5=91 f=C3=A1jlra g=C3=B6rget=C3=A9s diff n=
=C3=A9zetben"
+
+#: gitk:2712
+#, tcl-format
+msgid "<%s-S>\t\tSearch for next hit in diff view"
+msgstr "<%s-S>\t\tK=C3=B6vetkez=C5=91 tal=C3=A1latra keres=C3=A9s diff=
 n=C3=A9zetben"
+
+#: gitk:2713
+#, tcl-format
+msgid "<%s-R>\t\tSearch for previous hit in diff view"
+msgstr "<%s-R>\t\tEl=C5=91z=C5=91 tal=C3=A1latra keres=C3=A9s diff n=C3=
=A9zetben"
+
+#: gitk:2714
+#, tcl-format
+msgid "<%s-KP+>\tIncrease font size"
+msgstr "<%s-Nummerblock-Plus>\tBet=C5=B1m=C3=A9ret n=C3=B6vel=C3=A9se"
+
+#: gitk:2715
+#, tcl-format
+msgid "<%s-plus>\tIncrease font size"
+msgstr "<%s-Plus>\tBet=C5=B1m=C3=A9ret n=C3=B6vel=C3=A9se"
+
+#: gitk:2716
+#, tcl-format
+msgid "<%s-KP->\tDecrease font size"
+msgstr "<%s-Nummernblock-Minus> Bet=C5=B1m=C3=A9ret cs=C3=B6kkent=C3=A9=
se"
+
+#: gitk:2717
+#, tcl-format
+msgid "<%s-minus>\tDecrease font size"
+msgstr "<%s-Minus>\tBet=C5=B1m=C3=A9ret cs=C3=B6kkent=C3=A9se"
+
+#: gitk:2718
+msgid "<F5>\t\tUpdate"
+msgstr "<F5>\t\tFriss=C3=ADt=C3=A9s"
+
+#: gitk:3173
+#, tcl-format
+msgid "Error getting \"%s\" from %s:"
+msgstr "Hiba t=C3=B6rt=C3=A9nt \"%s\" let=C3=B6lt=C3=A9se k=C3=B6zben =
%s-r=C5=91l:"
+
+#: gitk:3230 gitk:3239
+#, tcl-format
+msgid "Error creating temporary directory %s:"
+msgstr "Hiba t=C3=B6rt=C3=A9nt az ideiglenes k=C3=B6nyvt=C3=A1r l=C3=A9=
trehoz=C3=A1sa k=C3=B6zben %s:"
+
+#: gitk:3251
+msgid "command failed:"
+msgstr "parancs hiba:"
+
+#: gitk:3397
+msgid "No such commit"
+msgstr "Nincs ilyen commit"
+
+#: gitk:3411
+msgid "git gui blame: command failed:"
+msgstr "git gui blame: parancs hiba:"
+
+#: gitk:3442
+#, tcl-format
+msgid "Couldn't read merge head: %s"
+msgstr "Nem siker=C3=BClt a Merge head olvas=C3=A1sa: %s"
+
+#: gitk:3450
+#, tcl-format
+msgid "Error reading index: %s"
+msgstr "Hiba t=C3=B6rt=C3=A9nt az index olvas=C3=A1sa k=C3=B6zben: %s"
+
+#: gitk:3475
+#, tcl-format
+msgid "Couldn't start git blame: %s"
+msgstr "Nem siker=C3=BClt a git blame ind=C3=ADt=C3=A1sa: %s"
+
+#: gitk:3478 gitk:6209
+msgid "Searching"
+msgstr "Keres=C3=A9s"
+
+#: gitk:3510
+#, tcl-format
+msgid "Error running git blame: %s"
+msgstr "Hiba t=C3=B6rt=C3=A9nt a git blame futtat=C3=A1sa k=C3=B6zben:=
 %s"
+
+#: gitk:3538
+#, tcl-format
+msgid "That line comes from commit %s,  which is not in this view"
+msgstr ""
+"A %s commitb=C3=B3l sz=C3=A1rmazik az a sor, amelyik nem tal=C3=A1lha=
t=C3=B3 ebben a n=C3=A9zetben"
+
+#: gitk:3552
+msgid "External diff viewer failed:"
+msgstr "K=C3=BCls=C5=91 diff n=C3=A9zeget=C5=91 hiba:"
+
+#: gitk:3670
+msgid "Gitk view definition"
+msgstr "Gitk n=C3=A9zet meghat=C3=A1roz=C3=A1sa"
+
+#: gitk:3674
+msgid "Remember this view"
+msgstr "Maradj enn=C3=A9l a n=C3=A9zetn=C3=A9l"
+
+#: gitk:3675
+msgid "Commits to include (arguments to git log):"
+msgstr "Bele=C3=A9rtend=C5=91 commitok (Argumentok a git log-hoz):"
+
+#: gitk:3676
+msgid "Use all refs"
+msgstr "Haszn=C3=A1ld az =C3=B6sszes referenci=C3=A1t"
+
+#: gitk:3677
+msgid "Strictly sort by date"
+msgstr "Szigor=C3=BA rendez=C3=A1s d=C3=A1tum alapj=C3=A1n"
+
+#: gitk:3678
+msgid "Mark branch sides"
+msgstr "Jel=C3=B6lje meg az =C3=A1gakat"
+
+#: gitk:3679
+msgid "Since date:"
+msgstr "Ett=C5=91l:"
+
+#: gitk:3680
+msgid "Until date:"
+msgstr "Eddig:"
+
+#: gitk:3681
+msgid "Max count:"
+msgstr "Max. sz=C3=A1m:"
+
+#: gitk:3682
+msgid "Skip:"
+msgstr "Kihagy:"
+
+#: gitk:3683
+msgid "Limit to first parent"
+msgstr "Korl=C3=A1toz=C3=A1s az els=C5=91 sz=C3=BCl=C5=91re"
+
+#: gitk:3684
+msgid "Command to generate more commits to include:"
+msgstr "Parancs t=C3=B6bb tartalmaz=C3=B3 commit gener=C3=A1l=C3=A1s=C3=
=A1ra:"
+
+#: gitk:3780
+msgid "Gitk: edit view"
+msgstr "Gitk: szerkeszt=C3=A9s n=C3=A9zet"
+
+#: gitk:3793
+msgid "Name"
+msgstr "N=C3=A9v"
+
+#: gitk:3841
+msgid "Enter files and directories to include, one per line:"
+msgstr "F=C3=A1jlok =C3=A9s k=C3=B6nyvt=C3=A1rak bejegyz=C3=A9se amike=
t tartalmaz, soronk=C3=A9nt:"
+
+#: gitk:3855
+msgid "Apply (F5)"
+msgstr "Alkalmaz (F5)"
+
+#: gitk:3893
+msgid "Error in commit selection arguments:"
+msgstr "Hiba t=C3=B6rt=C3=A9nt a commit argumentumok kiv=C3=A1laszt=C3=
=A1sa k=C3=B6zben:"
+
+#: gitk:3946 gitk:3998 gitk:4446 gitk:4460 gitk:5721 gitk:11114 gitk:1=
1115
+msgid "None"
+msgstr "Keine"
+
+#: gitk:4394 gitk:6241 gitk:7993 gitk:8008
+msgid "Date"
+msgstr "D=C3=A1tum"
+
+#: gitk:4394 gitk:6241
+msgid "CDate"
+msgstr "D=C3=A1tum"
+
+#: gitk:4543 gitk:4548
+msgid "Descendant"
+msgstr "Lesz=C3=A1rmazott"
+
+#: gitk:4544
+msgid "Not descendant"
+msgstr "Nem lesz=C3=A1rmazott"
+
+#: gitk:4551 gitk:4556
+msgid "Ancestor"
+msgstr "El=C5=91d"
+
+#: gitk:4552
+msgid "Not ancestor"
+msgstr "Nem el=C5=91d"
+
+#: gitk:4842
+msgid "Local changes checked in to index but not committed"
+msgstr "Lok=C3=A1lis v=C3=A1ltoztat=C3=A1sok, melyek be vannak t=C3=A9=
ve az indexbe, de m=C3=A9g
+nincsenek commitolva"
+
+#: gitk:4878
+msgid "Local uncommitted changes, not checked in to index"
+msgstr "Lok=C3=A1lis nem commitolt v=C3=A1ltoz=C3=A1sok, nincsenek bet=
=C3=A9ve az indexbe"
+
+#: gitk:6559
+msgid "many"
+msgstr "sok"
+
+#: gitk:6743
+msgid "Tags:"
+msgstr "Tagek:"
+
+#: gitk:6760 gitk:6766 gitk:7986
+msgid "Parent"
+msgstr "Eltern"
+
+#: gitk:6771
+msgid "Child"
+msgstr "Gyerek"
+
+#: gitk:6780
+msgid "Branch"
+msgstr "=C3=81g"
+
+#: gitk:6783
+msgid "Follows"
+msgstr "K=C3=B6vetkez=C5=91k"
+
+#: gitk:6786
+msgid "Precedes"
+msgstr "Megel=C5=91z=C5=91k"
+
+#: gitk:7279
+#, tcl-format
+msgid "Error getting diffs: %s"
+msgstr "Hiba t=C3=B6rt=C3=A9nt a diff-ek let=C3=B6lt=C3=A9se k=C3=B6zb=
en: %s"
+
+#: gitk:7819
+msgid "Goto:"
+msgstr "Menj:"
+
+#: gitk:7821
+msgid "SHA1 ID:"
+msgstr "SHA1 ID:"
+
+#: gitk:7840
+#, tcl-format
+msgid "Short SHA1 id %s is ambiguous"
+msgstr "R=C3=B6vid SHA1 id %s f=C3=A9lre=C3=A9rthet=C5=91"
+
+#: gitk:7852
+#, tcl-format
+msgid "SHA1 id %s is not known"
+msgstr "SHA1 id %s nem ismert"
+
+#: gitk:7854
+#, tcl-format
+msgid "Tag/Head %s is not known"
+msgstr "Tag/Head %s nem ismert"
+
+#: gitk:7996
+msgid "Children"
+msgstr "Gyerekek"
+
+#: gitk:8053
+#, tcl-format
+msgid "Reset %s branch to here"
+msgstr "=C3=81ll=C3=ADtsd vissza a %s branch-ot ide"
+
+#: gitk:8055
+msgid "Detached head: can't reset"
+msgstr "Elk=C3=BCl=C3=B6n=C3=ADtett head: nem lehet vissza=C3=A1ll=C3=AD=
tani"
+
+#: gitk:8164 gitk:8170
+msgid "Skipping merge commit "
+msgstr "Merge commit kihagy=C3=A1sa "
+
+#: gitk:8179 gitk:8184
+msgid "Error getting patch ID for "
+msgstr "Hiba t=C3=B6rt=C3=A9nt a patch ID megszerz=C3=A9se k=C3=B6zben=
 a k=C3=B6vetkez=C5=91n=C3=A9l "
+
+#: gitk:8180 gitk:8185
+msgid " - stopping\n"
+msgstr " - abbahagy=C3=A1s\n"
+
+#: gitk:8190 gitk:8193 gitk:8201 gitk:8211 gitk:8220
+msgid "Commit "
+msgstr "Commit "
+
+#: gitk:8194
+msgid ""
+" is the same patch as\n"
+"       "
+msgstr ""
+" Ugyanaz a patch mint\n"
+"       "
+
+#: gitk:8202
+msgid ""
+" differs from\n"
+"       "
+msgstr ""
+" k=C3=BCl=C3=B6nb=C3=B6zik innent=C5=91l\n"
+"       "
+
+#: gitk:8204
+msgid "- stopping\n"
+msgstr "- abbahagy=C3=A1s.\n"
+
+#: gitk:8212 gitk:8221
+#, tcl-format
+msgid " has %s children - stopping\n"
+msgstr " %s gyereke van. abbahagy=C3=A1s\n"
+
+#: gitk:8252
+msgid "Top"
+msgstr "Teteje"
+
+#: gitk:8253
+msgid "From"
+msgstr "Innen"
+
+#: gitk:8258
+msgid "To"
+msgstr "Ide"
+
+#: gitk:8282
+msgid "Generate patch"
+msgstr "Patch gener=C3=A1l=C3=A1sa"
+
+#: gitk:8284
+msgid "From:"
+msgstr "Innen:"
+
+#: gitk:8293
+msgid "To:"
+msgstr "Ide:"
+
+#: gitk:8302
+msgid "Reverse"
+msgstr "Visszafele"
+
+#: gitk:8304 gitk:8489
+msgid "Output file:"
+msgstr "Kimeneti f=C3=A1jl:"
+
+#: gitk:8310
+msgid "Generate"
+msgstr "Gener=C3=A1l=C3=A1s"
+
+#: gitk:8348
+msgid "Error creating patch:"
+msgstr "Hiba t=C3=B6rt=C3=A9t a patch k=C3=A9sz=C3=ADt=C3=A9se k=C3=B6=
zben:"
+
+#: gitk:8371 gitk:8477 gitk:8534
+msgid "ID:"
+msgstr "ID:"
+
+#: gitk:8380
+msgid "Tag name:"
+msgstr "Tag n=C3=A9v:"
+
+#: gitk:8384 gitk:8543
+msgid "Create"
+msgstr "L=C3=A9trehoz=C3=A1s"
+
+#: gitk:8401
+msgid "No tag name specified"
+msgstr "A tag neve nincsen megadva"
+
+#: gitk:8405
+#, tcl-format
+msgid "Tag \"%s\" already exists"
+msgstr "%s Tag m=C3=A1r l=C3=A9tezik"
+
+#: gitk:8411
+msgid "Error creating tag:"
+msgstr "Hiba t=C3=B6rt=C3=A9nt a tag l=C3=A9trehoz=C3=A1sa k=C3=B6zben=
:"
+
+#: gitk:8486
+msgid "Command:"
+msgstr "Parancs:"
+
+#: gitk:8494
+msgid "Write"
+msgstr "=C3=8Dr=C3=A1s"
+
+#: gitk:8512
+msgid "Error writing commit:"
+msgstr "Hiba t=C3=B6rt=C3=A9nt a commit =C3=ADr=C3=A1sa k=C3=B6zben:"
+
+#: gitk:8539
+msgid "Name:"
+msgstr "N=C3=A9v:"
+
+#: gitk:8562
+msgid "Please specify a name for the new branch"
+msgstr "K=C3=A9rem adja meg a nev=C3=A9t az =C3=BAj branchhoz"
+
+#: gitk:8567
+#, tcl-format
+msgid "Branch '%s' already exists. Overwrite?"
+msgstr "%s branch m=C3=A1r l=C3=A9tezik. Fel=C3=BCl=C3=ADrja?"
+
+#: gitk:8633
+#, tcl-format
+msgid "Commit %s is already included in branch %s -- really re-apply i=
t?"
+msgstr ""
+"%s commit m=C3=A1r benne van a %s branchban -- biztos hogy =C3=BAjra =
csin=C3=A1lja ?"
+"eintragen?"
+
+#: gitk:8638
+msgid "Cherry-picking"
+msgstr "Cherry-picking"
+
+#: gitk:8647
+#, tcl-format
+msgid ""
+"Cherry-pick failed because of local changes to file '%s'.\n"
+"Please commit, reset or stash your changes and try again."
+msgstr ""
+"Cherry-pick hiba t=C3=B6rt=C3=A9nt lok=C3=A1lis v=C3=A1ltot=C3=A1sok =
miatt a '%s' f=C3=A1jlban.\n"
+"K=C3=A9rem commitolja, ind=C3=ADtsa =C3=BAjra vagy rejtse el a v=C3=A1=
ltoztat=C3=A1sait =C3=A9s pr=C3=B3b=C3=A1lja =C3=BAjra."
+
+#: gitk:8653
+msgid ""
+"Cherry-pick failed because of merge conflict.\n"
+"Do you wish to run git citool to resolve it?"
+msgstr ""
+"Cherry-pick hiba t=C3=B6rt=C3=A9nt merge konfliktus miatt.\n"
+"K=C3=ADv=C3=A1nja futtatni a git citool-t a probl=C3=A9ma megold=C3=A1=
s=C3=A1hoz?"
+
+#: gitk:8669
+msgid "No changes committed"
+msgstr "Nincsen v=C3=A1ltoz=C3=A1s commitolva"
+
+#: gitk:8695
+msgid "Confirm reset"
+msgstr "=C3=9Ajraind=C3=ADt=C3=A1s meger=C5=91s=C3=ADt=C3=A9se"
+
+#: gitk:8697
+#, tcl-format
+msgid "Reset branch %s to %s?"
+msgstr "=C3=9Ajraind=C3=ADtja a %s branchot %s-ig?"
+
+#: gitk:8701
+msgid "Reset type:"
+msgstr "=C3=9Ajraind=C3=ADt=C3=A1s t=C3=ADpusa:"
+
+#: gitk:8705
+msgid "Soft: Leave working tree and index untouched"
+msgstr "Soft: Hagyd a working tree-t =C3=A9s az indexet =C3=A9rintetle=
n=C3=BCl"
+
+#: gitk:8708
+msgid "Mixed: Leave working tree untouched, reset index"
+msgstr ""
+"Kevert: Hagyd a working tree-t =C3=A9rintetlen=C3=BCl, t=C3=B6r=C3=B6=
ld az indexet"
+
+#: gitk:8711
+msgid ""
+"Hard: Reset working tree and index\n"
+"(discard ALL local changes)"
+msgstr ""
+"Hard: Ind=C3=ADtsd =C3=BAjra a working tree-t =C3=A9s az indexet\n"
+"(MINDEN lok=C3=A1lis v=C3=A1ltoz=C3=A1s eldob=C3=A1sa)"
+
+#: gitk:8728
+msgid "Resetting"
+msgstr "=C3=9Ajraind=C3=ADt=C3=A1s"
+
+#: gitk:8785
+msgid "Checking out"
+msgstr "Kivesz"
+
+#: gitk:8838
+msgid "Cannot delete the currently checked-out branch"
+msgstr ""
+"Nem lehet a jelenleg kivett branch-ot t=C3=B6r=C3=B6lni"
+
+#: gitk:8844
+#, tcl-format
+msgid ""
+"The commits on branch %s aren't on any other branch.\n"
+"Really delete branch %s?"
+msgstr ""
+"A %s branchon tal=C3=A1lhat=C3=B3 commit nem tal=C3=A1lhat=C3=B3 meg =
semelyik m=C3=A1sik branchon.\n"
+"T=C3=A9nyleg t=C3=B6rli a %s branchot?"
+
+#: gitk:8875
+#, tcl-format
+msgid "Tags and heads: %s"
+msgstr "Tagek =C3=A9s headek: %s"
+
+#: gitk:8890
+msgid "Filter"
+msgstr "Sz=C5=B1r=C5=91"
+
+#: gitk:9185
+msgid ""
+"Error reading commit topology information; branch and preceding/follo=
wing "
+"tag information will be incomplete."
+msgstr ""
+"Hiba t=C3=B6rt=C3=A9nt a commit topol=C3=B3giai inform=C3=A1ci=C3=B3 =
olvas=C3=A1sa k=C3=B6zben; branch =C3=A9s"
+"a megel=C5=91z=C5=91/k=C3=B6vetkez=C5=91 inform=C3=A1ci=C3=B3 nem les=
z teljes."
+
+#: gitk:10171
+msgid "Tag"
+msgstr "Tag"
+
+#: gitk:10171
+msgid "Id"
+msgstr "Id"
+
+#: gitk:10219
+msgid "Gitk font chooser"
+msgstr "Gitk-bet=C5=B1 kiv=C3=A1laszt=C3=B3"
+
+#: gitk:10236
+msgid "B"
+msgstr "F"
+
+#: gitk:10239
+msgid "I"
+msgstr "K"
+
+#: gitk:10334
+msgid "Gitk preferences"
+msgstr "Gitk be=C3=A1ll=C3=ADt=C3=A1sok"
+
+#: gitk:10336
+msgid "Commit list display options"
+msgstr "Commit lista kijelz=C3=A9si opci=C3=B3k"
+
+#: gitk:10339
+msgid "Maximum graph width (lines)"
+msgstr "Maxim=C3=A1lis grafikon sz=C3=A9less=C3=A9g (sorok)"
+
+#: gitk:10343
+#, tcl-format
+msgid "Maximum graph width (% of pane)"
+msgstr "Maxim=C3=A1lis grafikon sz=C3=A9less=C3=A9g (t=C3=A1ble %-je)"
+
+#: gitk:10347
+msgid "Show local changes"
+msgstr "Mutasd a lok=C3=A1lis v=C3=A1ltoztat=C3=A1sokat"
+
+#: gitk:10350
+msgid "Auto-select SHA1"
+msgstr "SHA1 Automatikus kiv=C3=A1laszt=C3=A1sa"
+
+#: gitk:10354
+msgid "Diff display options"
+msgstr "Diff kijelz=C5=91 opci=C3=B3k"
+
+#: gitk:10356
+msgid "Tab spacing"
+msgstr "Tab sork=C3=B6z"
+
+#: gitk:10359
+msgid "Display nearby tags"
+msgstr "Szomsz=C3=A9dos tagek kijelz=C3=A9se"
+
+#: gitk:10362
+msgid "Limit diffs to listed paths"
+msgstr "Korl=C3=A1tozott diffek a kilist=C3=A1zott =C3=BAtvonalakhoz"
+
+#: gitk:10365
+msgid "Support per-file encodings"
+msgstr "F=C3=A1jlonk=C3=A9nti k=C3=B3dol=C3=A1s t=C3=A1mgat=C3=A1sa"
+
+#: gitk:10371 gitk:10436
+msgid "External diff tool"
+msgstr "K=C3=BCls=C5=91 diff alkalmaz=C3=A1s"
+
+#: gitk:10373
+msgid "Choose..."
+msgstr "V=C3=A1laszd ..."
+
+#: gitk:10378
+msgid "Colors: press to choose"
+msgstr "Sz=C3=ADnek: nyomja meg a kiv=C3=A1laszt=C3=A1shoz"
+
+#: gitk:10381
+msgid "Background"
+msgstr "H=C3=A1tt=C3=A9r"
+
+#: gitk:10382 gitk:10412
+msgid "background"
+msgstr "h=C3=A1tt=C3=A9r"
+
+#: gitk:10385
+msgid "Foreground"
+msgstr "El=C5=91t=C3=A9r"
+
+#: gitk:10386
+msgid "foreground"
+msgstr "el=C5=91t=C3=A9r"
+
+#: gitk:10389
+msgid "Diff: old lines"
+msgstr "Diff: r=C3=A9gi sorok"
+
+#: gitk:10390
+msgid "diff old lines"
+msgstr "diff r=C3=A9gi sorok"
+
+#: gitk:10394
+msgid "Diff: new lines"
+msgstr "Diff: =C3=BAj sorok"
+
+#: gitk:10395
+msgid "diff new lines"
+msgstr "diff - =C3=BAj sorok"
+
+#: gitk:10399
+msgid "Diff: hunk header"
+msgstr "Diff: nagy header=C3=B6k"
+
+#: gitk:10401
+msgid "diff hunk header"
+msgstr "diff - nagy header=C3=B6k"
+
+#: gitk:10405
+msgid "Marked line bg"
+msgstr "Megjel=C3=B6lt sor h=C3=A1tt=C3=A9r"
+
+#: gitk:10407
+msgid "marked line background"
+msgstr "megjel=C3=B6lt sor h=C3=A1tt=C3=A9r"
+
+#: gitk:10411
+msgid "Select bg"
+msgstr "V=C3=A1lasszon h=C3=A1tteret"
+
+#: gitk:10415
+msgid "Fonts: press to choose"
+msgstr "Bet=C5=B1: nyomja meg a kiv=C3=A1laszt=C3=A1shoz"
+
+#: gitk:10417
+msgid "Main font"
+msgstr "F=C5=91 bet=C5=B1"
+
+#: gitk:10418
+msgid "Diff display font"
+msgstr "Diff kijelz=C5=91 bet=C5=B1"
+
+#: gitk:10419
+msgid "User interface font"
+msgstr "Felhaszn=C3=A1l=C3=B3i interf=C3=A9sz bet=C5=B1"
+
+#: gitk:10446
+#, tcl-format
+msgid "Gitk: choose color for %s"
+msgstr "Gitk: v=C3=A1lasszon sz=C3=ADnt a %s-ra"
+
+#: gitk:10893
+msgid ""
+"Sorry, gitk cannot run with this version of Tcl/Tk.\n"
+" Gitk requires at least Tcl/Tk 8.4."
+msgstr ""
+"Sajn=C3=A1ljuk, de a gitk nem futtathat=C3=B3 ezzel a Tcl/Tk verzi=C3=
=B3val.\n"
+"Gitk futtat=C3=A1s=C3=A1hoz legal=C3=A1bb Tcl/Tk 8.4 sz=C3=BCks=C3=A9=
ges."
+
+#: gitk:11020
+msgid "Cannot find a git repository here."
+msgstr "Nem tal=C3=A1lhat=C3=BC git repository itt."
+
+#: gitk:11024
+#, tcl-format
+msgid "Cannot find the git directory \"%s\"."
+msgstr "Nem tal=C3=A1lhat=C3=B3 a \"%s\" k=C3=B6nyvt=C3=A1r."
+
+#: gitk:11071
+#, tcl-format
+msgid "Ambiguous argument '%s': both revision and filename"
+msgstr "F=C3=A9lre=C3=A9rthet=C5=91 argumentum '%s': rev=C3=ADzi=C3=B3=
 =C3=A9s f=C3=A1jln=C3=A9v is"
+
+#: gitk:11083
+msgid "Bad arguments to gitk:"
+msgstr "Rossz gitk argumentumok:"
+
+#: gitk:11167
+msgid "Command line"
+msgstr "Parancs sor"
--=20
1.6.5
