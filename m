From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] Add git format-patch produced patches to .gitignore
Date: Sat, 15 May 2010 21:22:46 +0000
Message-ID: <1273958566-7328-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 15 23:23:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODOpy-0006ie-5c
	for gcvg-git-2@lo.gmane.org; Sat, 15 May 2010 23:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756685Ab0EOVXU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 May 2010 17:23:20 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:36114 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756295Ab0EOVXC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 May 2010 17:23:02 -0400
Received: by fg-out-1718.google.com with SMTP id d23so2168108fga.1
        for <git@vger.kernel.org>; Sat, 15 May 2010 14:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=vXV0QSwcns27zwNMAO/v+5eWQrWYDDBph7lrj0EdiFA=;
        b=fxsrJfpNY+FNlX68b5Jm2wr39DE48VTc52s0uVDkUn2u+eLoypU1Sah/hBEJTgBhjC
         vE4BAGDVGdGx2OmOGqP/qUf3bPtwR8o+gNNr9KJ8t/cQX8DyCG8XVC6Tz29U3Zy+8NVc
         8JtcL9dAa7A+BGY5bOYOVLQzGRDp6fCbJ0gLU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=j9AihUpaZsi1NTnKYqXtroKCNu5bSpHQATNwU/GbEL4Dy/61pwLSt+hpGL8i/fzGPa
         iiwHpft9onbYbXTyhz9fseTjpZ0XdekwWu1S9rQjMTbtidYS6PtMvNwpGVbk/dMRNzFq
         i2qeeuwVrOLL8YDx5of5RGK+iw8PEe4nfH69A=
Received: by 10.87.70.21 with SMTP id x21mr5428975fgk.62.1273958580875;
        Sat, 15 May 2010 14:23:00 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id 28sm5364558fkx.6.2010.05.15.14.22.59
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 15 May 2010 14:22:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.84.gd92f8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147165>

Change Git's own .gitignore so that patches produced with git
format-patch don't show up as untracked.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 .gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index dbf1b90..039d99c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -203,3 +203,4 @@
 *.pdb
 /Debug/
 /Release/
+[0-9][0-9][0-9][0-9]-*.patch
--=20
1.7.1.84.gd92f8
