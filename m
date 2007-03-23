From: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
Subject: Re: Git / Subversion Interoperability
Date: Fri, 23 Mar 2007 12:21:02 -0300
Message-ID: <20070323152102.GA4818@c3sl.ufpr.br>
References: <20070322224829.GA7048@c3sl.ufpr.br> <20070323004335.GA17773@spearce.org> <Pine.LNX.4.64.0703230052570.2746@beast.quantumfyre.co.uk> <20070323012422.GC17773@spearce.org> <Pine.LNX.4.64.0703230128330.4001@beast.quantumfyre.co.uk> <20070323103426.GA15923@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Mar 23 16:21:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUlZm-0004za-CG
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 16:21:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945916AbXCWPVH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 23 Mar 2007 11:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945915AbXCWPVH
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 11:21:07 -0400
Received: from mx.inf.ufpr.br ([200.17.202.3]:38271 "EHLO urquell.c3sl.ufpr.br"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945916AbXCWPVF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 11:21:05 -0400
Received: from cohiba (cohiba.c3sl.ufpr.br [200.17.202.52])
	by urquell.c3sl.ufpr.br (Postfix) with SMTP id 7C752301B310;
	Fri, 23 Mar 2007 12:21:02 -0300 (BRT)
Received: by cohiba (sSMTP sendmail emulation); Fri, 23 Mar 2007 12:21:02 -0300
Content-Disposition: inline
In-Reply-To: <20070323103426.GA15923@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42940>

On Fri, Mar 23, 2007 at 11:34:26AM +0100, Karl Hasselstr=C3=B6m wrote:
> On 2007-03-23 01:36:11 +0000, Julian Phillips wrote:
>=20
> > On Thu, 22 Mar 2007, Shawn O. Pearce wrote:
> >
> > > I thought about the properties, but didn't bother to write
> > > anything on that subject as we may just be able to say "look,
> > > properties are not supported in git-svnserver, so don't try to us=
e
> > > them".
> >
> > Indeed. That's what I was aiming at with the the last sentence (not
> > very clearly unfortunately). It would be nice if the server could
> > tell the client that properties are not supported ... but I doubt
> > that it can, since they are fundamental part of Subversion.
> >
> > In particular it's how the client finds out about things like
> > symlinks and line ending conversion. It may be necessary to provide
> > some basic support for some of the properties in the svn:...
> > namespace in order for the Subversion repo access library not to
> > refuse to talk to the git server.
>=20
> Maybe the pragmatic solution would be to have built-in handling of a
> few properties such as svn:executable and svn:ignore that have git
> equivalents, and just emulate all other properties with files.

My idea is to write the git-svnserver!!! I think it will be easier.

To begin coding, i plan to write basic functions [updade,commit,checkou=
t,
copy,merge,...] then start to implement most "complex" instructions.

As spearce said before, the idea of this is to migrate from svn to git
without many trouble in transition, so basic can work as the initial th=
ought.

>=20
> --=20
> Karl Hasselstr=C3=B6m, kha@treskal.com
>       www.treskal.com/kalle

--=20
Bruno Ribas - ribas@c3sl.ufpr.br
http://web.inf.ufpr.br/ribas
C3SL: http://www.c3sl.ufpr.br=20
