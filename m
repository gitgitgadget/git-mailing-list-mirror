From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 1/2] git-cvsserver: typo in a comment: bas -> has
Date: Sat, 19 Jun 2010 16:06:57 +0000
Message-ID: <1276963618-14662-2-git-send-email-avarab@gmail.com>
References: <1276963618-14662-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 19 18:07:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQ0aJ-00051P-1S
	for gcvg-git-2@lo.gmane.org; Sat, 19 Jun 2010 18:07:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754565Ab0FSQHv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jun 2010 12:07:51 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:60260 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725Ab0FSQHu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jun 2010 12:07:50 -0400
Received: by wwb22 with SMTP id 22so836405wwb.19
        for <git@vger.kernel.org>; Sat, 19 Jun 2010 09:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=2EZm7ZqN18VwdmGPJJtRZ/quqKnPZmJVdPzO9zDYamg=;
        b=QvEkwHDOdExTEkaW+TxXDmXtSBRj9UkmRmJOkSKjMWRFlU1Tu3NybBI7GRYaoVVRsr
         asRqSshXN53ntPlCBAr8NAj45zcABUvTpReGUnmhK9FOuxOFrsQZIeiF6aRZDTKuyAA6
         mt5YHtKi1xufFWWPAjzxBX29OIP4Hc2ecbNxI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=MhKmTdSZTpksWY6soZay1CcuHXpa2gHktBv5NiCuAbgKANCzH2IEuNqnF+Onf6ERiu
         q+WeIzgsy6ixhXo6ia1+TjmYmUZjFx9JHdxP+MMJgHpqmCV/ZP0IfULMmo+eaMr2G/AF
         dcnZb+f6l2TANSUfWyWU+Z+RmT0/MSqyghENQ=
Received: by 10.227.144.129 with SMTP id z1mr2539357wbu.3.1276963668503;
        Sat, 19 Jun 2010 09:07:48 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id y31sm7107452wby.16.2010.06.19.09.07.46
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 19 Jun 2010 09:07:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <1276963618-14662-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149384>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-cvsserver.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 3833bee..6de7921 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -2656,7 +2656,7 @@ sub descramble
     );
     my ($str) =3D @_;
=20
-    # This should never happen, the same password format (A) bas been
+    # This should never happen, the same password format (A) has been
     # used by CVS since the beginning of time
     die "invalid password format $1" unless substr($str, 0, 1) eq 'A';
=20
--=20
1.7.1.251.g92a7
