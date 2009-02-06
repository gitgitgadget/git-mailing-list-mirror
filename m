From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Chicken/egg problem building from a 'git clone'
Date: Fri, 6 Feb 2009 06:14:34 +0100
Message-ID: <20090206051434.GB31491@atjola.homenet>
References: <alpine.DEB.1.00.0902060530450.10279@pacific.mpi-cbg.de> <Pine.LNX.4.44.0902052238510.4851-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Joi Ellis <gyles19@visi.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 06:16:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVJ4k-0005wC-Br
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 06:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbZBFFOq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Feb 2009 00:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbZBFFOp
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 00:14:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:44048 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750952AbZBFFOo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 00:14:44 -0500
Received: (qmail invoked by alias); 06 Feb 2009 05:14:42 -0000
Received: from i577BA589.versanet.de (EHLO atjola.local) [87.123.165.137]
  by mail.gmx.net (mp007) with SMTP; 06 Feb 2009 06:14:42 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19mSG9kiYFmmLAULo368z+2TxNCu8Ut9KmilFAp9I
	HURLpk6jPSiQkI
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0902052238510.4851-100000@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108656>

On 2009.02.05 22:45:13 -0600, Joi Ellis wrote:
> On Fri, 6 Feb 2009, Johannes Schindelin wrote:
>=20
> > Hi,
> >=20
> > On Fri, 6 Feb 2009, Joi Ellis wrote:
> >=20
> > > "make all" fails becuase my libaries are old:
> > >=20
> > >     LINK git-fast-import
> > > fast-import.o: In function `store_object':
> > > /usr/local/src/git/git/fast-import.c:1086: undefined reference to=
 `deflateBound'
> > > /usr/local/src/git/git/fast-import.c:1109: undefined reference to=
 `deflateBound'
> >=20
> > You need to install a newer libz.  (And this is not a chicken & egg=
=20
> > problem.)
>=20
> Yes, this *is* a chicken & egg problem.

No, it's not. It would be one if you needed git to update your zlib or
autoconf. But you don't, so you could simply update zlib or autoconf.
There's no circular dependency. You can even just do "make
NO_DEFLATE_BOUND=3D1" and be done with it...

Bj=F6rn
