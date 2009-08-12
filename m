From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] git-gui: Update russian translation
Date: Wed, 12 Aug 2009 17:24:10 +0200
Message-ID: <20090812152409.GA5407@blimp.localdomain>
References: <4A4A77A6.1020905@lawrence.edu> <20090810153859.GT1033@spearce.org> <4A81B738.7090507@zwell.net> <20090811202927.GZ1033@spearce.org> <4A81BD58.8070300@zwell.net> <20090812144345.GC1033@spearce.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dan Zwell <dzwell@zwell.net>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 12 17:24:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbFgi-0003QS-4p
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 17:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256AbZHLPYP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Aug 2009 11:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753162AbZHLPYP
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 11:24:15 -0400
Received: from mout5.freenet.de ([195.4.92.95]:48055 "EHLO mout5.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752314AbZHLPYO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 11:24:14 -0400
Received: from [195.4.92.17] (helo=7.mx.freenet.de)
	by mout5.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #92)
	id 1MbFgT-0005Dg-4v; Wed, 12 Aug 2009 17:24:13 +0200
Received: from x6087.x.pppool.de ([89.59.96.135]:35046 helo=tigra.home)
	by 7.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.69 #93)
	id 1MbFgS-0007aj-Pe; Wed, 12 Aug 2009 17:24:13 +0200
Received: from blimp.localdomain (blimp.home [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id DEB0E277D8;
	Wed, 12 Aug 2009 17:24:10 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 7315F36D28; Wed, 12 Aug 2009 17:24:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090812144345.GC1033@spearce.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-purgate-ID: 149285::1250090653-000046EB-577F976B/0-0/0-0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125710>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Shawn O. Pearce, Wed, Aug 12, 2009 16:43:45 +0200:
> Dan Zwell <dzwell@zwell.net> wrote:
> > When there is a large number of new or modified files,
> > "display_all_files" takes a long time, and git-gui appears to
> > hang. This change limits the number of files that are displayed.
> > This limit can be set as gui.maxfilesdisplayed, and is
> > 5000 by default.
> >
> > A warning is shown when the list of files is truncated.
>=20
> Thanks, applied.
>=20

And the updated translation.

But now, when I really think about the change, it looks useless.
What has the _number_ of files has to do with the files you actually
have to handle? As the sorting of the file list cannot be changed (and
it wouldn't be a big help anyway), you have no chance to get to your
file if it happens to be past the limit!

Wouldn't a pathname/glob filter in the command-line (or file/path
selection dialog) to limit the scope be more appropriate and useful?
And have the file list reading to happen in background, as gitk does?

 po/ru.po |   28 ++++++++++++++++------------
 1 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/po/ru.po b/po/ru.po
index 0ffc4a4..364c074 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -90,12 +90,18 @@ msgstr "=D0=92=D1=8B=D0=B7=D0=BE=D0=B2 =D0=BF=D1=80=
=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D1=8B =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=
=D1=80=D0=B6=D0=BA=D0=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=
=D1=80=D0=B8=D1=8F
=20
 #: git-gui.sh:1384
 msgid "Commit declined by prepare-commit-msg hook."
-msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=BF=D1=80=D0=B5=D1=80=D0=B2=D0=B0=D0=BD=D0=BE =D0=BF=D1=80=D0=BE=D0=B3=D1=
=80=D0=B0=D0=BC=D0=BC=D0=BE=D0=B9 =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=80=D0=
=B6=D0=BA=D0=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=
=B8=D1=8F prepare-commit-msg"
+msgstr ""
+"=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BF=D1=
=80=D0=B5=D1=80=D0=B2=D0=B0=D0=BD=D0=BE =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=
=B0=D0=BC=D0=BC=D0=BE=D0=B9 =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=80=D0=B6=D0=
=BA=D0=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=
=8F prepare-commit-msg"
=20
 #: git-gui.sh:1542 lib/browser.tcl:246
 msgid "Ready."
 msgstr "=D0=93=D0=BE=D1=82=D0=BE=D0=B2=D0=BE."
=20
+#: git-gui.sh:1726
+#, tcl-format
+msgid "Displaying only %s of %s files."
+msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD=D0=BE %s =D0=B8=D0=B7=
 %s =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2."
+
 #: git-gui.sh:1819
 msgid "Unmodified"
 msgstr "=D0=9D=D0=B5 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=BE"
@@ -1297,8 +1303,8 @@ msgid ""
 msgstr ""
 "=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=B8=D1=
=81=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D1=81=D0=BE=D1=81=D1=82=D0=
=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D0=B2=D0=BE =D0=B2=D1=80=D0=B5=D0=BC=D1=8F=
 =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D0=B8 =D1=81=D0=BB=D0=B8=D1=
=8F=D0=BD=D0=B8=D1=8F.\n"
 "\n"
-"=D0=A2=D0=B5=D0=BA=D1=83=D1=89=D0=B5=D0=B5 =D1=81=D0=BB=D0=B8=D1=8F=D0=
=BD=D0=B8=D0=B5 =D0=BD=D0=B5 =D0=B7=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B5=
=D0=BD=D0=BE. =D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=
=BE =D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D0=BF=D1=80=
=D0=B5=D0=B4=D1=8B=D0=B4=D1=83=D1=89=D0=B5=D0=B5 "
-"=D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=BD=D0=BE=D0=B5 =D1=
=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5, =D0=BD=D0=B5 =D0=BF=
=D1=80=D0=B5=D1=80=D1=8B=D0=B2=D0=B0=D1=8F =D1=8D=D1=82=D1=83 =D0=BE=D0=
=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D1=8E.\n"
+"=D0=A2=D0=B5=D0=BA=D1=83=D1=89=D0=B5=D0=B5 =D1=81=D0=BB=D0=B8=D1=8F=D0=
=BD=D0=B8=D0=B5 =D0=BD=D0=B5 =D0=B7=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B5=
=D0=BD=D0=BE. =D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=
=BE =D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D0=BF=D1=80=
=D0=B5=D0=B4=D1=8B=D0=B4=D1=83=D1=89=D0=B5=D0=B5 =D1=81=D0=BE=D1=85=D1=80=
=D0=B0=D0=BD=D0=B5=D0=BD=D0=BD=D0=BE=D0=B5 "
+"=D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5, =D0=BD=D0=B5 =
=D0=BF=D1=80=D0=B5=D1=80=D1=8B=D0=B2=D0=B0=D1=8F =D1=8D=D1=82=D1=83 =D0=
=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D1=8E.\n"
=20
 #: lib/commit.tcl:48
 msgid "Error loading commit data for amend:"
@@ -1723,8 +1729,7 @@ msgid ""
 msgstr ""
 "=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=B2=D1=
=8B=D0=BF=D0=BE=D0=BB=D0=BD=D0=B8=D1=82=D1=8C =D1=81=D0=BB=D0=B8=D1=8F=D0=
=BD=D0=B8=D0=B5 =D0=B2=D0=BE =D0=B2=D1=80=D0=B5=D0=BC=D1=8F =D0=B8=D1=81=
=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D1=8F.\n"
 "\n"
-"=D0=97=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B8=D1=82=D0=B5 =D0=B8=D1=81=D0=
=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 =D0=B4=D0=B0=D0=BD=D0=
=BD=D0=BE=D0=B3=D0=BE =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=
=8F =D0=BF=D0=B5=D1=80=D0=B5=D0=B4 =D0=B2=D1=8B=D0=BF=D0=BE=D0=BB=D0=BD=
=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=
=D0=B8 "
-"=D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=8F.\n"
+"=D0=97=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B8=D1=82=D0=B5 =D0=B8=D1=81=D0=
=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 =D0=B4=D0=B0=D0=BD=D0=
=BD=D0=BE=D0=B3=D0=BE =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=
=8F =D0=BF=D0=B5=D1=80=D0=B5=D0=B4 =D0=B2=D1=8B=D0=BF=D0=BE=D0=BB=D0=BD=
=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=
=D0=B8 =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=8F.\n"
=20
 #: lib/merge.tcl:27
 msgid ""
@@ -1888,8 +1893,8 @@ msgstr ""
 #, tcl-format
 msgid "File %s seems to have unresolved conflicts, still stage?"
 msgstr ""
-"=D0=A4=D0=B0=D0=B9=D0=BB %s =D0=BA=D0=B0=D0=B6=D0=B5=D1=82=D1=81=D1=8F=
 =D1=81=D0=BE=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D1=82 =D0=BD=D0=B5=D0=BE=D0=
=B1=D1=80=D0=B0=D0=B1=D0=BE=D1=82=D0=B0=D0=BD=D1=8B=D0=B5 =D0=BA=D0=BE=D0=
=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=D1=8B. "
-"=D0=9F=D1=80=D0=BE=D0=B4=D0=BE=D0=BB=D0=B6=D0=B8=D1=82=D1=8C =D0=BF=D0=
=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BA=D1=83 =D0=BA =D1=81=D0=BE=
=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8E?"
+"=D0=A4=D0=B0=D0=B9=D0=BB %s =D0=BA=D0=B0=D0=B6=D0=B5=D1=82=D1=81=D1=8F=
 =D1=81=D0=BE=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D1=82 =D0=BD=D0=B5=D0=BE=D0=
=B1=D1=80=D0=B0=D0=B1=D0=BE=D1=82=D0=B0=D0=BD=D1=8B=D0=B5 =D0=BA=D0=BE=D0=
=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=D1=8B. =D0=9F=D1=80=D0=BE=D0=B4=D0=BE=
=D0=BB=D0=B6=D0=B8=D1=82=D1=8C =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=
=D0=B2=D0=BA=D1=83 =D0=BA "
+"=D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8E?"
=20
 #: lib/mergetool.tcl:60
 #, tcl-format
@@ -2213,8 +2218,8 @@ msgid ""
 "One or more of the merge tests failed because you have not fetched th=
e "
 "necessary commits.  Try fetching from %s first."
 msgstr ""
-"=D0=9D=D0=B5=D0=BA=D0=BE=D1=82=D0=BE=D1=80=D1=8B=D0=B5 =D1=82=D0=B5=D1=
=81=D1=82=D1=8B =D0=BD=D0=B0 =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D0=B5=
 =D0=BD=D0=B5 =D0=BF=D1=80=D0=BE=D1=88=D0=BB=D0=B8, =D0=BF=D0=BE=D1=82=D0=
=BE=D0=BC=D1=83 =D1=87=D1=82=D0=BE =D0=92=D1=8B =D0=BD=D0=B5 "
-"=D0=BF=D0=BE=D0=BB=D1=83=D1=87=D0=B8=D0=BB=D0=B8 =D0=BD=D0=B5=D0=BE=D0=
=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D1=8B=D0=B5 =D1=81=D0=BE=D1=81=D1=82=D0=
=BE=D1=8F=D0=BD=D0=B8=D1=8F. =D0=9F=D0=BE=D0=BF=D1=8B=D1=82=D0=B0=D0=B9=
=D1=82=D0=B5=D1=81=D1=8C =D0=BF=D0=BE=D0=BB=D1=83=D1=87=D0=B8=D1=82=D1=8C=
 =D0=B8=D1=85 =D0=B8=D0=B7 %s."
+"=D0=9D=D0=B5=D0=BA=D0=BE=D1=82=D0=BE=D1=80=D1=8B=D0=B5 =D1=82=D0=B5=D1=
=81=D1=82=D1=8B =D0=BD=D0=B0 =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D0=B5=
 =D0=BD=D0=B5 =D0=BF=D1=80=D0=BE=D1=88=D0=BB=D0=B8, =D0=BF=D0=BE=D1=82=D0=
=BE=D0=BC=D1=83 =D1=87=D1=82=D0=BE =D0=92=D1=8B =D0=BD=D0=B5 =D0=BF=D0=BE=
=D0=BB=D1=83=D1=87=D0=B8=D0=BB=D0=B8 =D0=BD=D0=B5=D0=BE=D0=B1=D1=85=D0=BE=
=D0=B4=D0=B8=D0=BC=D1=8B=D0=B5 "
+"=D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8F. =D0=9F=D0=BE=D0=
=BF=D1=8B=D1=82=D0=B0=D0=B9=D1=82=D0=B5=D1=81=D1=8C =D0=BF=D0=BE=D0=BB=D1=
=83=D1=87=D0=B8=D1=82=D1=8C =D0=B8=D1=85 =D0=B8=D0=B7 %s."
=20
 #: lib/remote_branch_delete.tcl:207
 msgid "Please select one or more branches to delete."
@@ -2381,8 +2386,8 @@ msgstr "=D0=92=D1=8B=D0=BF=D0=BE=D0=BB=D0=BD=D0=B5=
=D0=BD=D0=B8=D0=B5: %s"
=20
 #: lib/tools.tcl:149
 #, tcl-format
-msgid "Tool completed succesfully: %s"
-msgstr "=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 %s =D1=83=
=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D0=B7=D0=B0=D0=B2=D0=B5=D1=80=D1=88=
=D0=B8=D0=BB=D0=B0=D1=81=D1=8C."
+msgid "Tool completed successfully: %s"
+msgstr "=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 %s =D0=B7=
=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B8=D0=BB=D0=B0=D1=81=D1=8C =D1=83=D1=81=
=D0=BF=D0=B5=D1=88=D0=BD=D0=BE."
=20
 #: lib/tools.tcl:151
 #, tcl-format
@@ -2538,4 +2543,3 @@ msgstr "=D0=98=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=
=D0=BE=D0=B2=D0=B0=D1=82=D1=8C thin pack (=D0=B4=D0=BB=D1=8F =D0=BC=D0=B5=
=D0=B4=D0=BB=D0=B5=D0=BD=D0=BD=D1=8B=D1=85 =D1=81=D0=B5=D1=82=D0=B5=D0=B2
 #: lib/transport.tcl:179
 msgid "Include tags"
 msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D0=B4=D0=B0=D1=82=D1=8C =D0=BC=D0=B5=D1=
=82=D0=BA=D0=B8"
-
--=20
1.6.4.140.gc6dfd
