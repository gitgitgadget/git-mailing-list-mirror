From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 33/48] i18n: git-stash die + eval_gettext messages
Date: Sat, 21 May 2011 18:44:14 +0000
Message-ID: <1306003469-22939-34-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:46:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrBV-0000TI-SC
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757028Ab1EUSpr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:45:47 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39530 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756903Ab1EUSpd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:33 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1444607eyx.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=dg0trSS93yqkzvvBtUCdVbyvRvUopyCXOYUlKfwXAO4=;
        b=W0ScC+rrRTS7VhbZgPHhBPdCVNk2BJs8TbmV66/ruwezmMrwoBvBSQR3OdtkmcKOPO
         fusfQYcj1V8XMETEs7UiLu6WwTHoyPj+XOd0SKVLXVgEcEtXKuJxHDPXk5P/Q9c45JCg
         sPHanPq3jpp13p59pIGNu/1AMv60w84QOBCWc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=qrL5auHsQ48jTw0TW2thhnItBDCxh0Wob7gIWzoqwcilXuI3qniO1rZjf6JBH08hgA
         36RW+X6M8i3XP3GPaglAC8qZA40ME3TtUNSesKJ0QwxFTijoaUIejnNcY3zSocEZwF0A
         KnzDHR45AhDN7nIYR5YZd14eqIBGEA1g5ADps=
Received: by 10.14.4.154 with SMTP id 26mr259198eej.118.1306003533161;
        Sat, 21 May 2011 11:45:33 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.32
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174136>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-stash.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 5789215..3d89c15 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -295,7 +295,7 @@ parse_flags_and_rev()
 			:
 		;;
 		*)
-			die "Too many revisions specified: $REV"
+			die "$(eval_gettext "Too many revisions specified: \$REV")"
 		;;
 	esac
=20
--=20
1.7.5.1
