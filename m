From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 6/7] t/README: Add a section about skipping tests
Date: Fri,  2 Jul 2010 14:59:48 +0000
Message-ID: <1278082789-19872-7-git-send-email-avarab@gmail.com>
References: <1278082789-19872-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 02 17:01:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUhk6-0004di-SC
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 17:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758772Ab0GBPA7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Jul 2010 11:00:59 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:46104 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758761Ab0GBPAy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 11:00:54 -0400
Received: by ewy23 with SMTP id 23so1096024ewy.19
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 08:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=5LvP18bLvWBIFkf3vmhROsU6IZ2PoKgTT86xxzR88OI=;
        b=cq1UuFv+IyqDZlgmNLxolsV72w+wTG9cvxDB1cZV6/HK8sdSrapWfvSRKAR4M5AEiI
         YX+PAZ2FSF7NNAXXDwGKAEDaoAMbQ1hC/AdJZPXvFn1eOyOxwyUwYQG5auu43/p63lSV
         BfIcdQkncFM8TDZWq084+stMdmIKH1l+aV1wg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=D7Q+9uRxO1ImsW0fvLCd4r87V1Pn+2LjfV1f+VnGPMQrmpUj3y+8B8gCORD85YluyH
         ql6cJRkmhG9wGKRzhR/2FeYeuFO2lggWyMC3rHcxjeDxMI/F3PL8KrpICGEBOggeSdG1
         1e0ixBwgqY7qcrtlYBi4OLsDIh4hLto2zH7iY=
Received: by 10.213.28.134 with SMTP id m6mr826791ebc.6.1278082851908;
        Fri, 02 Jul 2010 08:00:51 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id a48sm6206858eei.19.2010.07.02.08.00.50
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 02 Jul 2010 08:00:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <1278082789-19872-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150133>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/README |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/t/README b/t/README
index 04ad927..4079635 100644
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
