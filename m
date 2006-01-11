From: Simon Richter <Simon.Richter@hogyros.de>
Subject: Re: RFC: Subprojects
Date: Wed, 11 Jan 2006 17:52:25 +0100
Message-ID: <43C537C9.4090206@hogyros.de>
References: <43C52B1F.8020706@hogyros.de> <Pine.LNX.4.63.0601111740220.17966@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF6035E14CA4238E47E17AC46"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 11 17:53:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwjDB-0008Iz-JW
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 17:52:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbWAKQwf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 11:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbWAKQwf
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 11:52:35 -0500
Received: from kleinhenz.com ([213.239.205.196]:37068 "EHLO kleinhenz.com")
	by vger.kernel.org with ESMTP id S1751678AbWAKQwe (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jan 2006 11:52:34 -0500
Received: from [192.168.115.35] (p5499772B.dip.t-dialin.net [84.153.119.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "Simon Richter", Issuer "Kleinhenz Elektronik CA" (verified OK))
	by kleinhenz.com (Postfix) with ESMTP id 34EDB4A8045;
	Wed, 11 Jan 2006 17:52:33 +0100 (CET)
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0601111740220.17966@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.93.0.0
OpenPGP: url=http://www.hogyros.de/simon.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14489>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF6035E14CA4238E47E17AC46
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Johannes Schindelin wrote:

> And since the subprojects are really independent, you can connect them by 
> an octopus.

The important thing for me is that I need to be able to transfer them 
easily, or turn a subdirectory into a subproject or vice versa.

> Sorry, we discussed similar things already. It is not necessary to change 
> the structure. Even more: it makes no sense. Why would you want to have 
> two or more commit messages for the same revision?

Because the commit affects both the subproject and the master project.

> Remember: trees, commits and tags (objects in general) are immutable. You 
> may think that you just commit a new revision of the subproject, and it is 
> picked up by the overall project, but that is not the case!

This is why I asked for intended behaviour on commit in a subproject. It 
is pretty obvious that the master project would need a new tree object 
to reference the new version of the subproject, and hence, a new commit 
to keep it all together (and correctly so, since I would like my master 
project to refer to that particular version of the subproject that is 
known to work).

> You can do this like I said: use branches (and possibly a common 
> GIT_OBJECT_DIRECTORY to save on disk space).

Yes, however that wouldn't cover consistency between the subprojects, 
would it?

    Simon

--------------enigF6035E14CA4238E47E17AC46
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBQ8U3y1Yr4CN7gCINAQK5SwP/WPOV6TqTomMB9nElSn4NEnHomv155pM3
0lMy+4M3I0DnOZnQ46H1c7o6NZMcwTq1fTBbkYmbdO8LURCLB2fxSwxcXVfGrOne
B242LIxqynsGWWA6/zdT7rWSkmrcGjAn3ahUMuimKMs8i6vqlVRq/zv/ce4N/OwH
3/UepsH6oW8=
=xuD/
-----END PGP SIGNATURE-----

--------------enigF6035E14CA4238E47E17AC46--
