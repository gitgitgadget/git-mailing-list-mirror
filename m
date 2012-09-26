From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/5] wildmatch series update
Date: Wed, 26 Sep 2012 18:25:36 +0700
Message-ID: <1348658741-8146-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 26 13:34:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGpsV-0005Vk-OB
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 13:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754135Ab2IZLd4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Sep 2012 07:33:56 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55406 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725Ab2IZLdz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 07:33:55 -0400
Received: by pbbrr4 with SMTP id rr4so1747509pbb.19
        for <git@vger.kernel.org>; Wed, 26 Sep 2012 04:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=9aKwrIYOUZ9kseHbn/kIxIMU0P5ZsxOIVWsUOQh//Xo=;
        b=i1Hn13Fuwt5Nq+U/skappNLa9xfWzxOqWYqtH1gOCOVlcHytvYNwZw134NzNCg9/ne
         bNgYL8ZFnyDIcO1uHkYikW8Lb/74aQHAsofAJzcIkTB10wZhIblLuyxhikxLVaKfvI+j
         rVJmrIH0QlgBHBr7pAfC9xCVdCiDSFeScL3r15jNerGbbM4qbs02MJYleXIdBZD/hXWV
         PK4F4jz9U539HfjmHyxjxyRz0G7rWlz22NWDlfJ7JSNmBnocJlPDHDwhxtIhJHP8W0Ld
         KVgMbFisgontLCm+NboF9z/r1nYO1SaxkH3oejsGXNNkSRldKOMVBxqTR534LP7cafZ1
         Igiw==
Received: by 10.68.235.71 with SMTP id uk7mr1786755pbc.10.1348659235245;
        Wed, 26 Sep 2012 04:33:55 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.51.2])
        by mx.google.com with ESMTPS id tt6sm1935990pbc.51.2012.09.26.04.33.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 26 Sep 2012 04:33:54 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 26 Sep 2012 18:27:08 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206406>

No functional changes. Just incorporate changes from Ramsay and Johanne=
s.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
  Import wildmatch from rsync
  compat/wildmatch: remove static variable force_lower_case
  compat/wildmatch: fix case-insensitive matching
  Integrate wildmatch to git
  Support "**" in .gitignore and .gitattributes patterns using
    wildmatch()

 .gitignore                         |   1 +
 Documentation/gitignore.txt        |   3 +
 Makefile                           |   3 +
 attr.c                             |   4 +-
 dir.c                              |   5 +-
 t/t0003-attributes.sh              |  17 ++
 t/t3001-ls-files-others-exclude.sh |  11 ++
 t/t3070-wildmatch.sh               |  27 +++
 t/t3070/wildtest.txt               | 165 +++++++++++++++++
 test-wildmatch.c                   | 208 ++++++++++++++++++++++
 wildmatch.c                        | 355 +++++++++++++++++++++++++++++=
++++++++
 wildmatch.h                        |   6 +
 12 files changed, 803 insertions(+), 2 deletions(-)
 create mode 100755 t/t3070-wildmatch.sh
 create mode 100644 t/t3070/wildtest.txt
 create mode 100644 test-wildmatch.c
 create mode 100644 wildmatch.c
 create mode 100644 wildmatch.h

--=20
1.7.12.1.406.g6ab07c4
