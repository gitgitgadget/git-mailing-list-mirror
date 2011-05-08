From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 13/48] i18n: git-pull add git-sh-i18n
Date: Sun,  8 May 2011 12:20:45 +0000
Message-ID: <1304857280-14773-14-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:22:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ305-0003rg-3j
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:22:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753571Ab1EHMVx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:21:53 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:37472 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753374Ab1EHMVn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:21:43 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1325598eyx.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=NmYxv1T5sWrOFsVa9iSsYDRp3b5bk8WUU2nFarDckYg=;
        b=j3M5TelKmCzJeJAkxnt8l+nCACOw7QWM9vOIEz5nfq2iC/2OZ/QYA9L9hWswIYHddu
         cDhSp2V+zyzDRwf2nlhzFyONCFCmD0rknKCb4ZpfRoFTV22zfbkYJXMDe2qFtbNjlkK6
         Sge7wRnTjdXRPHYRvDA8gDEBjyZhBeCBpTeZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=NTj2IVKzgISXkbj4t28kW5nTvL1kUmy8pEo7FIX0ip52Kag3S67yUK8uDzcgwHj1MA
         uUqmf4MB+IrPCaIY2G+L7ZfFmW4fE3Id6c4OfZdCq/NKqJqS/jTR4yl/NxK/usjYjKg9
         LVsB27B+Kn1kkXCIMxuNrvjlZzDnGGECib768=
Received: by 10.14.127.5 with SMTP id c5mr2725012eei.70.1304857303146;
        Sun, 08 May 2011 05:21:43 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.21.42
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:21:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173114>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-pull.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index fb9e2df..05011b1 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -9,6 +9,7 @@ LONG_USAGE=3D'Fetch one or more remote refs and merge i=
t/them into the current HEA
 SUBDIRECTORY_OK=3DYes
 OPTIONS_SPEC=3D
 . git-sh-setup
+. git-sh-i18n
 set_reflog_action "pull $*"
 require_work_tree
 cd_to_toplevel
--=20
1.7.4.4
