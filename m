From: Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH 2/2] send-email: rfc2047-quote subject lines with
 non-ascii characters
Date: Thu, 27 Mar 2008 15:44:57 -0400
Message-ID: <20080327194457.GU18510@inocybe.teonanacatl.org>
References: <7caf19ae394accab538d2f94953bb62b55a2c79f.1206486012.git.peff@peff.net>
 <200803260759.48922.tlikonen@iki.fi>
 <20080326062029.GA26286@coredump.intra.peff.net>
 <20080326083033.GA13933@mithlond.arda.local>
 <20080326083925.GA31475@coredump.intra.peff.net>
 <20080326092303.GA17835@mithlond.arda.local>
 <20080326093310.GA937@coredump.intra.peff.net>
 <20080327073808.GA22548@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="sDhuxz86kt5qlkuV"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 27 20:46:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jey2q-00036I-No
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 20:45:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757785AbYC0TpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 15:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757753AbYC0TpK
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 15:45:10 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49921 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757294AbYC0TpI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2008 15:45:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 770B32037
	for <git@vger.kernel.org>; Thu, 27 Mar 2008 15:45:03 -0400 (EDT)
Received: from inocybe.teonanacatl.org (c-68-39-203-93.hsd1.pa.comcast.net
 [68.39.203.93]) (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com
 (Postfix) with ESMTP id 2A77D2035 for <git@vger.kernel.org>; Thu, 27 Mar 2008
 15:45:01 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080327073808.GA22548@coredump.intra.peff.net>
X-Listening-To: Tool - Right In Two
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78363>


--sDhuxz86kt5qlkuV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jeff King wrote:
> Since it looks like you are using mutt also, I will warn you that
> there is a problem with this workflow: when mutt does the resend, it
> generates a new message-id. Thus the patches are all connected in a
> thread because they all in-reply-to the cover letter, but the cover
> letter is not connected, since it has a new message-id.
>=20
> I'm not sure if there is a way to fix this short of patching mutt.
> :(

I don't know if it would help, but perhaps you could try:

:set postponed=3D/path/to/your/format-patch-mbox

instead of opening the mbox using -f, and then recall the messages to
send.  That *might* prevent mutt from rewriting the message-id, but I
haven't tested it at all.

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Between two evils, I always pick the one I never tried before.
    -- Mae West


--sDhuxz86kt5qlkuV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iQFDBAEBAgAtBQJH6/k0JhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzjgm8H/j+YRQ1Bc3HXL3/W8ENXmeawX2k7BYP6FOtI
biK9icCojvPN1yI/oQT54m7HBIRK9rcXjNsfN7f/KdLWE+WZ9wdlWskpY85z6wFV
erAvexYAIMLQA0DWifBTBF+En5gkyPLmOLk7YEohUjQWQKgTfM2ycXLZUAH4q8oh
BvrxFmIjCQrCyhBSKm6e97SwIlJMeh4IUi/MnJSWJ/3CSe/n2iu3DgbY2KfPnmUR
6niR4PBalv0erL8mFsHtDl4Vt5RDylepUgtrS3lTJ43MEwjL/SyG9Cp6evbsWinc
noXWZSGHgkId/OVjcnKEX/XHOzDpXgiuQhCY4XmisYzQgtuCJzw=
=HB9W
-----END PGP SIGNATURE-----

--sDhuxz86kt5qlkuV--
