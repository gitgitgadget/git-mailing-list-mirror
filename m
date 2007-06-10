From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Port git-tag.sh to C.
Date: Sun, 10 Jun 2007 14:37:49 +0200
Message-ID: <200706101437.50441.robin.rosenberg.lists@dewire.com>
References: <11813427591137-git-send-email-krh@redhat.com> <7v7iqdf0gn.fsf@assigned-by-dhcp.cox.net> <466B376D.8040303@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kristian =?utf-8?q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 14:37:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxMfd-0002BP-3w
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 14:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753633AbXFJMhM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 10 Jun 2007 08:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752448AbXFJMhM
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 08:37:12 -0400
Received: from [83.140.172.130] ([83.140.172.130]:17324 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752141AbXFJMhK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jun 2007 08:37:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 54B428027FA;
	Sun, 10 Jun 2007 14:30:34 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 27959-09; Sun, 10 Jun 2007 14:30:34 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id E96E9800784;
	Sun, 10 Jun 2007 14:30:33 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <466B376D.8040303@redhat.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49721>

s=C3=B6ndag 10 juni 2007 skrev Kristian H=C3=B8gsberg:
> Junio C Hamano wrote:
> > Kristian H=C3=B8gsberg <krh@redhat.com> writes:
> >=20
> >> Content-Type: TEXT/PLAIN; charset=3DISO-8859-1
> >>
> >> From: Kristian H=C3=83=C2=B8gsberg <krh@redhat.com>
> >>
> >> A more or less straight-forward port of git-tag.sh to C.
> >>
> >> Signed-off-by: Kristian H=C3=83=C2=B8gsberg <krh@redhat.com>
> >> Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> >=20
> > I think your name in your commit message is in UTF-8 but munged you=
r
> > mail was mismarked as iso-8859-1.
>=20
> That's odd both the email I cc'ed to my redhat.com address and the on=
e I got=20
> on gmail.com through the list have
>=20
>    Content-Type: text/plain; charset=3Dutf-8
>=20
> and saving the raw message and asking /usr/bin/file, it tells me its
>=20
>    /home/krh/Desktop/hep: UTF-8 Unicode mail text

Maybe Junio's mail server has a problem with the impliction of this hea=
der line?=20

"Content-Transfer-Encoding: 8bit" ?

-- robin
