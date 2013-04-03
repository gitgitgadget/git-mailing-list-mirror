From: Martin von Gagern <Martin.vGagern@gmx.net>
Subject: Re: [PATCH] Documentation: Strip texinfo anchors to avoid duplicates
Date: Wed, 03 Apr 2013 23:08:34 +0200
Message-ID: <515C9A52.7020203@gmx.net>
References: <1365018873-22503-1-git-send-email-Martin.vGagern@gmx.net> <7vppyb4bu3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2HQTMQANPNGOUBXDHNOAR"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 03 23:09:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNUve-0003G3-Fm
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 23:09:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516Ab3DCVIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 17:08:40 -0400
Received: from mout.gmx.net ([212.227.17.21]:58309 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759183Ab3DCVIk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 17:08:40 -0400
Received: from mailout-de.gmx.net ([10.1.76.19]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0MXTY0-1U9pvE1dvK-00WYyf for
 <git@vger.kernel.org>; Wed, 03 Apr 2013 23:08:38 +0200
Received: (qmail invoked by alias); 03 Apr 2013 21:08:38 -0000
Received: from 178-27-35-12-dynip.superkabel.de (EHLO [192.168.71.20]) [178.27.35.12]
  by mail.gmx.net (mp019) with SMTP; 03 Apr 2013 23:08:38 +0200
X-Authenticated: #858129
X-Provags-ID: V01U2FsdGVkX1/Sboh/rW7SitNQ0bcfJuF34+aRuq/6mnVIvjNasC
	zXhZToKnHsz0r9
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130310 Thunderbird/17.0.4
In-Reply-To: <7vppyb4bu3.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219972>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2HQTMQANPNGOUBXDHNOAR
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03.04.2013 22:07, Junio C Hamano wrote:
> I see why duplicates are bad, but does that mean not having any is
> better?

I'd say yes: duplicate anchors cause current versions of texinfo to
reject the document outright, and older versions will likely cause a
broken interpretation of any anchor names.

What are possible scenarios where anchors could be useful?
a) Internal cross reference. I'm not sure whether texinfo checks for
   broken internal links. If it does, it did not report any.
b) Goto command issued by the user. I suppose most users would be happy
   with node-level navigation, and not use it for navigation to
   sub-node sections.
c) URLs in bookmarks or mails. I suppose people are more likely to use
   the html documents built by asciidoc, instead of a version
   constructed from the texinfo document. So not our issue.
Did I miss a relevant use case?

Automatically (or even manually?) generated unique names might be better
than none. But I'm not sure they are worth the trouble.

Martin von Gagern


------enig2HQTMQANPNGOUBXDHNOAR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFcmlMACgkQRhp6o4m9dFtkKACghTrXWkds+BeNZ+puSB97G/5G
RNMAoIvO4+8xg+OEz668oA+ZW+5sInkt
=70pa
-----END PGP SIGNATURE-----

------enig2HQTMQANPNGOUBXDHNOAR--
