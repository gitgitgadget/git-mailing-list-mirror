From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [doc] User Manual Suggestion
Date: Mon, 27 Apr 2009 01:41:59 +0200
Message-ID: <20090426234159.GD12338@atjola.homenet>
References: <m24owgqy0j.fsf@boostpro.com> <200904240051.46233.johan@herland.net> <b4087cc50904231730i1e8a005cpaf1921e23df11da6@mail.gmail.com> <200904242230.13239.johan@herland.net> <alpine.LNX.2.00.0904241655090.2147@iabervon.org> <20090424213848.GA14493@coredump.intra.peff.net> <alpine.LNX.2.00.0904241911590.2147@iabervon.org> <20090424232531.GA15136@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>,
	Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org,
	David Abrahams <dave@boostpro.com>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 27 13:08:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyE0o-0003vd-3G
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 01:43:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317AbZDZXmP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Apr 2009 19:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753042AbZDZXmP
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 19:42:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:41869 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752932AbZDZXmO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 19:42:14 -0400
Received: (qmail invoked by alias); 26 Apr 2009 23:42:12 -0000
Received: from i59F5A916.versanet.de (EHLO atjola.local) [89.245.169.22]
  by mail.gmx.net (mp001) with SMTP; 27 Apr 2009 01:42:12 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19wnKYcQ3hwqD36kjWwnIVIzqhQUZA6qhLbqP0sLY
	MWJja2nLVh8LUf
Content-Disposition: inline
In-Reply-To: <20090424232531.GA15136@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117655>

On 2009.04.24 19:25:31 -0400, Jeff King wrote:
> On Fri, Apr 24, 2009 at 07:21:26PM -0400, Daniel Barkalow wrote:
>=20
> > (And, actually, I think git has a few usability warts due to relyin=
g too=20
> > much on command line arguments being objects; it would be quite nic=
e if=20
> > "git blame 1a2b3c:Makefile" worked despite this technically being=20
> > incoherent.)
>=20
> Yeah, I think another is that "git show master:file" will not do CRLF=
 or
> other filters, and "git diff master:file other:file" will not respect
> diff settings. I think all of those could be solved by path lookup
> attaching a "here is a pathname I used to get to this object" string,
> which can then be accessed as appropriate.
>=20
> It is not all that different conceptually than what "git rev-list
> --objects" does.

It's also something that hash-object already does in some way. To apply
e.g. attributes to content that you supply via stdin.

Bj=F6rn
