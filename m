From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] gitignore: add test-mktemp to ignore list
Date: Sat, 12 Feb 2011 23:21:17 +0000
Message-ID: <1297552877-25651-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Arnout Engelen <arnouten@bzzt.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 13 00:21:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoOmU-0002dG-UC
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 00:21:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753312Ab1BLXV2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Feb 2011 18:21:28 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41021 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584Ab1BLXV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Feb 2011 18:21:27 -0500
Received: by bwz15 with SMTP id 15so4385219bwz.19
        for <git@vger.kernel.org>; Sat, 12 Feb 2011 15:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=pz2ZC4GH262s3cqelkH5xhKGaa0m5U4yyo/jRNGw9P4=;
        b=Z6mvVBKSWkxYXmErMRWCQ5pbPq073jtjqEcG8CpQZNw1ct/KAzSGfQZM8E5N0vD+Bp
         f+6+TOVYYXagVmA0pjAe6esWKY8IOZnH5WuSVSIuZreRz2qc4ZWaG6NXZa6hsNShe8hu
         QlzuTyi+i1t70i4Gr2X5lqYSC/AQReBmtgqFY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=cClPvRkrghuIfqUFiWM7OCTtNNS9ahgVQQ/YHoO/4WhQrQ8wrQBZ1/kjGDMsacdiKc
         zA3nu5Q6ynK3SyxBmkJj40xkIHCCkfQCKwjF4kovHBIF3hevDj6LKF9ryFNMvW8CzNZ3
         BaqErmFIKrPHf6yrXlfxdH9MeAlLqyqDDTco4=
Received: by 10.204.62.209 with SMTP id y17mr6295239bkh.98.1297552885943;
        Sat, 12 Feb 2011 15:21:25 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b6sm661155bkb.22.2011.02.12.15.21.25
        (version=SSLv3 cipher=OTHER);
        Sat, 12 Feb 2011 15:21:25 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166631>

Change the .gitignore to ignore test-mktemp which is built from
test-mktemp.c. Arnout Engelen added this in
6cf6bb3e47ac2f667fa0b27a4222e903ff6fb77c but did not add a
corresponding entry to .gitignore.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 .gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 3dd6ef7..c460c66 100644
--- a/.gitignore
+++ b/.gitignore
@@ -170,6 +170,7 @@
 /test-index-version
 /test-line-buffer
 /test-match-trees
+/test-mktemp
 /test-obj-pool
 /test-parse-options
 /test-path-utils
--=20
1.7.2.3
