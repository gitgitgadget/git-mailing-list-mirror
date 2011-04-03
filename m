From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 14/51] i18n: git-pull eval_gettext + die message
Date: Sun,  3 Apr 2011 16:45:38 +0000
Message-ID: <1301849175-1697-15-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:47:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QSH-00055g-DE
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856Ab1DCQqq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:46:46 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:33259 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752808Ab1DCQqo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:46:44 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1505908ewy.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=ji55mRFrvCzcukYASEQa1s/Kx62aaeyW/R6a/Iz03zM=;
        b=sCZrh3U7CRYUHyn96QpbTINY/NGjA69U7QljFqdTyX4u+/xset/nmsRXkjt8Z8GhJQ
         N5Kr5NoH7VPeWtQIBsFlotvkVvXcCH15VSjOIh/CEb78p5n39T1sdwyycWDqJyazIyzb
         6AqAqVyfE9oTSpYpdOQgsNwSnnLoFn+W21qeI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=VuEI4/Rbfb0Heb1WGU1K28mnfNlSNi5qY2Yh7aRQ4Sg9f58Fuww9kNIG41Lbr65t/S
         LJWPkUiaTVbGr/c+//69BuBrLTJou1OgCGX8PFo2lPQ9OEI9L1nnSF4u6cHlE/4fPd4I
         3QhqrEmC9fXDkztt2GIKTjxATXkxNIOqqY5t4=
Received: by 10.213.107.17 with SMTP id z17mr3169081ebo.100.1301849203889;
        Sun, 03 Apr 2011 09:46:43 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.46.43
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:46:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170714>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-pull.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index b19e097..36f34d6 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -244,12 +244,12 @@ then
 	echo >&2 "Warning: commit $orig_head."
 	git update-index -q --refresh
 	git read-tree -u -m "$orig_head" "$curr_head" ||
-		die 'Cannot fast-forward your working tree.
+		die "$(eval_gettext "Cannot fast-forward your working tree.
 After making sure that you saved anything precious from
-$ git diff '$orig_head'
+$ git diff \$orig_head
 output, run
 $ git reset --hard
-to recover.'
+to recover.")"
=20
 fi
=20
--=20
1.7.4.1
