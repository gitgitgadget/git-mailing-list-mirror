From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH] git-fetch.sh:append_fetch_head() no longer has a remote_nick argument
Date: Fri, 09 Mar 2007 16:21:14 +0100
Message-ID: <87zm6mfno5.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 09 16:21:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPgu6-0008WC-0a
	for gcvg-git@gmane.org; Fri, 09 Mar 2007 16:21:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993105AbXCIPVF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 9 Mar 2007 10:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993118AbXCIPVF
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 10:21:05 -0500
Received: from ifae-s0.ifae.es ([192.101.162.68]:43121 "EHLO ifae-s0.ifae.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2993105AbXCIPVD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 10:21:03 -0500
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id l29FL0n21541
	for <git@vger.kernel.org>; Fri, 9 Mar 2007 16:21:00 +0100
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.95 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41797>


Used in the fetch_dumb function.

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 git-fetch.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-fetch.sh b/git-fetch.sh
index 58cbef1..e56ba14 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -278,7 +278,7 @@ fetch_dumb () {
       esac
=20
       append_fetch_head "$head" "$remote" \
-	  "$remote_name" "$remote_nick" "$local_name" || exit
+	  "$remote_name" "$local_name" || exit
=20
   done
=20
--=20
1.5.0.3.927.g2432c
