From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH RFC] Move all dashed form git commands to libexecdir
Date: Tue, 27 Nov 2007 22:02:29 +0700
Message-ID: <20071127150229.GA14859@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 27 16:03:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix1xk-0007uW-Jy
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 16:03:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754731AbXK0PCl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Nov 2007 10:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752478AbXK0PCl
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 10:02:41 -0500
Received: from an-out-0708.google.com ([209.85.132.241]:52672 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752893AbXK0PCk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 10:02:40 -0500
Received: by an-out-0708.google.com with SMTP id d31so212969and
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 07:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        bh=wwRiroShaGjWGGqne/aGJ6+CLXm1l+FNbuaqwqCxFlQ=;
        b=k57ci1Mc+MVQtuCIKku59rM9Hx12iALeQp6eqPC6BpIFUVtyivEFx24HkSn2II0M6ggUlSMOAaLR7IPaBh/0+QjLLvEw2FrPWzZptux8xwTf7KZYGIZJMkrl2zcDI/zhkQS2LVAN/cgyOrlYx/nmKTWx9KWXD0F51ucw1qOugJI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        b=jmPodqe+cP9i/J/i10rApAuptECA+bj33jGAAq13WuaPrZuj0yGFX1afn4o56RHLMNriNyKVcqeNSoOdZSfnk37g4/j8OHuf2P9i1WmxXccjFP7f8cpOighMLlUe4UPbR5fM+2gG6kezQCIHoCIfv+1YFTQwmDBQuPqcbgc8a4Y=
Received: by 10.100.249.9 with SMTP id w9mr6680548anh.1196175759749;
        Tue, 27 Nov 2007 07:02:39 -0800 (PST)
Received: from pclouds@gmail.com ( [117.5.1.249])
        by mx.google.com with ESMTPS id d24sm4082804and.2007.11.27.07.02.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Nov 2007 07:02:39 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 27 Nov 2007 22:02:29 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66222>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 We have talked about it for quite some time now. How about
 making it happen? I won't miss dashed form commands much :)

 A compromised approach could be keeping porcelain commands
 in bindir, only plumbings are moved to libexecdir. That would
 be less shock than this.

 config.mak.in |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/config.mak.in b/config.mak.in
index 11d256e..1db0338 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -11,7 +11,7 @@ TCLTK_PATH =3D @TCLTK_PATH@
 prefix =3D @prefix@
 exec_prefix =3D @exec_prefix@
 bindir =3D @bindir@
-#gitexecdir =3D @libexecdir@/git-core/
+gitexecdir =3D @libexecdir@/git-core/
 datarootdir =3D @datarootdir@
 template_dir =3D @datadir@/git-core/templates/
=20
--=20
1.5.3.GIT
