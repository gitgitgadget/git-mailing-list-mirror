From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 03/12] gettextize: git-submodule say + eval_gettext messages
Date: Mon, 13 Sep 2010 22:09:09 +0000
Message-ID: <1284415758-20931-4-git-send-email-avarab@gmail.com>
References: <1284415758-20931-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 14 00:10:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvHEC-0006xe-L8
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 00:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753662Ab0IMWKM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 18:10:12 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64182 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753633Ab0IMWKK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 18:10:10 -0400
Received: by mail-ww0-f44.google.com with SMTP id 20so393266wwd.1
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 15:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=fV14ntPXDuLBsneZ3XD7HAvrXZGfY0eqDlW3fkMdw6E=;
        b=TnA9y0RbET0phQ1+JqrJEeGg8SWaJsNIAXJ8svwTLSZfaxOz49UJognz4pmZvMit0t
         oMzfK563XdE7OAhX/6Z4XqKogzGvG7ZdmZo6yQRfPCKqyTDigEJYd2m4FI9j66IN+iSp
         qyuYzvxmhLRg5RKuWV9pr18b4Xhm3Wb6k9lVo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=H6/s993Iqvz6eoVJ/hFHZlF8qUryrKYd5DmfUJcGV49TQyZ6wxU+PfNVgQaxYnOZDl
         VGFZ00wiXPIdeCRbuIXW760G0rpclRMLO5Ip3GMPvFPFse56Upf5xhLxHghNGPz7jKiP
         4MnskuSetuZ0L8xsjq4vhk6kFPWhoNyQSbKOk=
Received: by 10.216.188.211 with SMTP id a61mr3189312wen.15.1284415802063;
        Mon, 13 Sep 2010 15:10:02 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id w14sm4296416weq.9.2010.09.13.15.10.00
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Sep 2010 15:10:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.220.gb4d42
In-Reply-To: <1284415758-20931-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156136>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 5a08fe6..086acdd 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -840,7 +840,7 @@ cmd_sync()
 		if test -e "$path"/.git
 		then
 		(
-			say "Synchronizing submodule url for '$name'"
+			say "$(eval_gettext "Synchronizing submodule url for '\$name'")"
 			git config submodule."$name".url "$url"
 			clear_local_git_env
 			cd "$path"
--=20
1.7.3.rc1.220.gb4d42
