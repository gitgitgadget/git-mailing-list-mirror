Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31F9C2BA19
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 15:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ADD120732
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 15:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbgDMPvM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 11:51:12 -0400
Received: from smtp1.rz.tu-harburg.de ([134.28.205.38]:42752 "EHLO
        smtp1.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730865AbgDMPvM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 11:51:12 -0400
X-Greylist: delayed 332 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Apr 2020 11:51:02 EDT
Received: from mail.tu-harburg.de (mail3.rz.tu-harburg.de [134.28.202.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.tuhh.de", Issuer "DFN-Verein Global Issuing CA" (verified OK))
        by smtp1.rz.tu-harburg.de (Postfix) with ESMTPS id 491Ccn3J76zxST;
        Mon, 13 Apr 2020 17:45:29 +0200 (CEST)
Received: from mailspring.rz.tuhh.de (mailspring.rz.tuhh.de [134.28.202.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alucst@KERBEROS.TU-HARBURG.DE)
        by mail.tu-harburg.de (Postfix) with ESMTPSA id 491Ccn243wzJpRP;
        Mon, 13 Apr 2020 17:45:28 +0200 (CEST)
From:   Christian Stimming <christian@cstimming.de>
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] gitk: re-generate German po file from current source code
Date:   Mon, 13 Apr 2020 17:45:28 +0200
Message-ID: <14971792.xcfJqt4O1Y@ckiste>
In-Reply-To: <20200413073456.GC14888@blackberry>
References: <2527491.s4PuAgMcOf@ckiste> <20200413073456.GC14888@blackberry>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart1817602.O6iiOg1gnh"
Content-Transfer-Encoding: 7Bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart1817602.O6iiOg1gnh
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Dear Paul,

I think my email program has messed up the encoding of the characters in th=
e=20
inline patches I sent to you. I would kindly ask whether you could accept t=
he=20
patches as attached files in this exception case. Attached you find them.=20

In the patch files, the Umlaut characters are two bytes respectively, i.e i=
n=20
utf-8 encoding, just as the files in the repository. I'm pretty sure my ema=
il=20
program had the grandious idea of encoding that into latin-1 which means on=
e=20
byte per Umlaut, effectively breaking the patch file. I hope the attached=20
files are fine, otherwise we would have to come up with other means of gett=
ing=20
my patches from my local git repo to your computer - maybe a github clone o=
r=20
something similar? I just try the attached files first. Thanks!

Best Regards,

Christian

Am Montag, 13. April 2020, 09:34:56 CEST schrieb Paul Mackerras:
> On Mon, Feb 10, 2020 at 10:57:05PM +0100, Christian Stimming wrote:
> > So that subsequent translation updates have an up-to-date
> > starting point.
> >=20
> > Signed-off-by: Christian Stimming <christian@cstimming.de>
>=20
> I tried to apply this and the following patch, but this patch had a
>=20
> lot of rejects.  For example, in this hunk:
> > @@ -21,11 +21,11 @@ msgstr ""
> >=20
> >  msgid "Couldn't get list of unmerged files:"
> >  msgstr "Liste der nicht zusammengef=FChrten Dateien nicht gefunden:"
>=20
> the u with umlaut appears as a single 0xfc byte, but in the file
> po/de.po, it appears as a sequence of two bytes: 0xc3 0xbc, and so
> patch considers that the lines don't match.  I have my locale set to
> en_AU.UTF8.  Any ideas why the context in your patch would be
> different to what I see in the checked-out file?
>=20
> Paul.


--nextPart1817602.O6iiOg1gnh
Content-Disposition: attachment; filename="0002-gitk-update-German-translation.patch"
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; charset="UTF-8"; name="0002-gitk-update-German-translation.patch"

=46rom f7d7c7c8dbf7fc9ced4fae5dd2a494fcc6b6009d Mon Sep 17 00:00:00 2001
=46rom: Christian Stimming <christian@cstimming.de>
Date: Mon, 10 Feb 2020 22:37:33 +0100
Subject: [PATCH 2/2] gitk: update German translation

Adapt to recent wording changes in git-gui, so that both tools use the
common glossary. Notably, switch several terms from uncommon
translations back to English vocabulary.

This most prominently concerns "commit" (noun, verb), "repository",
"branch", and some more. These uncommon translations have been introduced
long ago and never been changed since. However, in German literature
and magazines, gitk and git-gui is regularly noted for its uncommon
choice of translated vocabulary. This somewhat distracts from the actual
benefits of this tool. So it is probably better to abandon the uncommon
translations and rather stick to the common English vocabulary in git
version control.

Signed-off-by: Christian Stimming <christian@cstimming.de>
=2D--
 po/de.po | 312 +++++++++++++++++++++++++------------------------------
 1 file changed, 139 insertions(+), 173 deletions(-)

diff --git a/po/de.po b/po/de.po
index b30dfb0..f87710f 100644
=2D-- a/po/de.po
+++ b/po/de.po
@@ -9,10 +9,10 @@ msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
 "POT-Creation-Date: 2020-01-24 23:48+0100\n"
=2D"PO-Revision-Date: 2015-10-20 14:20+0200\n"
=2D"Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
+"PO-Revision-Date: 2020-02-10 22:48+0100\n"
+"Last-Translator: Christian Stimming <christian@cstimming.de>\n"
 "Language-Team: German\n"
=2D"Language: \n"
+"Language: de_DE\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=3DUTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
@@ -31,7 +31,7 @@ msgstr "W=C3=B6rter kennzeichnen"
=20
 #: gitk:324
 msgid "Error parsing revisions:"
=2Dmsgstr "Fehler beim Laden der Versionen:"
+msgstr "Fehler beim Laden der Commits:"
=20
 #: gitk:380
 msgid "Error executing --argscmd command:"
@@ -61,11 +61,11 @@ msgstr "Lesen"
=20
 #: gitk:496 gitk:4555
 msgid "Reading commits..."
=2Dmsgstr "Versionen werden gelesen ..."
+msgstr "Commits werden gelesen ..."
=20
 #: gitk:499 gitk:1641 gitk:4558
 msgid "No commits selected"
=2Dmsgstr "Keine Versionen ausgew=C3=A4hlt"
+msgstr "Keine Commits ausgew=C3=A4hlt"
=20
 #: gitk:1449 gitk:4075 gitk:12643
 msgid "Command line"
@@ -77,7 +77,7 @@ msgstr "Ausgabe von =C2=BBgit log=C2=AB kann nicht erkann=
t werden:"
=20
 #: gitk:1744
 msgid "No commit information available"
=2Dmsgstr "Keine Versionsinformation verf=C3=BCgbar"
+msgstr "Keine Commit-Information verf=C3=BCgbar"
=20
 #: gitk:1911 gitk:1940 gitk:4345 gitk:9830 gitk:11434 gitk:11721
 msgid "OK"
@@ -98,11 +98,11 @@ msgstr "&Neu laden"
=20
 #: gitk:2093
 msgid "Reread re&ferences"
=2Dmsgstr "&Zweige neu laden"
+msgstr "&Branches neu laden"
=20
 #: gitk:2094
 msgid "&List references"
=2Dmsgstr "Zweige/Markierungen auf&listen"
+msgstr "Branches/Tags auf&listen"
=20
 #: gitk:2096
 msgid "Start git &gui"
@@ -170,7 +170,7 @@ msgstr "Suche"
=20
 #: gitk:2317
 msgid "commit"
=2Dmsgstr "Version nach"
+msgstr "Commit nach"
=20
 #: gitk:2321 gitk:2323 gitk:4717 gitk:4740 gitk:4764 gitk:6785 gitk:6857
 #: gitk:6942
@@ -220,7 +220,7 @@ msgstr "Autor"
=20
 #: gitk:2341 gitk:4901 gitk:6816 gitk:7391
 msgid "Committer"
=2Dmsgstr "Eintragender"
+msgstr "Committer"
=20
 #: gitk:2375
 msgid "Search"
@@ -260,11 +260,11 @@ msgstr "Baum"
=20
 #: gitk:2643 gitk:2664
 msgid "Diff this -> selected"
=2Dmsgstr "Vergleich: diese -> gew=C3=A4hlte"
+msgstr "Vergleich: dieser -> gew=C3=A4hlter"
=20
 #: gitk:2644 gitk:2665
 msgid "Diff selected -> this"
=2Dmsgstr "Vergleich: gew=C3=A4hlte -> diese"
+msgstr "Vergleich: gew=C3=A4hlter -> dieser"
=20
 #: gitk:2645 gitk:2666
 msgid "Make patch"
@@ -272,28 +272,27 @@ msgstr "Patch erstellen"
=20
 #: gitk:2646 gitk:9324
 msgid "Create tag"
=2Dmsgstr "Markierung erstellen"
+msgstr "Tag erstellen"
=20
 #: gitk:2647
=2D#, fuzzy
 msgid "Copy commit reference"
=2Dmsgstr "Keine Versionen ausgew=C3=A4hlt"
+msgstr "Commit-Bezeichnung kopieren"
=20
 #: gitk:2648 gitk:9455
 msgid "Write commit to file"
=2Dmsgstr "Version in Datei schreiben"
+msgstr "Commit in Datei schreiben"
=20
 #: gitk:2649
 msgid "Create new branch"
=2Dmsgstr "Neuen Zweig erstellen"
+msgstr "Neuen Branch erstellen"
=20
 #: gitk:2650
 msgid "Cherry-pick this commit"
=2Dmsgstr "Diese Version pfl=C3=BCcken"
+msgstr "Diesen Commit pfl=C3=BCcken (=C2=BBcherry-pick=C2=AB)"
=20
 #: gitk:2651
 msgid "Reset HEAD branch to here"
=2Dmsgstr "HEAD-Zweig auf diese Version zur=C3=BCcksetzen"
+msgstr "Branch-HEAD auf diesen Commit umsetzen"
=20
 #: gitk:2652
 msgid "Mark this commit"
@@ -305,7 +304,7 @@ msgstr "Zum Lesezeichen"
=20
 #: gitk:2654
 msgid "Find descendant of this and mark"
=2Dmsgstr "Abk=C3=B6mmling von Lesezeichen und dieser Version finden"
+msgstr "Nachfolge-Commit von Lesezeichen und diesem finden"
=20
 #: gitk:2655
 msgid "Compare with marked commit"
@@ -313,32 +312,31 @@ msgstr "Mit Lesezeichen vergleichen"
=20
 #: gitk:2656 gitk:2667
 msgid "Diff this -> marked commit"
=2Dmsgstr "Vergleich: diese -> gew=C3=A4hlte Version"
+msgstr "Vergleich: dieser Commit -> Lesezeichen"
=20
 #: gitk:2657 gitk:2668
 msgid "Diff marked commit -> this"
=2Dmsgstr "Vergleich: gew=C3=A4hlte -> diese Version"
+msgstr "Vergleich: Lesezeichen -> dieser Commit"
=20
 #: gitk:2658
 msgid "Revert this commit"
=2Dmsgstr "Version umkehren"
+msgstr "Commit zur=C3=BCcknehmen (=C2=BBrevert=C2=AB)"
=20
 #: gitk:2674
 msgid "Check out this branch"
=2Dmsgstr "Auf diesen Zweig umstellen"
+msgstr "Branch auschecken"
=20
 #: gitk:2675
=2D#, fuzzy
 msgid "Rename this branch"
=2Dmsgstr "Zweig l=C3=B6schen"
+msgstr "Branch umbenennen"
=20
 #: gitk:2676
 msgid "Remove this branch"
=2Dmsgstr "Zweig l=C3=B6schen"
+msgstr "Branch l=C3=B6schen"
=20
 #: gitk:2677
 msgid "Copy branch name"
=2Dmsgstr "Zweigname kopieren"
+msgstr "Branch-Name kopieren"
=20
 #: gitk:2684
 msgid "Highlight this too"
@@ -369,9 +367,8 @@ msgid "Run git gui blame on this line"
 msgstr "Diese Zeile annotieren (=C2=BBgit gui blame=C2=AB)"
=20
 #: gitk:3040
=2D#, fuzzy
 msgid "About gitk"
=2Dmsgstr "=C3=9Cber &gitk"
+msgstr "=C3=9Cber gitk"
=20
 #: gitk:3042
 msgid ""
@@ -385,10 +382,9 @@ msgstr ""
 "\n"
 "Gitk - eine Visualisierung der Git-Historie\n"
 "\n"
=2D"Copyright \\u00a9 2005-2016 Paul Mackerras\n"
+"Copyright =C2=A9 2005-2016 Paul Mackerras\n"
 "\n"
=2D"Benutzung und Weiterverbreitung gem=C3=A4=C3=9F den Bedingungen der GNU=
 General Public "
=2D"License"
+"Benutzung und Weiterverbreitung gem=C3=A4=C3=9F den Bedingungen der GNU G=
eneral Public License"
=20
 #: gitk:3050 gitk:3117 gitk:10045
 msgid "Close"
@@ -414,32 +410,32 @@ msgstr "<%s-F>\t\tFenster schlie=C3=9Fen"
=20
 #: gitk:3078
 msgid "<Home>\t\tMove to first commit"
=2Dmsgstr "<Pos1>\t\tZur neuesten Version springen"
+msgstr "<Pos1>\t\tZum neuesten Commit springen"
=20
 #: gitk:3079
 msgid "<End>\t\tMove to last commit"
=2Dmsgstr "<Ende>\t\tZur =C3=A4ltesten Version springen"
+msgstr "<Ende>\t\tZum =C3=A4ltesten Commit springen"
=20
 #: gitk:3080
 msgid "<Up>, p, k\tMove up one commit"
=2Dmsgstr "<Hoch>, p, k\tN=C3=A4chste neuere Version"
+msgstr "<Hoch>, p, k\tEinen Commit nach oben"
=20
 #: gitk:3081
 msgid "<Down>, n, j\tMove down one commit"
=2Dmsgstr "<Runter>, n, j\tN=C3=A4chste =C3=A4ltere Version"
+msgstr "<Runter>, n, j\tEinen Commit nach unten"
=20
 #: gitk:3082
 msgid "<Left>, z, h\tGo back in history list"
=2Dmsgstr "<Links>, z, h\tEine Version zur=C3=BCckgehen"
+msgstr "<Links>, z, h\tEinen Commit zur=C3=BCckgehen"
=20
 #: gitk:3083
 msgid "<Right>, x, l\tGo forward in history list"
=2Dmsgstr "<Rechts>, x, l\tEine Version weitergehen"
+msgstr "<Rechts>, x, l\tEinen Commit weitergehen"
=20
 #: gitk:3084
 #, tcl-format
 msgid "<%s-n>\tGo to n-th parent of current commit in history list"
=2Dmsgstr "<%s-n>\tZu n-ter Elternversion in Versionshistorie springen"
+msgstr "<%s-n>\t\tZu n-tem Eltern-Commit in Commit-Historie springen"
=20
 #: gitk:3085
 msgid "<PageUp>\tMove up one page in commit list"
@@ -452,44 +448,44 @@ msgstr "<BildRunter>\tEine Seite nach unten bl=C3=A4t=
tern"
 #: gitk:3087
 #, tcl-format
 msgid "<%s-Home>\tScroll to top of commit list"
=2Dmsgstr "<%s-Pos1>\tZum oberen Ende der Versionsliste bl=C3=A4ttern"
+msgstr "<%s-Pos1>\tZum oberen Ende der Commit-Liste bl=C3=A4ttern"
=20
 #: gitk:3088
 #, tcl-format
 msgid "<%s-End>\tScroll to bottom of commit list"
=2Dmsgstr "<%s-Ende>\tZum unteren Ende der Versionsliste bl=C3=A4ttern"
+msgstr "<%s-Ende>\tZum unteren Ende der Commit-Liste bl=C3=A4ttern"
=20
 #: gitk:3089
 #, tcl-format
 msgid "<%s-Up>\tScroll commit list up one line"
=2Dmsgstr "<%s-Hoch>\tVersionsliste eine Zeile nach oben bl=C3=A4ttern"
+msgstr "<%s-Hoch>\tCommit-Liste eine Zeile nach oben bl=C3=A4ttern"
=20
 #: gitk:3090
 #, tcl-format
 msgid "<%s-Down>\tScroll commit list down one line"
=2Dmsgstr "<%s-Runter>\tVersionsliste eine Zeile nach unten bl=C3=A4ttern"
+msgstr "<%s-Runter>\tCommit-Liste eine Zeile nach unten bl=C3=A4ttern"
=20
 #: gitk:3091
 #, tcl-format
 msgid "<%s-PageUp>\tScroll commit list up one page"
=2Dmsgstr "<%s-BildHoch>\tVersionsliste eine Seite nach oben bl=C3=A4ttern"
+msgstr "<%s-BildHoch>\tCommit-Liste eine Seite nach oben bl=C3=A4ttern"
=20
 #: gitk:3092
 #, tcl-format
 msgid "<%s-PageDown>\tScroll commit list down one page"
=2Dmsgstr "<%s-BildRunter>\tVersionsliste eine Seite nach unten bl=C3=A4tte=
rn"
+msgstr "<%s-BildRunter>\tCommit-Liste eine Seite nach unten bl=C3=A4ttern"
=20
 #: gitk:3093
 msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
=2Dmsgstr "<Umschalt-Hoch>\tR=C3=BCckw=C3=A4rts suchen (nach oben; neuere V=
ersionen)"
+msgstr "<Umschalt-Hoch>\tR=C3=BCckw=C3=A4rts suchen (nach oben; neuere Com=
mits)"
=20
 #: gitk:3094
 msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
=2Dmsgstr "<Umschalt-Runter> Suchen (nach unten; =C3=A4ltere Versionen)"
+msgstr "<Umschalt-Runter> Suchen (nach unten; =C3=A4ltere Commits)"
=20
 #: gitk:3095
 msgid "<Delete>, b\tScroll diff view up one page"
=2Dmsgstr "<Entf>, b\t\tVergleich eine Seite nach oben bl=C3=A4ttern"
+msgstr "<Entf>, b\tVergleich eine Seite nach oben bl=C3=A4ttern"
=20
 #: gitk:3096
 msgid "<Backspace>\tScroll diff view up one page"
@@ -523,7 +519,7 @@ msgstr "<Eingabetaste>\tWeitersuchen"
=20
 #: gitk:3103
 msgid "g\t\tGo to commit"
=2Dmsgstr "g\t\tZu Version springen"
+msgstr "g\t\tZu Commit springen"
=20
 #: gitk:3104
 msgid "/\t\tFocus the search box"
@@ -587,7 +583,7 @@ msgstr "Kommando fehlgeschlagen:"
=20
 #: gitk:3814
 msgid "No such commit"
=2Dmsgstr "Version nicht gefunden"
+msgstr "Commit nicht gefunden"
=20
 #: gitk:3828
 msgid "git gui blame: command failed:"
@@ -620,22 +616,19 @@ msgstr "Fehler beim Ausf=C3=BChren von =C2=BBgit blam=
e=C2=AB: %s"
 #: gitk:3955
 #, tcl-format
 msgid "That line comes from commit %s,  which is not in this view"
=2Dmsgstr ""
=2D"Diese Zeile stammt aus Version %s, die nicht in dieser Ansicht gezeigt =
wird"
+msgstr "Diese Zeile stammt aus Commit %s, der nicht in dieser Ansicht geze=
igt wird"
=20
 #: gitk:3969
 msgid "External diff viewer failed:"
 msgstr "Externes Diff-Programm fehlgeschlagen:"
=20
 #: gitk:4073
=2D#, fuzzy
 msgid "All files"
=2Dmsgstr "&Alle Dateien"
+msgstr "Alle Dateien"
=20
 #: gitk:4097
=2D#, fuzzy
 msgid "View"
=2Dmsgstr "&Ansicht"
+msgstr "Ansicht"
=20
 #: gitk:4100
 msgid "Gitk view definition"
@@ -647,31 +640,31 @@ msgstr "Diese Ansicht speichern"
=20
 #: gitk:4105
 msgid "References (space separated list):"
=2Dmsgstr "Zweige/Markierungen (durch Leerzeichen getrennte Liste):"
+msgstr "Branches/Tags (durch Leerzeichen getrennte Liste):"
=20
 #: gitk:4106
 msgid "Branches & tags:"
=2Dmsgstr "Zweige/Markierungen:"
+msgstr "Branches/Tags:"
=20
 #: gitk:4107
 msgid "All refs"
=2Dmsgstr "Alle Markierungen und Zweige"
+msgstr "Alle Tags und Branches"
=20
 #: gitk:4108
 msgid "All (local) branches"
=2Dmsgstr "Alle (lokalen) Zweige"
+msgstr "Alle (lokalen) Branches"
=20
 #: gitk:4109
 msgid "All tags"
=2Dmsgstr "Alle Markierungen"
+msgstr "Alle Tags"
=20
 #: gitk:4110
 msgid "All remote-tracking branches"
=2Dmsgstr "Alle =C3=9Cbernahmezweige"
+msgstr "Alle Tracking-Branches"
=20
 #: gitk:4111
 msgid "Commit Info (regular expressions):"
=2Dmsgstr "Versionsinformationen (regul=C3=A4re Ausdr=C3=BCcke):"
+msgstr "Commit-Informationen (regul=C3=A4re Ausdr=C3=BCcke):"
=20
 #: gitk:4112
 msgid "Author:"
@@ -679,23 +672,23 @@ msgstr "Autor:"
=20
 #: gitk:4113
 msgid "Committer:"
=2Dmsgstr "Eintragender:"
+msgstr "Committer:"
=20
 #: gitk:4114
 msgid "Commit Message:"
=2Dmsgstr "Versionsbeschreibung:"
+msgstr "Commit-Beschreibung:"
=20
 #: gitk:4115
 msgid "Matches all Commit Info criteria"
=2Dmsgstr "Alle Versionsinformationen-Kriterien erf=C3=BCllen"
+msgstr "Alle Commit-Informationen-Kriterien erf=C3=BCllen"
=20
 #: gitk:4116
 msgid "Matches no Commit Info criteria"
=2Dmsgstr "keine Versionsinformationen-Kriterien erf=C3=BCllen"
+msgstr "Keine Commit-Informationen-Kriterien erf=C3=BCllen"
=20
 #: gitk:4117
 msgid "Changes to Files:"
=2Dmsgstr "Dateien:"
+msgstr "=C3=84nderungen in Dateien:"
=20
 #: gitk:4118
 msgid "Fixed String"
@@ -713,8 +706,7 @@ msgstr "Suchausdruck:"
 msgid ""
 "Commit Dates (\"2 weeks ago\", \"2009-03-17 15:27:38\", \"March 17, 2009 "
 "15:27:38\"):"
=2Dmsgstr ""
=2D"Datum (=C2=BB2 weeks ago=C2=AB, =C2=BB2009-03-17 15:27:38=C2=AB, =C2=BB=
March 17, 2009 15:27:38=C2=AB)"
+msgstr "Commit-Datum (=C2=BB2 weeks ago=C2=AB, =C2=BB2009-03-17 15:27:38=
=C2=AB, =C2=BBMarch 17, 2009 15:27:38=C2=AB)"
=20
 #: gitk:4122
 msgid "Since:"
@@ -726,15 +718,15 @@ msgstr "Bis:"
=20
 #: gitk:4124
 msgid "Limit and/or skip a number of revisions (positive integer):"
=2Dmsgstr "Versionsanzahl begrenzen oder einige =C3=BCberspringen (ganzzahl=
iger Wert):"
+msgstr "Commit-Anzahl begrenzen oder einige =C3=BCberspringen (ganzzahlige=
r Wert):"
=20
 #: gitk:4125
 msgid "Number to show:"
=2Dmsgstr "Anzeigen:"
+msgstr "Anzahl zu zeigen:"
=20
 #: gitk:4126
 msgid "Number to skip:"
=2Dmsgstr "=C3=9Cberspringen:"
+msgstr "Anzahl zu =C3=BCberspringen:"
=20
 #: gitk:4127
 msgid "Miscellaneous options:"
@@ -746,11 +738,11 @@ msgstr "Streng nach Datum sortieren"
=20
 #: gitk:4129
 msgid "Mark branch sides"
=2Dmsgstr "Zweig-Seiten markieren"
+msgstr "Branch-Seiten markieren"
=20
 #: gitk:4130
 msgid "Limit to first parent"
=2Dmsgstr "Auf erste Elternversion beschr=C3=A4nken"
+msgstr "Auf ersten Eltern-Commit beschr=C3=A4nken"
=20
 #: gitk:4131
 msgid "Simple history"
@@ -766,7 +758,7 @@ msgstr "Folgende Dateien und Verzeichnisse anzeigen (ei=
ne pro Zeile):"
=20
 #: gitk:4134
 msgid "Command to generate more commits to include:"
=2Dmsgstr "Versionsliste durch folgendes Kommando erzeugen lassen:"
+msgstr "Commit-Liste durch folgendes Kommando erzeugen lassen:"
=20
 #: gitk:4258
 msgid "Gitk: edit view"
@@ -774,7 +766,7 @@ msgstr "Gitk: Ansicht bearbeiten"
=20
 #: gitk:4266
 msgid "-- criteria for selecting revisions"
=2Dmsgstr "-- Auswahl der angezeigten Versionen"
+msgstr "-- Kriterien f=C3=BCr angezeigte Commits"
=20
 #: gitk:4271
 msgid "View Name"
@@ -786,7 +778,7 @@ msgstr "Anwenden (F5)"
=20
 #: gitk:4384
 msgid "Error in commit selection arguments:"
=2Dmsgstr "Fehler in den ausgew=C3=A4hlten Versionen:"
+msgstr "Fehler in den Argumenten zur Commit-Auswahl:"
=20
 #: gitk:4439 gitk:4492 gitk:4954 gitk:4968 gitk:6238 gitk:12584 gitk:12585
 msgid "None"
@@ -794,32 +786,31 @@ msgstr "Keine"
=20
 #: gitk:5051 gitk:5056
 msgid "Descendant"
=2Dmsgstr "Abk=C3=B6mmling"
+msgstr "Nachfolge-Commit"
=20
 #: gitk:5052
 msgid "Not descendant"
=2Dmsgstr "Kein Abk=C3=B6mmling"
+msgstr "Kein Nachfolge-Commit"
=20
 #: gitk:5059 gitk:5064
 msgid "Ancestor"
=2Dmsgstr "Vorg=C3=A4nger"
+msgstr "Vorg=C3=A4nger-Commit"
=20
 #: gitk:5060
 msgid "Not ancestor"
=2Dmsgstr "Kein Vorg=C3=A4nger"
+msgstr "Kein Vorg=C3=A4nger-Commit"
=20
 #: gitk:5354
 msgid "Local changes checked in to index but not committed"
=2Dmsgstr "Lokale =C3=84nderungen bereitgestellt, aber nicht eingetragen"
+msgstr "Lokale =C3=84nderungen bereitgestellt, aber nicht committet"
=20
 #: gitk:5390
 msgid "Local uncommitted changes, not checked in to index"
 msgstr "Lokale =C3=84nderungen, nicht bereitgestellt"
=20
 #: gitk:7138
=2D#, fuzzy
 msgid "Error starting web browser:"
=2Dmsgstr "Fehler beim Holen von =C2=BB%s=C2=AB von =C2=BB%s=C2=AB:"
+msgstr "Fehler beim Starten des Browsers:"
=20
 #: gitk:7199
 msgid "and many more"
@@ -831,7 +822,7 @@ msgstr "viele"
=20
 #: gitk:7393
 msgid "Tags:"
=2Dmsgstr "Markierungen:"
+msgstr "Tags:"
=20
 #: gitk:7410 gitk:7416 gitk:8895
 msgid "Parent"
@@ -843,7 +834,7 @@ msgstr "Kind"
=20
 #: gitk:7430
 msgid "Branch"
=2Dmsgstr "Zweig"
+msgstr "Branch"
=20
 #: gitk:7433
 msgid "Follows"
@@ -870,7 +861,7 @@ msgstr "Kurzer SHA1-Hashwert =C2=BB%s=C2=AB ist mehrdeu=
tig"
 #: gitk:8748
 #, tcl-format
 msgid "Revision %s is not known"
=2Dmsgstr "Version =C2=BB%s=C2=AB ist unbekannt"
+msgstr "Commit =C2=BB%s=C2=AB ist unbekannt"
=20
 #: gitk:8758
 #, tcl-format
@@ -880,7 +871,7 @@ msgstr "SHA1-Hashwert =C2=BB%s=C2=AB ist unbekannt"
 #: gitk:8760
 #, tcl-format
 msgid "Revision %s is not in the current view"
=2Dmsgstr "Version =C2=BB%s=C2=AB wird in der aktuellen Ansicht nicht angez=
eigt"
+msgstr "Commit =C2=BB%s=C2=AB wird in der aktuellen Ansicht nicht angezeig=
t"
=20
 #: gitk:8902 gitk:8917
 msgid "Date"
@@ -893,15 +884,15 @@ msgstr "Kinder"
 #: gitk:8968
 #, tcl-format
 msgid "Reset %s branch to here"
=2Dmsgstr "Zweig =C2=BB%s=C2=AB hierher zur=C3=BCcksetzen"
+msgstr "Branch =C2=BB%s=C2=AB hierher umsetzen (=C2=BBreset=C2=AB)"
=20
 #: gitk:8970
 msgid "Detached head: can't reset"
=2Dmsgstr "Zweigspitze ist abgetrennt: Zur=C3=BCcksetzen nicht m=C3=B6glich"
+msgstr "Branchspitze ist losgel=C3=B6st: Umsetzen nicht m=C3=B6glich"
=20
 #: gitk:9075 gitk:9081
 msgid "Skipping merge commit "
=2Dmsgstr "=C3=9Cberspringe Zusammenf=C3=BChrungs-Version "
+msgstr "=C3=9Cberspringe Zusammenf=C3=BChrungs-Commit "
=20
 #: gitk:9090 gitk:9095
 msgid "Error getting patch ID for "
@@ -913,7 +904,7 @@ msgstr " - Abbruch.\n"
=20
 #: gitk:9101 gitk:9104 gitk:9112 gitk:9126 gitk:9135
 msgid "Commit "
=2Dmsgstr "Version "
+msgstr "Commit "
=20
 #: gitk:9105
 msgid ""
@@ -935,9 +926,7 @@ msgstr ""
 msgid ""
 "Diff of commits:\n"
 "\n"
=2Dmsgstr ""
=2D"Vergleich der Versionen:\n"
=2D"\n"
+msgstr "Vergleich der Commits:\n\n"
=20
 #: gitk:9127 gitk:9136
 #, tcl-format
@@ -947,12 +936,12 @@ msgstr " hat %s Kinder. Abbruch\n"
 #: gitk:9155
 #, tcl-format
 msgid "Error writing commit to file: %s"
=2Dmsgstr "Fehler beim Schreiben der Version in Datei: %s"
+msgstr "Fehler beim Schreiben des Commits in Datei: %s"
=20
 #: gitk:9161
 #, tcl-format
 msgid "Error diffing commits: %s"
=2Dmsgstr "Fehler beim Vergleichen der Versionen: %s"
+msgstr "Fehler beim Vergleichen der Commits: %s"
=20
 #: gitk:9207
 msgid "Top"
@@ -1000,15 +989,15 @@ msgstr "ID:"
=20
 #: gitk:9335
 msgid "Tag name:"
=2Dmsgstr "Markierungsname:"
+msgstr "Tag-Name:"
=20
 #: gitk:9338
 msgid "Tag message is optional"
=2Dmsgstr "Eine Markierungsbeschreibung ist optional"
+msgstr "Eine Tag-Beschreibung ist optional"
=20
 #: gitk:9340
 msgid "Tag message:"
=2Dmsgstr "Markierungsbeschreibung:"
+msgstr "Tag-Beschreibung:"
=20
 #: gitk:9344 gitk:9515
 msgid "Create"
@@ -1016,16 +1005,16 @@ msgstr "Erstellen"
=20
 #: gitk:9362
 msgid "No tag name specified"
=2Dmsgstr "Kein Markierungsname angegeben"
+msgstr "Kein Tag-Name angegeben"
=20
 #: gitk:9366
 #, tcl-format
 msgid "Tag \"%s\" already exists"
=2Dmsgstr "Markierung =C2=BB%s=C2=AB existiert bereits."
+msgstr "Tag =C2=BB%s=C2=AB existiert bereits."
=20
 #: gitk:9376
 msgid "Error creating tag:"
=2Dmsgstr "Fehler beim Erstellen der Markierung:"
+msgstr "Fehler beim Erstellen des Tags:"
=20
 #: gitk:9466
 msgid "Command:"
@@ -1037,21 +1026,20 @@ msgstr "Schreiben"
=20
 #: gitk:9492
 msgid "Error writing commit:"
=2Dmsgstr "Fehler beim Schreiben der Version:"
+msgstr "Fehler beim Schreiben der Commits:"
=20
 #: gitk:9514
=2D#, fuzzy
 msgid "Create branch"
=2Dmsgstr "Neuen Zweig erstellen"
+msgstr "Branch erstellen"
=20
 #: gitk:9530
=2D#, fuzzy, tcl-format
+#, tcl-format
 msgid "Rename branch %s"
=2Dmsgstr "Zweig =C2=BB%s=C2=AB auf =C2=BB%s=C2=AB zur=C3=BCcksetzen?"
+msgstr "Branch =C2=BB%s=C2=AB umbenennen"
=20
 #: gitk:9531
 msgid "Rename"
=2Dmsgstr ""
+msgstr "Umbenennen"
=20
 #: gitk:9555
 msgid "Name:"
@@ -1059,28 +1047,25 @@ msgstr "Name:"
=20
 #: gitk:9579
 msgid "Please specify a name for the new branch"
=2Dmsgstr "Bitte geben Sie einen Namen f=C3=BCr den neuen Zweig an."
+msgstr "Bitte geben Sie einen Namen f=C3=BCr den neuen Branch an."
=20
 #: gitk:9584
 #, tcl-format
 msgid "Branch '%s' already exists. Overwrite?"
=2Dmsgstr "Zweig =C2=BB%s=C2=AB existiert bereits. Soll er =C3=BCberschrieb=
en werden?"
+msgstr "Branch =C2=BB%s=C2=AB existiert bereits. Soll er =C3=BCberschriebe=
n werden?"
=20
 #: gitk:9628
=2D#, fuzzy
 msgid "Please specify a new name for the branch"
=2Dmsgstr "Bitte geben Sie einen Namen f=C3=BCr den neuen Zweig an."
+msgstr "Bitte geben Sie einen neuen Namen f=C3=BCr den Branch an."
=20
 #: gitk:9691
 #, tcl-format
 msgid "Commit %s is already included in branch %s -- really re-apply it?"
=2Dmsgstr ""
=2D"Version =C2=BB%s=C2=AB ist bereits im Zweig =C2=BB%s=C2=AB enthalten --=
 trotzdem erneut "
=2D"eintragen?"
+msgstr "Commit =C2=BB%s=C2=AB ist bereits im Branch =C2=BB%s=C2=AB enthalt=
en -- trotzdem erneut committen?"
=20
 #: gitk:9696
 msgid "Cherry-picking"
=2Dmsgstr "Version pfl=C3=BCcken"
+msgstr "Cherry-pick"
=20
 #: gitk:9705
 #, tcl-format
@@ -1088,31 +1073,31 @@ msgid ""
 "Cherry-pick failed because of local changes to file '%s'.\n"
 "Please commit, reset or stash your changes and try again."
 msgstr ""
=2D"Pfl=C3=BCcken fehlgeschlagen, da noch lokale =C3=84nderungen in Datei =
=C2=BB%s=C2=AB\n"
=2D"vorliegen. Bitte diese =C3=84nderungen eintragen, zur=C3=BCcksetzen ode=
r\n"
=2D"zwischenspeichern (=C2=BBgit stash=C2=AB) und dann erneut versuchen."
+"Cherry-pick fehlgeschlagen, da noch lokale =C3=84nderungen in Datei =C2=
=BB%s=C2=AB\n"
+"vorliegen. Bitte diese =C3=84nderungen committen, verwerfen oder\n"
+"im Stash speichern (=C2=BBgit stash=C2=AB) und dann erneut versuchen."
=20
 #: gitk:9711
 msgid ""
 "Cherry-pick failed because of merge conflict.\n"
 "Do you wish to run git citool to resolve it?"
 msgstr ""
=2D"Pfl=C3=BCcken fehlgeschlagen, da ein Zusammenf=C3=BChrungs-Konflikt auf=
getreten\n"
=2D"ist. Soll das Zusammenf=C3=BChrungs-Werkzeug (=C2=BBgit citool=C2=AB) a=
ufgerufen\n"
=2D"werden, um diesen Konflikt aufzul=C3=B6sen?"
+"Cherry-pick fehlgeschlagen, da ein Zusammenf=C3=BChrungs-Konflikt\n"
+"aufgetreten ist. Soll das Zusammenf=C3=BChrungs-Werkzeug (=C2=BBgit citoo=
l=C2=AB)\n"
+"aufgerufen werden, um diesen Konflikt aufzul=C3=B6sen?"
=20
 #: gitk:9727 gitk:9785
 msgid "No changes committed"
=2Dmsgstr "Keine =C3=84nderungen eingetragen"
+msgstr "Keine =C3=84nderungen committet"
=20
 #: gitk:9754
 #, tcl-format
 msgid "Commit %s is not included in branch %s -- really revert it?"
=2Dmsgstr "Version =C2=BB%s=C2=AB ist nicht im Zweig =C2=BB%s=C2=AB enthalt=
en -- trotzdem umkehren?"
+msgstr "Commit =C2=BB%s=C2=AB ist nicht im Branch =C2=BB%s=C2=AB enthalten=
 -- trotzdem zur=C3=BCcknehmen?"
=20
 #: gitk:9759
 msgid "Reverting"
=2Dmsgstr "Umkehren"
+msgstr "Zur=C3=BCcknehmen"
=20
 #: gitk:9767
 #, tcl-format
@@ -1120,31 +1105,31 @@ msgid ""
 "Revert failed because of local changes to the following files:%s Please "
 "commit, reset or stash  your changes and try again."
 msgstr ""
=2D"Umkehren fehlgeschlagen, da noch lokale =C3=84nderungen in Datei =C2=BB=
%s=C2=AB\n"
=2D"vorliegen. Bitte diese =C3=84nderungen eintragen, zur=C3=BCcksetzen ode=
r\n"
=2D"zwischenspeichern (=C2=BBgit stash=C2=AB) und dann erneut versuchen."
+"Zur=C3=BCcknehmen fehlgeschlagen, da noch lokale =C3=84nderungen in Datei=
 =C2=BB%s=C2=AB\n"
+"vorliegen. Bitte diese =C3=84nderungen committen, verwerfen oder im Stash=
\n"
+"speichern und dann erneut versuchen."
=20
 #: gitk:9771
 msgid ""
 "Revert failed because of merge conflict.\n"
 " Do you wish to run git citool to resolve it?"
 msgstr ""
=2D"Umkehren fehlgeschlagen, da ein Zusammenf=C3=BChrungs-Konflikt aufgetre=
ten\n"
=2D"ist. Soll das Zusammenf=C3=BChrungs-Werkzeug (=C2=BBgit citool=C2=AB) a=
ufgerufen\n"
=2D"werden, um diesen Konflikt aufzul=C3=B6sen?"
+"Zur=C3=BCcknehmen fehlgeschlagen, da ein Zusammenf=C3=BChrungs-Konflikt\n"
+"aufgetreten ist. Soll das Zusammenf=C3=BChrungs-Werkzeug (=C2=BBgit citoo=
l=C2=AB)\n"
+"aufgerufen werden, um diesen Konflikt aufzul=C3=B6sen?"
=20
 #: gitk:9814
 msgid "Confirm reset"
=2Dmsgstr "Zur=C3=BCcksetzen best=C3=A4tigen"
+msgstr "Umsetzen best=C3=A4tigen"
=20
 #: gitk:9816
 #, tcl-format
 msgid "Reset branch %s to %s?"
=2Dmsgstr "Zweig =C2=BB%s=C2=AB auf =C2=BB%s=C2=AB zur=C3=BCcksetzen?"
+msgstr "Branch =C2=BB%s=C2=AB auf =C2=BB%s=C2=AB umsetzen?"
=20
 #: gitk:9818
 msgid "Reset type:"
=2Dmsgstr "Art des Zur=C3=BCcksetzens:"
+msgstr "Art des Umsetzens:"
=20
 #: gitk:9821
 msgid "Soft: Leave working tree and index untouched"
@@ -1166,12 +1151,12 @@ msgstr ""
=20
 #: gitk:9844
 msgid "Resetting"
=2Dmsgstr "Zur=C3=BCcksetzen"
+msgstr "Umsetzen"
=20
 #: gitk:9917
 #, tcl-format
 msgid "A local branch named %s exists already"
=2Dmsgstr ""
+msgstr "Ein lokaler Branch mit dem Namen =C2=BB%s=C2=AB existiert bereits."
=20
 #: gitk:9925
 msgid "Checking out"
@@ -1179,9 +1164,7 @@ msgstr "Umstellen"
=20
 #: gitk:9984
 msgid "Cannot delete the currently checked-out branch"
=2Dmsgstr ""
=2D"Der Zweig, auf den die Arbeitskopie momentan umgestellt ist, kann nicht=
 "
=2D"gel=C3=B6scht werden."
+msgstr "Der Branch, der in der Arbeitskopie gerade ausgecheckt ist, kann n=
icht gel=C3=B6scht werden."
=20
 #: gitk:9990
 #, tcl-format
@@ -1189,13 +1172,13 @@ msgid ""
 "The commits on branch %s aren't on any other branch.\n"
 "Really delete branch %s?"
 msgstr ""
=2D"Die Versionen auf Zweig =C2=BB%s=C2=AB existieren auf keinem anderen Zw=
eig.\n"
=2D"Zweig =C2=BB%s=C2=AB trotzdem l=C3=B6schen?"
+"Die Commits von Branch =C2=BB%s=C2=AB existieren auf keinem anderen Branc=
h.\n"
+"Branch =C2=BB%s=C2=AB trotzdem l=C3=B6schen?"
=20
 #: gitk:10021
 #, tcl-format
 msgid "Tags and heads: %s"
=2Dmsgstr "Markierungen und Zweige: %s"
+msgstr "Branches und Tags: %s"
=20
 #: gitk:10038
 msgid "Filter"
@@ -1205,13 +1188,11 @@ msgstr "Filtern"
 msgid ""
 "Error reading commit topology information; branch and preceding/following=
 "
 "tag information will be incomplete."
=2Dmsgstr ""
=2D"Fehler beim Lesen der Strukturinformationen; Zweige und Informationen z=
u "
=2D"Vorg=C3=A4nger/Nachfolger werden unvollst=C3=A4ndig sein."
+msgstr "Fehler beim Lesen der Strukturinformationen; Informationen zu Bran=
ch und Vorg=C3=A4nger-/Nachfolge-Tags werden unvollst=C3=A4ndig sein."
=20
 #: gitk:11316
 msgid "Tag"
=2Dmsgstr "Markierung"
+msgstr "Tag"
=20
 #: gitk:11320
 msgid "Id"
@@ -1231,7 +1212,7 @@ msgstr "K"
=20
 #: gitk:11541
 msgid "Commit list display options"
=2Dmsgstr "Anzeige der Versionsliste"
+msgstr "Anzeige der Commit-Liste"
=20
 #: gitk:11544
 msgid "Maximum graph width (lines)"
@@ -1252,7 +1233,7 @@ msgstr "SHA1-Hashwert (L=C3=A4nge) automatisch ausw=
=C3=A4hlen"
=20
 #: gitk:11558
 msgid "Hide remote refs"
=2Dmsgstr "Entfernte Zweige/Markierungen ausblenden"
+msgstr "Externe Branches/Tags ausblenden"
=20
 #: gitk:11562
 msgid "Diff display options"
@@ -1264,11 +1245,11 @@ msgstr "Tabulatorbreite"
=20
 #: gitk:11567
 msgid "Display nearby tags/heads"
=2Dmsgstr "Naheliegende Markierungen/Zweigspitzen anzeigen"
+msgstr "Naheliegende Tags/Branches anzeigen"
=20
 #: gitk:11570
 msgid "Maximum # tags/heads to show"
=2Dmsgstr "Maximale Anzahl anzuzeigender Markierungen/Zweigspitzen"
+msgstr "Maximale Anzahl anzuzeigender Tags/Branches"
=20
 #: gitk:11573
 msgid "Limit diffs to listed paths"
@@ -1288,7 +1269,7 @@ msgstr "W=C3=A4hlen ..."
=20
 #: gitk:11590
 msgid "Web browser"
=2Dmsgstr ""
+msgstr "Browser"
=20
 #: gitk:11595
 msgid "General options"
@@ -1352,11 +1333,11 @@ msgstr "Vergleich - Neue Zeilen"
=20
 #: gitk:11638
 msgid "Diff: hunk header"
=2Dmsgstr "Vergleich: =C3=84nderungstitel"
+msgstr "Vergleich: Titel des Patch-Block"
=20
 #: gitk:11640
 msgid "diff hunk header"
=2Dmsgstr "Vergleich - =C3=84nderungstitel"
+msgstr "Vergleich - Titel des Patch-Block"
=20
 #: gitk:11644
 msgid "Marked line bg"
@@ -1423,23 +1404,8 @@ msgstr "Kein Git-Projektarchiv gefunden."
 #: gitk:12523
 #, tcl-format
 msgid "Ambiguous argument '%s': both revision and filename"
=2Dmsgstr "Mehrdeutige Angabe =C2=BB%s=C2=AB: Sowohl Version als auch Datei=
name existiert."
+msgstr "Mehrdeutige Angabe =C2=BB%s=C2=AB: Sowohl Commit als auch Dateinam=
e existiert."
=20
 #: gitk:12535
 msgid "Bad arguments to gitk:"
 msgstr "Falsche Kommandozeilen-Parameter f=C3=BCr gitk:"
=2D
=2D#~ msgid "mc"
=2D#~ msgstr "mc"
=2D
=2D#~ msgid "next"
=2D#~ msgstr "n=C3=A4chste"
=2D
=2D#~ msgid "prev"
=2D#~ msgstr "vorige"
=2D
=2D#~ msgid "CDate"
=2D#~ msgstr "Eintragedatum"
=2D
=2D#~ msgid "Cannot find the git directory \"%s\"."
=2D#~ msgstr "Git-Verzeichnis =C2=BB%s=C2=AB wurde nicht gefunden."
=2D-=20
2.17.1


--nextPart1817602.O6iiOg1gnh
Content-Disposition: attachment; filename="0001-gitk-re-generate-German-po-file-from-current-source-.patch"
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; charset="UTF-8"; name="0001-gitk-re-generate-German-po-file-from-current-source-.patch"

=46rom 592a367d13033db11faf752e9089bf9aa1f4b3ee Mon Sep 17 00:00:00 2001
=46rom: Christian Stimming <christian@cstimming.de>
Date: Sun, 9 Feb 2020 23:39:04 +0100
Subject: [PATCH 1/2] gitk: re-generate German po file from current source c=
ode

So that subsequent translation updates have an up-to-date
starting point.

Signed-off-by: Christian Stimming <christian@cstimming.de>
=2D--
 po/de.po | 672 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 365 insertions(+), 307 deletions(-)

diff --git a/po/de.po b/po/de.po
index 5db3824..b30dfb0 100644
=2D-- a/po/de.po
+++ b/po/de.po
@@ -8,7 +8,7 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
=2D"POT-Creation-Date: 2015-05-17 14:32+1000\n"
+"POT-Creation-Date: 2020-01-24 23:48+0100\n"
 "PO-Revision-Date: 2015-10-20 14:20+0200\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German\n"
@@ -21,11 +21,11 @@ msgstr ""
 msgid "Couldn't get list of unmerged files:"
 msgstr "Liste der nicht zusammengef=C3=BChrten Dateien nicht gefunden:"
=20
=2D#: gitk:212 gitk:2381
+#: gitk:212 gitk:2407
 msgid "Color words"
 msgstr "W=C3=B6rter einf=C3=A4rben"
=20
=2D#: gitk:217 gitk:2381 gitk:8220 gitk:8253
+#: gitk:217 gitk:2407 gitk:8290 gitk:8323
 msgid "Markup words"
 msgstr "W=C3=B6rter kennzeichnen"
=20
@@ -59,306 +59,321 @@ msgstr "Fehler beim Ausf=C3=BChren von =C2=BBgit log=
=C2=AB:"
 msgid "Reading"
 msgstr "Lesen"
=20
=2D#: gitk:496 gitk:4525
+#: gitk:496 gitk:4555
 msgid "Reading commits..."
 msgstr "Versionen werden gelesen ..."
=20
=2D#: gitk:499 gitk:1637 gitk:4528
+#: gitk:499 gitk:1641 gitk:4558
 msgid "No commits selected"
 msgstr "Keine Versionen ausgew=C3=A4hlt"
=20
=2D#: gitk:1445 gitk:4045 gitk:12432
+#: gitk:1449 gitk:4075 gitk:12643
 msgid "Command line"
 msgstr "Kommandozeile"
=20
=2D#: gitk:1511
+#: gitk:1515
 msgid "Can't parse git log output:"
 msgstr "Ausgabe von =C2=BBgit log=C2=AB kann nicht erkannt werden:"
=20
=2D#: gitk:1740
+#: gitk:1744
 msgid "No commit information available"
 msgstr "Keine Versionsinformation verf=C3=BCgbar"
=20
=2D#: gitk:1903 gitk:1932 gitk:4315 gitk:9669 gitk:11241 gitk:11521
+#: gitk:1911 gitk:1940 gitk:4345 gitk:9830 gitk:11434 gitk:11721
 msgid "OK"
 msgstr "Ok"
=20
=2D#: gitk:1934 gitk:4317 gitk:9196 gitk:9275 gitk:9391 gitk:9440 gitk:9671
=2D#: gitk:11242 gitk:11522
+#: gitk:1942 gitk:4347 gitk:9266 gitk:9345 gitk:9475 gitk:9561 gitk:9832
+#: gitk:11435 gitk:11722
 msgid "Cancel"
 msgstr "Abbrechen"
=20
=2D#: gitk:2069
+#: gitk:2091
 msgid "&Update"
 msgstr "&Aktualisieren"
=20
=2D#: gitk:2070
+#: gitk:2092
 msgid "&Reload"
 msgstr "&Neu laden"
=20
=2D#: gitk:2071
+#: gitk:2093
 msgid "Reread re&ferences"
 msgstr "&Zweige neu laden"
=20
=2D#: gitk:2072
+#: gitk:2094
 msgid "&List references"
 msgstr "Zweige/Markierungen auf&listen"
=20
=2D#: gitk:2074
+#: gitk:2096
 msgid "Start git &gui"
 msgstr "=C2=BBgit &gui=C2=AB starten"
=20
=2D#: gitk:2076
+#: gitk:2098
 msgid "&Quit"
 msgstr "&Beenden"
=20
=2D#: gitk:2068
+#: gitk:2090
 msgid "&File"
 msgstr "&Datei"
=20
=2D#: gitk:2080
+#: gitk:2102
 msgid "&Preferences"
 msgstr "&Einstellungen"
=20
=2D#: gitk:2079
+#: gitk:2101
 msgid "&Edit"
 msgstr "&Bearbeiten"
=20
=2D#: gitk:2084
+#: gitk:2106
 msgid "&New view..."
 msgstr "&Neue Ansicht ..."
=20
=2D#: gitk:2085
+#: gitk:2107
 msgid "&Edit view..."
 msgstr "Ansicht &bearbeiten ..."
=20
=2D#: gitk:2086
+#: gitk:2108
 msgid "&Delete view"
 msgstr "Ansicht &entfernen"
=20
=2D#: gitk:2088 gitk:4043
+#: gitk:2110
 msgid "&All files"
 msgstr "&Alle Dateien"
=20
=2D#: gitk:2083 gitk:4067
+#: gitk:2105
 msgid "&View"
 msgstr "&Ansicht"
=20
=2D#: gitk:2093 gitk:2103 gitk:3012
+#: gitk:2115 gitk:2125
 msgid "&About gitk"
 msgstr "=C3=9Cber &gitk"
=20
=2D#: gitk:2094 gitk:2108
+#: gitk:2116 gitk:2130
 msgid "&Key bindings"
 msgstr "&Tastenk=C3=BCrzel"
=20
=2D#: gitk:2092 gitk:2107
+#: gitk:2114 gitk:2129
 msgid "&Help"
 msgstr "&Hilfe"
=20
=2D#: gitk:2185 gitk:8652
+#: gitk:2207 gitk:8722
 msgid "SHA1 ID:"
 msgstr "SHA1 ID:"
=20
=2D#: gitk:2229
+#: gitk:2251
 msgid "Row"
 msgstr "Zeile"
=20
=2D#: gitk:2267
+#: gitk:2289
 msgid "Find"
 msgstr "Suche"
=20
=2D#: gitk:2295
+#: gitk:2317
 msgid "commit"
 msgstr "Version nach"
=20
=2D#: gitk:2299 gitk:2301 gitk:4687 gitk:4710 gitk:4734 gitk:6755 gitk:6827
=2D#: gitk:6912
+#: gitk:2321 gitk:2323 gitk:4717 gitk:4740 gitk:4764 gitk:6785 gitk:6857
+#: gitk:6942
 msgid "containing:"
 msgstr "Beschreibung:"
=20
=2D#: gitk:2302 gitk:3526 gitk:3531 gitk:4763
+#: gitk:2324 gitk:3556 gitk:3561 gitk:4793
 msgid "touching paths:"
 msgstr "Dateien:"
=20
=2D#: gitk:2303 gitk:4777
+#: gitk:2325 gitk:4807
 msgid "adding/removing string:"
 msgstr "=C3=84nderungen:"
=20
=2D#: gitk:2304 gitk:4779
+#: gitk:2326 gitk:4809
 msgid "changing lines matching:"
 msgstr "Ge=C3=A4nderte Zeilen entsprechen:"
=20
=2D#: gitk:2313 gitk:2315 gitk:4766
+#: gitk:2335 gitk:2337 gitk:4796
 msgid "Exact"
 msgstr "Exakt"
=20
=2D#: gitk:2315 gitk:4854 gitk:6723
+#: gitk:2337 gitk:4884 gitk:6753
 msgid "IgnCase"
 msgstr "Kein Gro=C3=9F/Klein"
=20
=2D#: gitk:2315 gitk:4736 gitk:4852 gitk:6719
+#: gitk:2337 gitk:4766 gitk:4882 gitk:6749
 msgid "Regexp"
 msgstr "Regexp"
=20
=2D#: gitk:2317 gitk:2318 gitk:4874 gitk:4904 gitk:4911 gitk:6848 gitk:6916
+#: gitk:2339 gitk:2340 gitk:4904 gitk:4934 gitk:4941 gitk:6878 gitk:6946
 msgid "All fields"
 msgstr "Alle Felder"
=20
=2D#: gitk:2318 gitk:4871 gitk:4904 gitk:6786
+#: gitk:2340 gitk:4901 gitk:4934 gitk:6816
 msgid "Headline"
 msgstr "=C3=9Cberschrift"
=20
=2D#: gitk:2319 gitk:4871 gitk:6786 gitk:6916 gitk:7389
+#: gitk:2341 gitk:4901 gitk:6816 gitk:6946 gitk:7454
 msgid "Comments"
 msgstr "Beschreibung"
=20
=2D#: gitk:2319 gitk:4871 gitk:4876 gitk:4911 gitk:6786 gitk:7324 gitk:8830
=2D#: gitk:8845
+#: gitk:2341 gitk:4901 gitk:4906 gitk:4941 gitk:6816 gitk:7389 gitk:8900
+#: gitk:8915
 msgid "Author"
 msgstr "Autor"
=20
=2D#: gitk:2319 gitk:4871 gitk:6786 gitk:7326
+#: gitk:2341 gitk:4901 gitk:6816 gitk:7391
 msgid "Committer"
 msgstr "Eintragender"
=20
=2D#: gitk:2350
+#: gitk:2375
 msgid "Search"
 msgstr "Suchen"
=20
=2D#: gitk:2358
+#: gitk:2383
 msgid "Diff"
 msgstr "Vergleich"
=20
=2D#: gitk:2360
+#: gitk:2385
 msgid "Old version"
 msgstr "Alte Version"
=20
=2D#: gitk:2362
+#: gitk:2387
 msgid "New version"
 msgstr "Neue Version"
=20
=2D#: gitk:2364
+#: gitk:2390
 msgid "Lines of context"
 msgstr "Kontextzeilen"
=20
=2D#: gitk:2374
+#: gitk:2400
 msgid "Ignore space change"
 msgstr "Leerzeichen=C3=A4nderungen ignorieren"
=20
=2D#: gitk:2378 gitk:2380 gitk:7959 gitk:8206
+#: gitk:2404 gitk:2406 gitk:8024 gitk:8276
 msgid "Line diff"
 msgstr "Zeilenunterschied"
=20
=2D#: gitk:2445
+#: gitk:2471
 msgid "Patch"
 msgstr "Patch"
=20
=2D#: gitk:2447
+#: gitk:2473
 msgid "Tree"
 msgstr "Baum"
=20
=2D#: gitk:2617 gitk:2637
+#: gitk:2643 gitk:2664
 msgid "Diff this -> selected"
 msgstr "Vergleich: diese -> gew=C3=A4hlte"
=20
=2D#: gitk:2618 gitk:2638
+#: gitk:2644 gitk:2665
 msgid "Diff selected -> this"
 msgstr "Vergleich: gew=C3=A4hlte -> diese"
=20
=2D#: gitk:2619 gitk:2639
+#: gitk:2645 gitk:2666
 msgid "Make patch"
 msgstr "Patch erstellen"
=20
=2D#: gitk:2620 gitk:9254
+#: gitk:2646 gitk:9324
 msgid "Create tag"
 msgstr "Markierung erstellen"
=20
=2D#: gitk:2621 gitk:9371
+#: gitk:2647
+#, fuzzy
+msgid "Copy commit reference"
+msgstr "Keine Versionen ausgew=C3=A4hlt"
+
+#: gitk:2648 gitk:9455
 msgid "Write commit to file"
 msgstr "Version in Datei schreiben"
=20
=2D#: gitk:2622 gitk:9428
+#: gitk:2649
 msgid "Create new branch"
 msgstr "Neuen Zweig erstellen"
=20
=2D#: gitk:2623
+#: gitk:2650
 msgid "Cherry-pick this commit"
 msgstr "Diese Version pfl=C3=BCcken"
=20
=2D#: gitk:2624
+#: gitk:2651
 msgid "Reset HEAD branch to here"
 msgstr "HEAD-Zweig auf diese Version zur=C3=BCcksetzen"
=20
=2D#: gitk:2625
+#: gitk:2652
 msgid "Mark this commit"
 msgstr "Lesezeichen setzen"
=20
=2D#: gitk:2626
+#: gitk:2653
 msgid "Return to mark"
 msgstr "Zum Lesezeichen"
=20
=2D#: gitk:2627
+#: gitk:2654
 msgid "Find descendant of this and mark"
 msgstr "Abk=C3=B6mmling von Lesezeichen und dieser Version finden"
=20
=2D#: gitk:2628
+#: gitk:2655
 msgid "Compare with marked commit"
 msgstr "Mit Lesezeichen vergleichen"
=20
=2D#: gitk:2629 gitk:2640
+#: gitk:2656 gitk:2667
 msgid "Diff this -> marked commit"
 msgstr "Vergleich: diese -> gew=C3=A4hlte Version"
=20
=2D#: gitk:2630 gitk:2641
+#: gitk:2657 gitk:2668
 msgid "Diff marked commit -> this"
 msgstr "Vergleich: gew=C3=A4hlte -> diese Version"
=20
=2D#: gitk:2631
+#: gitk:2658
 msgid "Revert this commit"
 msgstr "Version umkehren"
=20
=2D#: gitk:2647
+#: gitk:2674
 msgid "Check out this branch"
 msgstr "Auf diesen Zweig umstellen"
=20
=2D#: gitk:2648
+#: gitk:2675
+#, fuzzy
+msgid "Rename this branch"
+msgstr "Zweig l=C3=B6schen"
+
+#: gitk:2676
 msgid "Remove this branch"
 msgstr "Zweig l=C3=B6schen"
=20
=2D#: gitk:2649
+#: gitk:2677
 msgid "Copy branch name"
 msgstr "Zweigname kopieren"
=20
=2D#: gitk:2656
+#: gitk:2684
 msgid "Highlight this too"
 msgstr "Diesen auch hervorheben"
=20
=2D#: gitk:2657
+#: gitk:2685
 msgid "Highlight this only"
 msgstr "Nur diesen hervorheben"
=20
=2D#: gitk:2658
+#: gitk:2686
 msgid "External diff"
 msgstr "Externes Diff-Programm"
=20
=2D#: gitk:2659
+#: gitk:2687
 msgid "Blame parent commit"
 msgstr "Annotieren der Elternversion"
=20
=2D#: gitk:2660
+#: gitk:2688
 msgid "Copy path"
 msgstr "Pfad kopieren"
=20
=2D#: gitk:2667
+#: gitk:2695
 msgid "Show origin of this line"
 msgstr "Herkunft dieser Zeile anzeigen"
=20
=2D#: gitk:2668
+#: gitk:2696
 msgid "Run git gui blame on this line"
 msgstr "Diese Zeile annotieren (=C2=BBgit gui blame=C2=AB)"
=20
=2D#: gitk:3014
+#: gitk:3040
+#, fuzzy
+msgid "About gitk"
+msgstr "=C3=9Cber &gitk"
+
+#: gitk:3042
 msgid ""
 "\n"
 "Gitk - a commit viewer for git\n"
@@ -375,517 +390,532 @@ msgstr ""
 "Benutzung und Weiterverbreitung gem=C3=A4=C3=9F den Bedingungen der GNU G=
eneral Public "
 "License"
=20
=2D#: gitk:3022 gitk:3089 gitk:9857
+#: gitk:3050 gitk:3117 gitk:10045
 msgid "Close"
 msgstr "Schlie=C3=9Fen"
=20
=2D#: gitk:3043
+#: gitk:3071
 msgid "Gitk key bindings"
 msgstr "Gitk-Tastaturbelegung"
=20
=2D#: gitk:3046
+#: gitk:3074
 msgid "Gitk key bindings:"
 msgstr "Gitk-Tastaturbelegung:"
=20
=2D#: gitk:3048
+#: gitk:3076
 #, tcl-format
 msgid "<%s-Q>\t\tQuit"
 msgstr "<%s-Q>\t\tBeenden"
=20
=2D#: gitk:3049
+#: gitk:3077
 #, tcl-format
 msgid "<%s-W>\t\tClose window"
 msgstr "<%s-F>\t\tFenster schlie=C3=9Fen"
=20
=2D#: gitk:3050
+#: gitk:3078
 msgid "<Home>\t\tMove to first commit"
 msgstr "<Pos1>\t\tZur neuesten Version springen"
=20
=2D#: gitk:3051
+#: gitk:3079
 msgid "<End>\t\tMove to last commit"
 msgstr "<Ende>\t\tZur =C3=A4ltesten Version springen"
=20
=2D#: gitk:3052
+#: gitk:3080
 msgid "<Up>, p, k\tMove up one commit"
 msgstr "<Hoch>, p, k\tN=C3=A4chste neuere Version"
=20
=2D#: gitk:3053
+#: gitk:3081
 msgid "<Down>, n, j\tMove down one commit"
 msgstr "<Runter>, n, j\tN=C3=A4chste =C3=A4ltere Version"
=20
=2D#: gitk:3054
+#: gitk:3082
 msgid "<Left>, z, h\tGo back in history list"
 msgstr "<Links>, z, h\tEine Version zur=C3=BCckgehen"
=20
=2D#: gitk:3055
+#: gitk:3083
 msgid "<Right>, x, l\tGo forward in history list"
 msgstr "<Rechts>, x, l\tEine Version weitergehen"
=20
=2D#: gitk:3056
+#: gitk:3084
 #, tcl-format
 msgid "<%s-n>\tGo to n-th parent of current commit in history list"
 msgstr "<%s-n>\tZu n-ter Elternversion in Versionshistorie springen"
=20
=2D#: gitk:3057
+#: gitk:3085
 msgid "<PageUp>\tMove up one page in commit list"
 msgstr "<BildHoch>\tEine Seite nach oben bl=C3=A4ttern"
=20
=2D#: gitk:3058
+#: gitk:3086
 msgid "<PageDown>\tMove down one page in commit list"
 msgstr "<BildRunter>\tEine Seite nach unten bl=C3=A4ttern"
=20
=2D#: gitk:3059
+#: gitk:3087
 #, tcl-format
 msgid "<%s-Home>\tScroll to top of commit list"
 msgstr "<%s-Pos1>\tZum oberen Ende der Versionsliste bl=C3=A4ttern"
=20
=2D#: gitk:3060
+#: gitk:3088
 #, tcl-format
 msgid "<%s-End>\tScroll to bottom of commit list"
 msgstr "<%s-Ende>\tZum unteren Ende der Versionsliste bl=C3=A4ttern"
=20
=2D#: gitk:3061
+#: gitk:3089
 #, tcl-format
 msgid "<%s-Up>\tScroll commit list up one line"
 msgstr "<%s-Hoch>\tVersionsliste eine Zeile nach oben bl=C3=A4ttern"
=20
=2D#: gitk:3062
+#: gitk:3090
 #, tcl-format
 msgid "<%s-Down>\tScroll commit list down one line"
 msgstr "<%s-Runter>\tVersionsliste eine Zeile nach unten bl=C3=A4ttern"
=20
=2D#: gitk:3063
+#: gitk:3091
 #, tcl-format
 msgid "<%s-PageUp>\tScroll commit list up one page"
 msgstr "<%s-BildHoch>\tVersionsliste eine Seite nach oben bl=C3=A4ttern"
=20
=2D#: gitk:3064
+#: gitk:3092
 #, tcl-format
 msgid "<%s-PageDown>\tScroll commit list down one page"
 msgstr "<%s-BildRunter>\tVersionsliste eine Seite nach unten bl=C3=A4ttern"
=20
=2D#: gitk:3065
+#: gitk:3093
 msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
 msgstr "<Umschalt-Hoch>\tR=C3=BCckw=C3=A4rts suchen (nach oben; neuere Ver=
sionen)"
=20
=2D#: gitk:3066
+#: gitk:3094
 msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
 msgstr "<Umschalt-Runter> Suchen (nach unten; =C3=A4ltere Versionen)"
=20
=2D#: gitk:3067
+#: gitk:3095
 msgid "<Delete>, b\tScroll diff view up one page"
 msgstr "<Entf>, b\t\tVergleich eine Seite nach oben bl=C3=A4ttern"
=20
=2D#: gitk:3068
+#: gitk:3096
 msgid "<Backspace>\tScroll diff view up one page"
 msgstr "<L=C3=B6schtaste>\tVergleich eine Seite nach oben bl=C3=A4ttern"
=20
=2D#: gitk:3069
+#: gitk:3097
 msgid "<Space>\t\tScroll diff view down one page"
 msgstr "<Leertaste>\tVergleich eine Seite nach unten bl=C3=A4ttern"
=20
=2D#: gitk:3070
+#: gitk:3098
 msgid "u\t\tScroll diff view up 18 lines"
 msgstr "u\t\tVergleich um 18 Zeilen nach oben bl=C3=A4ttern"
=20
=2D#: gitk:3071
+#: gitk:3099
 msgid "d\t\tScroll diff view down 18 lines"
 msgstr "d\t\tVergleich um 18 Zeilen nach unten bl=C3=A4ttern"
=20
=2D#: gitk:3072
+#: gitk:3100
 #, tcl-format
 msgid "<%s-F>\t\tFind"
 msgstr "<%s-F>\t\tSuchen"
=20
=2D#: gitk:3073
+#: gitk:3101
 #, tcl-format
 msgid "<%s-G>\t\tMove to next find hit"
 msgstr "<%s-G>\t\tWeitersuchen"
=20
=2D#: gitk:3074
+#: gitk:3102
 msgid "<Return>\tMove to next find hit"
 msgstr "<Eingabetaste>\tWeitersuchen"
=20
=2D#: gitk:3075
+#: gitk:3103
 msgid "g\t\tGo to commit"
 msgstr "g\t\tZu Version springen"
=20
=2D#: gitk:3076
+#: gitk:3104
 msgid "/\t\tFocus the search box"
 msgstr "/\t\tTastaturfokus ins Suchfeld"
=20
=2D#: gitk:3077
+#: gitk:3105
 msgid "?\t\tMove to previous find hit"
 msgstr "?\t\tR=C3=BCckw=C3=A4rts weitersuchen"
=20
=2D#: gitk:3078
+#: gitk:3106
 msgid "f\t\tScroll diff view to next file"
 msgstr "f\t\tVergleich zur n=C3=A4chsten Datei bl=C3=A4ttern"
=20
=2D#: gitk:3079
+#: gitk:3107
 #, tcl-format
 msgid "<%s-S>\t\tSearch for next hit in diff view"
 msgstr "<%s-S>\t\tWeitersuchen im Vergleich"
=20
=2D#: gitk:3080
+#: gitk:3108
 #, tcl-format
 msgid "<%s-R>\t\tSearch for previous hit in diff view"
 msgstr "<%s-R>\t\tR=C3=BCckw=C3=A4rts weitersuchen im Vergleich"
=20
=2D#: gitk:3081
+#: gitk:3109
 #, tcl-format
 msgid "<%s-KP+>\tIncrease font size"
 msgstr "<%s-Nummerblock-Plus>\tSchrift vergr=C3=B6=C3=9Fern"
=20
=2D#: gitk:3082
+#: gitk:3110
 #, tcl-format
 msgid "<%s-plus>\tIncrease font size"
 msgstr "<%s-Plus>\tSchrift vergr=C3=B6=C3=9Fern"
=20
=2D#: gitk:3083
+#: gitk:3111
 #, tcl-format
 msgid "<%s-KP->\tDecrease font size"
 msgstr "<%s-Nummernblock-Minus> Schrift verkleinern"
=20
=2D#: gitk:3084
+#: gitk:3112
 #, tcl-format
 msgid "<%s-minus>\tDecrease font size"
 msgstr "<%s-Minus>\tSchrift verkleinern"
=20
=2D#: gitk:3085
+#: gitk:3113
 msgid "<F5>\t\tUpdate"
 msgstr "<F5>\t\tAktualisieren"
=20
=2D#: gitk:3550 gitk:3559
+#: gitk:3580 gitk:3589
 #, tcl-format
 msgid "Error creating temporary directory %s:"
 msgstr "Fehler beim Erzeugen des tempor=C3=A4ren Verzeichnisses =C2=BB%s=
=C2=AB:"
=20
=2D#: gitk:3572
+#: gitk:3602
 #, tcl-format
 msgid "Error getting \"%s\" from %s:"
 msgstr "Fehler beim Holen von =C2=BB%s=C2=AB von =C2=BB%s=C2=AB:"
=20
=2D#: gitk:3635
+#: gitk:3665
 msgid "command failed:"
 msgstr "Kommando fehlgeschlagen:"
=20
=2D#: gitk:3784
+#: gitk:3814
 msgid "No such commit"
 msgstr "Version nicht gefunden"
=20
=2D#: gitk:3798
+#: gitk:3828
 msgid "git gui blame: command failed:"
 msgstr "git gui blame: Kommando fehlgeschlagen:"
=20
=2D#: gitk:3829
+#: gitk:3859
 #, tcl-format
 msgid "Couldn't read merge head: %s"
 msgstr "Zusammenf=C3=BChrungs-Spitze konnte nicht gelesen werden: %s"
=20
=2D#: gitk:3837
+#: gitk:3867
 #, tcl-format
 msgid "Error reading index: %s"
 msgstr "Fehler beim Lesen der Bereitstellung (=C2=BBindex=C2=AB): %s"
=20
=2D#: gitk:3862
+#: gitk:3892
 #, tcl-format
 msgid "Couldn't start git blame: %s"
 msgstr "=C2=BBgit blame=C2=AB konnte nicht gestartet werden: %s"
=20
=2D#: gitk:3865 gitk:6754
+#: gitk:3895 gitk:6784
 msgid "Searching"
 msgstr "Suchen"
=20
=2D#: gitk:3897
+#: gitk:3927
 #, tcl-format
 msgid "Error running git blame: %s"
 msgstr "Fehler beim Ausf=C3=BChren von =C2=BBgit blame=C2=AB: %s"
=20
=2D#: gitk:3925
+#: gitk:3955
 #, tcl-format
 msgid "That line comes from commit %s,  which is not in this view"
 msgstr ""
 "Diese Zeile stammt aus Version %s, die nicht in dieser Ansicht gezeigt wi=
rd"
=20
=2D#: gitk:3939
+#: gitk:3969
 msgid "External diff viewer failed:"
 msgstr "Externes Diff-Programm fehlgeschlagen:"
=20
=2D#: gitk:4070
+#: gitk:4073
+#, fuzzy
+msgid "All files"
+msgstr "&Alle Dateien"
+
+#: gitk:4097
+#, fuzzy
+msgid "View"
+msgstr "&Ansicht"
+
+#: gitk:4100
 msgid "Gitk view definition"
 msgstr "Gitk-Ansichten"
=20
=2D#: gitk:4074
+#: gitk:4104
 msgid "Remember this view"
 msgstr "Diese Ansicht speichern"
=20
=2D#: gitk:4075
+#: gitk:4105
 msgid "References (space separated list):"
 msgstr "Zweige/Markierungen (durch Leerzeichen getrennte Liste):"
=20
=2D#: gitk:4076
+#: gitk:4106
 msgid "Branches & tags:"
 msgstr "Zweige/Markierungen:"
=20
=2D#: gitk:4077
+#: gitk:4107
 msgid "All refs"
 msgstr "Alle Markierungen und Zweige"
=20
=2D#: gitk:4078
+#: gitk:4108
 msgid "All (local) branches"
 msgstr "Alle (lokalen) Zweige"
=20
=2D#: gitk:4079
+#: gitk:4109
 msgid "All tags"
 msgstr "Alle Markierungen"
=20
=2D#: gitk:4080
+#: gitk:4110
 msgid "All remote-tracking branches"
 msgstr "Alle =C3=9Cbernahmezweige"
=20
=2D#: gitk:4081
+#: gitk:4111
 msgid "Commit Info (regular expressions):"
 msgstr "Versionsinformationen (regul=C3=A4re Ausdr=C3=BCcke):"
=20
=2D#: gitk:4082
+#: gitk:4112
 msgid "Author:"
 msgstr "Autor:"
=20
=2D#: gitk:4083
+#: gitk:4113
 msgid "Committer:"
 msgstr "Eintragender:"
=20
=2D#: gitk:4084
+#: gitk:4114
 msgid "Commit Message:"
 msgstr "Versionsbeschreibung:"
=20
=2D#: gitk:4085
+#: gitk:4115
 msgid "Matches all Commit Info criteria"
 msgstr "Alle Versionsinformationen-Kriterien erf=C3=BCllen"
=20
=2D#: gitk:4086
+#: gitk:4116
 msgid "Matches no Commit Info criteria"
 msgstr "keine Versionsinformationen-Kriterien erf=C3=BCllen"
=20
=2D#: gitk:4087
+#: gitk:4117
 msgid "Changes to Files:"
 msgstr "Dateien:"
=20
=2D#: gitk:4088
+#: gitk:4118
 msgid "Fixed String"
 msgstr "Zeichenkette"
=20
=2D#: gitk:4089
+#: gitk:4119
 msgid "Regular Expression"
 msgstr "Regul=C3=A4rer Ausdruck"
=20
=2D#: gitk:4090
+#: gitk:4120
 msgid "Search string:"
 msgstr "Suchausdruck:"
=20
=2D#: gitk:4091
+#: gitk:4121
 msgid ""
 "Commit Dates (\"2 weeks ago\", \"2009-03-17 15:27:38\", \"March 17, 2009 "
 "15:27:38\"):"
 msgstr ""
 "Datum (=C2=BB2 weeks ago=C2=AB, =C2=BB2009-03-17 15:27:38=C2=AB, =C2=BBMa=
rch 17, 2009 15:27:38=C2=AB)"
=20
=2D#: gitk:4092
+#: gitk:4122
 msgid "Since:"
 msgstr "Von:"
=20
=2D#: gitk:4093
+#: gitk:4123
 msgid "Until:"
 msgstr "Bis:"
=20
=2D#: gitk:4094
+#: gitk:4124
 msgid "Limit and/or skip a number of revisions (positive integer):"
 msgstr "Versionsanzahl begrenzen oder einige =C3=BCberspringen (ganzzahlig=
er Wert):"
=20
=2D#: gitk:4095
+#: gitk:4125
 msgid "Number to show:"
 msgstr "Anzeigen:"
=20
=2D#: gitk:4096
+#: gitk:4126
 msgid "Number to skip:"
 msgstr "=C3=9Cberspringen:"
=20
=2D#: gitk:4097
+#: gitk:4127
 msgid "Miscellaneous options:"
 msgstr "Sonstiges:"
=20
=2D#: gitk:4098
+#: gitk:4128
 msgid "Strictly sort by date"
 msgstr "Streng nach Datum sortieren"
=20
=2D#: gitk:4099
+#: gitk:4129
 msgid "Mark branch sides"
 msgstr "Zweig-Seiten markieren"
=20
=2D#: gitk:4100
+#: gitk:4130
 msgid "Limit to first parent"
 msgstr "Auf erste Elternversion beschr=C3=A4nken"
=20
=2D#: gitk:4101
+#: gitk:4131
 msgid "Simple history"
 msgstr "Einfache Historie"
=20
=2D#: gitk:4102
+#: gitk:4132
 msgid "Additional arguments to git log:"
 msgstr "Zus=C3=A4tzliche Argumente f=C3=BCr =C2=BBgit log=C2=AB:"
=20
=2D#: gitk:4103
+#: gitk:4133
 msgid "Enter files and directories to include, one per line:"
 msgstr "Folgende Dateien und Verzeichnisse anzeigen (eine pro Zeile):"
=20
=2D#: gitk:4104
+#: gitk:4134
 msgid "Command to generate more commits to include:"
 msgstr "Versionsliste durch folgendes Kommando erzeugen lassen:"
=20
=2D#: gitk:4228
+#: gitk:4258
 msgid "Gitk: edit view"
 msgstr "Gitk: Ansicht bearbeiten"
=20
=2D#: gitk:4236
+#: gitk:4266
 msgid "-- criteria for selecting revisions"
 msgstr "-- Auswahl der angezeigten Versionen"
=20
=2D#: gitk:4241
+#: gitk:4271
 msgid "View Name"
 msgstr "Ansichtsname"
=20
=2D#: gitk:4316
+#: gitk:4346
 msgid "Apply (F5)"
 msgstr "Anwenden (F5)"
=20
=2D#: gitk:4354
+#: gitk:4384
 msgid "Error in commit selection arguments:"
 msgstr "Fehler in den ausgew=C3=A4hlten Versionen:"
=20
=2D#: gitk:4409 gitk:4462 gitk:4924 gitk:4938 gitk:6208 gitk:12373 gitk:123=
74
+#: gitk:4439 gitk:4492 gitk:4954 gitk:4968 gitk:6238 gitk:12584 gitk:12585
 msgid "None"
 msgstr "Keine"
=20
=2D#: gitk:5021 gitk:5026
+#: gitk:5051 gitk:5056
 msgid "Descendant"
 msgstr "Abk=C3=B6mmling"
=20
=2D#: gitk:5022
+#: gitk:5052
 msgid "Not descendant"
 msgstr "Kein Abk=C3=B6mmling"
=20
=2D#: gitk:5029 gitk:5034
+#: gitk:5059 gitk:5064
 msgid "Ancestor"
 msgstr "Vorg=C3=A4nger"
=20
=2D#: gitk:5030
+#: gitk:5060
 msgid "Not ancestor"
 msgstr "Kein Vorg=C3=A4nger"
=20
=2D#: gitk:5324
+#: gitk:5354
 msgid "Local changes checked in to index but not committed"
 msgstr "Lokale =C3=84nderungen bereitgestellt, aber nicht eingetragen"
=20
=2D#: gitk:5360
+#: gitk:5390
 msgid "Local uncommitted changes, not checked in to index"
 msgstr "Lokale =C3=84nderungen, nicht bereitgestellt"
=20
=2D#: gitk:7134
+#: gitk:7138
+#, fuzzy
+msgid "Error starting web browser:"
+msgstr "Fehler beim Holen von =C2=BB%s=C2=AB von =C2=BB%s=C2=AB:"
+
+#: gitk:7199
 msgid "and many more"
 msgstr "und weitere"
=20
=2D#: gitk:7137
+#: gitk:7202
 msgid "many"
 msgstr "viele"
=20
=2D#: gitk:7328
+#: gitk:7393
 msgid "Tags:"
 msgstr "Markierungen:"
=20
=2D#: gitk:7345 gitk:7351 gitk:8825
+#: gitk:7410 gitk:7416 gitk:8895
 msgid "Parent"
 msgstr "Eltern"
=20
=2D#: gitk:7356
+#: gitk:7421
 msgid "Child"
 msgstr "Kind"
=20
=2D#: gitk:7365
+#: gitk:7430
 msgid "Branch"
 msgstr "Zweig"
=20
=2D#: gitk:7368
+#: gitk:7433
 msgid "Follows"
 msgstr "Folgt auf"
=20
=2D#: gitk:7371
+#: gitk:7436
 msgid "Precedes"
 msgstr "Vorg=C3=A4nger von"
=20
=2D#: gitk:7966
+#: gitk:8031
 #, tcl-format
 msgid "Error getting diffs: %s"
 msgstr "Fehler beim Laden des Vergleichs: %s"
=20
=2D#: gitk:8650
+#: gitk:8720
 msgid "Goto:"
 msgstr "Gehe zu:"
=20
=2D#: gitk:8671
+#: gitk:8741
 #, tcl-format
 msgid "Short SHA1 id %s is ambiguous"
 msgstr "Kurzer SHA1-Hashwert =C2=BB%s=C2=AB ist mehrdeutig"
=20
=2D#: gitk:8678
+#: gitk:8748
 #, tcl-format
 msgid "Revision %s is not known"
 msgstr "Version =C2=BB%s=C2=AB ist unbekannt"
=20
=2D#: gitk:8688
+#: gitk:8758
 #, tcl-format
 msgid "SHA1 id %s is not known"
 msgstr "SHA1-Hashwert =C2=BB%s=C2=AB ist unbekannt"
=20
=2D#: gitk:8690
+#: gitk:8760
 #, tcl-format
 msgid "Revision %s is not in the current view"
 msgstr "Version =C2=BB%s=C2=AB wird in der aktuellen Ansicht nicht angezei=
gt"
=20
=2D#: gitk:8832 gitk:8847
+#: gitk:8902 gitk:8917
 msgid "Date"
 msgstr "Datum"
=20
=2D#: gitk:8835
+#: gitk:8905
 msgid "Children"
 msgstr "Kinder"
=20
=2D#: gitk:8898
+#: gitk:8968
 #, tcl-format
 msgid "Reset %s branch to here"
 msgstr "Zweig =C2=BB%s=C2=AB hierher zur=C3=BCcksetzen"
=20
=2D#: gitk:8900
+#: gitk:8970
 msgid "Detached head: can't reset"
 msgstr "Zweigspitze ist abgetrennt: Zur=C3=BCcksetzen nicht m=C3=B6glich"
=20
=2D#: gitk:9005 gitk:9011
+#: gitk:9075 gitk:9081
 msgid "Skipping merge commit "
 msgstr "=C3=9Cberspringe Zusammenf=C3=BChrungs-Version "
=20
=2D#: gitk:9020 gitk:9025
+#: gitk:9090 gitk:9095
 msgid "Error getting patch ID for "
 msgstr "Fehler beim Holen der Patch-ID f=C3=BCr "
=20
=2D#: gitk:9021 gitk:9026
+#: gitk:9091 gitk:9096
 msgid " - stopping\n"
 msgstr " - Abbruch.\n"
=20
=2D#: gitk:9031 gitk:9034 gitk:9042 gitk:9056 gitk:9065
+#: gitk:9101 gitk:9104 gitk:9112 gitk:9126 gitk:9135
 msgid "Commit "
 msgstr "Version "
=20
=2D#: gitk:9035
+#: gitk:9105
 msgid ""
 " is the same patch as\n"
 "       "
@@ -893,7 +923,7 @@ msgstr ""
 " ist das gleiche Patch wie\n"
 "       "
=20
=2D#: gitk:9043
+#: gitk:9113
 msgid ""
 " differs from\n"
 "       "
@@ -901,7 +931,7 @@ msgstr ""
 " ist unterschiedlich von\n"
 "       "
=20
=2D#: gitk:9045
+#: gitk:9115
 msgid ""
 "Diff of commits:\n"
 "\n"
@@ -909,131 +939,150 @@ msgstr ""
 "Vergleich der Versionen:\n"
 "\n"
=20
=2D#: gitk:9057 gitk:9066
+#: gitk:9127 gitk:9136
 #, tcl-format
 msgid " has %s children - stopping\n"
 msgstr " hat %s Kinder. Abbruch\n"
=20
=2D#: gitk:9085
+#: gitk:9155
 #, tcl-format
 msgid "Error writing commit to file: %s"
 msgstr "Fehler beim Schreiben der Version in Datei: %s"
=20
=2D#: gitk:9091
+#: gitk:9161
 #, tcl-format
 msgid "Error diffing commits: %s"
 msgstr "Fehler beim Vergleichen der Versionen: %s"
=20
=2D#: gitk:9137
+#: gitk:9207
 msgid "Top"
 msgstr "Oben"
=20
=2D#: gitk:9138
+#: gitk:9208
 msgid "From"
 msgstr "Von"
=20
=2D#: gitk:9143
+#: gitk:9213
 msgid "To"
 msgstr "bis"
=20
=2D#: gitk:9167
+#: gitk:9237
 msgid "Generate patch"
 msgstr "Patch erstellen"
=20
=2D#: gitk:9169
+#: gitk:9239
 msgid "From:"
 msgstr "Von:"
=20
=2D#: gitk:9178
+#: gitk:9248
 msgid "To:"
 msgstr "bis:"
=20
=2D#: gitk:9187
+#: gitk:9257
 msgid "Reverse"
 msgstr "Umgekehrt"
=20
=2D#: gitk:9189 gitk:9385
+#: gitk:9259 gitk:9469
 msgid "Output file:"
 msgstr "Ausgabedatei:"
=20
=2D#: gitk:9195
+#: gitk:9265
 msgid "Generate"
 msgstr "Erzeugen"
=20
=2D#: gitk:9233
+#: gitk:9303
 msgid "Error creating patch:"
 msgstr "Fehler beim Erzeugen des Patches:"
=20
=2D#: gitk:9256 gitk:9373 gitk:9430
+#: gitk:9326 gitk:9457 gitk:9545
 msgid "ID:"
 msgstr "ID:"
=20
=2D#: gitk:9265
+#: gitk:9335
 msgid "Tag name:"
 msgstr "Markierungsname:"
=20
=2D#: gitk:9268
+#: gitk:9338
 msgid "Tag message is optional"
 msgstr "Eine Markierungsbeschreibung ist optional"
=20
=2D#: gitk:9270
+#: gitk:9340
 msgid "Tag message:"
 msgstr "Markierungsbeschreibung:"
=20
=2D#: gitk:9274 gitk:9439
+#: gitk:9344 gitk:9515
 msgid "Create"
 msgstr "Erstellen"
=20
=2D#: gitk:9292
+#: gitk:9362
 msgid "No tag name specified"
 msgstr "Kein Markierungsname angegeben"
=20
=2D#: gitk:9296
+#: gitk:9366
 #, tcl-format
 msgid "Tag \"%s\" already exists"
 msgstr "Markierung =C2=BB%s=C2=AB existiert bereits."
=20
=2D#: gitk:9306
+#: gitk:9376
 msgid "Error creating tag:"
 msgstr "Fehler beim Erstellen der Markierung:"
=20
=2D#: gitk:9382
+#: gitk:9466
 msgid "Command:"
 msgstr "Kommando:"
=20
=2D#: gitk:9390
+#: gitk:9474
 msgid "Write"
 msgstr "Schreiben"
=20
=2D#: gitk:9408
+#: gitk:9492
 msgid "Error writing commit:"
 msgstr "Fehler beim Schreiben der Version:"
=20
=2D#: gitk:9435
+#: gitk:9514
+#, fuzzy
+msgid "Create branch"
+msgstr "Neuen Zweig erstellen"
+
+#: gitk:9530
+#, fuzzy, tcl-format
+msgid "Rename branch %s"
+msgstr "Zweig =C2=BB%s=C2=AB auf =C2=BB%s=C2=AB zur=C3=BCcksetzen?"
+
+#: gitk:9531
+msgid "Rename"
+msgstr ""
+
+#: gitk:9555
 msgid "Name:"
 msgstr "Name:"
=20
=2D#: gitk:9458
+#: gitk:9579
 msgid "Please specify a name for the new branch"
 msgstr "Bitte geben Sie einen Namen f=C3=BCr den neuen Zweig an."
=20
=2D#: gitk:9463
+#: gitk:9584
 #, tcl-format
 msgid "Branch '%s' already exists. Overwrite?"
 msgstr "Zweig =C2=BB%s=C2=AB existiert bereits. Soll er =C3=BCberschrieben=
 werden?"
=20
=2D#: gitk:9530
+#: gitk:9628
+#, fuzzy
+msgid "Please specify a new name for the branch"
+msgstr "Bitte geben Sie einen Namen f=C3=BCr den neuen Zweig an."
+
+#: gitk:9691
 #, tcl-format
 msgid "Commit %s is already included in branch %s -- really re-apply it?"
 msgstr ""
 "Version =C2=BB%s=C2=AB ist bereits im Zweig =C2=BB%s=C2=AB enthalten -- t=
rotzdem erneut "
 "eintragen?"
=20
=2D#: gitk:9535
+#: gitk:9696
 msgid "Cherry-picking"
 msgstr "Version pfl=C3=BCcken"
=20
=2D#: gitk:9544
+#: gitk:9705
 #, tcl-format
 msgid ""
 "Cherry-pick failed because of local changes to file '%s'.\n"
@@ -1043,7 +1092,7 @@ msgstr ""
 "vorliegen. Bitte diese =C3=84nderungen eintragen, zur=C3=BCcksetzen oder\=
n"
 "zwischenspeichern (=C2=BBgit stash=C2=AB) und dann erneut versuchen."
=20
=2D#: gitk:9550
+#: gitk:9711
 msgid ""
 "Cherry-pick failed because of merge conflict.\n"
 "Do you wish to run git citool to resolve it?"
@@ -1052,21 +1101,20 @@ msgstr ""
 "ist. Soll das Zusammenf=C3=BChrungs-Werkzeug (=C2=BBgit citool=C2=AB) auf=
gerufen\n"
 "werden, um diesen Konflikt aufzul=C3=B6sen?"
=20
=2D#: gitk:9566 gitk:9624
+#: gitk:9727 gitk:9785
 msgid "No changes committed"
 msgstr "Keine =C3=84nderungen eingetragen"
=20
=2D#: gitk:9593
+#: gitk:9754
 #, tcl-format
 msgid "Commit %s is not included in branch %s -- really revert it?"
=2Dmsgstr ""
=2D"Version =C2=BB%s=C2=AB ist nicht im Zweig =C2=BB%s=C2=AB enthalten -- t=
rotzdem umkehren?"
+msgstr "Version =C2=BB%s=C2=AB ist nicht im Zweig =C2=BB%s=C2=AB enthalten=
 -- trotzdem umkehren?"
=20
=2D#: gitk:9598
+#: gitk:9759
 msgid "Reverting"
 msgstr "Umkehren"
=20
=2D#: gitk:9606
+#: gitk:9767
 #, tcl-format
 msgid ""
 "Revert failed because of local changes to the following files:%s Please "
@@ -1076,7 +1124,7 @@ msgstr ""
 "vorliegen. Bitte diese =C3=84nderungen eintragen, zur=C3=BCcksetzen oder\=
n"
 "zwischenspeichern (=C2=BBgit stash=C2=AB) und dann erneut versuchen."
=20
=2D#: gitk:9610
+#: gitk:9771
 msgid ""
 "Revert failed because of merge conflict.\n"
 " Do you wish to run git citool to resolve it?"
@@ -1085,30 +1133,30 @@ msgstr ""
 "ist. Soll das Zusammenf=C3=BChrungs-Werkzeug (=C2=BBgit citool=C2=AB) auf=
gerufen\n"
 "werden, um diesen Konflikt aufzul=C3=B6sen?"
=20
=2D#: gitk:9653
+#: gitk:9814
 msgid "Confirm reset"
 msgstr "Zur=C3=BCcksetzen best=C3=A4tigen"
=20
=2D#: gitk:9655
+#: gitk:9816
 #, tcl-format
 msgid "Reset branch %s to %s?"
 msgstr "Zweig =C2=BB%s=C2=AB auf =C2=BB%s=C2=AB zur=C3=BCcksetzen?"
=20
=2D#: gitk:9657
+#: gitk:9818
 msgid "Reset type:"
 msgstr "Art des Zur=C3=BCcksetzens:"
=20
=2D#: gitk:9660
+#: gitk:9821
 msgid "Soft: Leave working tree and index untouched"
 msgstr "Harmlos: Arbeitskopie und Bereitstellung unver=C3=A4ndert"
=20
=2D#: gitk:9663
+#: gitk:9824
 msgid "Mixed: Leave working tree untouched, reset index"
 msgstr ""
 "Gemischt: Arbeitskopie unver=C3=A4ndert,\n"
 "Bereitstellung zur=C3=BCckgesetzt"
=20
=2D#: gitk:9666
+#: gitk:9827
 msgid ""
 "Hard: Reset working tree and index\n"
 "(discard ALL local changes)"
@@ -1116,21 +1164,26 @@ msgstr ""
 "Hart: Arbeitskopie und Bereitstellung\n"
 "(Alle lokalen =C3=84nderungen werden gel=C3=B6scht)"
=20
=2D#: gitk:9683
+#: gitk:9844
 msgid "Resetting"
 msgstr "Zur=C3=BCcksetzen"
=20
=2D#: gitk:9743
+#: gitk:9917
+#, tcl-format
+msgid "A local branch named %s exists already"
+msgstr ""
+
+#: gitk:9925
 msgid "Checking out"
 msgstr "Umstellen"
=20
=2D#: gitk:9796
+#: gitk:9984
 msgid "Cannot delete the currently checked-out branch"
 msgstr ""
 "Der Zweig, auf den die Arbeitskopie momentan umgestellt ist, kann nicht "
 "gel=C3=B6scht werden."
=20
=2D#: gitk:9802
+#: gitk:9990
 #, tcl-format
 msgid ""
 "The commits on branch %s aren't on any other branch.\n"
@@ -1139,16 +1192,16 @@ msgstr ""
 "Die Versionen auf Zweig =C2=BB%s=C2=AB existieren auf keinem anderen Zwei=
g.\n"
 "Zweig =C2=BB%s=C2=AB trotzdem l=C3=B6schen?"
=20
=2D#: gitk:9833
+#: gitk:10021
 #, tcl-format
 msgid "Tags and heads: %s"
 msgstr "Markierungen und Zweige: %s"
=20
=2D#: gitk:9850
+#: gitk:10038
 msgid "Filter"
 msgstr "Filtern"
=20
=2D#: gitk:10146
+#: gitk:10339
 msgid ""
 "Error reading commit topology information; branch and preceding/following=
 "
 "tag information will be incomplete."
@@ -1156,218 +1209,223 @@ msgstr ""
 "Fehler beim Lesen der Strukturinformationen; Zweige und Informationen zu "
 "Vorg=C3=A4nger/Nachfolger werden unvollst=C3=A4ndig sein."
=20
=2D#: gitk:11123
+#: gitk:11316
 msgid "Tag"
 msgstr "Markierung"
=20
=2D#: gitk:11127
+#: gitk:11320
 msgid "Id"
 msgstr "Id"
=20
=2D#: gitk:11210
+#: gitk:11403
 msgid "Gitk font chooser"
 msgstr "Gitk-Schriften w=C3=A4hlen"
=20
=2D#: gitk:11227
+#: gitk:11420
 msgid "B"
 msgstr "F"
=20
=2D#: gitk:11230
+#: gitk:11423
 msgid "I"
 msgstr "K"
=20
=2D#: gitk:11348
+#: gitk:11541
 msgid "Commit list display options"
 msgstr "Anzeige der Versionsliste"
=20
=2D#: gitk:11351
+#: gitk:11544
 msgid "Maximum graph width (lines)"
 msgstr "Maximale Graphenbreite (Zeilen)"
=20
=2D#: gitk:11355
+#: gitk:11548
 #, no-tcl-format
 msgid "Maximum graph width (% of pane)"
 msgstr "Maximale Graphenbreite (% des Fensters)"
=20
=2D#: gitk:11358
+#: gitk:11551
 msgid "Show local changes"
 msgstr "Lokale =C3=84nderungen anzeigen"
=20
=2D#: gitk:11361
+#: gitk:11554
 msgid "Auto-select SHA1 (length)"
 msgstr "SHA1-Hashwert (L=C3=A4nge) automatisch ausw=C3=A4hlen"
=20
=2D#: gitk:11365
+#: gitk:11558
 msgid "Hide remote refs"
 msgstr "Entfernte Zweige/Markierungen ausblenden"
=20
=2D#: gitk:11369
+#: gitk:11562
 msgid "Diff display options"
 msgstr "Anzeige des Vergleichs"
=20
=2D#: gitk:11371
+#: gitk:11564
 msgid "Tab spacing"
 msgstr "Tabulatorbreite"
=20
=2D#: gitk:11374
+#: gitk:11567
 msgid "Display nearby tags/heads"
 msgstr "Naheliegende Markierungen/Zweigspitzen anzeigen"
=20
=2D#: gitk:11377
+#: gitk:11570
 msgid "Maximum # tags/heads to show"
 msgstr "Maximale Anzahl anzuzeigender Markierungen/Zweigspitzen"
=20
=2D#: gitk:11380
+#: gitk:11573
 msgid "Limit diffs to listed paths"
 msgstr "Vergleich nur f=C3=BCr angezeigte Pfade"
=20
=2D#: gitk:11383
+#: gitk:11576
 msgid "Support per-file encodings"
 msgstr "Zeichenkodierung pro Datei ermitteln"
=20
=2D#: gitk:11389 gitk:11536
+#: gitk:11582 gitk:11736
 msgid "External diff tool"
 msgstr "Externes Diff-Programm"
=20
=2D#: gitk:11390
+#: gitk:11583
 msgid "Choose..."
 msgstr "W=C3=A4hlen ..."
=20
=2D#: gitk:11395
+#: gitk:11590
+msgid "Web browser"
+msgstr ""
+
+#: gitk:11595
 msgid "General options"
 msgstr "Allgemeine Optionen"
=20
=2D#: gitk:11398
+#: gitk:11598
 msgid "Use themed widgets"
 msgstr "Aussehen der Benutzeroberfl=C3=A4che durch Thema bestimmen"
=20
=2D#: gitk:11400
+#: gitk:11600
 msgid "(change requires restart)"
 msgstr "(=C3=84nderungen werden erst nach Neustart wirksam)"
=20
=2D#: gitk:11402
+#: gitk:11602
 msgid "(currently unavailable)"
 msgstr "(Momentan nicht verf=C3=BCgbar)"
=20
=2D#: gitk:11413
+#: gitk:11613
 msgid "Colors: press to choose"
 msgstr "Farben: Klicken zum W=C3=A4hlen"
=20
=2D#: gitk:11416
+#: gitk:11616
 msgid "Interface"
 msgstr "Benutzeroberfl=C3=A4che"
=20
=2D#: gitk:11417
+#: gitk:11617
 msgid "interface"
 msgstr "Benutzeroberfl=C3=A4che"
=20
=2D#: gitk:11420
+#: gitk:11620
 msgid "Background"
 msgstr "Hintergrund"
=20
=2D#: gitk:11421 gitk:11451
+#: gitk:11621 gitk:11651
 msgid "background"
 msgstr "Hintergrund"
=20
=2D#: gitk:11424
+#: gitk:11624
 msgid "Foreground"
 msgstr "Vordergrund"
=20
=2D#: gitk:11425
+#: gitk:11625
 msgid "foreground"
 msgstr "Vordergrund"
=20
=2D#: gitk:11428
+#: gitk:11628
 msgid "Diff: old lines"
 msgstr "Vergleich: Alte Zeilen"
=20
=2D#: gitk:11429
+#: gitk:11629
 msgid "diff old lines"
 msgstr "Vergleich - Alte Zeilen"
=20
=2D#: gitk:11433
+#: gitk:11633
 msgid "Diff: new lines"
 msgstr "Vergleich: Neue Zeilen"
=20
=2D#: gitk:11434
+#: gitk:11634
 msgid "diff new lines"
 msgstr "Vergleich - Neue Zeilen"
=20
=2D#: gitk:11438
+#: gitk:11638
 msgid "Diff: hunk header"
 msgstr "Vergleich: =C3=84nderungstitel"
=20
=2D#: gitk:11440
+#: gitk:11640
 msgid "diff hunk header"
 msgstr "Vergleich - =C3=84nderungstitel"
=20
=2D#: gitk:11444
+#: gitk:11644
 msgid "Marked line bg"
 msgstr "Hintergrund f=C3=BCr markierte Zeile"
=20
=2D#: gitk:11446
+#: gitk:11646
 msgid "marked line background"
 msgstr "Hintergrund f=C3=BCr markierte Zeile"
=20
=2D#: gitk:11450
+#: gitk:11650
 msgid "Select bg"
 msgstr "Hintergrundfarbe ausw=C3=A4hlen"
=20
=2D#: gitk:11459
+#: gitk:11659
 msgid "Fonts: press to choose"
 msgstr "Schriftart: Klicken zum W=C3=A4hlen"
=20
=2D#: gitk:11461
+#: gitk:11661
 msgid "Main font"
 msgstr "Programmschriftart"
=20
=2D#: gitk:11462
+#: gitk:11662
 msgid "Diff display font"
 msgstr "Schriftart f=C3=BCr Vergleich"
=20
=2D#: gitk:11463
+#: gitk:11663
 msgid "User interface font"
 msgstr "Beschriftungen"
=20
=2D#: gitk:11485
+#: gitk:11685
 msgid "Gitk preferences"
 msgstr "Gitk-Einstellungen"
=20
=2D#: gitk:11494
+#: gitk:11694
 msgid "General"
 msgstr "Allgemein"
=20
=2D#: gitk:11495
+#: gitk:11695
 msgid "Colors"
 msgstr "Farben"
=20
=2D#: gitk:11496
+#: gitk:11696
 msgid "Fonts"
 msgstr "Schriftarten"
=20
=2D#: gitk:11546
+#: gitk:11746
 #, tcl-format
 msgid "Gitk: choose color for %s"
 msgstr "Gitk: Farbe w=C3=A4hlen f=C3=BCr %s"
=20
=2D#: gitk:12059
+#: gitk:12259
 msgid ""
 "Sorry, gitk cannot run with this version of Tcl/Tk.\n"
 " Gitk requires at least Tcl/Tk 8.4."
 msgstr ""
=2D"Entschuldigung, gitk kann nicht mit dieser Tcl/Tk Version ausgef=C3=BCh=
rt werden.\n"
+"Entschuldigung, gitk kann nicht mit dieser Tcl/Tk Version ausgef=C3=BChrt=
 "
+"werden.\n"
 " Gitk erfordert mindestens Tcl/Tk 8.4."
=20
=2D#: gitk:12269
+#: gitk:12476
 msgid "Cannot find a git repository here."
 msgstr "Kein Git-Projektarchiv gefunden."
=20
=2D#: gitk:12316
+#: gitk:12523
 #, tcl-format
 msgid "Ambiguous argument '%s': both revision and filename"
 msgstr "Mehrdeutige Angabe =C2=BB%s=C2=AB: Sowohl Version als auch Dateina=
me existiert."
=20
=2D#: gitk:12328
+#: gitk:12535
 msgid "Bad arguments to gitk:"
 msgstr "Falsche Kommandozeilen-Parameter f=C3=BCr gitk:"
=20
=2D-=20
2.17.1


--nextPart1817602.O6iiOg1gnh--



