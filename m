From: Dennis Putnam <dap1@bellsouth.net>
Subject: Re: Push Windows to Linux Repository Problem
Date: Sun, 23 Dec 2012 10:28:15 -0500
Message-ID: <50D7230F.80204@bellsouth.net>
References: <50D65090.4010303@bellsouth.net> <m27go9dtnn.fsf@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig601F5021706E23A62D92E12B"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sun Dec 23 16:28:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmnTd-0004z4-Cr
	for gcvg-git-2@plane.gmane.org; Sun, 23 Dec 2012 16:28:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576Ab2LWP2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Dec 2012 10:28:16 -0500
Received: from nm4.access.bullet.mail.mud.yahoo.com ([66.94.237.205]:34931
	"EHLO nm4.access.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750947Ab2LWP2O (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Dec 2012 10:28:14 -0500
Received: from [66.94.237.196] by nm4.access.bullet.mail.mud.yahoo.com with NNFMP; 23 Dec 2012 15:28:13 -0000
Received: from [98.139.221.57] by tm7.access.bullet.mail.mud.yahoo.com with NNFMP; 23 Dec 2012 15:28:13 -0000
Received: from [127.0.0.1] by smtp110.sbc.mail.bf1.yahoo.com with NNFMP; 23 Dec 2012 15:28:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bellsouth.net; s=s1024; t=1356276493; bh=lTF2jwomOlhUA4GOj9XgsNtErjoZ5enKHp6Ad3RcXbM=; h=X-Yahoo-Newman-Id:X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:Received:Message-ID:Date:From:User-Agent:MIME-Version:CC:Subject:References:In-Reply-To:X-Enigmail-Version:Content-Type; b=ZpnBXh18X1o/bJJVTXZ9CgZOhjeL8vjBMUjuPQMk8roGBicQ509jn15crHlxoAYCZuWv4UpO0ZpZOjE/xETB4M6AnLJOoy8PC786sGu4WfpXXc0Kq20yRWQBNrDGaNX6D6XcGNrBa/rY1Ln+PT0ye18ns307nPNkZIAcYrxCqr8=
X-Yahoo-Newman-Id: 556502.86932.bm@smtp110.sbc.mail.bf1.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: 0mA.HiIVM1mAheRRwlTntBahu5D97UqdNgu1IcZvahGaCMu
 T09vjGgukI4E_zZlnRpGW9CcorsPaprr32dAFD.ptm7g5c1W41..l4LFNAPP
 J2cAxPxCnORfjwRMnrehl9sT_e8_XZQusdy8e.mKv.16Dc4lz2gaQOUsf.au
 9m6tADCpUtP.mBYZGHH48LO2G8GkXLU8_aSVN9BiPyGj2TF7IhYcZ3hKREbt
 5PfkOMnPDvNqHlNOUjHBVtWBUcB5ARH5pJ.3uloV9QxZbanDGiaBbKx9XOh.
 VlY3GzV_5s2fTCgzRPt5.tYZZFzBMODR4zCXo0edDRxImK_NyX8uLGMS3SWd
 cfT_hx2BCTUWaIlhgfM6Cetw7pCTyAHzO7558b5e.9OvaDke6NtIOPCGBu5D
 ITT4WouuSvCXJKEQKPWdywkh_aQoYgiOogkShSCsxSR.KoasQjioS
X-Yahoo-SMTP: vUK3UKuswBCE01YQVYEZ1wHCa.HPSVCYhektzgdifA--
Received: from [192.168.0.100] (dap1@74.176.50.42 with plain)
        by smtp110.sbc.mail.bf1.yahoo.com with SMTP; 23 Dec 2012 07:28:13 -0800 PST
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <m27go9dtnn.fsf@linux-m68k.org>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212084>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig601F5021706E23A62D92E12B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

Thanks for the reply and no, I could not. However, you put me on the
right track. Since I was only pushing/pulling from Windows to/from my
Linux repository, I did not realize that an SSH session from the Linux
back to Windows would ever be necessary. I don't really understand why
but apparently it is. I never set up that backwards connection. Once I
did, everything started working.

On 12/23/2012 4:06 AM, Andreas Schwab wrote:
> Dennis Putnam <dap1@bellsouth.net> writes:
>
>> I keep getting "fatal: Could not read from remote repository."
> Can you "git ls-remote" the repository?
>
> Andreas.
>



--------------enig601F5021706E23A62D92E12B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlDXIw8ACgkQ/fiWYqZ2tVSZ8ACfTuIuhlW+vA8a11HsMUMl9T0g
OCAAoOp4wCWyudbAG+sM0u70whxIY6BX
=REC4
-----END PGP SIGNATURE-----

--------------enig601F5021706E23A62D92E12B--
