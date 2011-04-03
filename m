From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 20/51] i18n: git-submodule add git-sh-i18n
Date: Sun,  3 Apr 2011 16:45:44 +0000
Message-ID: <1301849175-1697-21-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:49:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QUX-0005ya-OK
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319Ab1DCQsd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:48:33 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47128 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848Ab1DCQqu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:46:50 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1502908eyx.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=Db3jNcBWbDMM/ngT7U0MkkxMIkkg3O2eXXRB9LwHAgE=;
        b=J727ZGEmyauDDgJFYhuAaZHF7D+5Tz8WlONebC9u6pwvIT55EAGb+YzPhZdA1k085K
         byCyJd2Qp4zBZAp1AOrze7H+Mb8TUfZz3PVNRAfsJoDNcz9i0KYovj5ICNamx4cdXgWN
         WY7up9GcaOALLLFe/3Y8fuAkcF9xrJXPBDBDo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=YSAqStYIR+u3cr0K0P7GpMRm0mRPl5neOzuGH8Xj97fY06PPcASvCj2/LRLAtb/IJb
         BK9G1N/ux215B2WZyo6sBMoEf3U1y+3lJm8zhxVSeqEzorfDRxL/i1NkM6Hl56WlH1iL
         liybtlQ3cr4pPi1SDFsKkjwRbWoGUrmuikVKs=
Received: by 10.14.9.212 with SMTP id 60mr2971038eet.182.1301849209475;
        Sun, 03 Apr 2011 09:46:49 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.46.48
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:46:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170748>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 3a13397..1d128f0 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -14,6 +14,7 @@ USAGE=3D"[--quiet] add [-b branch] [-f|--force] [--re=
ference <repository>] [--] <r
    or: $dashless [--quiet] sync [--] [<path>...]"
 OPTIONS_SPEC=3D
 . git-sh-setup
+. git-sh-i18n
 . git-parse-remote
 require_work_tree
=20
--=20
1.7.4.1
