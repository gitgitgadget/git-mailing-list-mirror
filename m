From: "Yossi Leybovich" <sleybo@mellanox.co.il>
Subject: RE: corrupt object on git-gc
Date: Fri, 9 Nov 2007 14:16:39 +0200
Message-ID: <6C2C79E72C305246B504CBA17B5500C9029A36F1@mtlexch01.mtl.com>
References: <6C2C79E72C305246B504CBA17B5500C902535D9C@mtlexch01.mtl.com> <458BC6B0F287034F92FE78908BD01CE814472B3D@mtlexch01.mtl.com> <6C2C79E72C305246B504CBA17B5500C9029A36A1@mtlexch01.mtl.com> <200711090613.17566.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: "Christian Couder" <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Nov 09 13:17:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqSnG-0003dI-5W
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 13:17:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbXKIMQr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Nov 2007 07:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752129AbXKIMQr
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 07:16:47 -0500
Received: from mail.mellanox.co.il ([194.90.237.44]:47226 "EHLO mellanox.co.il"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751523AbXKIMQq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Nov 2007 07:16:46 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from sleybo@mellanox.co.il)
	with SMTP; 9 Nov 2007 14:16:43 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <200711090613.17566.chriscool@tuxfamily.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: corrupt object on git-gc
Thread-Index: Acgijkua51aeQ6g5TAW3SY3Rpx/hoAAO9WTA
x-pineapp-mail-mail-from: sleybo@mellanox.co.il
x-pineapp-mail-rcpt-to: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64170>


Just tried it :

sleybo@SLEYBO-LT /w/work/EMC/ib.071030.001/ib
$ git-cat-file.exe -p 4b9458b3786228369c63936db65827de3cc06200
error: corrupt loose object '4b9458b3786228369c63936db65827de3cc06200'
fatal: Cannot read object 4b9458b3786228369c63936db65827de3cc06200

Is this say something ?

Yossi=20

> -----Original Message-----
> From: Christian Couder [mailto:chriscool@tuxfamily.org]
> Sent: Friday, November 09, 2007 12:13 AM
> To: Yossi Leybovich
> Cc: git@vger.kernel.org
> Subject: Re: corrupt object on git-gc
>=20
> Le vendredi 9 novembre 2007, Yossi Leybovich a =E9crit :
> >
> > Unfortunately I can't get this object from backup directories as
> advise
> > in the FAQ.
> > Can this object manually fixed by any tool? (the object is attached=
)
> I
> > don't even know to which file/tree/commit it belong how can I know
> that
> > ?
>=20
> Could you try something like:
>=20
> git-cat-file -p 4b9458b3786228369c63936db65827de3cc06200
>=20
> in your repository ?
>=20
> Thanks,
> Christian.
