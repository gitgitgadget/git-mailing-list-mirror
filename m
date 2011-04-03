From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 12/51] i18n: git-pull add git-sh-i18n
Date: Sun,  3 Apr 2011 16:45:36 +0000
Message-ID: <1301849175-1697-13-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:47:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QSG-00055g-RD
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816Ab1DCQqo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:46:44 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47128 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803Ab1DCQqm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:46:42 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1502908eyx.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=vZ0hEufS52/Xbs/wb1tsxN5FiXl36+UYgVlVMQu+824=;
        b=fy47MHAfmoOafR+NMSpkOdPieT1VPy8IEJmMKGXL+lMLpY/HjWbQQrENintQtvOo91
         oA8iCYrCydhtVcttntS9AdMSTNPgw64proJkXt2+qe9HKrZBDIc0ytA3n2EuSCyLDJJt
         6InhbdZkozAbUOXi1zOOntmbO+ETtPkQ5V3FI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=IV2+UEIjuggy8ljHGN+UAl+txTXn/qvXJWhQBADMBdknESZzOz75yrAX+Hw22RMNrc
         M14E1xk+CiyNkCxggMNrcvwe1+1DIE4V3NGXlxEwYb2vzMzCY+zLAHzW3eR+52va5gKX
         qI9wmXR+x4IEW7nCt2CmyeFbhFM2dCO3sq4hw=
Received: by 10.213.33.143 with SMTP id h15mr1154390ebd.22.1301849202136;
        Sun, 03 Apr 2011 09:46:42 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.46.41
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:46:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170711>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-pull.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index e31226b..0b623bf 100755
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
1.7.4.1
