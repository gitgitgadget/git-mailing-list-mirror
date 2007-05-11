From: Jan Hudec <bulb@ucw.cz>
Subject: Integrate StGIT into Git? (Was: Re: Using StGIT for tweaking already-committed stuff)
Date: Fri, 11 May 2007 07:48:07 +0200
Message-ID: <20070511054807.GA13880@efreet.light.src>
References: <1178794261.5806.98.camel@murta.transitives.com> <4643049C.3D5F30D8@eudaptics.com> <alpine.LFD.0.98.0705100857450.3986@woody.linux-foundation.org> <87wszg39cp.wl%cworth@cworth.org> <20070510171457.GK13719@fieldses.org> <87vef0350y.wl%cworth@cworth.org> <20070510192106.GB4489@pasky.or.cz> <87tzuk31fu.wl%cworth@cworth.org> <20070510200253.GD4489@pasky.or.cz> <87sla42xc4.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Cc: Petr Baudis <pasky@suse.cz>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <J.Sixt@eudaptics.com>,
	catalin.marinas@gmail.com, git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Fri May 11 07:48:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmNzR-0001bn-Ch
	for gcvg-git@gmane.org; Fri, 11 May 2007 07:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757503AbXEKFsX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 01:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757576AbXEKFsX
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 01:48:23 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:1171 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757503AbXEKFsW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 01:48:22 -0400
Received: from ([85.207.119.145])
	by mail.bluetone.cz with ESMTP with TLS id 5203017.167648;
	Fri, 11 May 2007 07:48:07 +0200
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1HmNz5-000660-NT; Fri, 11 May 2007 07:48:07 +0200
Content-Disposition: inline
In-Reply-To: <87sla42xc4.wl%cworth@cworth.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-esp: ESP<0>=
	RBL:<0> 
	SHA:<0> 
	UHA:<0> 
	BAYES:<0> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46937>


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Folks,

On Thu, May 10, 2007 at 14:16:43 -0700, Carl Worth wrote:
> I'll try again.
>=20
> I like the git user interface. I like it a lot. (It's got a couple of
> tiny things that I would do differently if I could start over, but
> more importantly it has a lot of big things that I wouldn't have even
> thought of if I had started from scratch.)
>=20
> But with respect to the current topic, there are a couple of features
> that the git interface is missing compared to something like stg:
>=20
> 1. Amend a commit that's somewhere besides the tip of a branch,
>    (rebuilding every commit that follows)
>=20
> 2. Re-ordering commits that exist on a branch, (again, rebuilding
>    every commit that follows).

I would actually propose to (gradually) add stg functionality into git. If =
it
was done in stgit-compatible fashion, it would allow using stgit for the bi=
ts
still not ported to git and switching back and forth according to user's
taste.

Many commands from stgit either already have git equivalent or do just
a little work beyond what the git command already does, so they could be
easily integrated.

> [...]
> I'd just love to see something more minimal, and incorporated into git
> itself, to address the missing functionality. Right now, "cherry-pick
> A..B" is all I have to suggest. But maybe later there could be some
> sort of push/pop addition as well, (except that obviously the name
> "push" isn't available as a sub-command).

I think that many of them would be actually pretty simple.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGRAOXRel1vVwhjGURAkvYAKC1F6ij/0Oak5xWN7zl1UoBY0O1JgCgj6v5
PNRDx9ck924FSe8YfsFRFgs=
=1sCG
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
