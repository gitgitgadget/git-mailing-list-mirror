From: Enrico Weigelt <enrico.weigelt@vnc.biz>
Subject: Re: Auto-repo-repair
Date: Mon, 19 Nov 2012 23:35:34 +0100 (CET)
Message-ID: <fd162e10-46a8-433c-80b2-c1c4185c2032@zcs>
References: <CAM9Z-nmu2MiE9vF9T6Aw8vFTR8mTkuR3akHgZX6+=n3uA4fmpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 23:35:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TaZwV-0006mg-Ff
	for gcvg-git-2@plane.gmane.org; Mon, 19 Nov 2012 23:35:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754Ab2KSWfg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Nov 2012 17:35:36 -0500
Received: from zcs.vnc.biz ([83.144.240.118]:54395 "EHLO zcs.vnc.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752291Ab2KSWfg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Nov 2012 17:35:36 -0500
Received: from localhost (localhost [127.0.0.1])
	by zcs.vnc.biz (Postfix) with ESMTP id 3B77F460007;
	Mon, 19 Nov 2012 23:35:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at vnc.biz
Received: from zcs.vnc.biz ([127.0.0.1])
	by localhost (zcs.vnc.biz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AlqXLGWpN-Zn; Mon, 19 Nov 2012 23:35:34 +0100 (CET)
Received: from zcs.vnc.biz (zcs.vnc.biz [172.17.1.118])
	by zcs.vnc.biz (Postfix) with ESMTP id D655F622895;
	Mon, 19 Nov 2012 23:35:34 +0100 (CET)
In-Reply-To: <CAM9Z-nmu2MiE9vF9T6Aw8vFTR8mTkuR3akHgZX6+=n3uA4fmpA@mail.gmail.com>
X-Originating-IP: [91.43.180.96]
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC20 (Linux)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210060>


> >> How would the broken repository be sure of what it is missing to
> >> request it from the other side?
> >
> > fsck will find missing objects.
>=20
> And what about the objects referred to by objects that are missing?

Will be fetched after multiple iterations.
We could even introduce some 'fsck --autorepair' mode, which triggers
it to fetch any missing object from its remotes.

Maybe even introduce a concept of peer object stores, which (a bit like
alternates) are asked for objects that arent locally availabe - that
could be even a plain venti store.


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
