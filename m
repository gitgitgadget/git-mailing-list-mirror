From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] builtin/ff-refs.c: mark some file-local variables static
Date: Wed, 25 Nov 2015 22:01:50 +0000
Message-ID: <56562FCE.7090007@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
To: rappazzo@gmail.com
X-From: git-owner@vger.kernel.org Wed Nov 25 23:02:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1i8x-0004ws-PQ
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 23:02:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138AbbKYWC0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Nov 2015 17:02:26 -0500
Received: from avasout08.plus.net ([212.159.14.20]:60015 "EHLO
	avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131AbbKYWCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 17:02:25 -0500
Received: from [10.0.2.15] ([146.200.5.254])
	by avasout08 with smtp
	id ly1s1r0025UqX4q01y1tKd; Wed, 25 Nov 2015 22:01:53 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bI7rW6KZ c=1 sm=1 tr=0
 a=GKs3PHufgjMgxBavMeQJCg==:117 a=GKs3PHufgjMgxBavMeQJCg==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=IkcTkHD0fZMA:10 a=9tszv2KlkPYPFglYk1MA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281746>


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Michael,

If you need to re-roll the patches in your 'mr/ff-refs' branch,
could you please squash parts of this patch into the relevant
patches from your branch.

Thanks.

Also, I note that gcc complains about the two calls to chdir().
(warning: ignoring return value of =E2=80=98chdir=E2=80=99, declared wi=
th
attribute warn_unused_result [-Wunused-result])

ATB,
Ramsay Jones

 builtin/ff-refs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/ff-refs.c b/builtin/ff-refs.c
index ae68cfb..db8c378 100644
--- a/builtin/ff-refs.c
+++ b/builtin/ff-refs.c
@@ -5,10 +5,10 @@
 #include "run-command.h"
 #include "worktree.h"
=20
-int dry_run =3D 0;
-int no_wt =3D 0;
-struct worktree **worktrees;
-const char *padding =3D ".............................................=
=2E.......";
+static int dry_run =3D 0;
+static int no_wt =3D 0;
+static struct worktree **worktrees;
+static const char *padding =3D "......................................=
=2E..............";
=20
 static const char * const builtin_ff_refs_usage[] =3D {
 	N_("git ff-refs [<options>]"),
--=20
2.6.0
