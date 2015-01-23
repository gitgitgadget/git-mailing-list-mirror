From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 2/6] t7004: rename ULIMIT test prerequisite to ULIMIT_STACK_SIZE
Date: Fri, 23 Jan 2015 12:03:58 -0800
Message-ID: <1422043442-30676-3-git-send-email-sbeller@google.com>
References: <54C0E76D.5070104@alum.mit.edu>
 <1422043442-30676-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: mhagger@alum.mit.edu, peff@peff.net, git@vger.kernel.org,
	gitster@pobox.com, loic@dachary.org
X-From: git-owner@vger.kernel.org Fri Jan 23 21:05:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEkTk-0007KR-R4
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 21:05:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756028AbbAWUFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 15:05:13 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:53899 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755895AbbAWUFH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 15:05:07 -0500
Received: by mail-ig0-f174.google.com with SMTP id b16so3795170igk.1
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 12:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YqfekQnL1/5BWd7HDBEHKo6o4oF9CwMM5u2onw+LaZ8=;
        b=e5Yb0Ky2abJqFFT5spi9w+7X3ezAnKLYYsvO3RBlecHlty5blhEqj306h56FnZAKOB
         j7de8t8h5CtA4B4cEvSI70ff5kuQxnhAylLPA/7thfAP9SYp80wYYnM18W9LbFRC+riV
         01qm7v2wGn6C4CXB4WkWC5WRNJQ+anRWFy45l1VrmrPGY/MDL9NSc4m4MiGcuCDsB8Qe
         ueCRBR1m5zx9fW7dfz/o2PJ6Xp+Fimv0TQZflcrykwLprkGdT6MUBch9qaQbnjqRsjdS
         67dMiw/tt42klzvY+6M2A81igI9RQL/z1ZFbDwtwSFkWZ3iOsVAWc0WoclKPg12NzTvr
         P4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YqfekQnL1/5BWd7HDBEHKo6o4oF9CwMM5u2onw+LaZ8=;
        b=Sh2jCa4UKiha3g/w8ixou1aFRNcYVjQRyoQnHt5GudzqYG8Ru6gGRzDcoJ4m/yeG3X
         abQiIgh+pXcVVjrI1a08dSb+NckZlTlJVBzj1ZFoJvggZsZMFXl+f1gZLD7xBc83MaC4
         s+nPoUBdftSTRsFwK4X/QqNo7CIBPfI+Jz2x058VGlepfDBSZogftSg2LOFT6Ak/oAAh
         4F5ovycM5e/GI0s/vvH7zlcduhOhhR2lK+2Tno0ljn3OZ0E7fDW1emqcZ5ymF4AN6O1f
         4ReOCCpxJWJFSa8yQH1+r1Dct+be+YdCCHkb8yiFJip2yw8KBsIA2Niprv1Pp7sMgRvc
         ZmVQ==
X-Gm-Message-State: ALoCoQm9iuFtvVwzf+4r47qpTlPWjIYxIRtCHQTZUhAmPxJYN88w1+a2cFSn6+q4Jl7dXFPuUcZe
X-Received: by 10.107.150.6 with SMTP id y6mr5643247iod.22.1422043506791;
        Fri, 23 Jan 2015 12:05:06 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:40d0:e4e:2e83:8781])
        by mx.google.com with ESMTPSA id 15sm1378388ioj.3.2015.01.23.12.05.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 23 Jan 2015 12:05:06 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1422043442-30676-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262954>

During creation of the patch series our discussion we could have a
more descriptive name for the prerequisite for the test so it stays
unique when other limits of ulimit are introduced.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

Notes:
    v2->v3:
    no changes

 t/t7004-tag.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 796e9f7..06b8e0d 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1463,10 +1463,10 @@ run_with_limited_stack () {
 	(ulimit -s 128 && "$@")
 }
 
-test_lazy_prereq ULIMIT 'run_with_limited_stack true'
+test_lazy_prereq ULIMIT_STACK_SIZE 'run_with_limited_stack true'
 
 # we require ulimit, this excludes Windows
-test_expect_success ULIMIT '--contains works in a deep repo' '
+test_expect_success ULIMIT_STACK_SIZE '--contains works in a deep repo' '
 	>expect &&
 	i=1 &&
 	while test $i -lt 8000
-- 
2.2.1.62.g3f15098
