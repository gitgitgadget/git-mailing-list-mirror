From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Rewrite some function exit paths to avoid "unreachable code" traps
Date: Sat, 17 Nov 2007 15:31:09 +0100
Message-ID: <200711171531.09545.robin.rosenberg.lists@dewire.com>
References: <Pine.LNX.4.64.0711152317140.7416@bianca.dialin.t-online.de> <200711171139.32631.robin.rosenberg.lists@dewire.com> <20071117122317.GA2716@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Guido Ostkamp <git@ostkamp.fastmail.fm>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 15:36:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItOmU-00060B-Qr
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 15:36:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbXKQO3F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Nov 2007 09:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbXKQO3E
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 09:29:04 -0500
Received: from [83.140.172.130] ([83.140.172.130]:12001 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751361AbXKQO3D (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 09:29:03 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 3458D8026F1;
	Sat, 17 Nov 2007 15:19:52 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24809-07; Sat, 17 Nov 2007 15:19:51 +0100 (CET)
Received: from [10.9.0.5] (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id D1D2C80264D;
	Sat, 17 Nov 2007 15:19:51 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <20071117122317.GA2716@steel.home>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65281>

l=F6rdag 17 november 2007 skrev Alex Riesen:
> Robin Rosenberg, Sat, Nov 17, 2007 11:39:32 +0100:
> > l=F6rdag 17 november 2007 skrev Alex Riesen:
> > > Noticed by Guido Ostkamp for Sun's Workshop cc.
> > >=20
> > > Originally-by: Guido Ostkamp <git@ostkamp.fastmail.fm>
> > > Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> > > ---
> > > Guido Ostkamp, Fri, Nov 16, 2007 23:52:01 +0100:
> > > >
> > > > What about the xdiff/xdiffi.c problem that should also be solve=
d?
> > > >
> > >=20
> >=20
> > Please... This just looks bad. I'm sure we'll have fixup patches on=
 the list
> > to fix those gotos.=20
> >=20
> > Do we support any such stupid compiler that requires a dummy goto?
>=20
> It is more for the compilers we don't know about yet.
>=20
> Userspace programming, especially with intent to be portable, often
> means supporting *bugs* of the platform where it happens.

*If* it happens. We do not workaround every hypothetical compiler bug o=
r every hypotetical
buggy compiler. Compilers we don't know about does not "exist", expect =
for the perfectly
confirming ones, but they aren't buggy.

It seems the return in utf8.c was introduced by mistake and Junio has m=
ade his decision now.

-- robin
