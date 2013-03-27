From: Christian Helmuth <christian.helmuth@genode-labs.com>
Subject: [PATCH] Enhance git-commit doc for multiple `-m` options
Date: Wed, 27 Mar 2013 15:19:35 +0100
Organization: Genode Labs
Message-ID: <20130327141935.GE2940@genode-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 27 15:28:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKrLM-0001LC-NQ
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 15:28:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411Ab3C0O2V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Mar 2013 10:28:21 -0400
Received: from static.88-198-56-169.clients.your-server.de ([88.198.56.169]:37981
	"EHLO mail.genode-labs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751766Ab3C0O2U (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Mar 2013 10:28:20 -0400
X-Greylist: delayed 515 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Mar 2013 10:28:20 EDT
Received: by mail.genode-labs.com (Postfix, from userid 1001)
	id 6970A1D436F; Wed, 27 Mar 2013 15:19:43 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on mail.genode-labs.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.1
Received: from localhost (drsd-4dbd90b1.pool.mediaWays.net [77.189.144.177])
	by mail.genode-labs.com (Postfix) with ESMTPSA id 8C8841D41F6
	for <git@vger.kernel.org>; Wed, 27 Mar 2013 15:19:42 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219251>

The text is copied from Documentation/git-tag.txt.

Signed-off-by: Christian Helmuth <christian.helmuth@genode-labs.com>
---
 Documentation/git-commit.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.tx=
t
index 24a99cc..05f8297 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -137,6 +137,8 @@ OPTIONS
 -m <msg>::
 --message=3D<msg>::
 	Use the given <msg> as the commit message.
+	If multiple `-m` options are given, their values are
+	concatenated as separate paragraphs.
=20
 -t <file>::
 --template=3D<file>::
--=20
1.8.1.5


--=20
Christian Helmuth
Genode Labs

http://www.genode-labs.com/ =C2=B7 http://genode.org/
https://twitter.com/GenodeLabs =C2=B7 /=CB=88d=CA=92i=CB=90.n=C9=99=CA=8A=
d/

Genode Labs GmbH =C2=B7 Amtsgericht Dresden =C2=B7 HRB 28424 =C2=B7 Sit=
z Dresden
Gesch=C3=A4ftsf=C3=BChrer: Dr.-Ing. Norman Feske, Christian Helmuth
