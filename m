From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: [PATCH v2] git-checkout.txt: Document "git checkout <pathspec>"
 better
Date: Wed, 17 Jun 2015 09:54:51 +0200
Message-ID: <558127CB.70603@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de, eda@waniasset.com, i.grok@comcast.net,
	pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 17 09:55:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z58Bj-0001Us-6Y
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 09:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757827AbbFQHzH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Jun 2015 03:55:07 -0400
Received: from mout.web.de ([212.227.15.4]:52297 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757724AbbFQHzC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 03:55:02 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0MgOUY-1ZSrIc3E50-00Nf1N; Wed, 17 Jun 2015 09:54:56
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.0.1
X-Provags-ID: V03:K0:s7qmfD15w3dIUSlqz4cWiOe1IczmCJxc0ajFRzwFUub7OlegAbx
 XHTYjVH49+c+90mrBcd8FTy/d2XoocW/R8DM3CUIUrHWNu7+STUVdGQDcdFm6Saz/4u1Q9R
 6mM1MfJnYX4jQGYbkqzckN6vWbGPedg9lKIzTFpxTfDdGc38Xoa3+0GtQ0d95OaVq5TANMx
 YzevGav8CMkALnhQRaGmA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+PzeYmcATNI=:UKDXOSvCwpi3FQTi5bw3Xx
 7usQKpouVo/DUEBgkNmShHCjsDvPSaL9afUov4G4RgCkr5IVER8s7kq5yuydlRob+6v6n4Ct8
 5jB8xeGM77Vm/FNSqFTEbI6HxM/cFMA7kCvm23+3xCLUiVkNOeNlILI6PoQc3ARF+ofPFyFO/
 iqSt19FpS9NiXO+BkYejxo88fOGcTIbhq8DfcXYvRIyWQMZyWDPq7hi4eptWo8Rnav0Z9o7jj
 xkNnEP5fKUehb4f5RpIUp1Q7eUAdemxEsurvp5O83DreOiDkbcF+YuYlXxfHnnsx47tMAQwlW
 n+svXfSbyYvskKevDDjprXni+3bNOz8KCD3Pd25Lc7d+m6dlViK5sLrK4fb10a14p5+zpYOxB
 Bnlm6VPl9muBLe1zZ1/G7cBOwLQ9h12kaFQ82rTz9PrR/jgR4HIYHJm8ETQBXC/rm8HQapfY9
 /ehTJihyhOLZY1L0Bj6EuQRql7SC7k+F9yxecRiP/f/Jw0b94bcAyBgx8lqFIdXxadru/iR4k
 sJVZckKMCW/hZI85xjmgqBCFwxCVZX6oNc6Iro7huXwuP3CANz4IMSh66d9LXK6SDs73khwqE
 tdcjtuLwZMpZk3CTN9b27j4PFIWTgfjMNb1QeCHejhHlOKqPtyOX7Cp71CSwPOJpCkxv3waoa
 Lh1x4gVj/4ibIBJkyMOhGeogHh0Jdj9c78YLiNuehk8u7YpRG6vgvYXsIPh4PQnGa5Kg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271812>

git checkout <pathspec> can be used to reset changes in the working tre=
e.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
Version 2: Try to summarize the suggestions from the mailing list
 Documentation/git-checkout.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index d263a56..39ad36f 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -3,7 +3,7 @@ git-checkout(1)
  NAME
 ----
-git-checkout - Checkout a branch or paths to the working tree
+git-checkout - Switch branches or restore changes
  SYNOPSIS
 --------
@@ -89,6 +89,10 @@ Omitting <branch> detaches HEAD at the tip of the cu=
rrent branch.
 	(i.e.  commit, tag or tree) to update the index for the given
 	paths before updating the working tree.
 +
+'git checkout' with <paths> or `--patch` is used to restore modified o=
r
+deleted paths to their original contents from the index or replace pat=
hs
+with the contents from a named <tree-ish> (most often a commit-ish).
++
 The index may contain unmerged entries because of a previous failed me=
rge.
 By default, if you try to check out such an entry from the index, the
 checkout operation will fail and nothing will be checked out.
--=20
2.2.0.rc1.790.ge19fcd2
