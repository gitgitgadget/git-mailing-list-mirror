From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH] git-checkout.txt: Document "git checkout <pathspec>" better
Date: Mon, 08 Jun 2015 22:21:28 +0200
Message-ID: <5575F948.4060400@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de, eda@waniasset.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 08 22:21:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z23YB-0006US-BA
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 22:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753434AbbFHUVe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jun 2015 16:21:34 -0400
Received: from mout.web.de ([212.227.15.4]:52029 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752895AbbFHUVd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 16:21:33 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0LgYdx-1ZMUk03Gpp-00o1f6; Mon, 08 Jun 2015 22:21:29
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
X-Provags-ID: V03:K0:N/9coaz34kMh5n9hxjv6ZX8NqfkWGmz5B5ZMr4IQqMcCypHfkvD
 OQf+P6M7zXfYmOUaLN66lyuBSoGB5Alqg6CSBadS9R2g9Pj5epw2Ju+1iN10I1HfalXTnq4
 aK+iyhVmV4ESi6+g2uPLPgBel2JFH7zx+4c2cEXJOvyZ73ZOuSiK6OvtO/Bqy3Z4MB+M2lK
 /Lu3+ems8n0Ru/cSC7t6A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RbHSiK91MKc=:241oOhdARmgFpzSZB4JnGN
 C421mc+OFqva8S4pppAEKIhXRO0iu1BL1VPucvF6XW58WylMeMVtioFPeuwkuLgbKwJR1YGnR
 wljMxRRji0V+pdb1w4q40/fkLfTl/SkN4vbXJ7DJu1OdmDFyI8HC57Nf1V6HgLSideWTty3xt
 E4m2XD8x+gBY7TWQqN1LJS3ok8K3mPypDBR8h2xVoyZA0Ds8vdSL8iblP4oH1bSjlM8P0WhRo
 bag5KKpsal14uwZiVSJTFIbT0wT0dopAKlRnT54Y7WQeo4nCjSE4YSLSUhYO7qFSVv9FrLOgP
 zMRljviKl8o5abUz5NlOyhPGu/jd0cbUS2nHkAfmEtMJovP8tFd3rhvR+8lKjSRd4fHpe5LCb
 yUr1OESaypoVl2eWvXGQswJx/XCB0/As4Df+KvJ2qRGxz0PjtA3Tv0zqCtxNxh5YIMM++pTYs
 pA6VDG+Xl6DnNLxrQjFqZl3PQa8RXTE7lL1uvo3gB2nfdkKStY3rX/iu+YXovvstdeRszkhqd
 PUFMJYcEUmPFLJnh6rVglBSlm/YQdSFLsc+yCCAtaTBZXcruZgzOxKBO4VkKZ9sPr82l+I6v/
 ZJt/EVbpGie+YDx54y+dbcoLpuW52aNRBUWUITxmW4oAE/vWTF53Mljj6IsuxhX3adHkGrV5v
 R9mHuVBLaDoSpG+I9KWB3L/05apSpNq1odtdYjBpEQkFjTDQ+5xl5Q6gZHKgWiTB7gLU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271124>

git checkout <pathspec> can be used to revert changes in the working tr=
ee.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
My first attempt to improve the documentation

 Documentation/git-checkout.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index d263a56..8cd018a 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -3,7 +3,7 @@ git-checkout(1)
=20
 NAME
 ----
-git-checkout - Checkout a branch or paths to the working tree
+git-checkout - Switch branches or reverts changes in the working tree
=20
 SYNOPSIS
 --------
@@ -83,7 +83,8 @@ Omitting <branch> detaches HEAD at the tip of the cur=
rent branch.
 	When <paths> or `--patch` are given, 'git checkout' does *not*
 	switch branches.  It updates the named paths in the working tree
 	from the index file or from a named <tree-ish> (most often a
-	commit).  In this case, the `-b` and `--track` options are
+	commit).  Changes in files are discarded and deleted files are
+	restored. In this case, the `-b` and `--track` options are
 	meaningless and giving either of them results in an error.  The
 	<tree-ish> argument can be used to specify a specific tree-ish
 	(i.e.  commit, tag or tree) to update the index for the given
--=20
2.2.0.rc1.790.ge19fcd2
