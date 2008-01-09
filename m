From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git svn fetch segfaults
Date: Wed, 9 Jan 2008 21:53:54 +0100
Message-ID: <20080109205354.GA1433@atjola.homenet>
References: <200801082325.45756.devurandom@gmx.net> <20080109003307.GS29972@genesis.frugalware.org> <200801091353.44630.devurandom@gmx.net> <7v4pdmiwo4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dennis Schridde <devurandom@gmx.net>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 21:54:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JChwP-0005ZW-R0
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 21:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753229AbYAIUx6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jan 2008 15:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752408AbYAIUx6
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 15:53:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:58089 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752839AbYAIUx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 15:53:58 -0500
Received: (qmail invoked by alias); 09 Jan 2008 20:53:56 -0000
Received: from i577ADAF5.versanet.de (EHLO localhost) [87.122.218.245]
  by mail.gmx.net (mp050) with SMTP; 09 Jan 2008 21:53:56 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19/K1kwk6J/n4ym/y0ObOztQKZkXfbLCUw8kS5HBe
	GTJQXO9lXbNAr1
Content-Disposition: inline
In-Reply-To: <7v4pdmiwo4.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-12-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70013>

On 2008.01.09 12:14:19 -0800, Junio C Hamano wrote:
> Dennis Schridde <devurandom@gmx.net> writes:
>=20
> > Am Mittwoch, 9. Januar 2008 01:33:07 schrieb Miklos Vajna:
> >> On Tue, Jan 08, 2008 at 11:25:45PM +0100, Dennis Schridde=20
> > <devurandom@gmx.net> wrote:
> >> > mkdir org.gna.warzone2100.git
> >> > cd org.gna.warzone2100.git
> >> > git --bare init
> >> > git --bare svn init --use-svnsync-props --stdlayout
> >> > file:///var/svn/warzone2100/
> >> > git --bare svn fetch
> >>
> >> wget http://svn.kynes.de/warzone2100.bz2
> >>
> >> svnadmin create warzone2100 && bzcat warzone2100.bz2 | svnadmin lo=
ad
> >> warzone2100
> >>
> >> the rest is the same i get a segfault at the very same place.
> >>
> >> > If I do not specify --use-svnsync-prop to "git svn init", it get=
s past
> >> > r13 in tags/1.10a.
> >>
> >> same.
> >>
> >> > I am using these versions:
> >> > svn, version 1.4.6 (r28521)
> >> > git version 1.5.4.rc2
> >>
> >> $ svn --version
> >> svn, version 1.4.5 (r25188)
> >>
> >> $ git --version
> >> git version 1.5.4.rc2.38.gd6da3
> > Same with git version 1.5.3.7
>=20
> Has anybody determined which executable is the segfaulting one?

I just tried to, but it's still running, at r600 now.

> If it is svn executable spawned by Perl that runs git-svn, or
> libsvn shared object linked to Perl while running git-svn, I
> suspect testing with different git versions will not be very
> productive.

Oh well, anyway, just for the record:
doener@atjola:~ $ svn --version
svn, version 1.4.4 (r25188)

doener@atjola:~ $ git --version
git version 1.5.4.rc1.11.gd2f82

Bj=F6rn
