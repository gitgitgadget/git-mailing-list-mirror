From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv5 12/16] t7001 (mv): add missing &&
Date: Sat,  2 Oct 2010 23:10:40 -0600
Message-ID: <1286082644-31595-13-git-send-email-newren@gmail.com>
References: <1286082644-31595-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, avarab@gmail.com, jrnieder@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 07:10:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Gpt-0001zH-G8
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 07:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406Ab0JCFJn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 01:09:43 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60045 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339Ab0JCFJm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 01:09:42 -0400
Received: by mail-pz0-f46.google.com with SMTP id 34so1066499pzk.19
        for <git@vger.kernel.org>; Sat, 02 Oct 2010 22:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=y9nu3TNb7+dXPlxXJzK5VH40ZypV4748iS+mi5rVMok=;
        b=I6m1Lwqdbw+U/NSy2+1BxIkxzWnoTyRpiEh4mWG2dxrhpwmjS02KocZkO2gwj5auHb
         ennnMVHpkwEA+VY0JRA5HijkvEzTaRGkCx4mOvZhDPUIQbL5TbA33Ij5ugzHnTdj9n85
         8r5rWJoCkCpfYqOmYxt7a3eDmnY6GzbiCHZm8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=YvDiXVh8PYi2HhY1R1F6z2qNz1H4V6khcPxClDO5rx0lEaKmoPcJHW5U3FC5YquKJR
         rc2fD7XbfSXpeoMVFNKZekJOT+1uaLcTTTeKxB+h5ba7KJ9q21Q4idFeqmG0q5/MRb8w
         q+0bB66THIarPFT8F0hW9b77DmHeHxcIyQWug=
Received: by 10.142.188.20 with SMTP id l20mr818265wff.4.1286082581911;
        Sat, 02 Oct 2010 22:09:41 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id o16sm4140250wfh.19.2010.10.02.22.09.39
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 02 Oct 2010 22:09:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.66.gab790
In-Reply-To: <1286082644-31595-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157836>

Also, prefix an expected-to-fail git mv command with 'test_must_fail'.

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
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
--=20
1.7.3.1.66.gab790
