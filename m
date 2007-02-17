From: Martin Waitz <tali@admingilde.org>
Subject: exception in git-gui when saving options
Date: Sat, 17 Feb 2007 20:40:33 +0100
Message-ID: <20070217194033.GH21842@admingilde.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xkXJwpr35CY/Lc3I"
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Feb 17 20:40:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIVQE-0001gR-4s
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 20:40:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932855AbXBQTkf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 14:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932858AbXBQTkf
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 14:40:35 -0500
Received: from mail.admingilde.org ([213.95.32.147]:59201 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932855AbXBQTke (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 14:40:34 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HIVQ9-0005t9-8x; Sat, 17 Feb 2007 20:40:33 +0100
Content-Disposition: inline
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40011>


--xkXJwpr35CY/Lc3I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

I get the following backtrace when I want to save options in a
git-gui which is started in blame mode:

can't read "current_diff_path": no such variable
    while executing
"set p $current_diff_path"
    (procedure "reshow_diff" line 5)
    invoked from within
"reshow_diff"
    (procedure "do_save_config" line 5)
    invoked from within
"do_save_config .options_editor"
    invoked from within
".options_editor.buttons.save invoke"
    ("uplevel" body line 1)
    invoked from within
"uplevel #0 [list $w invoke]"
    (procedure "tk::ButtonUp" line 22)
    invoked from within
"tk::ButtonUp .options_editor.buttons.save"
    (command bound to event)

The options seem to be saved correctly.

--=20
Martin Waitz

--xkXJwpr35CY/Lc3I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFF11oxj/Eaxd/oD7IRArAPAJ4n47cEYmepXq3bT/wYZHhoTZ+MNQCcCH0p
8BeXjAswKwA475zLfnp4kGw=
=lGjs
-----END PGP SIGNATURE-----

--xkXJwpr35CY/Lc3I--
