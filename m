From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 41/51] i18n: git-bisect add git-sh-i18n
Date: Sun,  3 Apr 2011 16:46:05 +0000
Message-ID: <1301849175-1697-42-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:48:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QTL-0005RJ-74
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753145Ab1DCQrP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:47:15 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:33259 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028Ab1DCQrO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:47:14 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1505908ewy.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=8B5n9NAVcaVtBfR0JbzRxmCWNyWg6uyvbZolFA9YxMc=;
        b=nVUt539l0/1eT05OhLHISlVxjRP1b1uVyJpH1eDdDcelgNzWtBAHs+Q8wFpuYxuOSb
         9FWYNj+a8ve5LY2XWrFSCvWxcz5x70KEl1HpYEAqEfHPWRuvTbMZdQALDYCg92SjLQoJ
         6VFB78jJ3Y63QIwLe46l3GTdM/z9wMuXihIg4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=fHlfL0y/PzO7iuBEes/DqTmYoArrZLOjbet5z8ZaiV67hZW65L3YOHjWm0+ZK47ryx
         AeUdZO5HVy9WNx7iQBZY9dSzoDHtJOxT/Kz4+HCLnqoHBrbABlj40lj2Nr7ojICtP32J
         h66CINl4tZwA7IH9KMLvybR6ApAXJllyEI2Fg=
Received: by 10.14.124.139 with SMTP id x11mr1451895eeh.219.1301849233524;
        Sun, 03 Apr 2011 09:47:13 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.47.12
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:47:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170733>

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
1.7.4.1
