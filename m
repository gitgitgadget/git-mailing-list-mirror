From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 29/48] i18n: git-stash add git-sh-i18n
Date: Sun,  8 May 2011 12:21:01 +0000
Message-ID: <1304857280-14773-30-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:22:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ30A-0003rg-27
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980Ab1EHMWQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:22:16 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56660 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852Ab1EHMWB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:22:01 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1327019ewy.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=deCEPtcIQ30GLUYjergClS5zPlcutg0TpB7bn88P7NQ=;
        b=jkeLlnwCwA2teCCQHr7ARg27j6x/mLcEqlHvLSVr4YH/leNtM5qwrPfn7G/NiP2ayp
         0OZqBJE4RVc0z5ZEGpVetHHSZ6hhQUPwdldMdt52qBjZQ2ozfvE747ryrcmC3PN79IrT
         MK8DASbeyCZ+GcBaaHb1dRhm3cdqoE18EVVo4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=gJlsFn0yK/QnIIbLbyTDdJ8f8+ZMDhONybU/CLzUKqW+s3Vmq1j47G/mwre/LRGUNS
         9mCv0Uyjj5lNlhVmLZV2LJhCr4ppqZGvGKGJVUHQGuaqQV7pKo0w6fLV0xFcaKXSG+wP
         4CSSke23lu6jPPLl8O+SZAhTHF4HEPDvzB/78=
Received: by 10.213.100.18 with SMTP id w18mr1873918ebn.45.1304857320361;
        Sun, 08 May 2011 05:22:00 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.21.59
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:21:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173120>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-stash.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 0a94036..1ad380a 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -14,6 +14,7 @@ SUBDIRECTORY_OK=3DYes
 OPTIONS_SPEC=3D
 START_DIR=3D`pwd`
 . git-sh-setup
+. git-sh-i18n
 require_work_tree
 cd_to_toplevel
=20
--=20
1.7.4.4
