From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 17/48] i18n: git-submodule add git-sh-i18n
Date: Sun,  8 May 2011 12:20:49 +0000
Message-ID: <1304857280-14773-18-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:23:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ31P-0004a3-NJ
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753843Ab1EHMXf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:23:35 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:37472 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753482Ab1EHMVs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:21:48 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1325598eyx.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=DK1g+/e/TRK2W2J/bmVDm2hc7uMr3Kr4An3LVXE6r4s=;
        b=MqDsdOZIEpP/uTHPCKCDf6q/tCLmAVfkF/3XtQOCzEjoUaWBETbB9PDAqOvPs/dccF
         iWY8FD0UEzTsRIlQ+FElq2E4dasfFb9MFKQkkk5HVle/rMu2lEC4+jFBStWQ1iBwWCZn
         58XJNqaFN6XlZOkI+YH9DmUlJeShXtLuZlv6o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=orihh8Clr0JcrwZ+noKq8mPDJgj5bsh/+sMNgTBbn1la60Zd8Xc7CrUA2D0csfCBV/
         5nSABqq1MoctBV4PnfbcZPDMnhBwGOaZFVCG3zBNgsA8A1hgVAt96VE6LF1K8COhNd6L
         h1102vvrxI8DZb8Sex9zdGpZK1omw/AA5Aki4=
Received: by 10.14.18.100 with SMTP id k76mr2811847eek.125.1304857307483;
        Sun, 08 May 2011 05:21:47 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.21.46
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:21:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173144>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index bf110e9..816ab3d 100755
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
1.7.4.4
