From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 38/48] i18n: git-bisect add git-sh-i18n
Date: Sun,  8 May 2011 12:21:10 +0000
Message-ID: <1304857280-14773-39-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:23:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ30s-0004Hv-TP
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:23:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048Ab1EHMWb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:22:31 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:37472 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753926Ab1EHMWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:22:09 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1325598eyx.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=2NBiwO7GA+BH7JpDkjmPyIJzQJgLiAcuHwBNE4+HnJ4=;
        b=plcP2Fvd9sS/hc/4nGUUYcOnp+GuSHBC4eDimmAwvDlfz51skP/0SOhNPGN/9hOwJb
         U59Q/nn/aep2VV1roOaJcms57LWfO4rDtZSfUIsbA0m3Io8iyZ/iTu9Qt0ZZUn9/v5te
         kuE6LBdYBizQynaQQsAD30yq0pvpZwS6aGnoc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=eGutQJV+wcF2t6dMnf9X3N3BJxxZWoBSGnTYVbcVxdZ1jFyvU+lOLrsJQ6X8/KsuQM
         dC2R3PvR6QYVCJKj+00UcyyFrGPsnMTuF8oyjfokhi9dbTOhEc79x5SxfU693pO0QBcI
         +c7C6K4vhEayPdQ8HpMyea1dckci4hz9t9l60=
Received: by 10.14.44.135 with SMTP id n7mr2783443eeb.130.1304857328782;
        Sun, 08 May 2011 05:22:08 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.22.07
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:22:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173131>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-bisect.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 415a8d0..751c733 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -28,6 +28,7 @@ Please use "git help bisect" to get the full man page=
=2E'
=20
 OPTIONS_SPEC=3D
 . git-sh-setup
+. git-sh-i18n
 require_work_tree
=20
 _x40=3D'[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
--=20
1.7.4.4
