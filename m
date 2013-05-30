From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] git.txt: document GIT_TRACE_PACKET
Date: Thu, 30 May 2013 20:51:48 +0700
Message-ID: <1369921908-2988-2-git-send-email-pclouds@gmail.com>
References: <1369921908-2988-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 15:50:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui3Fg-0001Cy-8p
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 15:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268Ab3E3Nuj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 May 2013 09:50:39 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:63783 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932244Ab3E3Nug (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 09:50:36 -0400
Received: by mail-pd0-f172.google.com with SMTP id 10so386376pdi.31
        for <git@vger.kernel.org>; Thu, 30 May 2013 06:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=1HAb/NrtQvt2uB0UaSzXk9UIePZkx8O11DaLutngxfw=;
        b=Tvy9gxpFXMy+90tN6X0A7ECpr3bzcfDbAGrDNPY7cS2jKuj8V3W+nlEqCuiQFTTIH9
         MvEtQDapsAJCESA1fMKe1gjjC2R7ecZrXBeZ2GqkfIiEW/12Wi95cOiSKEGSrfMyyMNT
         I2u21LzmNdPh+xh2fmUa2gv6Gy+CYkXTU2ROynJ56i10T6s42CoqThU0cqqHs+KnI0bc
         wdPI+jZxr15CZlhufKRLbsRWft2LjUPZa9/KKgHFukb7bW1gNeEMWwqe6BEMtvkpq+hY
         WT+QWubXXJth1LNF2pAFt44ROodN9Mzy/sssATpFZvh6WypCPlJDEXhlcqy5+hTfp454
         tKiw==
X-Received: by 10.68.8.232 with SMTP id u8mr8187821pba.184.1369921834551;
        Thu, 30 May 2013 06:50:34 -0700 (PDT)
Received: from lanh ([115.73.234.90])
        by mx.google.com with ESMTPSA id lq4sm44919087pab.19.2013.05.30.06.50.31
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 30 May 2013 06:50:33 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 30 May 2013 20:51:56 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1369921908-2988-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225992>

"This can help with debugging object negotiation or other protocol
issues."

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 3e74440..12ef7a2 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -839,6 +839,11 @@ for further details.
 	recorded. This may be helpful for troubleshooting some
 	pack-related performance problems.
=20
+'GIT_TRACE_PACKET'::
+	If this variable is set, it shows a trace of all packets
+	coming in or out of a given program. This can help with
+	debugging object negotiation or other protocol issues.
+
 GIT_LITERAL_PATHSPECS::
 	Setting this variable to `1` will cause Git to treat all
 	pathspecs literally, rather than as glob patterns. For example,
--=20
1.8.2.83.gc99314b
