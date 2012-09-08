From: Enrico Weigelt <enrico.weigelt@vnc.biz>
Subject: Re: Encrypted repositories
Date: Sat, 08 Sep 2012 05:34:48 +0200 (CEST)
Message-ID: <0666bd29-b156-4c3d-b859-ab140d2f849e@zcs>
References: <7vmx132aph.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 08 05:35:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TABpa-0003nX-RI
	for gcvg-git-2@plane.gmane.org; Sat, 08 Sep 2012 05:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759077Ab2IHDfW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Sep 2012 23:35:22 -0400
Received: from zcs.vnc.biz ([83.144.240.118]:57580 "EHLO zcs.vnc.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752287Ab2IHDeu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Sep 2012 23:34:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by zcs.vnc.biz (Postfix) with ESMTP id EEF6D6228CB;
	Sat,  8 Sep 2012 05:34:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at vnc.biz
Received: from zcs.vnc.biz ([127.0.0.1])
	by localhost (zcs.vnc.biz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Euphtyq5wnE1; Sat,  8 Sep 2012 05:34:48 +0200 (CEST)
Received: from zcs.vnc.biz (zcs.vnc.biz [172.17.1.118])
	by zcs.vnc.biz (Postfix) with ESMTP id 9213B62225F;
	Sat,  8 Sep 2012 05:34:48 +0200 (CEST)
In-Reply-To: <7vmx132aph.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [91.43.202.136]
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC18 (Linux)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205006>


> > Well, everybody can access the objects, but they're encrypted,
> > so you need the repo key (which, of course isn't contained in
> > the repo itself ;-p) to decrypt them.
>=20
> So, in short, blobs are not encrypted with the hash of their
> contents as encryption keys at all.

No, the blobs are encrypted with their content hash as key, and the
encrypted blob will be stored with it's content hash as object id.

> > For the usecases I have in mind (backups, filesharing, etc) this
> > wouldn't hurt so much, if the objects are compressed before
> > encryption.
>=20
> For that kind of usage pattern, you are better off looking at
> encrypted tarballs or zip archives.

No, that doesn't give us anything like history, incremental
synchronization, etc, etc.

What I finnaly wanna has is a usual git, just with encryption,
but I can live with loosing differential compression.


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
