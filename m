From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] =?UTF-8?q?.mailmap:=20Entries=20for=20Alex=20Benn=C3=A9e,=20Deskin=20Miller,=20Vitaly=20"=5FVi"=20Shukela?=
Date: Fri, 19 Mar 2010 12:02:04 +0100
Message-ID: <cd13e44f33c1f6bc9ec11903c3041199c9c464ee.1268996321.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 19 12:04:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsa0g-0003hk-F7
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 12:04:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228Ab0CSLEw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Mar 2010 07:04:52 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:52990 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751068Ab0CSLEv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Mar 2010 07:04:51 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 96DA9E9A64;
	Fri, 19 Mar 2010 07:04:50 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 19 Mar 2010 07:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding; s=smtpout; bh=u9W3ycLSwBWWJp0uT5+GIJTJaNs=; b=VotqCWgDmGM2rElQZqPZDrWPWfG2d1vqajcfVy+5HQUKfCGrgpBfviZ7XOaDVDRMV8gMKWTt9jCPvPfNLTgGIKBSgEnswnTEfBPyUs7XgKtq9YP/2U5EoFyb3GO6w9Bu6HdOxKhMq3zeY56va+DYUV6/ZY75T+s3xvmL7PCAaPE=
X-Sasl-enc: EJxjSXvWOmDPjddSViGmAluXws/WHz+b1a1t5mSVoRvL 1268996689
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id EB2834936;
	Fri, 19 Mar 2010 07:04:49 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.2.358.g30511
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142574>

With the current .mailmap, git shortlog shows the following for these:

    11	Deskin Miller
     3	Vitaly \"_Vi\" Shukela
     1	Alex Bennee
     1	Alex Benn=C3=A9e
     1	Deskin Miler
     1	Vitaly _Vi Shukela

Add (e-mail based qualified) entries to .mailmap to get:

    12	Deskin Miller
     4	Vitaly "_Vi" Shukela
     2	Alex Benn=C3=A9e

The Shukela spelling is based on the version used consistently in the s=
-o-b
lines of all his patches.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Sparked by the recent discussion on uuid etc. I did a few (manual) chec=
ks.
There seem to be 4 remaining "problematic" cases (Elrond, jidanni,
Kirill, Twiinz) but 3 are unique, and I don't think we strictly require
full names. Kirill may be one of several other Kirills.

http://repo.or.cz/w/git/mjg.git/commit/cd13e44f33c1f6bc9ec11903c3041199=
c9c464ee

(branch typo-fixes) in case of encoding problems

 .mailmap |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/.mailmap b/.mailmap
index 975e675..c507309 100644
--- a/.mailmap
+++ b/.mailmap
@@ -5,6 +5,7 @@
 # same person appearing not to be so.
 #
=20
+Alex Benn=C3=A9e <kernel-hacker@bennee.com>
 Alexander Gavrilov <angavrilov@gmail.com>
 Aneesh Kumar K.V <aneesh.kumar@gmail.com>
 Brian M. Carlson <sandals@crustytoothpaste.ath.cx>
@@ -15,6 +16,7 @@ Daniel Barkalow <barkalow@iabervon.org>
 David D. Kilzer <ddkilzer@kilzer.net>
 David K=C3=A5gedal <davidk@lysator.liu.se>
 David S. Miller <davem@davemloft.net>
+Deskin Miller <deskinm@umich.edu>
 Dirk S=C3=BCsserott <newsletter@dirk.my1.cc>
 Fredrik Kuivinen <freku045@student.liu.se>
 H. Peter Anvin <hpa@bonde.sc.orionmulti.com>
@@ -59,6 +61,7 @@ Uwe Kleine-K=C3=B6nig <ukleinek@informatik.uni-freibu=
rg.de>
 Uwe Kleine-K=C3=B6nig <uzeisberger@io.fsforth.de>
 Uwe Kleine-K=C3=B6nig <zeisberg@informatik.uni-freiburg.de>
 Ville Skytt=C3=A4 <scop@xemacs.org>
+Vitaly "_Vi" Shukela <public_vi@tut.by>
 William Pursell <bill.pursell@gmail.com>
 YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
 anonymous <linux@horizon.com>
--=20
1.7.0.2.358.g30511
