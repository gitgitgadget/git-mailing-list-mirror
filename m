From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 01/48] i18n: git-am add git-sh-i18n
Date: Sun,  8 May 2011 12:20:33 +0000
Message-ID: <1304857280-14773-2-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:21:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ2zQ-0003Sr-QX
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945Ab1EHMVe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:21:34 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56660 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864Ab1EHMVb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:21:31 -0400
Received: by ewy4 with SMTP id 4so1327019ewy.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=Xdj0IDs+8OXB1233z2x3NzfcSRghjE+llOn77F0LJ/M=;
        b=Du2gfkw3KzfTx3DCBe1+79YM2nxBDjl5VWbltYcjUCvhcNwrzizdY+s1rgeteEnKp1
         yulP75oDICxmHciE3FRVRVmaGwa8boidCMQWjukjMgF7nohcVEjSUMx0324BH8NCsFUJ
         BAfS7WF0OtHQsDHHh6dvQ78hRMahOEbtAMYAA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=bDiwYWG87z/ZxQ9pvfX/CRYzRMb0YxV0MFZpcbKMfgqaXvdyeiZFP7EWfrk3+s6zQn
         PxLDatrNFHEFPknc9gX6bgKXq6WYZDgv+DBoKLTXu52kBNrOR4BqWqgTEB0bt12UoEHn
         0rvtxyd4cxUUj9v6rUSpn9Fl4aA3vLpW/WjhQ=
Received: by 10.14.127.1 with SMTP id c1mr2877768eei.215.1304857290537;
        Sun, 08 May 2011 05:21:30 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.21.29
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:21:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173105>

Source git-sh-i18n in git-am.sh, it's needed to import the Git gettext
shell functions.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-am.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 6cdd591..79c5ea2 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -37,6 +37,7 @@ rerere-autoupdate update the index with reused confli=
ct resolution if possible
 rebasing*       (internal use for git-rebase)"
=20
 . git-sh-setup
+. git-sh-i18n
 prefix=3D$(git rev-parse --show-prefix)
 set_reflog_action am
 require_work_tree
--=20
1.7.4.4
