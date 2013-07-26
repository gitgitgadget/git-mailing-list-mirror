From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/4] document 'allow-tip-sha1-in-want' capability
Date: Fri, 26 Jul 2013 18:01:54 +0700
Message-ID: <1374836514-17741-1-git-send-email-pclouds@gmail.com>
References: <20130724080342.GD4425@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 26 13:01:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2fmI-0004Oe-O6
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 13:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758578Ab3GZLBi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Jul 2013 07:01:38 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:51338 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758575Ab3GZLBh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 07:01:37 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so2807749pdi.27
        for <git@vger.kernel.org>; Fri, 26 Jul 2013 04:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=zSBeZhzS1m21INItzNEFSbSYYMH0RIRE+2+j5QZljE4=;
        b=Ua1s5khWDD4KxI8PjVUxGaUbntWzZBCYEl2l6kHfgX6tOyAp45vAZK+BOvdImrg44p
         kdbjBnty0XeujJF4qHLvIsRfxRHpgPfPGy3Igjzgl3MQ2m+MsjzKuX4sdEh2QrkM+SWA
         pL2pQwRzezQdHiz4I2zJxhTCal9zy1mfWpvaLIMeDUDe/sGkG+tT1zVwcM+pKZRcfmck
         wvYK2cmr9bYjLSkNRJE/q65TBLwsIZ/ib4BxUI5zhD5OxbmsrmkEtW7LOkSAsTZ8JgR0
         OJuZ9IwPKW7WQU7KEX/y76PDpSLQM4GnuvIYGkMdPBXAZ0wdd8NrnZVpttl/0QBnsBMd
         Ye7A==
X-Received: by 10.68.238.230 with SMTP id vn6mr38827282pbc.66.1374836497209;
        Fri, 26 Jul 2013 04:01:37 -0700 (PDT)
Received: from lanh ([115.73.246.132])
        by mx.google.com with ESMTPSA id fa5sm18620633pbb.3.2013.07.26.04.01.33
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 26 Jul 2013 04:01:36 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 26 Jul 2013 18:02:02 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <20130724080342.GD4425@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231180>

See 390eb36 (upload-pack: optionally allow fetching from the tips of
hidden refs - 2013-01-28) for more information.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Maybe this too for completeness..

 Documentation/technical/protocol-capabilities.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/technical/protocol-capabilities.txt b/Docume=
ntation/technical/protocol-capabilities.txt
index ec131b6..31cbe07 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -210,3 +210,10 @@ be shown when processing the received pack. A send=
-pack client should
 respond with the 'quiet' capability to suppress server-side progress
 reporting if the local progress reporting is also being suppressed
 (e.g., via `push -q`, or if stderr does not go to a tty).
+
+allow-tip-sha1-in-want
+----------------------
+
+If the upload-pack server advertises this capability, fetch-pack may
+send "want" lines with SHA-1s that exist at the server but are not
+advertised by upload-pack.
--=20
1.8.2.83.gc99314b
