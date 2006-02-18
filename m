From: Nicolas Vilz 'niv' <niv@iaglans.de>
Subject: Re: [RFC] empty ident?
Date: Sat, 18 Feb 2006 11:00:03 +0100
Message-ID: <43F6F023.1020708@iaglans.de>
References: <7vzmkpqco1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF5089A486B5D4AC9E9140763"
X-From: git-owner@vger.kernel.org Sat Feb 18 11:03:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAOvw-0002FA-MT
	for gcvg-git@gmane.org; Sat, 18 Feb 2006 11:03:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWBRKDR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Feb 2006 05:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWBRKDR
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Feb 2006 05:03:17 -0500
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:52752 "EHLO
	vsectoor.geht-ab-wie-schnitzel.de") by vger.kernel.org with ESMTP
	id S1751122AbWBRKDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2006 05:03:16 -0500
Received: from localhost (localhost [127.0.0.1])
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 66F883F82
	for <git@vger.kernel.org>; Sat, 18 Feb 2006 11:02:58 +0100 (CET)
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1])
	by localhost (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 23852-08 for <git@vger.kernel.org>;
	Sat, 18 Feb 2006 11:02:57 +0100 (CET)
Received: from [192.168.100.26] (hermes.lan.home.vilz.de [192.168.100.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id D18F83E92
	for <git@vger.kernel.org>; Sat, 18 Feb 2006 11:02:55 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <7vzmkpqco1.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.92.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16405>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF5089A486B5D4AC9E9140763
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Junio C Hamano wrote:
> It appears that some people who did not care about having bogus
> names in their own commit messages are bitten by the recent
> change to require a sane environment [*1*].
> 
> While it was a good idea to prevent people from using bogus
> names to create commits and doing sign-offs, the error message
> is not very informative.  This patch attempts to warn things
> upfront and hint people how to fix their environments.

Mh... it made me not using cg-init, but git-init, and after that editing
.git/config, before the first commit.

This doesn't apply to works with git-svn, because here imported commits
are tailored from the base-uuid of the SVN repository and the commit-user.

niv <niv@$uuid>

after that i can setup my .git/config, as well.

Sincerly
Nicolas

--------------enigF5089A486B5D4AC9E9140763
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFD9vAqSlT0CowElk8RAgSNAJsECVCbEG1rpyxo31AvP29vVLf9KwCgn9Hc
oFa40LS86oNvPPHWrhgEsbI=
=sfFj
-----END PGP SIGNATURE-----

--------------enigF5089A486B5D4AC9E9140763--
