From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 17/48] i18n: git-submodule add git-sh-i18n
Date: Sat, 21 May 2011 18:43:58 +0000
Message-ID: <1306003469-22939-18-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:45:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrB9-0000JJ-9R
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756866Ab1EUSp2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:45:28 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:44943 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910Ab1EUSpS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:18 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1451116ewy.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=/QYpEcc6FziX5NK2zcgaIs1Oo5tHWF+NdhXa4IRAm8Q=;
        b=jnlGAJNoVb882n9TPkll6fngCD8gMViHw6vyRGvO5oZm2EEFkqZymLelK1jiQ0VVHM
         s1dK6vPbLeyvHy7w3KswqeAuh0HZDGupeN/iKVvSMMoyBW6MQk/VcpobdXSy3QWUqMO8
         ur0iZUpYhVLR5eQAoltP0TS8EkHUHPc9n1uHY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=agzlzQQy0pFoMkWb/C94fMLArWrzMujsTqCt31VfRi5ydeotiYzDLM6U2pFUNv6ScI
         Wb0imzoj+U+wHd0ZRS5X05QRFwu+emu5C5PExkAJXrmp8Iv5NIh8xgJv9MvhKsrOAn11
         q+wBLBF74q5+ydLjwGZUsIgPqzZQm/h/YQUL0=
Received: by 10.213.21.134 with SMTP id j6mr536612ebb.141.1306003517779;
        Sat, 21 May 2011 11:45:17 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.16
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174127>

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
1.7.5.1
