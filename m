From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv3 12/16] t7001 (mv): add missing &&
Date: Sat, 25 Sep 2010 13:07:03 -0600
Message-ID: <1285441627-28233-13-git-send-email-newren@gmail.com>
References: <1285441627-28233-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 25 21:06:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oza4v-0005Xq-Vj
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 21:06:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756795Ab0IYTGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 15:06:04 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:48425 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756682Ab0IYTFw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 15:05:52 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so1062331pxi.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 12:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ldfdKL8AAzXqWk1ZjS24N9LCnLOWoH0zKtZDdWSB2yw=;
        b=jM5GjZEUdwq33+5r9ym0+cKlv67GY14cYmk/GkeMzhErVDwYm8icavCWadfIatiW1N
         RZQ0YGCZnv60wnVx+bLlbNtb0eXxlEYNsoBmznwS72WkzfxLlsS8synJvAzxv+yfR0wV
         V/51K4nKfplMMo6OBs/dIzfp2/q2JHr4jgJkU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HOrlZk+wvsAih8hhwLnyBur5tZfeKnVuPd8893Yk6EeGP1Ogtt3HD9cSu33drpk7vS
         tKesP89ZCr2RdOLbUtXmWe2WX2GtMdUovnCvtafw43intKVGBpd6kR1BdmJFraokZDIX
         2ECFHn/4eytecCH6Iq0j3PUQjmonJENm1qPMo=
Received: by 10.114.148.15 with SMTP id v15mr5668346wad.127.1285441552304;
        Sat, 25 Sep 2010 12:05:52 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id o17sm6338669wal.21.2010.09.25.12.05.50
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 12:05:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285441627-28233-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157187>

Also, prefix an expected-to-fail git mv command with 'test_must_fail'.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7001-mv.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 65a35d9..624e6d2 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -61,7 +61,7 @@ test_expect_success \
 test_expect_success \
     'checking -f on untracked file with existing target' \
     'touch path0/untracked1 &&
-     git mv -f untracked1 path0
+     test_must_fail git mv -f untracked1 path0 &&
      test ! -f .git/index.lock &&
      test -f untracked1 &&
      test -f path0/untracked1'
-- 
1.7.3.95.g14291
