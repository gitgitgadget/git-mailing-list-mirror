From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 16/73] gettextize: git-branch "remote branch '%s' not found" message
Date: Tue, 22 Feb 2011 23:41:35 +0000
Message-ID: <1298418152-27789-17-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:44:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1tk-0007ye-BY
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:44:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754954Ab1BVXnu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:43:50 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39375 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754853Ab1BVXnr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:43:47 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866600bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=GHfuFBp2eRjFqWLoko6OGyLAS+ZgVtRLLWzrF52lQUA=;
        b=K7iKmbahOmL9hGQHSPeMms4Zar4e/OHXVWJ1jYhpoHbkktvnHskP2uwDhN37pFW/Ks
         kqA0X8zsws+qxwDLZXKbwtX2Pt6KeszKzjGpBAVC8UPjR9sa3gNJiNuUlFLa36Y9omSE
         OHw6tjgOlBIJukEKS7+PMODzE46ayHAb3HCDY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=FQS/G3j0jVB/C80bYs2alcaExcJLEcrMdmLviD9yCibGSxNKGlabR1FGGYusEEITZI
         okjaBmxdqdMAx2xYDBvQTULDxwB2aPBwlYBlUTr757t1nsd3bn8luAE6/0SUKgywPjtP
         G1YWg5DzgirqbjlJ+e9z7kZsDJ9bWRHm0ZkX0=
Received: by 10.204.138.142 with SMTP id a14mr3049214bku.197.1298418226784;
        Tue, 22 Feb 2011 15:43:46 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.43.45
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:43:46 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167593>

This could be done better by splitting it up, but it would change too
much code, which I'm trying to avoid at this point. Instead add a
TRANSLATORS comment to explain what "remote " does.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/branch.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 6695db4..e9d8a5a 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -157,7 +157,8 @@ static int delete_branches(int argc, const char **a=
rgv, int force, int kinds)
 	switch (kinds) {
 	case REF_REMOTE_BRANCH:
 		fmt =3D "refs/remotes/%s";
-		remote =3D "remote ";
+		/* TRANSLATORS: This is "remote " in "remote branch '%s' not found" =
*/
+		remote =3D _("remote ");
 		force =3D 1;
 		break;
 	case REF_LOCAL_BRANCH:
--=20
1.7.2.3
