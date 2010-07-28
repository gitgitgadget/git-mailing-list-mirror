From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] SubmittingPatches: Clarify the Signed-off-by rules
Date: Wed, 28 Jul 2010 14:12:59 +0000
Message-ID: <1280326379-10257-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 28 16:13:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe7Nl-0007SB-Pa
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 16:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754583Ab0G1ONM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 10:13:12 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36930 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754465Ab0G1ONK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 10:13:10 -0400
Received: by bwz1 with SMTP id 1so3973427bwz.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 07:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=ne5065yC30cibwldI+yWfwbgva6q7omYbjbZhjFhlXs=;
        b=SXdIXvZjVaTYtf8zvkpzdFYSR3+hUBCOouqR3J3UGRAJp4UnnuB8qnvLMo6w4CTDGg
         kDMswp1cPczDmfsYzHi3S3dkAPxeFL0uhjZY6u7W/uLE0AJF89fp8xtokqO4FYVKm2go
         MtbyyB86Y86pr33VCV41Tr9k49NIvNfnQHHIw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=OsFVSfWKOVbg19VYhdLXudCqa79DPxE/yoX4HSXat4VmPCJjgFwejbwIU/ak5RIDV5
         kVhVa2xiF3/LPEq+bBXidLCgSHsR/12nZpYUKDPrmldTgEc4wPMRob6NX+uAYdv7knxE
         xGSaVeRqevyctKGn8JSUDTSvRPnXGxY4kgwbg=
Received: by 10.204.7.217 with SMTP id e25mr8021374bke.32.1280326388945;
        Wed, 28 Jul 2010 07:13:08 -0700 (PDT)
Received: from localhost.localdomain (dslb-088-067-237-210.pools.arcor-ip.net [88.67.237.210])
        by mx.google.com with ESMTPS id bq20sm4813004bkb.16.2010.07.28.07.13.07
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 28 Jul 2010 07:13:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152090>

The wording of the Signed-off-by rules could be read as stating that
S-O-B should only be added when the submitter considered the patch
ready for inclusion in git.git.

We also want Signed-off-by to be used for e.g. RFC patches, in case
someone wants to dig an old patch out of the archive and improve
it. Change the wording to recommend a Signed-off-by for all submitted
patches.

The problem with the wording came up in the "[PATCH/RFC] Hacky version
of a glob() driven config include" thread[1]. Bert Wesarg suggested[2]
that it be removed to avoid confusion, which this change implements.

  1. <1273180440-8641-1-git-send-email-avarab@gmail.com>
  2. <AANLkTimziTKL13VKIOcaS1TX1F_xvTVjH8Q398Yx36Us@mail.gmail.com>

Suggested-by: Bert Wesarg <bert.wesarg@googlemail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Documentation/SubmittingPatches |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/Submitting=
Patches
index 099b238..ece3c77 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -14,11 +14,9 @@ Checklist (and a short version for the impatient):
 		  not "changed" or "changes".
 		- includes motivation for the change, and contrasts
 		  its implementation with previous behaviour
-	- if you want your work included in git.git, add a
-	  "Signed-off-by: Your Name <you@example.com>" line to the
-	  commit message (or just use the option "-s" when
-	  committing) to confirm that you agree to the Developer's
-	  Certificate of Origin
+	- add a "Signed-off-by: Your Name <you@example.com>" line to the
+	  commit message (or just use the option "-s" when committing)
+	  to confirm that you agree to the Developer's Certificate of Origin
 	- make sure that you have tests for the bug you are fixing
 	- make sure that the test suite passes after your commit
=20
--=20
1.7.0.4
