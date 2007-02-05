From: =?us-ascii?B?PT91dGYtOD9xP1V3ZV9LbGVpbmUtSz1DMz1CNm5pZz89?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: [PATCH] add replay and log to the usage string of git-bisect
Date: Mon, 5 Feb 2007 23:21:18 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070205222118.GA5357@lala>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 05 23:21:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HECDc-0004c0-EL
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 23:21:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbXBEWVY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 5 Feb 2007 17:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbXBEWVX
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 17:21:23 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:62398 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964923AbXBEWVW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Feb 2007 17:21:22 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HECDB-0004WV-Iw
	for git@vger.kernel.org; Mon, 05 Feb 2007 23:21:21 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id l15MLJIm028687
	for <git@vger.kernel.org>; Mon, 5 Feb 2007 23:21:19 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11/Submit) id l15MLIho028686
	for git@vger.kernel.org; Mon, 5 Feb 2007 23:21:18 +0100 (MET)
Mail-Followup-To: =?us-ascii?B?PT91dGYtOD9xP1V3ZV9LbGVpbmUtSz1DMz1CNm5p?=
	=?us-ascii?B?Zz89?= <ukleinek@informatik.uni-freiburg.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38794>

Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.de>
---
 git-bisect.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index e8d3418..382c291 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
=20
-USAGE=3D'[start|bad|good|next|reset|visualize]'
+USAGE=3D'[start|bad|good|next|reset|visualize|replay|log]'
 LONG_USAGE=3D'git bisect start [<pathspec>]	reset bisect state and sta=
rt bisection.
 git bisect bad [<rev>]		mark <rev> a known-bad revision.
 git bisect good [<rev>...]	mark <rev>... known-good revisions.
--=20
1.5.0.rc2.gb4df


--=20
Uwe Kleine-K=F6nig
