From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH 3/4] apply: Format all options using back-quotes
Date: Sun, 22 Nov 2009 20:43:53 +0100
Message-ID: <4B099479.7060305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 22 20:44:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCILp-0005zK-Q5
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 20:44:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753991AbZKVTnu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Nov 2009 14:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753970AbZKVTnu
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 14:43:50 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:52054 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846AbZKVTnt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 14:43:49 -0500
Received: by mail-ew0-f219.google.com with SMTP id 19so1206009ewy.21
        for <git@vger.kernel.org>; Sun, 22 Nov 2009 11:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=Rbghz/GFvsxmOFMtK7dS1SuYUXwTNs7jlWq36WrTYYs=;
        b=oB2SvuTOk56xfQuKtIM+okrW5Mh24szyufKXB8jMVkWSsQc4Tm4nB8WA9a1Ai70F76
         vnwYRJeNC3YebGWtiDlKyLisNxuPut/88CMwgl+N2xWo+TtT9IHzYuoDSyMVGo5+lt1t
         uM3/F3/1E6djVoOW7NRwGjwJylyoYSsW71niQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=aRZS/D+8P41L4QniZ26p8r9aEeXZRaQtS1LFqJKWezg6tx9AlUzL9sy/wSh5kgo6HO
         47CS/AMeGOPUXAh/Sl/ZokNQocQAW1t/21P0SJnKNV19Qnn/KVgkwb3Vrm8r93DWZmY4
         ZMpNA3d9M6g7zIMtLjZFB+LjQEFmdH/LZytUI=
Received: by 10.213.0.197 with SMTP id 5mr2689788ebc.93.1258919035285;
        Sun, 22 Nov 2009 11:43:55 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 10sm865921eyd.45.2009.11.22.11.43.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Nov 2009 11:43:54 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133453>

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 Documentation/git-apply.txt |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 0c55ca9..6a07ec2 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -37,7 +37,7 @@ OPTIONS
 	input.  Turns off "apply".
=20
 --numstat::
-	Similar to \--stat, but shows the number of added and
+	Similar to `--stat`, but shows the number of added and
 	deleted lines in decimal notation and the pathname without
 	abbreviation, to make it more machine friendly.  For
 	binary files, outputs two `-` instead of saying
@@ -55,7 +55,7 @@ OPTIONS
 	file and detects errors.  Turns off "apply".
=20
 --index::
-	When --check is in effect, or when applying the patch
+	When `--check` is in effect, or when applying the patch
 	(which is the default when none of the options that
 	disables it is in effect), make sure the patch is
 	applicable to what the current index file records.  If
@@ -66,7 +66,7 @@ OPTIONS
 --cached::
 	Apply a patch without touching the working tree. Instead take the
 	cached data, apply the patch, and store the result in the index
-	without using the working tree. This implies '--index'.
+	without using the working tree. This implies `--index`.
=20
 --build-fake-ancestor=3D<file>::
 	Newer 'git-diff' output has embedded 'index information'
@@ -112,8 +112,8 @@ any of those replacements occurred.
 	By default, 'git-apply' expects that the patch being
 	applied is a unified diff with at least one line of context.
 	This provides good safety measures, but breaks down when
-	applying a diff generated with --unified=3D0. To bypass these
-	checks use '--unidiff-zero'.
+	applying a diff generated with `--unified=3D0`. To bypass these
+	checks use `--unidiff-zero`.
 +
 Note, for the reasons stated above usage of context-free patches is
 discouraged.
@@ -149,7 +149,7 @@ discouraged.
 	be useful when importing patchsets, where you want to include certain
 	files or directories.
 +
-When --exclude and --include patterns are used, they are examined in t=
he
+When `--exclude` and `--include` patterns are used, they are examined =
in the
 order they appear on the command line, and the first match determines =
if a
 patch to each path is used.  A patch to a path that does not match any
 include/exclude pattern is used by default if there is no include patt=
ern
@@ -232,13 +232,13 @@ Submodules
 If the patch contains any changes to submodules then 'git-apply'
 treats these changes as follows.
=20
-If --index is specified (explicitly or implicitly), then the submodule
+If `--index` is specified (explicitly or implicitly), then the submodu=
le
 commits must match the index exactly for the patch to apply.  If any
 of the submodules are checked-out, then these check-outs are completel=
y
 ignored, i.e., they are not required to be up-to-date or clean and the=
y
 are not updated.
=20
-If --index is not specified, then the submodule commits in the patch
+If `--index` is not specified, then the submodule commits in the patch
 are ignored and only the absence or presence of the corresponding
 subdirectory is checked and (if possible) updated.
=20
--=20
1.6.5.3.298.g39add
