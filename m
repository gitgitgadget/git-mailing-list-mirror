From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH] t/t5515-fetch-merge-logic.sh: Add two more tests
Date: Wed, 07 Mar 2007 13:18:59 +0100
Message-ID: <87k5xt5jrg.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 07 13:18:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOv6c-00024x-Gl
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 13:18:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbXCGMSv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 7 Mar 2007 07:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbXCGMSv
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 07:18:51 -0500
Received: from ifae-s0.ifae.es ([192.101.162.68]:40169 "EHLO ifae-s0.ifae.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751216AbXCGMSu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 07:18:50 -0500
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id l27CIlw29871
	for <git@vger.kernel.org>; Wed, 7 Mar 2007 13:18:48 +0100
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.95 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41665>


They test the behaviour with just a URL in the command line.

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 t/t5515-fetch-merge-logic.sh      |    1 +
 t/t5515/fetch.br-unconfig_.._.git |    2 ++
 t/t5515/fetch.master_.._.git      |    2 ++
 3 files changed, 5 insertions(+), 0 deletions(-)
 create mode 100644 t/t5515/fetch.br-unconfig_.._.git
 create mode 100644 t/t5515/fetch.master_.._.git

diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.s=
h
index 765c83f..0b600bb 100755
--- a/t/t5515-fetch-merge-logic.sh
+++ b/t/t5515-fetch-merge-logic.sh
@@ -114,6 +114,7 @@ done >> tests
 # neither in the Pull: or .fetch config
 for branch in master br-unconfig ; do
     cat <<EOF
+$branch ../.git
 $branch ../.git one
 $branch ../.git one two
 $branch --tags ../.git
diff --git a/t/t5515/fetch.br-unconfig_.._.git b/t/t5515/fetch.br-uncon=
fig_.._.git
new file mode 100644
index 0000000..284bb1f
--- /dev/null
+++ b/t/t5515/fetch.br-unconfig_.._.git
@@ -0,0 +1,2 @@
+# br-unconfig ../.git
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b		../
diff --git a/t/t5515/fetch.master_.._.git b/t/t5515/fetch.master_.._.gi=
t
new file mode 100644
index 0000000..66d1aad
--- /dev/null
+++ b/t/t5515/fetch.master_.._.git
@@ -0,0 +1,2 @@
+# master ../.git
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b		../
--=20
1.5.0.3.897.g91a70-dirty
