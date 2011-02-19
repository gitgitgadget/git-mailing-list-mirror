From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 41/72] gettextize: git-merge "You have not concluded your merge" messages
Date: Sat, 19 Feb 2011 19:24:24 +0000
Message-ID: <1298143495-3681-42-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:30:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsVK-00042j-Vc
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:30:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756373Ab1BST34 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:29:56 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:60431 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756027Ab1BST2B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:28:01 -0500
Received: by mail-ew0-f46.google.com with SMTP id 5so1970440ewy.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=ntwofPkYO2jc1OFEsIzTNI99iLYCGqmHER6nWB475H4=;
        b=lrtbeHUm08AK8GaugSI6P4TbyvHyqRFYuTGBWO9lmN/ElIswApey+tBDGrfVG0SOie
         P7WNnymHdSBi9mXTTbMmfoOLfmkK78bBd2uzA7tAAPsLHuXB7vdPlF42qtG+Km0nigIJ
         CJGV/BCrhHtuqombBSsi6zppQPyt4fRGdpzTs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=KZwxhLZVt1wb3ya/XQwmb2D/NJIbcsJOwhPJT4nlHZKMxNm6pMdGCI4/OKQAf6E7jz
         3YgKNMHpSS9MOqh7ZP8jst0IV4BazHVW9+yWiriSzw3oaBPzicOyAIT+0Kj9RjrYfpMD
         JmNCdZkUusEz/SL6WJE8k2u87OM/FsNZxv9uQ=
Received: by 10.14.37.79 with SMTP id x55mr2419069eea.27.1298143681054;
        Sat, 19 Feb 2011 11:28:01 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.28.00
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:28:00 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167370>

Gettextize the "You have not concluded your merge messages. A test in
t3030-merge-recursive.sh explicitly checked for this message. Change
it to skip the test under GETTEXT_POISON=3DYesPlease.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t3030-merge-recursive.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index 34794f8..d441036 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -312,7 +312,7 @@ test_expect_success 'merge-recursive result' '
=20
 '
=20
-test_expect_success 'fail if the index has unresolved entries' '
+test_expect_success NO_GETTEXT_POISON 'fail if the index has unresolve=
d entries' '
=20
 	rm -fr [abcd] &&
 	git checkout -f "$c1" &&
--=20
1.7.2.3
