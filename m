From: Dennis Putnam <dap1@bellsouth.net>
Subject: Push Windows to Linux Repository Problem
Date: Sat, 22 Dec 2012 19:30:08 -0500
Message-ID: <50D65090.4010303@bellsouth.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1AEAB1A90E686A21F7ED5437"
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 23 01:35:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmZXY-0007Gn-Rs
	for gcvg-git-2@plane.gmane.org; Sun, 23 Dec 2012 01:35:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406Ab2LWAfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2012 19:35:21 -0500
Received: from nm13.access.bullet.mail.sp2.yahoo.com ([98.139.44.140]:28679
	"EHLO nm13.access.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752359Ab2LWAfT (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Dec 2012 19:35:19 -0500
X-Greylist: delayed 311 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Dec 2012 19:35:19 EST
Received: from [98.139.44.106] by nm13.access.bullet.mail.sp2.yahoo.com with NNFMP; 23 Dec 2012 00:30:08 -0000
Received: from [67.195.14.108] by tm11.access.bullet.mail.sp2.yahoo.com with NNFMP; 23 Dec 2012 00:30:08 -0000
Received: from [127.0.0.1] by smtp105.sbc.mail.gq1.yahoo.com with NNFMP; 23 Dec 2012 00:30:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bellsouth.net; s=s1024; t=1356222608; bh=EqyzjHBV+CQ/DyQVuq3R6o1Ik7/BFam48dzEKaz8psc=; h=X-Yahoo-Newman-Id:X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:Received:Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:X-Enigmail-Version:Content-Type; b=LJIgW8kh6WjhxWj5Iw3nYBG056Eylv78ROX+U9TOZ8E9A/uMFEqflcgP0MdOrAodm2LUp1oHwcv+adqaZ7yTRBjsVl1yKUPDQIa6AZakgpKZiEOXZUVUsUVvHE5JcGG7u8U0g+3EjE8+doFZnwHS/2gRCgflkmFB02D5l6iEplk=
X-Yahoo-Newman-Id: 94066.96398.bm@smtp105.sbc.mail.gq1.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: 0nz6zpYVM1mjLmiRhwyHKoNsIaudUNFDT8K487xaeuLFtMn
 UM8Zg38zrIC72TO3J9HuGcDFEmP8cQBMg9OAuoMhXkRvXe8ynbmPOVTBeaOW
 Cb0xXh8mM8mJ0UjOQUdO1KzisCF4h2MIsgZRqQodqFNiIpu_hOgSsl7pclxk
 dq9d8mpiTSgB96IEas1jJgC3Xm9HCgYSo1rFCwU0BaCCcZ6xxgvHxq4W_2HW
 SlvN5E5qtRf6gQhQsoXPKZ5EdevZrpWauUy.DlDx.mIFzZ9N5fMAFOIOg1kj
 ZdgGhCERgmfkRTeZ.FWi88CysSfGI5SxF11r1krw2XbTvuEu1y_R6BAdyU6P
 x0jV175XsPnqL6JZdRGvpvPmzDY8JVESj_YD44IJYo4PHJ5p3.TM0ptCzZ7T
 dmEsujKC9.WKTjD6d1VyQUbsBrvT_ZrkK58fCArCPa79M4k1TflHkfZq.Xcm
 J7GhU4fa8cI6AVh4bIMPBHK7yvomb
X-Yahoo-SMTP: vUK3UKuswBCE01YQVYEZ1wHCa.HPSVCYhektzgdifA--
Received: from [192.168.0.100] (dap1@74.176.50.42 with plain)
        by smtp105.sbc.mail.gq1.yahoo.com with SMTP; 22 Dec 2012 16:30:08 -0800 PST
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/17.0 Thunderbird/17.0
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212073>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1AEAB1A90E686A21F7ED5437
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I think I have my Linux central repository set up correctly. I can pull
and push from/to the repository on the Linux host itself.  My problem is
trying to push commits to that repository from windows. I keep getting
"fatal: Could not read from remote repository." When I run 'ls' commands
using plink from the command line it works fine with the same
credentials. Clearly there is an issue with git on Windows and using SSH
to access the remote repository. I'm stuck as to how to debug this. Can
anyone point me in the right direction? TIA


--------------enig1AEAB1A90E686A21F7ED5437
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlDWUJAACgkQ/fiWYqZ2tVTmMgCfSpMn4AAPjdemF6TE9a17YsI2
kr0An0/LeuMCr4s6xxs7v4ogbTTU7Ov6
=QjEQ
-----END PGP SIGNATURE-----

--------------enig1AEAB1A90E686A21F7ED5437--
