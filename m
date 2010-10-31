From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [RFC/PATCH 5/5] gettextize: git-merge: !fixup "basic messages"
Date: Sun, 31 Oct 2010 11:34:20 +0000
Message-ID: <1288524860-538-6-git-send-email-avarab@gmail.com>
References: <AANLkTikOgMGqw5fc95c2VGwXxKu9rmsA+=z5_jykD92=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 31 12:34:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCWBe-0002ko-JE
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 12:34:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755349Ab0JaLen convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Oct 2010 07:34:43 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62506 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755389Ab0JaLei (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 07:34:38 -0400
Received: by mail-wy0-f174.google.com with SMTP id 28so4574626wyf.19
        for <git@vger.kernel.org>; Sun, 31 Oct 2010 04:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=BAK1cb5vi8nBbGPrK+132iIafahOEBqHM4quWCCzx+o=;
        b=s6PAf9lpKzMB6WxD0UrcUFonS8Rt4LDhvzQX/hwx1IefJRHsLZ2L4dRHkRyaBez4He
         ZS/Ax1A57rqba1lQd49IsQPqtgMM0MeZ5GqEf7cpIl4DbZKuC6F0jAaZ4jLJEx0jrs3k
         qFflVGd0KsEKObfblzXhEWxr4e2iSQxSPcPgE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Dfyu2FJA/E+7ZzikN/Bn3cHWRMcUbi4kQLts8h8iqkmWFu8dlj8qiMm3NQigUeC1ht
         oP3Q5Jh+lmiqDSWaGVvG6ZjU0GpelYmOLrbJrxNhVgxskfMSPSMFClN6RhruhqWwtkt1
         ZLKTP53LwoDmYtDZeZ60FhRpFIoDjDtZx3Q6M=
Received: by 10.216.132.131 with SMTP id o3mr679164wei.19.1288524877244;
        Sun, 31 Oct 2010 04:34:37 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id x12sm3009770weq.18.2010.10.31.04.34.36
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 31 Oct 2010 04:34:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.2.312.ge13a7
In-Reply-To: <AANLkTikOgMGqw5fc95c2VGwXxKu9rmsA+=z5_jykD92=@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160436>

Gettextize a "%s: negative length %s" error message in builtin/merge.c
that I missed the first time around.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/merge.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 62bdd6c..524ef22 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -511,7 +511,7 @@ static int git_merge_config(const char *k, const ch=
ar *v, void *cb)
 		int is_bool;
 		shortlog_len =3D git_config_bool_or_int(k, v, &is_bool);
 		if (!is_bool && shortlog_len < 0)
-			return error("%s: negative length %s", k, v);
+			return error(_("%s: negative length %s"), k, v);
 		if (is_bool && shortlog_len)
 			shortlog_len =3D DEFAULT_MERGE_LOG_LEN;
 		return 0;
--=20
1.7.3.2.312.ge13a7
