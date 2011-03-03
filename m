From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH] Documentation: fix a typo in git-apply.txt
Date: Thu,  3 Mar 2011 10:28:30 +0100
Message-ID: <1299144510-8143-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 03 10:28:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pv4pw-00031s-0x
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 10:28:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754245Ab1CCJ2g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Mar 2011 04:28:36 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64369 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019Ab1CCJ2f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2011 04:28:35 -0500
Received: by wyg36 with SMTP id 36so848595wyg.19
        for <git@vger.kernel.org>; Thu, 03 Mar 2011 01:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=szkJg4cOksAR8JGKeOulRNUnGiHdUD75ErnY6Kqzjck=;
        b=UBP4h95y+WN7jaGPY2uwxMqagW41906ZhBXyGVZikya4xDx10WKvUwrJjLk1p7pTW0
         VbRyx5MWvh8EfwflzDWGsugbBmy85CIBVORi+B7f7e8HrhvydWK66fbC8D+LvaNujoLM
         DFfbxkZl/z3Yjt0Zv8ZGyl94RM1HwIqcinpfI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=d/G9I/0Xv4oUILHyQofQqW2vci4iom6jAqHv01rAwbhdPE6BlzEmjFYM75F0wDgbn/
         9ph442HRz1D+/MMNwHJ60WNBTCO2yEH6WleeWIeKNwasMIXePm+Mfr862w18QuKm+BCc
         pqmQGo1TuxlATiavDD+mfVzkcA5iL179StBlU=
Received: by 10.216.157.68 with SMTP id n46mr367811wek.111.1299144513867;
        Thu, 03 Mar 2011 01:28:33 -0800 (PST)
Received: from localhost (pc10.ivo.park.gdynia.pl [153.19.128.10])
        by mx.google.com with ESMTPS id n11sm464471wej.43.2011.03.03.01.28.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 Mar 2011 01:28:33 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168383>

git-apply accepts the --cached option, not --cache.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
 Documentation/git-apply.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git Documentation/git-apply.txt Documentation/git-apply.txt
index 881652f..2dcfc09 100644
--- Documentation/git-apply.txt
+++ Documentation/git-apply.txt
@@ -22,7 +22,7 @@ DESCRIPTION
 -----------
 Reads the supplied diff output (i.e. "a patch") and applies it to file=
s.
 With the `--index` option the patch is also applied to the index, and
-with the `--cache` option the patch is only applied to the index.
+with the `--cached` option the patch is only applied to the index.
 Without these options, the command applies the patch only to files,
 and does not require them to be in a git repository.
=20
--=20
1.7.4.1
