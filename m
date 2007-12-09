From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH] Remove repo version check from setup_git_directory
Date: Sun, 9 Dec 2007 17:14:39 +0700
Message-ID: <20071209101439.GA18312@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 09 11:15:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1JBp-0000CE-Qe
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 11:15:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbXLIKOu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Dec 2007 05:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752006AbXLIKOt
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 05:14:49 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:40864 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbXLIKOs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 05:14:48 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1252868rvb
        for <git@vger.kernel.org>; Sun, 09 Dec 2007 02:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        bh=5T0IQZIKvHSFe+ykq3Yc5xAXVX4md2bk0dkiKRLreF4=;
        b=fOTRzXj/rqrenNdQBS7ImDXeJ4ZQh8h6yjw+YbNxbl5jzPvLNE+LbKDJzxC1lt2j/QoyoBnRnG8XbPyWB6BQ1UIBTp7owPFlyX9xVlZoTEzAGgBldBu58V+2HssGoAk6qwjSmyf0k53kegGc0et1Nk7ncFA4GsQRveoLd7/ENhg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        b=BtMdGVBHzaY8gyQe3GYaHbnPLspreIGJkgNree2jROqyUJvzwWg9XkMz17IGFwiiY5r/tipUsPCVjy68kXzIr8D2cGzZqKydW2M/nUpzGKwd+XtsxSxr+1jNSXjKfAaK5LoRMN2SjNRB3yR0Cz5Qp2UE5gY0gllAAapNvRhfi0M=
Received: by 10.141.99.4 with SMTP id b4mr1399409rvm.1197195288520;
        Sun, 09 Dec 2007 02:14:48 -0800 (PST)
Received: from pclouds@gmail.com ( [117.5.3.72])
        by mx.google.com with ESMTPS id b24sm3828613rvf.2007.12.09.02.14.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 09 Dec 2007 02:14:47 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  9 Dec 2007 17:14:39 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67613>

setup_git_directory_gently has done the check already.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Sorry, somehow I left this line behind. It should have been gone
 from my re-fix patch.

 setup.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/setup.c b/setup.c
index e96a316..b59dbe7 100644
--- a/setup.c
+++ b/setup.c
@@ -388,7 +388,6 @@ int check_repository_format(void)
 const char *setup_git_directory(void)
 {
 	const char *retval =3D setup_git_directory_gently(NULL);
-	check_repository_format();
=20
 	/* If the work tree is not the default one, recompute prefix */
 	if (inside_work_tree < 0) {
--=20
1.5.3.7.2155.g4c25
