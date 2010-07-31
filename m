From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] test-lib: Remove 3 year old no-op --no-python option
Date: Sat, 31 Jul 2010 16:49:53 +0000
Message-ID: <1280594993-2481-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 31 18:50:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfFGG-0003AT-D9
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 18:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754994Ab0GaQuE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 12:50:04 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45888 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446Ab0GaQuD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 12:50:03 -0400
Received: by wyb39 with SMTP id 39so2088677wyb.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 09:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=4v/4tR6/T8DyezJfRuu9EadIQwZ3H6QLiM6qHpBjV0Y=;
        b=oxR0F4dpTflonTKDVx/cstPrBT/09weHEpaTWP0rvoybp1H+8HlcQ7KafLwN3WvENX
         87zeVObwFeWogOmYAnoQhIXYMD7K1YJh4Ku0ttN4yAoDT0MeHcKMx9bCkz7FceoZeinj
         u3U8BRdck6U4k4OZkzRYXWfyeOLwFRgNORbV8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=cLYVlLRnuO1Jz4UZkZIiQBjD0nVVKUE914StUEa1iFlzhr+Lo/BDFWT4SxW/xz9lnJ
         J3zaCNjtm//BR4Ue1SflRpi1UQ1AbJkwmZM/AIBdF+C/8VmDtRSVhBy0rnkOi1bi+L2w
         1wMDNfRMLuhNb4bZsFGzo63fjGYo6Nn9VDD9g=
Received: by 10.216.45.15 with SMTP id o15mr2936555web.111.1280595002014;
        Sat, 31 Jul 2010 09:50:02 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id j1sm1835091wej.39.2010.07.31.09.49.59
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 31 Jul 2010 09:50:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152333>

The --no-python option was added to test-lib.sh by Johannes Schindelin
in early 2006 in abb7c7b3. It was later turned into a no-op by Junio C
Hamano in 7cdbff14 the same year.

Over three years is long enough before removing this old wart which
was retained for backwards compatibility. Our tests have been using
NO_PYTHON and "test_have_prereq PYTHON" for a long time now.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/test-lib.sh |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index e5523dd..e151da6 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -132,9 +132,6 @@ do
 		with_dashes=3Dt; shift ;;
 	--no-color)
 		color=3D; shift ;;
-	--no-python)
-		# noop now...
-		shift ;;
 	--va|--val|--valg|--valgr|--valgri|--valgrin|--valgrind)
 		valgrind=3Dt; verbose=3Dt; shift ;;
 	--tee)
--=20
1.7.1
