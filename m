From: =?UTF-8?q?Lawrence=20Vel=C3=A1zquez?= <vq@larryv.me>
Subject: [PATCH] git-svn.txt: Remove mentions of repack options
Date: Thu,  4 Sep 2014 23:46:25 -0400
Message-ID: <1409888785-56341-1-git-send-email-vq@larryv.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 05 05:46:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPkUD-0005a7-EC
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 05:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753996AbaIEDqx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Sep 2014 23:46:53 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55170 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751999AbaIEDqw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Sep 2014 23:46:52 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by gateway2.nyi.internal (Postfix) with ESMTP id 0FDBB208DB;
	Thu,  4 Sep 2014 23:46:52 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 04 Sep 2014 23:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=larryv.me; h=from
	:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=mesmtp; bh=f3nqHABXa0F3dgi3pYDrTh1
	al48=; b=utW02w8fKNFOeO4nLhxmyHb9nrn3TiPmp208QumkhcGmbG4uTmqg1I6
	JQlK95T5HaLt/5Za1Bzf+cp5ew3HcSA8z8pkPuDYE/2bccykfkHO4EtlpExQh9lq
	EztPVZOvO4kgs8s1hTbzB2MTprjjPTi71FZLP/fTpkUNchKSpM3w=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=smtpout;
	 bh=f3nqHABXa0F3dgi3pYDrTh1al48=; b=GboPhrOGbu/GFP5jpy/BkadVdExE
	aTae5MW5HKfyebGY0Gu0qkk8VxhcV40TG2uvE6pGieD+z95hhAPaSGgZ3Awbq2kD
	Fah8cHpvxJ3hlZdKE3uLQa1gxPBw7uiGHI7kNs5rIlDd65Itx8ASgQPsdjPVA+Hw
	Wer4oSc+DoIcyMI=
X-Sasl-enc: i9lo166IpUNdV/u6ximqoUFjtlSb8rxc8F4GJfK1B5/R 1409888811
Received: from localhost.localdomain (unknown [108.29.181.142])
	by mail.messagingengine.com (Postfix) with ESMTPA id D5E5EC00919;
	Thu,  4 Sep 2014 23:46:51 -0400 (EDT)
X-Mailer: git-send-email 2.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256499>

Git no longer seems to use these flags or their associated config keys;
when they are present, git-svn outputs a message indicating that they
are being ignored.

Signed-off-by: Lawrence Vel=C3=A1zquez <vq@larryv.me>
---
 Documentation/git-svn.txt | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 44c970c..14036cf 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -608,21 +608,6 @@ config key: svn.authorsfile
 	Make 'git svn' less verbose. Specify a second time to make it
 	even less verbose.
=20
---repack[=3D<n>]::
---repack-flags=3D<flags>::
-	These should help keep disk usage sane for large fetches with
-	many revisions.
-+
---repack takes an optional argument for the number of revisions
-to fetch before repacking.  This defaults to repacking every
-1000 commits fetched if no argument is specified.
-+
---repack-flags are passed directly to 'git repack'.
-+
-[verse]
-config key: svn.repack
-config key: svn.repackflags
-
 -m::
 --merge::
 -s<strategy>::
--=20
2.1.0
