From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Implementing stat() with FindFirstFile()
Date: Mon, 30 Mar 2009 07:11:18 +0200
Message-ID: <20090330051118.GA2681@atjola.homenet>
References: <20090321154738.GA27249@jeeves.jpl.local> <200903212055.15026.j6t@kdbg.org> <20090324215416.GB27249@jeeves.jpl.local> <49CB2BA5.1070100@viscovery.net> <20090326213907.GC27249@jeeves.jpl.local> <alpine.DEB.1.00.0903270320020.10279@pacific.mpi-cbg.de> <20090329224803.GD27249@jeeves.jpl.local> <alpine.DEB.1.00.0903300245080.6454@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Magnus =?iso-8859-1?Q?B=E4ck?= <baeck@swipnet.se>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 30 07:47:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoALL-0003K5-Kd
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 07:47:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758035AbZC3Fpc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2009 01:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757996AbZC3Fpb
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 01:45:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:57521 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757940AbZC3Fpa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 01:45:30 -0400
Received: (qmail invoked by alias); 30 Mar 2009 05:45:27 -0000
Received: from i59F55306.versanet.de (EHLO atjola.local) [89.245.83.6]
  by mail.gmx.net (mp052) with SMTP; 30 Mar 2009 07:45:27 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19X/dxOAuxXgUmAaQF1Q/36IvKVPkSt3f5bLlPOsK
	hoUSkw6ZVozcwF
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0903300245080.6454@intel-tinevez-2-302>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115081>

On 2009.03.30 02:52:47 +0200, Johannes Schindelin wrote:
> On Mon, 30 Mar 2009, Magnus B=E4ck wrote:
> > On Friday, March 27, 2009 at 03:25 CET,
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > On Thu, 26 Mar 2009, Magnus B=E4ck wrote:
> > > > I'd be very surprised if ZwQueryDirectoryFile() hasn't always b=
een
> > > > around (I just verified ntdll.dll from NT 4.0), so that's not a
> > > > worry. Don't know why MSDN reports it as introduced in XP.
> > >
> > > As the current maintainer of msysGit, I refuse to have something =
in
> > > the installer I ship that relies on not-at-all guaranteed interfa=
ces.
> >=20
> > Although I do appreciate the importance of guaranteed interfaces,
> > I am also pragmatic. An incompatible change in ntdll.dll would brea=
k
> > vast amounts of programs, including cygwin. There is a lot to be sa=
id
> > about Microsoft and their APIs, but I don't think they have a habit=
 of
> > changing ABIs or function semantics for userland libraries that hav=
e
> > been around for 15 years.
>=20
> Had you pointed to some document that states that the function has be=
en in=20
> all NT-based versions, that would have done the trick.

Not official documentation, but at least from some MS guy it seems:
http://www.osronline.com/showThread.cfm?link=3D73086 (last message).

Apparently, it was in NT3.x, but they document only what's actually
defined in the header.

Bj=F6rn, feeling weird for trying to help with some Windows issue...
