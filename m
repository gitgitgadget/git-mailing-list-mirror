From: Michael Niedermayer <michaelni@gmx.at>
Subject: Re: FFmpeg considering GIT
Date: Fri, 4 May 2007 22:24:49 +0200
Message-ID: <20070504202448.GD14859@MichaelsNB>
References: <loom.20070502T111026-882@post.gmane.org> <20070503180016.GB21333@informatik.uni-freiburg.de> <20070503200013.GG4489@pasky.or.cz> <loom.20070504T143538-533@post.gmane.org> <87y7k4lahq.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FhvelBhrd33NvMcY"
Cc: git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Fri May 04 22:28:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk4O0-0006Xd-De
	for gcvg-git@gmane.org; Fri, 04 May 2007 22:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S376137AbXEDU2G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 16:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S376141AbXEDU2G
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 16:28:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:47417 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S376137AbXEDU2C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 16:28:02 -0400
Received: (qmail invoked by alias); 04 May 2007 20:27:59 -0000
Received: from chello080109116125.4.15.vie.surfer.at (EHLO localhost) [80.109.116.125]
  by mail.gmx.net (mp003) with SMTP; 04 May 2007 22:27:59 +0200
X-Authenticated: #3831892
X-Provags-ID: V01U2FsdGVkX1/XQzVZuibXc4FxH6GpvR5jVzwQcH3fGTruPtUEUF
	K4mopeloVitwqv
Content-Disposition: inline
In-Reply-To: <87y7k4lahq.wl%cworth@cworth.org>
User-Agent: Mutt/1.5.10i
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46213>


--FhvelBhrd33NvMcY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, May 04, 2007 at 11:17:05AM -0700, Carl Worth wrote:
> On Fri, 4 May 2007 13:46:28 +0000 (UTC), Michael Niedermayer wrote:
> > well, my example above was exagerated, noone ever reindented the whole
> > ffmpeg or checked in a old version over HEAD. what did and does occasio=
nally
> > happen is that people check in several things at once (like a 100k rein=
denton
> > mixed with various functional changes)
>=20
> That sounds like an opportunity to educate your contributors a bit on
> what good commits should look like.=20

we have a nice svn policy which explains that, also people wont receive
write access without having submitted a few clean patches first
so i dont know if more education would really help, the problems are IMHO
rather caused by a mix of lazyness, arrogance and plain oversight
but please dont missunderstand, these problems are not that common, its
rather once every few month


> So I think this is more a social
> issue than a technical issue,=20

yes i think so too, the added push after commit wont stop a bad commit
as the developer already saw the change when running svn diff ...


> (but git has some technical means that
> make it much easier to address the social issues).
>=20
> Your description above makes an assumption that there is a single
> central repository that multiple people push changes into, (which is
> really the only way to organize a project with svn or cvs). And with
> those systems all you get is a bit than you can flip on for whether
> you trust someone to push changes into the repository or not. But git
> is much more flexible than that.
>=20
> The opposite extreme is to organize the project in a way similar to
> the linux kernel---all contributors maintain their own repositories
> and things get merged only when a maintainer reviews and pulls. With
> this approach, garbage never lands in your own repository by
> definition, (since you don't pull if it looks like garbage to you). So
> that solves the problem, but this organization might seem too radical
> a shift for your project.

yes, id like to switch ffmpeg to git or mercurial as that seems like a
good idea and many of our developers seem to want it, the question
about the organization is a different thing, not a single ffmpeg=20
developer suggested to change the current "every developer has write access"
system, actually its even more than just that, almost every mplayer
developer has technically write access to ffmpeg and almost every ffmpeg
developer has technically write access to mplayer and this has never
caused a problem ...

also its kinda nice to review a patch and reply with "looks ok" and
someone else applies the patch locally, tests it extensively and
commits it, it reduces the work for reviewers ...


[...]

>=20
> > well if git blame and others could somehow be told to automatically ign=
ore
> > nonsense changes and matching nonsense reverts that would be great
> > maybe by searching for some keyword in the revert message?
>=20
> That sounds like a bad technical workaround for a problem that really
> shouldn't exist. You should look for ways to create the history you'd
> really like to have rather than trying to find a way to get the tool
> to ignore the history that's actually there.
>=20
> Sure, mistakes will happen. Just learn to live with that.

btw, that leads me to another minor issue, i think commit log
messages cannot be changed in git after they are public, while we
commonly did change them to improve them, the issue simply is that some
developers are not good at writing nice commit log messages, sometimes
due them being plain bad in english or bad at writing descriptive
log messages ...

also our docs team loves to correct spelling errors in the commit messages
not that i consider that of any importance :)


>=20
> Oh, and I also think the emphasis on "blame" is due to a lack of other
> more powerful history exploration features in other systems. For

yes

[...]

--=20
Michael     GnuPG fingerprint: 9FF2128B147EF6730BADF133611EC787040B0FAB

In a rich man's house there is no place to spit but his face.
-- Diogenes of Sinope

--FhvelBhrd33NvMcY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGO5aQYR7HhwQLD6sRAkUAAJsHwbh4gA1ktGX+wXnnV35tM7A1fACfR5AA
9AbvVYJsA0sEj722Xflf6K4=
=rR5w
-----END PGP SIGNATURE-----

--FhvelBhrd33NvMcY--
