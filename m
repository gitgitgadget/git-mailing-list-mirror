From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v2 15/15] user-manual: Use --format=tar.gz to create a
 gzipped tarball
Date: Sun, 10 Feb 2013 18:01:52 -0500
Message-ID: <20130210230152.GC8704@odin.tremily.us>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
 <92a02e35df3dab70928e56e6790417243beea2af.1360508415.git.wking@tremily.us>
 <7va9rbst37.fsf@alter.siamese.dyndns.org>
 <20130210223239.GE8377@odin.tremily.us>
 <7vk3qfrdco.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=CblX+4bnyfN0pR09
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 00:02:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4fup-0006GO-4D
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 00:02:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756965Ab3BJXCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 18:02:07 -0500
Received: from vms173003pub.verizon.net ([206.46.173.3]:25762 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756856Ab3BJXCG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 18:02:06 -0500
X-Greylist: delayed 2329 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Feb 2013 18:02:06 EST
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MI100K9E1B4FUA0@vms173003.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 10 Feb 2013 17:01:53 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 545F1879D9B; Sun,
 10 Feb 2013 18:01:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1360537312; bh=wjhHrL7AXQGS1eJr08/1oNnOwe8rhMPVEPqXa/bFR9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c2VBY6nMTj/HefP7Kn0MfeIsUgt+Z8L5y+WFXanIuUXG0rbVb7n+c5MTFSPIkK88Y
 Y/cqsB10E6PB0BlOz90QsmpooDEziRAZo0Hk5O5bPh0hQWyXSxlGaAVhDI2WO7coa+
 rtQLc/WnqBlp3RiS+7ZlsZ1AwSthn7c4RgOr5D6w=
Content-disposition: inline
In-reply-to: <7vk3qfrdco.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215968>


--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 10, 2013 at 02:52:23PM -0800, Junio C Hamano wrote:
> "W. Trevor King" <wking@tremily.us> writes:
> > On Sun, Feb 10, 2013 at 02:27:08PM -0800, Junio C Hamano wrote:
> >> This is a "meh" at least to me.  Unless it uses something like
> >>=20
> >> 	git archive -o latest.tar.gz --prefix=3Dproject/ HEAD
> >>        =20
> >> it is not all that interesting.
> >
> > Great suggestion.  My original goal was to remove the pipe, but if we
> > can remove the redirection too, that's one less POSIX-ism for newbies
> > to wonder about ;).
>=20
> I was referring to more about the implicit format recognition not
> pipe.

I'll mention it when I'm linking them to git-archive(1) ;).  I think
the goal in the manual should be to show people that the functionality
exists and is not scary.  Explaining the actual implementation details
and assorted usage details is best left to command-specific
documentation.

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--CblX+4bnyfN0pR09
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRGCbfAAoJEEUbTsx0l5OMQasQAMCfdblzFxwdF5lOYs8UcggQ
iL7g0rgDz7IO0BMnHMcURxfz+u+JhiEjaguMnCI1OJLBYnqQmuqhKgtyd1S1xpZf
8whRfAOVGInDGMoPrLTG5qbzno7M0XO7OmPr0JcuMWXdWM44WUyGoHoFjKfXbsL6
0SJEzjoYFDllE7K24+7c+h+6tX8Y12BsDl/DYIYqtVF+2ckP14GAulicXf42SPUP
1SoQeSUno1YWIFAazdJLV5uxUBXjNHDehNEkHQMg5OPENFY69oLhfaca1TuWfEhI
840LqrI8H6ME/X+6OzLYA6ReRYfmT4lJVpPJjXWJP383Fwx6CWuG8z+Fxx3+JU35
+ovUCB+p0Vv7/srKu9yl26kFpGvKqOSslB7d9XcMQ5BxMi5iw0EZUpnEdikN67Ly
/Z8gh3ssZZQ/tCKQWEEUWn4tzxqgG4SfTel9GsJ6UydmsR7Py++2E7pnOuMEHNfm
HNLdyk5EJmn2mI6ShDQSxiuoSj5A71Wn98C/8i/YS361tOZqpBQ5F+ylyQ4DtiLm
H7k7bBVIYLjCmLV/1uDL6s3F+wzBV5kwin9b07hr9nOVTLAISyn/xzSlbIwRg0yx
ThYoT42rZH3GzPlkYQO9XBYVKTIHOIuEENP8GO9dSeJ8s/H6CeHlDuRLwXrzFTy/
cAPz8F7r/liiHWl2CrLX
=jecn
-----END PGP SIGNATURE-----

--CblX+4bnyfN0pR09--
