From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/3] t/gitweb-lib.sh improvements
Date: Sun, 12 Sep 2010 11:41:03 +0200
Message-ID: <1284284466-14506-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 12 11:41:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ouj41-00073O-Ms
	for gcvg-git-2@lo.gmane.org; Sun, 12 Sep 2010 11:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324Ab0ILJl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Sep 2010 05:41:28 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62592 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141Ab0ILJl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Sep 2010 05:41:27 -0400
Received: by bwz11 with SMTP id 11so3684689bwz.19
        for <git@vger.kernel.org>; Sun, 12 Sep 2010 02:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=HxiYaDRJXZ+T1FKrHPl+78Hc1SHxiINa0NACKcrFtDA=;
        b=LNFo4spmCZ2Q0Ur/DPJEoy+3HIuvxWMf7O8SFKDbZP4uwIMcb0UVfODAb7J4i8PEyr
         +hmgItO68KP3fzbCRFfqZOORYEs23cEYJk7MnvmFWcb9ZeC8HSvZ08fmAIkcXgFJXJPI
         65nZ8UvTtQroLp76Zz7hRtoXh8bykcUeUDCik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=gcA9ZAkYZMcKCKATKC07o6WM1DJbsaAyGeQb/d802NPlOTighK2SDGd3ETmlpyp9II
         hOOVRQNkArT2FRQJjFCsHSb6Da3Cw1p4HU2QLJmqWwgvyde8b2k2+OQZ6yjsdKfISLrY
         nwk4aOMCyqWsHRJ9nendVnR6f29moBU3R0QHI=
Received: by 10.204.126.29 with SMTP id a29mr2161364bks.59.1284284485939;
        Sun, 12 Sep 2010 02:41:25 -0700 (PDT)
Received: from localhost.localdomain (abvl188.neoplus.adsl.tpnet.pl [83.8.209.188])
        by mx.google.com with ESMTPS id 24sm3570708bkr.19.2010.09.12.02.41.24
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 12 Sep 2010 02:41:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156023>

This series of patches is meant as preparation for splitting gitweb;
the most important (but only RFC) is the last patch adding support for
GITWEB_TEST_INSTALLED, similar to GIT_TEST_INSTALLED from
t/test-lib.sh

Comments appreciated.

Jakub Narebski (3):
  t/gitweb-lib.sh: Use GIT_BUILD_DIR
  t/gitweb-lib.sh: Use tabs for indent consistently
  t/gitweb-lib.sh: Add support for GITWEB_TEST_INSTALLED

 t/gitweb-lib.sh |   25 ++++++++++++++++++-------
 1 files changed, 18 insertions(+), 7 deletions(-)
 mode change 100644 => 100755 t/gitweb-lib.sh

-- 
1.7.2.1
