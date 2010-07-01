From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 7/8] t/README: Add a section about skipping tests
Date: Thu,  1 Jul 2010 20:17:57 +0000
Message-ID: <1278015478-6920-8-git-send-email-avarab@gmail.com>
References: <1278015478-6920-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 01 22:19:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUQDu-0003YO-5b
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 22:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756089Ab0GAUSs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 16:18:48 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:55617 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755966Ab0GAUSp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 16:18:45 -0400
Received: by wwd20 with SMTP id 20so358051wwd.1
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 13:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=TBrfHLRh/zzeAepd+XMF1UhIDIedWzIYPr49urLXuok=;
        b=K0C3MCVUElsRU5OHWQ1Y8XFY4nYGHcWgAHLca7O1uSFsnNCVHEaPXP+AUgioyc2g3b
         ymVWxW/b4tRPDIlxYNjTPR5MmC+LbmK/sjGO2Aa4baa7mTlTIVU4x303Chgrf+LVb7Lp
         QZIwnqGhxtMLkAIOmFtxkeYVMLkU1Qj3cvDW8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=uDY6RzrNfEvTrs6SP9vFFNi/4d40+5bsUZ3G2z3aSctF2eo+gFovCekf7EpdqceeUc
         MTZ9DZ1vi0GlYEj7k5Fpekjg74H4cSperEebk/ol67QfADtD1YJP4fu/TmvHVh5u1Bnn
         pVeExyKoIkycXK/C2kGoCOLto/ulQNdrOAHCY=
Received: by 10.213.29.65 with SMTP id p1mr2971903ebc.76.1278015523023;
        Thu, 01 Jul 2010 13:18:43 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id v8sm261986eeh.14.2010.07.01.13.18.40
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 13:18:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <1278015478-6920-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150078>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/README |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/t/README b/t/README
index 27b9658..5a291e1 100644
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
