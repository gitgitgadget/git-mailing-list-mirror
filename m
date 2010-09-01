From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 09/13] gettextize: git-branch "(no branch)" message
Date: Wed,  1 Sep 2010 20:44:01 +0000
Message-ID: <1283373845-2022-10-git-send-email-avarab@gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 01 22:45:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OquBT-000790-Rn
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 22:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754944Ab0IAUop convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Sep 2010 16:44:45 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34335 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753964Ab0IAUol (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 16:44:41 -0400
Received: by mail-wy0-f174.google.com with SMTP id 35so9681721wyb.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 13:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=dhbSW53VXzBalsucWVNbddh8c/Epr13xlCxsUi0jois=;
        b=c2ECLJ796e3XV89jP6/P20ng2UCBguNvOCsgriYGyPL0r7z3P9nHmgV6r2eRi6giBJ
         PHF790KNe+pxILl3M+TbcJCuOx84ib66DCqStr+EsKBq/UMGlJfar75OOsU0oTeh96Yp
         Dz/axWuARJ224ULtqlLHbebk57V8OxPwMwVqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=EPU63VciE6mMJ3QNLF+7EgbWH9CdHNG+gBMRlXxSoEzMmvqcyU31C4ItFAdHefyPTD
         EH+HzSCy8v6uWsqlyEStwXFkgW+/AvxoC915EcKya3vDtfc6VszYdCYCv1k8+4SWhp7a
         lqxP17I0Eqk245kY+M73D3Ck/0iW8rJKBp5vo=
Received: by 10.216.1.18 with SMTP id 18mr756505wec.24.1283373881179;
        Wed, 01 Sep 2010 13:44:41 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id v11sm6461150weq.16.2010.09.01.13.44.40
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Sep 2010 13:44:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.579.g2183d
In-Reply-To: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155082>

This is possibly a plumbing message.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

ditto about the maybe plumbing output, but I think not.

 builtin/branch.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 59e71fc..fc6c4c3 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -481,7 +481,7 @@ static void show_detached(struct ref_list *ref_list=
)
=20
 	if (head_commit && is_descendant_of(head_commit, ref_list->with_commi=
t)) {
 		struct ref_item item;
-		item.name =3D xstrdup("(no branch)");
+		item.name =3D xstrdup(_("(no branch)"));
 		item.len =3D strlen(item.name);
 		item.kind =3D REF_LOCAL_BRANCH;
 		item.dest =3D NULL;
--=20
1.7.2.2.579.g2183d
