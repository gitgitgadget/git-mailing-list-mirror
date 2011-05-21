From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 13/48] i18n: git-pull add git-sh-i18n
Date: Sat, 21 May 2011 18:43:54 +0000
Message-ID: <1306003469-22939-14-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:47:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrCq-0001Bj-EK
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757232Ab1EUSrQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:47:16 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55119 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755086Ab1EUSpP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:15 -0400
Received: by eyx24 with SMTP id 24so1444635eyx.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=UUixHxgNvInthp8JlJwsw+nCMoEbBhGszd29U20WxAc=;
        b=Nm/wQjf3BtAWhnKLrOx6rdBlXAbqaAmoUu7/Ftx/MaaNPoRbll6VoD0gFX7a1upQuA
         irkiaKHdJYZw1XD/aN7QmZMGKZue4YVACyGeprB1mxlbT3tIRyV3v1/+0bGrAzkp11AF
         niAegLuk/kPmACu+A9hkjUlUORUXfTY4nnAq8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=k8lcYg1n6Qi6WbYpm4sTg0TcXTwqSUzvTyztsaOVrZ1dpDrlT/5OYc33iGJJGA9HDN
         i81eqtIdMMayfb7pBYk1CKG5InYMuWB6XfQmpoLJY+l/LvkQICnK3CvRBOQ36MK+eY79
         sBqJZcY8J+p8/Oz3psYlW9MjeL1bsMWRLhTr0=
Received: by 10.213.4.7 with SMTP id 7mr572535ebp.75.1306003514043;
        Sat, 21 May 2011 11:45:14 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.13
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174159>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-pull.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index fb9e2df..05011b1 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -9,6 +9,7 @@ LONG_USAGE=3D'Fetch one or more remote refs and merge i=
t/them into the current HEA
 SUBDIRECTORY_OK=3DYes
 OPTIONS_SPEC=3D
 . git-sh-setup
+. git-sh-i18n
 set_reflog_action "pull $*"
 require_work_tree
 cd_to_toplevel
--=20
1.7.5.1
