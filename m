From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/5] diff: add space around "="
Date: Mon, 16 Jan 2012 11:47:57 +0700
Message-ID: <1326689281-23788-2-git-send-email-pclouds@gmail.com>
References: <1326689281-23788-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 05:48:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmeUm-0002V1-D2
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 05:48:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289Ab2APEsc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Jan 2012 23:48:32 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34863 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232Ab2APEsX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jan 2012 23:48:23 -0500
Received: by mail-iy0-f174.google.com with SMTP id f6so1947623iag.19
        for <git@vger.kernel.org>; Sun, 15 Jan 2012 20:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=hSoVPAemGnQvWvkvDzVlB+PsvXge5OYK198R0hEx65w=;
        b=lS8raj8AVw+0lSUz6+LP7N9BhsLdlyfJsZHblugkxEjWJbBawcO2bdYlLGx9Jvgxua
         pB5dzMsmybxIA0nx2jXZ8hjJnG2+kIKUDKWDF9bLuSR/tQnoWzgSfAXpJzulwN5eDsQG
         3UTD9D+VPw4+tamTw4fIdYxrRiyc4M5DyRUe4=
Received: by 10.50.173.98 with SMTP id bj2mr8468568igc.27.1326689303041;
        Sun, 15 Jan 2012 20:48:23 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id l28sm61395551ibc.3.2012.01.15.20.48.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 15 Jan 2012 20:48:22 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 16 Jan 2012 11:48:12 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1326689281-23788-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188610>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index 374ecf3..d4223e2 100644
--- a/diff.c
+++ b/diff.c
@@ -1482,7 +1482,7 @@ static void show_shortstats(struct diffstat_t *da=
ta, struct diff_options *option
 		if (!data->files[i]->is_binary &&
 		    !data->files[i]->is_unmerged) {
 			int added =3D data->files[i]->added;
-			int deleted=3D data->files[i]->deleted;
+			int deleted =3D data->files[i]->deleted;
 			if (!data->files[i]->is_renamed &&
 			    (added + deleted =3D=3D 0)) {
 				total_files--;
--=20
1.7.3.1.256.g2539c.dirty
