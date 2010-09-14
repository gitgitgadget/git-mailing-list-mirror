From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 02/20] gettextize: git-stash echo + gettext message
Date: Tue, 14 Sep 2010 13:52:02 +0000
Message-ID: <1284472340-7049-3-git-send-email-avarab@gmail.com>
References: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 14 15:52:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvVwM-00046h-4v
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 15:52:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749Ab0INNws convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 09:52:48 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48443 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774Ab0INNwr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 09:52:47 -0400
Received: by wwd20 with SMTP id 20so136386wwd.1
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 06:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=bRbW/SHLhGXBBUu6raOrKywJ9hm0qS6WJwU4aabHr4Q=;
        b=hPXovU1KiYlOwNiOx2eywvjD8yEglQU4e7lpyY3NKdVSEWGwHvrDPNV7j24B+0gUHN
         JdjfShG0ZGNHaDly7ahIR4h1AVWIltt4e46OnTaXbHjUae3IgKWtjFHPwCqzZthKiW1a
         6KoI4cRHVcO7foFPnst3Ad/MmCe05a8rMESsA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=h4wnCjK09He6GGgzEwYZDmNi87tFaErkmuipKh+9AjyrBdNmDxUWSEuJze4GDYqEP+
         fnfLKNwM5s7sK/XvkPuQ6rj1fsTV5F+G2CXmXkpcoaUx8k2kQA0bcuM+zv2QR/eF46ub
         J0EyGu0OvpAy0yLf+aGM8NtX5V3o+wDoRFM0E=
Received: by 10.216.168.202 with SMTP id k52mr5576686wel.105.1284472366153;
        Tue, 14 Sep 2010 06:52:46 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id v11sm158854weq.16.2010.09.14.06.52.44
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 14 Sep 2010 06:52:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.234.g8dc15
In-Reply-To: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156174>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-stash.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index e89a629..efffdce 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -408,7 +408,7 @@ apply_stash () {
 		status=3D$?
 		if test -n "$INDEX_OPTION"
 		then
-			echo >&2 'Index was not unstashed.'
+			echo >&2 "$(gettext "Index was not unstashed.")"
 		fi
 		exit $status
 	fi
--=20
1.7.3.rc1.234.g8dc15
