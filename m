From: Todd Zullinger <tmz@pobox.com>
Subject: Re: groff .ft command use in asciidoc
Date: Fri, 19 Nov 2010 20:48:09 -0500
Message-ID: <20101120014808.GZ16929@inocybe.localdomain>
References: <20101117095233.GA23817@basil.fritz.box>
 <20101117101516.GA12416@burratino>
 <20101117143855.GA1987@sigill.intra.peff.net>
 <20101117154829.GE23656@basil.fritz.box>
 <20101119175424.GA13276@sigill.intra.peff.net>
 <1290198893.13785.68.camel@drew-northup.unet.maine.edu>
 <20101119204010.GA18342@sigill.intra.peff.net>
 <7v62vsc45d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="CaPKgh3XHpq3rEUV"
Cc: Jeff King <peff@peff.net>, Drew Northup <drew.northup@maine.edu>,
	Andi Kleen <andi@firstfloor.org>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Chris Johnsen <chris_johnsen@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 20 02:48:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJcZ9-0002BR-Fe
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 02:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756322Ab0KTBsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 20:48:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41187 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756078Ab0KTBs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 20:48:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26F201A6B;
	Fri, 19 Nov 2010 20:48:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
	:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=l1Km4VzLDy9hSff2GLD0vtCUN0U=; b=bkj3Kzu
	Ds7vzmrDWFj80McYjm+wkujsh/aQrkGiCW353ZQXMJo2VIacckFZz3ouGtBVJJvX
	ddNaZVPkaTZ+KaS/+tnJY7wMfAwbD0R3PvyjyywqB1DVFN9wNO60V7jSldE1c8oF
	x1o1rOrda5WitxFJFgKILYTJUxK2GZ/zIse4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=sasl; b=TAnXhCgBCoB2nVoCMFODhSVtWPHae6WGD
	aRyFDr56dEegnR14LxtJLZUh3GSrOFkf+BI7Slx//Xz+OPmRX34Qb6swLz4lUstE
	//Taj7f+pkFKRvMFU2obk6kUWDcwXlMVR/Q7i+wWBY83nxQ30bUmZol0tyzmsoh4
	cXZpInWrp4=
Received: from b-pb-sasl-quonix. (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B71211A66;
	Fri, 19 Nov 2010 20:48:19 -0500 (EST)
Received: from inocybe.localdomain (unknown [98.117.251.177]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D5211A64; Fri, 19 Nov 2010
 20:48:11 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7v62vsc45d.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Pobox-Relay-ID: 4040082C-F448-11DF-88AA-8E8CAFBB27C9-09356542!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161817>


--CaPKgh3XHpq3rEUV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> Thanks.  I usually am fairly cautious when changing the default, but
> I think this particular one is not such a big deal.  I agree that
> the end of the year release would probably be a good time to switch.
>
> I think people on RHEL5 would also be ok; they have paid support for
> this kind of thing, no ;-)?

Sadly, git isn't in RHEL5 officially.  We package it in EPEL though.
Currently, it's at the ancient 1.5.5.6 mile marker.  I have taken care
to ensure that the Fedora rpm's build cleanly for EPEL-5 (and 4 last I
checked), albeit with the lack of emacs support=B9.

I haven't tested this patch, but I am confident that removing the
ASCIIDOC knobs where appropriate won't cause us any grief in Fedora,
EPEL, or RHEL (where git-1.7.x is now officially supported, finally!). =20

=B9 Incidentally, if anyone here is a strong user of emacs vcs mode and
could help work out what we need to do to make git-1.7.x work with the
emacs-21.4 shipped in RHEL, please let me know.  That's the only
impediment (that I know of) keeping us from moving EPEL to a more
modern git, with all the fabulous advantages the fine folks here have
made since 1.5.x.

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Happiness, n.: An agreeable sensation arising from contemplating the
misery of another.
    -- Ambrose Bierce, "The Devil's Dictionary"


--CaPKgh3XHpq3rEUV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAEBCAAtBQJM5yjJJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzjYSAH/jTVbLZQbJQcvWSGEbo06zQpKRl33BM4MvKf
JPrTH0gsLdxu55RY9o+VKQB/WxyHMHYVbDfd3E2tfE+43MkdkelCrIU+TSVSqAO/
OMo0C8RWr23eXmETMu2AS6gEiDiSvav17OJ9U/vovtpElpGi1nJ1afYAj480nmvA
2s5YAyd+vYFtMlQJSHP7ZxNXyaG+OV/ZKCZL8jX93y41uxILR4taGLEFBcHt1naI
LRj6YXabFtfFaSbuCk9k7e/5uIiaZYpMQ2kCPhZ1Ad2crRYHGTAEv8QbHYsYGbjP
nkCqLQGsw8pd0GxQeskNQSBgIxCg7FAu7XzWw7mUcZzPPPgo0Hs=
=xUJc
-----END PGP SIGNATURE-----

--CaPKgh3XHpq3rEUV--
