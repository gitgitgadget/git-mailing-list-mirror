From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: [PATCH] git-mailinfo: document the -n option
Date: Thu, 10 Jul 2008 23:36:28 +0200
Message-ID: <487680DC.2010104@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 23:37:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH3pU-0008NE-Co
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 23:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874AbYGJVgb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jul 2008 17:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752205AbYGJVgb
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 17:36:31 -0400
Received: from atum.ita.chalmers.se ([129.16.4.148]:55902 "EHLO
	atum.ita.chalmers.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbYGJVga (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 17:36:30 -0400
Received: from [192.168.0.82] (153.29.227.87.static.kba.siw.siwnet.net [87.227.29.153])
	(Authenticated sender: lukass)
	by atum.ita.chalmers.se (Postfix) with ESMTP id F2EBF11D33;
	Thu, 10 Jul 2008 23:36:28 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.1.14) Gecko/20080504 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88013>

Signed-off-by: Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>
---
 Documentation/git-mailinfo.txt |    5 ++++-
 builtin-mailinfo.c             |    2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinf=
o.txt
index cc52db3..316bcc6 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -8,7 +8,7 @@ git-mailinfo - Extracts patch and authorship from a sin=
gle e-mail message
=20
 SYNOPSIS
 --------
-'git mailinfo' [-k] [-u | --encoding=3D<encoding>] <msg> <patch>
+'git mailinfo' [-k] [-u | --encoding=3D<encoding> | -n] <msg> <patch>
=20
=20
 DESCRIPTION
@@ -46,6 +46,9 @@ conversion, even with this flag.
 	from what is specified by i18n.commitencoding, this flag
 	can be used to override it.
=20
+-n::
+	Disable all charset re-coding of the metadata.
+
 <msg>::
 	The commit log message extracted from e-mail, usually
 	except the title line which comes from e-mail Subject.
diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index fa6e8f9..962aa34 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -960,7 +960,7 @@ static int mailinfo(FILE *in, FILE *out, int ks, co=
nst char *encoding,
 }
=20
 static const char mailinfo_usage[] =3D
-	"git-mailinfo [-k] [-u | --encoding=3D<encoding>] msg patch <mail >in=
fo";
+	"git-mailinfo [-k] [-u | --encoding=3D<encoding> | -n] msg patch <mai=
l >info";
=20
 int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 {
--=20
1.5.4.5
