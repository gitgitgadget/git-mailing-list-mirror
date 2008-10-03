From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: rebase -i: remove leftover debugging
Date: Fri, 3 Oct 2008 11:33:20 +0200
Message-ID: <20081003093320.GF6839@neumann>
References: <1222992501-943-1-git-send-email-szeder@ira.uka.de>
	<20081003060110.GA4473@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 03 11:34:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Klh3W-0005Wz-1p
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 11:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289AbYJCJda convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Oct 2008 05:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753888AbYJCJda
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 05:33:30 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:56137 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753059AbYJCJd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 05:33:29 -0400
Received: from [127.0.1.1] (p5B1337F6.dip0.t-ipconnect.de [91.19.55.246])
	by mrelayeu.kundenserver.de (node=mrelayeu7) with ESMTP (Nemesis)
	id 0ML2xA-1Klh2G3pF8-0003pE; Fri, 03 Oct 2008 11:33:22 +0200
Content-Disposition: inline
In-Reply-To: <20081003060110.GA4473@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Provags-ID: V01U2FsdGVkX1/WS38GZVtDI7GkB+GuxuHwl/rBY1zserAEGcU
 JwnNK/DPch6LtGa17SkeURpSB/oU7cCIRJEY36bIXxIQBM3zGS
 Ki2mhUFo8KFHW/dSj1L9A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97406>

Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>
---
On Fri, Oct 03, 2008 at 02:01:10AM -0400, Jeff King wrote:
> Sorry, but "cp -v" is not portable. It's not in POSIX, and this break=
s
> the script for (at least) Solaris.
>=20
> However, it's not even clear to me why "-v" is used at all, consideri=
ng
> that the "squash" case above does not use it. Is it a debugging
> leftover? Am I missing something?
Oh, yeah, it's just leftover debugging.  Thanks for catching.


 git-rebase--interactive.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 77e1132..ec4299a 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -322,7 +322,7 @@ do_next () {
 			MSG_OPT=3D
 			MSG_FILE=3D
 			rm -f "$SQUASH_MSG" || exit
-			cp -v "$MSG" "$GIT_DIR"/SQUASH_MSG
+			cp "$MSG" "$GIT_DIR"/SQUASH_MSG
 			rm -f "$GIT_DIR"/MERGE_MSG || exit
 			;;
 		esac
--=20
1.6.0.2.430.gfc53
