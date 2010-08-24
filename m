From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/32] add const to ce_write()
Date: Wed, 25 Aug 2010 08:19:51 +1000
Message-ID: <1282688422-7738-2-git-send-email-pclouds@gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 00:22:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo1ss-0001Xh-Mr
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 00:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304Ab0HXWVP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 18:21:15 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:47096 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932284Ab0HXWU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 18:20:58 -0400
Received: by pzk26 with SMTP id 26so2824689pzk.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 15:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Kh5hPkDjLUtgNDTwL4S8LC/DNLFtSLe06V7cSj+vpLI=;
        b=MB1lcdYXMR7Q3d6OSd2BrEs+MPOHXJTFTlRpV29j5CHHAO5secuD2zRTEugRVLYDzy
         BXA2k2xzugFkkxuXsJsN+RkZOAso8siXuWsZoLRPFU2Jrj901RE4B4Fpe4/piO9emMg9
         DyDwV3+5JRYNDAzX7wKeA2YAxNDAtfzSqNurk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=MD5Ir/ds2Lusj/rTzFDvMF8e4KhMqAhMIBVXQ9oNLyFFoPwgQTZc+xCOEoQbk/+qgW
         JBUE8XDyFXFKzWYJza2NA98WpnAmXUMBtiC2UpfN9q8N4pICr8tjBBjD2JDV6kjUi/+A
         +/mjJBwNku05E+daA5GrdbYEN52aYNbgswVUs=
Received: by 10.114.137.8 with SMTP id k8mr8415168wad.202.1282688458443;
        Tue, 24 Aug 2010 15:20:58 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id g4sm944734wae.14.2010.08.24.15.20.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 15:20:44 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 25 Aug 2010 08:20:35 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154346>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 read-cache.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 1f42473..881dd93 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1409,7 +1409,7 @@ static int ce_write_flush(git_SHA_CTX *context, i=
nt fd)
 	return 0;
 }
=20
-static int ce_write(git_SHA_CTX *context, int fd, void *data, unsigned=
 int len)
+static int ce_write(git_SHA_CTX *context, int fd, const void *data, un=
signed int len)
 {
 	while (len) {
 		unsigned int buffered =3D write_buffer_len;
--=20
1.7.1.rc1.69.g24c2f7
