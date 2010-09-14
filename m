From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 01/20] gettextize: git-stash add git-sh-i18n
Date: Tue, 14 Sep 2010 13:52:01 +0000
Message-ID: <1284472340-7049-2-git-send-email-avarab@gmail.com>
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
	id 1OvVwL-00046h-Jq
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 15:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657Ab0INNwn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 09:52:43 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:47340 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774Ab0INNwn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 09:52:43 -0400
Received: by mail-wy0-f174.google.com with SMTP id 22so7426257wyf.19
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 06:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=cVmWafSyAEn2B6rXypbWqABcyeCAS799m6KD02ITFco=;
        b=sUwxP0pPh+GGU/OcEe7S0a13x1F8o+YaViG0c49YeNZOKFlPJ7pPvvw+r2OUIheO37
         ZY8wHvHQnwybZL6wdN2kSK1H6z5os6RTjnbh+g0RbMdMmGNaa885mSCPYWM5cKD3DJsf
         7GhYAuAgY8b1bAy5ScUG4kudbnJh4IaXRYTvc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Jb8DMnxlR9n+GMV1iizIPRyBDFHXTJgLWGFZl+8lZqFrfEUR53L+M1FZd3ak7LLBe7
         ObKw8FNmDpaiHJYGFx+0skqn19m+kda+QiD72w2yTOIptb6EDS2XlhaTVjEQh4c7U3Kf
         fsrkOf4v22d1t5DrpTOg4ExKY7uJGg9sBEXqE=
Received: by 10.227.37.8 with SMTP id v8mr1807118wbd.37.1284472362457;
        Tue, 14 Sep 2010 06:52:42 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id v11sm158854weq.16.2010.09.14.06.52.39
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 14 Sep 2010 06:52:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.234.g8dc15
In-Reply-To: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156173>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-stash.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 7ce818b..e89a629 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -13,6 +13,7 @@ USAGE=3D"list [<options>]
 SUBDIRECTORY_OK=3DYes
 OPTIONS_SPEC=3D
 . git-sh-setup
+. git-sh-i18n
 require_work_tree
 cd_to_toplevel
=20
--=20
1.7.3.rc1.234.g8dc15
