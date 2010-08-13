From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 05/10] t/t9001-send-email.sh: Remove needless PROG=* assignment
Date: Fri, 13 Aug 2010 20:40:08 +0000
Message-ID: <1281732013-18284-6-git-send-email-avarab@gmail.com>
References: <1281732013-18284-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 13 22:41:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok147-0007V9-MW
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 22:41:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755980Ab0HMUlL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 16:41:11 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:52144 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755793Ab0HMUlH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 16:41:07 -0400
Received: by ewy23 with SMTP id 23so1555183ewy.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 13:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=4Tt/iN0ahDH1L5dAWQyWYmkLszeH14mT3lKaPPgpP5M=;
        b=bQ29chIIzt8UBLdceOPPMhaa+2mLp0H0ytrV70vwjT/JoGf6mBdHm7Oe6wxTrdBFoV
         /dUwO8fDqExutvJN5ZPbRUBOEp1dKnqiXioIA3pURRxyqkbwCqBiUq2nrE1ph6Di8Lku
         vSKxp9LNonlzPkrRd60c8EZWbnhmT7213RBBI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Pp5eYv5yQi7lPJjOHWAspK70LP18Uc1odPlbqYLHIri3aYU32HoOF0oTlDSgWH9rbp
         yqNvl1l49Nk38hDNRiC3lc1DM1IXrBETMQVdX0ia1GOS1jgHTIIVrqtpoNGl+M2FDFQF
         SxSk+s1idFmZD3QEaioYKgelAeoxNKktLHVpY=
Received: by 10.216.10.77 with SMTP id 55mr1765809weu.17.1281732066013;
        Fri, 13 Aug 2010 13:41:06 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e8sm1838298wej.46.2010.08.13.13.41.04
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 13 Aug 2010 13:41:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.338.gf2379
In-Reply-To: <1281732013-18284-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153498>

Remove the PROG=3D* assignment from t9001-send-email.sh. It's been ther=
e
since v1.4.0-rc1~30 when the test was originally added, but only tests
that source annotate-tests.sh need it, it was seemingly introduced to
this test via copy/paste coding.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t9001-send-email.sh |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 23597cc..6525d1d 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -8,7 +8,6 @@ if ! test_have_prereq PERL; then
 	test_done
 fi
=20
-PROG=3D'git send-email'
 test_expect_success \
     'prepare reference tree' \
     'echo "1A quick brown fox jumps over the" >file &&
--=20
1.7.2.1.338.gf2379
