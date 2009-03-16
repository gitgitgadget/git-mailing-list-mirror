From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH] Create a debugging tool "jgit rebuild-commitgraph"
Date: Mon, 16 Mar 2009 13:13:33 -0700
Message-ID: <20090316201333.GR22920@spearce.org>
References: <1236954901-30990-1-git-send-email-spearce@spearce.org> <200903151234.39367.robin.rosenberg@dewire.com> <20090316144450.GN22920@spearce.org> <200903162109.46653.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 21:15:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjJDE-00071R-N7
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 21:15:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754977AbZCPUNh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Mar 2009 16:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756598AbZCPUNf
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 16:13:35 -0400
Received: from george.spearce.org ([209.20.77.23]:60710 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361AbZCPUNf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 16:13:35 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 93E5238211; Mon, 16 Mar 2009 20:13:33 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200903162109.46653.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113364>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> m=E5ndag 16 mars 2009 15:44:50 skrev "Shawn O. Pearce" <spearce@spear=
ce.org>:
> > Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> > >=20
> > > I'd hate to put such a dangerous thing in the list of normal tool=
s. If the user
> > > want to shoot him/her-self in the foot they should get a license =
first.
> >=20
> > How about squashing this in?
>=20
> Does it have to be a utility accessible through the pgm interface? Wh=
y not=20
> just run ut as java org.spearce.jgit.pgm.debug.RebuildCommitGraph ?=20

Yea, that's fine too.  Then its "debug-rebuildcommitgraph" I think,
but that's still a reasonable name for it.
=20
> >  	@Override
> >  	protected void run() throws Exception {
> > +		if (!really && !db.getAllRefs().isEmpty()) {
> > +			final StringBuilder m =3D new StringBuilder();
> > +			m.append("fatal: ");
=2E..
> > +			System.err.println(m);
> > +			throw die("Need approval to destroy current repository");
>=20
> What's wrong with old fashioned '+' ? (which just translated to exact=
ly this series
> of StringBuilder calls anyway?

Nothing, other than formatting.  + line wraps somewhat ugly sometimes
under the Eclipse formatter.  Using StringBuilder with one append per
line and a short name for the StringBuilder variable makes it easier
to format.

--=20
Shawn.
