From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/6] protocol-capabilities.txt: refer multi_ack_detailed back to pack-protocol.txt
Date: Thu,  6 Feb 2014 22:10:37 +0700
Message-ID: <1391699439-22781-5-git-send-email-pclouds@gmail.com>
References: <1391699439-22781-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 06 16:11:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBQcM-0005gS-2N
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 16:11:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753886AbaBFPLt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Feb 2014 10:11:49 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:49174 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753736AbaBFPLt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 10:11:49 -0500
Received: by mail-pa0-f44.google.com with SMTP id kq14so1796311pab.3
        for <git@vger.kernel.org>; Thu, 06 Feb 2014 07:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=BDMX15ouhoV9wHgxwtxFgVvQ0IuKkrL+vwchm5YU/yU=;
        b=SmT6DkjiAaKS5XDBgoEpNVYuyhfQWJNSS1gp266nzZsrA9n9ZY/oxrrKjiFNt3lnsQ
         UihG2+7n1O2ozMdgoVDvJGe4PGJmzuWxKMFSMgI0mszgAUCA9d7HESFmtindul2j3jdu
         UASGNnWg/Bou57vcb4+Iu2KsZKidiK0StJAOAQvfi0a24HszPrAnkP/uTRf7BUR5TiVk
         5hSqhMU4fBGh/t4hSFX3Udy2cGXRUnsh2oz6Us9vdCYl5YgeAeV85ftNEKkhDGS4eGpT
         Eglgjqoyz2DYOtn7ZbOqUGL8ofSU9hzDT612RFSL0Ez7FbcgpLl1FXqLGlJ6gD28IxF3
         Wj7A==
X-Received: by 10.66.163.2 with SMTP id ye2mr1172343pab.110.1391699508683;
        Thu, 06 Feb 2014 07:11:48 -0800 (PST)
Received: from lanh ([115.73.207.183])
        by mx.google.com with ESMTPSA id e3sm4379990pbc.17.2014.02.06.07.11.45
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 06 Feb 2014 07:11:48 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 06 Feb 2014 22:11:48 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391699439-22781-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241697>

pack-protocol.txt explains in detail how multi_ack_detailed works and
what's the difference between no multi_ack, multi_ack and
multi_ack_detailed. No need to repeat here.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/technical/protocol-capabilities.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/technical/protocol-capabilities.txt b/Docume=
ntation/technical/protocol-capabilities.txt
index e3e7924..cb40ebb 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -69,6 +69,12 @@ ends.
 Without multi_ack the client would have sent that c-b-a chain anyway,
 interleaved with S-R-Q.
=20
+multi_ack_detailed
+------------------
+This is an extension of multi_ack that permits client to better
+understand the server's in-memory state. See pack-protocol.txt,
+section "Packfile Negotiation" for more information.
+
 thin-pack
 ---------
=20
--=20
1.8.5.2.240.g8478abd
