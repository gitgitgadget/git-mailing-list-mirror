From: =?UTF-8?B?RGVqYW4gUmliacSN?= <dejan.ribic@gmail.com>
Subject: [PATCH] typo in git-gui/lib/sshkeys.tcl
Date: Sun, 30 Oct 2011 11:15:06 +0100
Message-ID: <4EAD23AA.8000400@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDB2197085D6DB814599471D8"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 30 11:15:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKSQJ-0001br-KC
	for gcvg-git-2@lo.gmane.org; Sun, 30 Oct 2011 11:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933790Ab1J3KPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Oct 2011 06:15:22 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33343 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933363Ab1J3KPV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2011 06:15:21 -0400
Received: by faan17 with SMTP id n17so4757242faa.19
        for <git@vger.kernel.org>; Sun, 30 Oct 2011 03:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :x-enigmail-version:content-type;
        bh=imbCrEsa94wRz6zRU2oMiU98lueyLIn6cE4pnm1WhdE=;
        b=Cx/1Ne2vpDdgNjVvh6T2LXaJvTUVLD2jcKNyZF8/z9SusjlOMK7Enr/k2W7YnofwYc
         Uj95AtoV3bgUuVcdG+LtnzQk2NCtbhNt1rEAdrtADvYH4zzvFM5IzvQYPZ0TL33AmukD
         UzyJXu9IsunZQIf0rQir2jY5Xmsj4Xrjsrh3k=
Received: by 10.223.16.82 with SMTP id n18mr20620979faa.2.1319969720246;
        Sun, 30 Oct 2011 03:15:20 -0700 (PDT)
Received: from [192.168.2.136] (cpe-46-164-0-113.dynamic.amis.net. [46.164.0.113])
        by mx.google.com with ESMTPS id y17sm30368826faa.22.2011.10.30.03.15.19
        (version=SSLv3 cipher=OTHER);
        Sun, 30 Oct 2011 03:15:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
X-Enigmail-Version: 1.4a1pre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184472>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDB2197085D6DB814599471D8
Content-Type: multipart/mixed;
 boundary="------------090402080602050100010109"

This is a multi-part message in MIME format.
--------------090402080602050100010109
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

   I am new at this, but I am trying to fix a few "bitesize" bugs in
Ubuntu for start and somebody suggested, that I post this patch to
Upstream, so I'm doing this.

Cheers,

Dejan

P.S.: I am not subscribed to this list, so please CC to me.

--------------090402080602050100010109
Content-Type: text/x-patch;
 name="sshkeys.tcl.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="sshkeys.tcl.diff"

=3D=3D=3D modified file 'git-gui/lib/sshkey.tcl'
--- git-gui/lib/sshkey.tcl	2010-04-03 15:07:19 +0000
+++ git-gui/lib/sshkey.tcl	2011-10-29 23:08:15 +0000
@@ -117,7 +117,7 @@
 	} else {
 		set finfo [find_ssh_key]
 		if {$finfo eq {}} {
-			set sshkey_title [mc "Generation succeded, but no keys found."]
+			set sshkey_title [mc "Generation succeeded, but no keys found."]
 			$w.contents insert end $sshkey_output
 		} else {
 			set sshkey_title [mc "Your key is in: %s" [lindex $finfo 0]]


--------------090402080602050100010109--

--------------enigDB2197085D6DB814599471D8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJOrSO2AAoJEE81mVwDgtRlnWYIAK8WqTL0DE7z/MowG5Q2//WA
MsxSsmfuM/5ZLCc1wPHjD8t8sjsBPSm3FS8SQnmc2CX66HC7rzvJSYeGgt0oIkha
oQOuhYra1iV3Cj5IgpTcp85VBehIk/L2A8+flhbU0nElt3PKhh0HdqxAXEsx7bHd
yo1fj98Sp4HXMM3efe91ODU1TYdEUFL2BLJb0chqtje2lO2xwPL/htSfmfWt7lHK
XNXnrucv44/BTBYa+01a/l50BkQBLBJtLRH+hFTda3GfNJkZ6PFx9Jdei6ehgOUe
rdQcMMhzSAzvaJHoBA4hdsEA4PaiFJZg7rXVgvWlIvY9WpWT7nU9u5kD0ut8vTc=
=PoYa
-----END PGP SIGNATURE-----

--------------enigDB2197085D6DB814599471D8--
