From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/18] verify-pack: use RUN_SETUP_GENTLY
Date: Sun,  7 Mar 2010 11:56:00 +0700
Message-ID: <1267937767-12504-12-git-send-email-pclouds@gmail.com>
References: <1267937767-12504-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 06:10:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No8iR-0002Jh-LL
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 06:07:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308Ab0CGFHm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Mar 2010 00:07:42 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47409 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702Ab0CGFHm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 00:07:42 -0500
Received: by pwj8 with SMTP id 8so3158578pwj.19
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 21:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=MzZmo/KjkPEXeE4HPtgbh5OzxH0Inlop4fZOstiRTMw=;
        b=jT8xIVRHvKDSzgCMx2eqKp9D87TrCE1GZAmZ35GrTnL5Jq+JVtFAv6LiswB4kJOz51
         85bWZK+T3OHfDEAMNCxXM9elO32YxxBg517/PHbLG2V7bOlqz9mvnI57KEnd3cp3IPMw
         jG4ST5+P65UTC6YwtPf2wcfVAmXBPqPfQmH4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ZK9Mjc6e3aKsN13cxCpJqVcuZAuh9rZNjksb32Gt0Alz56EixFyLRayqNx8fnoAbQg
         9Vwc2jvhsMv1TkLlWrwd3KpHplxai20Rdd4p1Jg2D0NKkS4IfKW9CRDXfmCtwaYXcyzF
         FmCtaeCM//oYkFSwrCOVFXrzgxz9XFk9S0gXI=
Received: by 10.143.153.14 with SMTP id f14mr2089349wfo.255.1267938010630;
        Sat, 06 Mar 2010 21:00:10 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.223.3])
        by mx.google.com with ESMTPS id 20sm3274356pzk.15.2010.03.06.21.00.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Mar 2010 21:00:10 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  7 Mar 2010 11:56:55 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1267937767-12504-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141667>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
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
1.7.0.195.g637a2
