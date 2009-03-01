From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Chicken/egg problem building from a 'git clone'
Date: Sun, 1 Mar 2009 17:34:29 +0100
Message-ID: <20090301163429.GB6289@atjola.homenet>
References: <7vskmr43le.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.44.0903010945290.4675-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Miles Bader <miles@gnu.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Joi Ellis <gyles19@visi.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 17:36:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ldoe3-00040h-Oy
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 17:36:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523AbZCAQef convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Mar 2009 11:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752905AbZCAQef
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 11:34:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:59299 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753141AbZCAQee (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 11:34:34 -0500
Received: (qmail invoked by alias); 01 Mar 2009 16:34:31 -0000
Received: from i577B8BC7.versanet.de (EHLO atjola.local) [87.123.139.199]
  by mail.gmx.net (mp038) with SMTP; 01 Mar 2009 17:34:31 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/gHAMOIung/DiIUTFWpbiEdS5zqUbygKgZORhosm
	vK6br+dpJdxH7c
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0903010945290.4675-100000@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111852>

On 2009.03.01 09:56:46 -0600, Joi Ellis wrote:
> On Fri, 6 Feb 2009, Junio C Hamano wrote:
>=20
> > Jeff King <peff@peff.net> writes:
> >=20
> > > Now, in this case, it was only one tweak and other responders hav=
e
> > > already pointed him in the right direction. So just making that t=
weak
> > > manually is probably the sane thing to do in this situation.
> > >
> > > But I wanted to point out that autoconf is not totally without va=
lue
> > > here.
> >=20
> > I am not saying something that strong, either.  If autoconf generat=
ed
> > configure works _for you_ without hassle, great.  Keep using it.
> >=20
> > The original message that started this thread was what to do when i=
t does
> > NOT work for you, and my point was in general it is much nicer to p=
oint at
> > the knob to tweak from the make invocation command line (or in conf=
ig.mak)
> > than having you spend time on upgrade autoconf, generate configure =
and run
> > it.
>=20
> Actually, guys, if you go back and re-read my original message, I was
> pointing out that if you use a 'git clone' to get a build tree, THERE=
 IS
> NO CONFIGURE SCRIPT in the tree.

And Junio was talking about the Makefile not working for you. And btw,
if you want a real chicken/egg problem, go complaining to the autoconf
folks that the autoconf git repository has no configure script either.
And autoconf actually requires autoconf for bootstrapping AFAICT, while
git does not. I'm sure they'll be happy to explain to you why having a
generated configure script in the repo is not a good idea.

Bj=F6rn
