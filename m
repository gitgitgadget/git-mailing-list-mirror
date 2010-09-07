From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 11/20] gettextize: git-am add git-sh-i18n
Date: Tue,  7 Sep 2010 16:48:25 +0000
Message-ID: <1283878113-19533-2-git-send-email-avarab@gmail.com>
References: <1283877955-19105-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 07 18:51:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot1O6-0004K7-Tu
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 18:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209Ab0IGQsv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 12:48:51 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:37488 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932191Ab0IGQsq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 12:48:46 -0400
Received: by ewy23 with SMTP id 23so2471911ewy.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 09:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=rjnGS2Uu3Z2VHTZEiR7vOW9sPaI669B0kQVy7HSPfj8=;
        b=Rins04QptsrtxREtZcjZJmOjiajWbxDWzvYYR7iJTk8vn2KfkvmexFuQcQaqn+Hh6F
         ZbFaguPVpE3s11+t5WPMXx0CGrqEYHAKvBLaMam+NDZWkdwgkrOzLKjypzJ+n01+UTtS
         9bOVnN485uqGBEu1gLAmf9BYKmW0S/Zasx8yc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=LSj5xav4JHnbNvHErVTpeFxeJ5+sFiKmC9yXGfC1cGjiW5eDOpo+D+A0Wm9BziQh7c
         xajNvHNe1v+DoEfUuoaxDKoUQf7FrJaVSZhtb/2Khd0RCAHY8Emq8nH1kzbBGI27bF5L
         U7oOqKDFxIMLqIty76CSFLx4v1EBL82uCehB0=
Received: by 10.216.181.15 with SMTP id k15mr117140wem.82.1283878124424;
        Tue, 07 Sep 2010 09:48:44 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k46sm4304936weq.34.2010.09.07.09.48.43
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Sep 2010 09:48:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283877955-19105-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155717>

Source git-sh-i18n in git-am.sh, it's needed to import the Git gettext
shell functions.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-am.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index e7f008c..a7185d9 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -37,6 +37,7 @@ rerere-autoupdate update the index with reused confli=
ct resolution if possible
 rebasing*       (internal use for git-rebase)"
=20
 . git-sh-setup
+. git-sh-i18n
 prefix=3D$(git rev-parse --show-prefix)
 set_reflog_action am
 require_work_tree
--=20
1.7.2.3.313.gcd15
