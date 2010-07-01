From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 7/8] t/README: Add a section about skipping tests
Date: Thu,  1 Jul 2010 15:10:03 +0000
Message-ID: <1277997004-29504-8-git-send-email-avarab@gmail.com>
References: <1277997004-29504-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 01 17:15:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OULTp-00006b-65
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 17:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754933Ab0GAPK7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 11:10:59 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38159 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508Ab0GAPK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 11:10:58 -0400
Received: by mail-wy0-f174.google.com with SMTP id 23so805138wyf.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 08:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=6QrGdcoP4nL5MGMxmSOT3NI1zpmopF6j18pfbeUvx/Q=;
        b=SeDTJ7ngFFLUV+Gtz32BF4uZiDX5CkuB34/tu9+gTMht9LtxYEaQXfm2N5Kyc3wrA5
         wFnKibolUwOZEb1otWj8g2a8QZuZwMg5Vjo7JhUcyjdndAn0bineI3wAH88PbIZt44Dt
         qJA/RegIPZd8HpPN4P9r8FMcGxGHKB0vOXlgg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Ho28pxGVw9JDbGGlpre0jxGfQCUUcGc5LA3+VMlmQXmy+zeXJB3ZJvSZLcQOa7oskC
         chSlXmAEXoUrHfTXBZE9j0nO5Jy7RGeVDcE6wl9bpLa/pMJF3jSj1CuQAzVk0XQ3Epgh
         Nn/LQBRPlxyAmaNuwQdb4Pr9RUnfb6wILCNks=
Received: by 10.213.33.135 with SMTP id h7mr5546620ebd.26.1277997058032;
        Thu, 01 Jul 2010 08:10:58 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id v59sm10377672eeh.12.2010.07.01.08.10.55
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 08:10:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <1277997004-29504-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150042>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/README |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/t/README b/t/README
index 6232567..42a4c25 100644
--- a/t/README
+++ b/t/README
@@ -231,6 +231,18 @@ This test harness library does the following thing=
s:
    consistently when command line arguments --verbose (or -v),
    --debug (or -d), and --immediate (or -i) is given.
=20
+Skipping tests
+--------------
+
+If you need to skip all the remaining tests you should set skip_all
+and immediately call test_done. The string you give to skip_all will
+be used as an explanation for why the test was skipped. for instance:
+
+	if ! test_have_prereq PERL
+	then
+	    skip_all=3D'skipping perl interface tests, perl not available'
+	    test_done
+	fi
=20
 End with test_done
 ------------------
--=20
1.7.1.251.g92a7
