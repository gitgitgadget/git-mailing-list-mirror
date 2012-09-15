From: Enrico Weigelt <enrico.weigelt@vnc.biz>
Subject: Re: Failing svn imports from apache.org
Date: Sat, 15 Sep 2012 12:07:51 +0200 (CEST)
Message-ID: <974faf03-e8e6-4b98-81df-e2bd4d9ae77a@zcs>
References: <505302EB.8040600@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Sep 15 12:08:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCpID-0002FB-WC
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 12:08:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781Ab2IOKHy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Sep 2012 06:07:54 -0400
Received: from zcs.vnc.biz ([83.144.240.118]:42933 "EHLO zcs.vnc.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190Ab2IOKHx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Sep 2012 06:07:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by zcs.vnc.biz (Postfix) with ESMTP id ECFE36228EB;
	Sat, 15 Sep 2012 12:07:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at vnc.biz
Received: from zcs.vnc.biz ([127.0.0.1])
	by localhost (zcs.vnc.biz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SiL9ZJ-IWEZK; Sat, 15 Sep 2012 12:07:51 +0200 (CEST)
Received: from zcs.vnc.biz (zcs.vnc.biz [172.17.1.118])
	by zcs.vnc.biz (Postfix) with ESMTP id 7B7436228E8;
	Sat, 15 Sep 2012 12:07:51 +0200 (CEST)
In-Reply-To: <505302EB.8040600@drmicha.warpmail.net>
X-Originating-IP: [91.43.185.93]
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC18 (Linux)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205548>


> > Does anyone have an idea, what might be wrong here / how to fix it
> > ?
>=20
> Here: git svn --version
> git-svn version 1.7.12.592.g41e7905 (svn 1.6.18)
>=20
> What's yours?

1.7.9.5 (ubuntu precise)
=20
> I'm getting
>=20
> Initialized empty Git repository in /tmp/discovery/.git/
> Using higher level of URL:
> http://svn.apache.org/repos/asf/commons/proper/discovery =3D>
> http://svn.apache.org/repos/asf
> W: Ignoring error from SVN, path probably does not exist: (160013):
> Dateisystem hat keinen Eintrag: File not found: revision 100, path
> '/commons/proper/discovery'
> W: Do not be alarmed at the above message git-svn is just searching
> aggressively for old history.
> This may take a while on large repositories
>=20
> and then it checks the revisions. I didn't want to wait for
> r1301705...
>=20
> Does your git svn abort earlier or after checking all revs?

It also scanned through thousands of revisions and then failed:

W: Do not be alarmed at the above message git-svn is just searching agg=
ressively for old history.
This may take a while on large repositories
mkdir .git: No such file or directory at /usr/lib/git-core/git-svn line=
 3669


cu
--=20
Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards=20

Enrico Weigelt=20
VNC - Virtual Network Consult GmbH=20
Head Of Development=20

Pariser Platz 4a, D-10117 Berlin
Tel.: +49 (30) 3464615-20
=46ax: +49 (30) 3464615-59

enrico.weigelt@vnc.biz; www.vnc.de=20
