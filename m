From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv4 11/15] t7001 (mv): add missing &&
Date: Sun, 26 Sep 2010 17:14:35 -0600
Message-ID: <1285542879-16381-12-git-send-email-newren@gmail.com>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 27 01:14:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P00Py-0005ch-7W
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 01:14:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758364Ab0IZXN2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Sep 2010 19:13:28 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43680 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758272Ab0IZXN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 19:13:26 -0400
Received: by mail-pw0-f46.google.com with SMTP id 6so1036112pwj.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 16:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=M6tY/AMgCEPgig4T89cZq3V4Ctt5N4m8iKlaZhSoemg=;
        b=AhJo4rr8MuYya1BY5ylp0fbeCYayVetc6fdieNuNyU80FMS+Khuo7cKBUhkC+F8UAY
         NV6wHfPYJIjxyWma6RSCDy89Nia8g4Y053mhcwTozy611smtArI7gcfwm8nHgzN7UAI7
         uia1CZIHPy05n/4T6cJYRphnfXPL2ntmnZwjk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=p9ysJWhPNRRFlyxtxep0EZopGH/8BudlDUntMBtN0lB6Mc5DpHv+JYUmYdTOdz/wYQ
         H7p5a7dQa85UUJPF865kyJsy5QD/JFYT/JA7X/rlcVXgWFfbFnHzB/sIsW/zNQ3QiiG1
         BEHEHjAIKTkkPRpIJ1E8zaSMeD56Gvdr1upXo=
Received: by 10.115.14.6 with SMTP id r6mr7410272wai.8.1285542806171;
        Sun, 26 Sep 2010 16:13:26 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id c24sm9242157wam.19.2010.09.26.16.13.23
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 16:13:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285542879-16381-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157276>

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
1.7.3.95.g14291
