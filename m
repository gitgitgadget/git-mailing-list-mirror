From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v2 12/12] fmt-merge-msg: remove deprecated summary-related
	options and config variable
Date: Wed, 16 Apr 2008 02:39:11 +0200
Message-ID: <1208306351-20922-13-git-send-email-szeder@ira.uka.de>
References: <7vzls7so8m.fsf@gitster.siamese.dyndns.org>
	<1208306351-20922-1-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-2-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-3-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-4-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-5-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-6-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-7-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-8-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-9-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-10-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-11-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-12-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 07:03:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jlvht-0007aE-Lo
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 02:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756490AbYDPAji convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Apr 2008 20:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756565AbYDPAji
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 20:39:38 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:59046 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756465AbYDPAjg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 20:39:36 -0400
Received: from [127.0.1.1] (p5B13305D.dip0.t-ipconnect.de [91.19.48.93])
	by mrelayeu.kundenserver.de (node=mrelayeu8) with ESMTP (Nemesis)
	id 0ML31I-1JlvgI2lxr-00033c; Wed, 16 Apr 2008 02:39:23 +0200
X-Mailer: git-send-email 1.5.5.76.g546c
In-Reply-To: <1208306351-20922-12-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V01U2FsdGVkX1/L2kzl6MB01b9ASb79oUHkc3NUcU8mzjVXumF
 SwuIgK4Fs9SZwtY3SV/Sp/aadmdaYW8VguEn9RMxE7UZofWxe9
 S9NbKjv/lNOLdLHZd7NPA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79657>

Also remove related test.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 Documentation/git-fmt-merge-msg.txt |    9 ---------
 Documentation/merge-config.txt      |    3 ---
 builtin-fmt-merge-msg.c             |   12 +++---------
 t/t6200-fmt-merge-msg.sh            |    8 +-------
 4 files changed, 4 insertions(+), 28 deletions(-)

diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fm=
t-merge-msg.txt
index 6e23e6c..4d0ca4c 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -33,12 +33,6 @@ OPTIONS
 	Do not list one-line descriptions from the actual commits being
 	merged.
=20
---summary::
-	Deprecated equivalent of --log.
-
---no-summary::
-	Deprecated equivalent of --no-log.
-
 --file <file>, -F <file>::
 	Take the list of merged objects from <file> instead of
 	stdin.
@@ -50,9 +44,6 @@ merge.log::
 	Whether to include summaries of merged commits in newly
 	merge commit messages. False by default.
=20
-merge.summary::
-	Deprecated equivalent of merge.log.
-
 SEE ALSO
 --------
 linkgit:git-merge[1]
diff --git a/Documentation/merge-config.txt b/Documentation/merge-confi=
g.txt
index 896f914..9719311 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -6,9 +6,6 @@ merge.log::
 	Whether to include summaries of merged commits in newly created
 	merge commit messages. False by default.
=20
-merge.summary::
-	Deprecated equivalent of merge.log.
-
 merge.tool::
 	Controls which merge resolution program is used by
 	linkgit:git-mergetool[1].  Valid built-in values are: "kdiff3",
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index d49f545..0bf87c1 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -12,12 +12,7 @@ static int merge_summary;
=20
 static int fmt_merge_msg_config(const char *key, const char *value)
 {
-	static int found_merge_log =3D 0;
-	if (!strcmp("merge.log", key)) {
-		found_merge_log =3D 1;
-		merge_summary =3D git_config_bool(key, value);
-	}
-	if (!found_merge_log && !strcmp("merge.summary", key))
+	if (!strcmp("merge.log", key))
 		merge_summary =3D git_config_bool(key, value);
 	return 0;
 }
@@ -255,10 +250,9 @@ int cmd_fmt_merge_msg(int argc, const char **argv,=
 const char *prefix)
 	git_config(fmt_merge_msg_config);
=20
 	while (argc > 1) {
-		if (!strcmp(argv[1], "--log") || !strcmp(argv[1], "--summary"))
+		if (!strcmp(argv[1], "--log"))
 			merge_summary =3D 1;
-		else if (!strcmp(argv[1], "--no-log")
-				|| !strcmp(argv[1], "--no-summary"))
+		else if (!strcmp(argv[1], "--no-log"))
 			merge_summary =3D 0;
 		else if (!strcmp(argv[1], "-F") || !strcmp(argv[1], "--file")) {
 			if (argc < 3)
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 926ca50..d844661 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -108,7 +108,7 @@ EOF
=20
 test_expect_success 'merge-msg test #3' '
=20
-	git config merge.summary true &&
+	git config merge.log true &&
=20
 	git checkout master &&
 	setdate &&
@@ -138,7 +138,6 @@ EOF
=20
 test_expect_success 'merge-msg test #4' '
=20
-	git config --unset merge.summary &&
 	git config merge.log true &&
=20
 	git checkout master &&
@@ -177,11 +176,6 @@ test_expect_success 'merge-msg command line option=
s #2' '
 	git diff actual msg.left.log
 '
=20
-test_expect_success 'merge-msg deprecated command line options' '
-	git fmt-merge-msg --summary <.git/FETCH_HEAD >actual &&
-	git diff actual msg.left.log
-'
-
 test_expect_success 'merge-msg command line option overrides config #1=
' '
 	git config merge.log true &&
=20
--=20
1.5.5.76.g546c
