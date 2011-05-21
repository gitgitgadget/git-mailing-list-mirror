From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 30/48] i18n: git-stash echo + gettext message
Date: Sat, 21 May 2011 18:44:11 +0000
Message-ID: <1306003469-22939-31-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:47:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrCk-0001Bj-Gi
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757205Ab1EUSqs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:46:48 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:50211 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753882Ab1EUSpa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:30 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1451108ewy.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=cdzME2bcJPny8HBxHucI4RbYgClDNR9gWT6DLRbvRiU=;
        b=mwDieBjlbyu51WrWc1XegXbWdijV3Jp80aB+pwRDSTXEJHMEngarrXge9USNvZR6aS
         lM53CznmGlR/PwBOWizBL20sWJL+zHhoFcKQIshk3xMuazybqUwjnE3A8tLbmVEQqaPL
         DM9gje4oiFhzgKJSVt3KCsebiOghTBiUWzsKk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=buUTpViPN+O1VAQzFROGePQR1y2BsflWlLhSd+dx8mWeCqeSexfUVxKKbUWIRYzZaJ
         PzLwklsezk1x5DhaW+BMp5Sb9urWVwbWDQuAFnQTqjRePb6ZWwxirFqhTaBp97oJsvxN
         XBZqvJsTYFYrd5PmLhf0Cut7C8opJLV0DOaGs=
Received: by 10.213.114.71 with SMTP id d7mr279866ebq.83.1306003530066;
        Sat, 21 May 2011 11:45:30 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.29
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174149>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-stash.sh |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 1ad380a..d720554 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -390,7 +390,10 @@ apply_stash () {
 		status=3D$?
 		if test -n "$INDEX_OPTION"
 		then
-			echo >&2 'Index was not unstashed.'
+			(
+				gettext "Index was not unstashed." &&
+				echo
+			) >&2
 		fi
 		exit $status
 	fi
--=20
1.7.5.1
