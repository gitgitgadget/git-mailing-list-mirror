From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 3/8] gettextize: git-pull eval_gettext + die message
Date: Mon, 13 Sep 2010 19:35:53 +0000
Message-ID: <1284406558-23684-4-git-send-email-avarab@gmail.com>
References: <1284406558-23684-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 13 21:36:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvEpR-0005HT-QG
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 21:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755053Ab0IMTgc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 15:36:32 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49809 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755189Ab0IMTgO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 15:36:14 -0400
Received: by mail-wy0-f174.google.com with SMTP id 22so6574868wyf.19
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 12:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=dFjy/AafEEz1AMLl42IBjWxxnIsBUfYjWaROVf3Kehk=;
        b=ER73z2g8lntggJ0+N8cL82bkRRKhNmgmAXwwSA4yYMYp4gZdlZmpwyFLOXpEOZqcJ5
         FRucUf8Lct/yiPNQODpNkR5urAaeCqx/fcF657sqIeFWKsS/Dft+Ye5flcLbVugPYfiK
         CoQ/57jFMIbFuucFInYQodzl16o61y1fyAl7s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=qJEvkXpp3XpgTYxk7c07rqTz5jz6zQO3aQFaI3roTEcUiIIxd87rJyWhr+2TWAyLlY
         U/ZfulK93gEyYLV1inlasrXoG5KX6k+y4adV6SmRBJjC0ddrA4kbTbEdQ77L45SoBIoT
         nnhX65prmBw47tCSK2HDHTHq7trN0xflKaOos=
Received: by 10.216.26.194 with SMTP id c44mr4613589wea.104.1284406573999;
        Mon, 13 Sep 2010 12:36:13 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k7sm4178195wej.2.2010.09.13.12.36.13
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Sep 2010 12:36:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.110.g6776a.dirty
In-Reply-To: <1284406558-23684-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156122>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-pull.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 324ac95..99837dd 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -238,12 +238,12 @@ then
 	echo >&2 "Warning: commit $orig_head."
 	git update-index -q --refresh
 	git read-tree -u -m "$orig_head" "$curr_head" ||
-		die 'Cannot fast-forward your working tree.
+		die "$(eval_gettext "Cannot fast-forward your working tree.
 After making sure that you saved anything precious from
-$ git diff '$orig_head'
+\$ git diff \$orig_head
 output, run
-$ git reset --hard
-to recover.'
+\$ git reset --hard
+to recover.")"
=20
 fi
=20
--=20
1.7.3.rc1.110.g6776a.dirty
