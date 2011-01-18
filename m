From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 1/3] t/t5400-send-pack.sh: use the canonical test_expect_success syntax
Date: Tue, 18 Jan 2011 22:41:34 +0100
Message-ID: <1295386896-21828-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 18 22:42:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfJJu-00031N-TY
	for gcvg-git-2@lo.gmane.org; Tue, 18 Jan 2011 22:42:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338Ab1ARVmZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jan 2011 16:42:25 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46636 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668Ab1ARVmY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jan 2011 16:42:24 -0500
Received: by eye27 with SMTP id 27so82442eye.19
        for <git@vger.kernel.org>; Tue, 18 Jan 2011 13:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=HKKejk9DOrDd+OxkbtKezdlcdPEZNfbaEOd1Vafnso0=;
        b=tRYVYqZ/lZOjxStRwLFEwUyKZXivo4UAPKxaMAMoo+YTl7y0klzN5nasTlpCdg9Xji
         rzDlb9zQlpb76t8cK3eAItCl9PBqMAL43hmpiwos2IJUDAmM1+vpcoDeXagJz6rrWmLf
         o/l8ugdWt1cwdJlJjxLN5nrHrFlrICQp6Iiyo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=jrRD8WLspewPaGnD3nwRqoYvYbCABV9BmQLvyTHat1nvA/ucgeFpM0svZzov1OdR3E
         pszHTyJB66FUnjzl1+6R0mpVtzHWM4ZDZta3Eic3CvL9Fik6KHuOUJdBSd5jz0vQ4XGc
         FyTktL6s/z3UmtLsb67U0NOWFgKA2AUSqTwac=
Received: by 10.213.114.15 with SMTP id c15mr6273655ebq.52.1295386943409;
        Tue, 18 Jan 2011 13:42:23 -0800 (PST)
Received: from snth.ams7.corp.booking.com (212-182-132-170.ip.telfort.nl [212.182.132.170])
        by mx.google.com with ESMTPS id t5sm4916974eeh.20.2011.01.18.13.42.21
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 18 Jan 2011 13:42:22 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165223>

Change t/t5400-send-pack.sh to use the usual test_expect_success
syntax, i.e. change:

    test_expect_success \
        'description'

To:

    test_expect_success 'description'

Like the rest of the tests in t/t5400-send-pack.sh do.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t5400-send-pack.sh |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index b0b2684..656ab1a 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -76,8 +76,7 @@ test_expect_success 'refuse pushing rewound head with=
out --force' '
 	test "$victim_head" =3D "$pushed_head"
 '
=20
-test_expect_success \
-        'push can be used to delete a ref' '
+test_expect_success 'push can be used to delete a ref' '
 	( cd victim && git branch extra master ) &&
 	git send-pack ./victim :extra master &&
 	( cd victim &&
--=20
1.7.2.3
