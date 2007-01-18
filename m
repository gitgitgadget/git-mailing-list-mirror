From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [PATCH] Document --ignore-if-in-upstream in git-format-patch
Date: Thu, 18 Jan 2007 12:27:35 +0100
Message-ID: <8764b4fuc8.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Jan 18 12:28:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7VR3-0005Nl-Pa
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 12:28:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029AbXARL1y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 18 Jan 2007 06:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752033AbXARL1y
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 06:27:54 -0500
Received: from main.gmane.org ([80.91.229.2]:36872 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752029AbXARL1x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 06:27:53 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H7VQp-0002QU-H9
	for git@vger.kernel.org; Thu, 18 Jan 2007 12:27:47 +0100
Received: from vtab.com ([62.20.90.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Jan 2007 12:27:47 +0100
Received: from davidk by vtab.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Jan 2007 12:27:47 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: vtab.com
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:NstgdzYzv0q9cfDs0cLXeGJgSts=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37080>


---
 Documentation/git-format-patch.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

I looked at the code, and tried to guess what it actually did.  This
documentation doesn't really explain how or why it's supposed to be
used.

Someone who knows how it *actually* works is encouraged to send a
better explanation.

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-for=
mat-patch.txt
index 67425dc..3ad0fcd 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -12,6 +12,7 @@ SYNOPSIS
 'git-format-patch' [-n | -k] [-o <dir> | --stdout] [--attach] [--threa=
d]
 	           [-s | --signoff] [--diff-options] [--start-number <n>]
 		   [--in-reply-to=3DMessage-Id]
+		   [--ignore-if-in-upstream]
 		   <since>[..<until>]
=20
 DESCRIPTION
@@ -78,6 +79,11 @@ OPTIONS
 	reply to the given Message-Id, which avoids breaking threads to
 	provide a new patch series.
=20
+--ignore-if-in-upstream::
+	Do not include the same patch twice.  If there are two commits
+	that would produce identical patches, the second one is
+	excluded from the output.
+
 CONFIGURATION
 -------------
 You can specify extra mail header lines to be added to each
--=20
1.5.0.rc1.g04f3-dirty


--=20
David K=C3=A5gedal
