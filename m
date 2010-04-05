From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/43] verify-pack: use RUN_SETUP_GENTLY
Date: Mon,  5 Apr 2010 20:40:56 +0200
Message-ID: <1270492888-26589-12-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:42:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrFh-0005ZJ-0e
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755997Ab0DESmS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:42:18 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:62876 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755978Ab0DESmN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:42:13 -0400
Received: by mail-fx0-f227.google.com with SMTP id 27so1250782fxm.28
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=SLJxkFZN2fVxq2BVL8bITVRP3MuLGHbScLwxhS3woGk=;
        b=Ejh/b1tczZnnPoL1XJMfmgAeaFprVTWNeQV7nzdAjvtbMB6/tR9TYLWCIa0Ov5qNzL
         rLBbm1Y206DVZ5u/372gpfN6QdRMliYk6xuPqfyuOUhewmj5cqfkegzVqJwoYn8CqAfF
         WNB80xcYwCKCteWbxb3Yg6Kvcc2pTSM4qtis0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=H2beANpDp+vG96wTo7iD/XAdD9g1+mpGMreEgOVGPJNSrhBpVFHB+thV50A2yXlVpr
         3xyyeTIPjljxzSumtleZc5e1ogHrfFPPxqDL4XmNOPLnlADvFiyNVxR6fGqrPB46XzsU
         Wdm1/j2QlKlRHvbQ2trguqHhFTbImHxmnTKo4=
Received: by 10.223.22.74 with SMTP id m10mr2590813fab.93.1270492932184;
        Mon, 05 Apr 2010 11:42:12 -0700 (PDT)
Received: from dektop ([212.247.124.209])
        by mx.google.com with ESMTPS id z15sm26853566fkz.51.2010.04.05.11.42.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:42:11 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:42:07 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144005>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index a8660f4..0e052c8 100644
--- a/git.c
+++ b/git.c
@@ -396,7 +396,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "version", cmd_version },
 		{ "whatchanged", cmd_whatchanged, RUN_SETUP | USE_PAGER },
 		{ "write-tree", cmd_write_tree, RUN_SETUP },
-		{ "verify-pack", cmd_verify_pack },
+		{ "verify-pack", cmd_verify_pack, RUN_SETUP_GENTLY },
 		{ "show-ref", cmd_show_ref, RUN_SETUP },
 		{ "pack-refs", cmd_pack_refs, RUN_SETUP },
 	};
--=20
1.7.0.rc1.541.g2da82.dirty
