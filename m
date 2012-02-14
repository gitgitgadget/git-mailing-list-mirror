From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: =?UTF-8?q?=5BPATCH=5D=20man=3A=20rearrange=20git=20synopsis=20to=20fit=20in=2080=20lines?=
Date: Wed, 15 Feb 2012 00:54:21 +0100
Message-ID: <1329263661-20194-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Seymour <jon.seymour@gmail.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 15 00:54:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxSCj-0002Sx-MJ
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 00:54:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761382Ab2BNXyd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Feb 2012 18:54:33 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:52610 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757420Ab2BNXyc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 18:54:32 -0500
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1RxSCd-0002m0-ED; Wed, 15 Feb 2012 00:54:31 +0100
X-Mailer: git-send-email 1.7.9.6.ga1838.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190803>

The line was extended in 2dd8c3 ('git: add --info-path and --man-path
options'), and the formatted man output stopped fitting into the 80
column window.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
Just a small thing which I noticed when looking at git -p help --all
example used by Junio.

 Documentation/git.txt | 6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index c991430..2a5a756 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -9,11 +9,11 @@ git - the stupid content tracker
 SYNOPSIS
 --------
 [verse]
-'git' [--version] [--exec-path[=3D<path>]] [--html-path] [--man-path] =
[--info-path]
+'git' [--version] [--help] [-c <name>=3D<value>]
+    [--exec-path[=3D<path>]] [--html-path] [--man-path] [--info-path]
     [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]
     [--git-dir=3D<path>] [--work-tree=3D<path>] [--namespace=3D<name>]
-    [-c <name>=3D<value>]
-    [--help] <command> [<args>]
+    <command> [<args>]
=20
 DESCRIPTION
 -----------
--=20
1.7.9.6.ga1838.dirty
