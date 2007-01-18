From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [PATCH] Shell syntax fix in git-reset
Date: Thu, 18 Jan 2007 12:15:13 +0100
Message-ID: <87ac0gfuwu.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Jan 18 12:16:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7VFu-0002Wc-0z
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 12:16:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbXARLQ2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 18 Jan 2007 06:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751990AbXARLQ2
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 06:16:28 -0500
Received: from main.gmane.org ([80.91.229.2]:42896 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751023AbXARLQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 06:16:27 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H7VFF-00089k-Gu
	for git@vger.kernel.org; Thu, 18 Jan 2007 12:15:49 +0100
Received: from vtab.com ([62.20.90.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Jan 2007 12:15:49 +0100
Received: from davidk by vtab.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Jan 2007 12:15:49 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: vtab.com
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:ToKOFMHbDjjlC4BlWP57N+g+Qpk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37079>


---
 git-reset.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

My /bin/sh is a symlink to dash, which is probably why I got this and
few others.

diff --git a/git-reset.sh b/git-reset.sh
index bf2a058..fee6d98 100755
--- a/git-reset.sh
+++ b/git-reset.sh
@@ -43,7 +43,7 @@ case "$1" in --) shift ;; esac
 # affecting the working tree nor HEAD.
 if test $# !=3D 0
 then
-	test "$reset_type" =3D=3D "--mixed" ||
+	test "$reset_type" =3D "--mixed" ||
 		die "Cannot do partial $reset_type reset."
=20
 	git-diff-index --cached $rev -- "$@" |
--=20
1.5.0.rc1.g04f3-dirty


--=20
David K=C3=A5gedal
