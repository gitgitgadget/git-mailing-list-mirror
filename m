From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: Re: [PATCH] gitweb: use decode_utf8 directly
Date: Fri, 27 Apr 2007 11:55:16 +0300
Organization: TUBITAK/UEKAE
Message-ID: <200704271155.24304.ismail@pardus.org.tr>
References: <200704241705.19661.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart15499102.rZ6Gjpcinr";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 27 10:54:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhMDP-0005fy-2M
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 10:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755485AbXD0IyD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 04:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755489AbXD0IyD
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 04:54:03 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:34582 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755485AbXD0IyA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 04:54:00 -0400
Received: from southpark.local (unknown [85.96.74.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id 092365F948A9
	for <git@vger.kernel.org>; Fri, 27 Apr 2007 11:53:55 +0300 (EEST)
User-Agent: KMail/1.9.6
In-Reply-To: <200704241705.19661.ismail@pardus.org.tr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45703>

--nextPart15499102.rZ6Gjpcinr
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 24 April 2007 17:05:15 you wrote:
> Hi,
>
> gitweb currently uses Encode::decode function with a wrapper like this :
>
> # very thin wrapper for decode("utf8", $str, Encode::FB_DEFAULT);
> sub to_utf8 {
>        my $str =3D shift;
>        return decode("utf8", $str, Encode::FB_DEFAULT);
> }
>
> But for me this gives the following error when I try to view RSS feed for
> Linux kernel GIT repo (local checkout) :
>
> Cannot decode string with wide characters
> at /usr/lib/perl5/vendor_perl/5.8.8/i686-linux/Encode.pm line 162.
>
> I Google'd a bit but the relevant information seems to be missing about
> this error. Anyhow there is no need for a wrapper at all as Encode class
> has a decode_utf8 function which fixes the problem I am experiencing too
> and chops off the unneeded wrapper.
>
> Patch against git 1.5.1.2 is attached. Comments welcome.
>
> P.S: I am using Encode 2.20 from CPAN which is the latest stable version
> available.

Ping? This patch should be harmless and it fixes a real error, can it be=20
applied please?

Regards,
ismail


--nextPart15499102.rZ6Gjpcinr
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.3 (GNU/Linux)

iD8DBQBGMbp8Gp0leluI9UwRAhuYAJ99LJo1pCjlC6bbcENs9VY9RP/e+gCeLrQ7
HBC0ToNzLbsaquczG95CjN8=
=O/+X
-----END PGP SIGNATURE-----

--nextPart15499102.rZ6Gjpcinr--
