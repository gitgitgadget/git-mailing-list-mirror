From: "Brian J. Murrell" <brian@interlinx.bc.ca>
Subject: Re: GIT get corrupted on lustre
Date: Mon, 24 Dec 2012 10:11:28 -0500
Message-ID: <50D870A0.90205@interlinx.bc.ca>
References: <50D861EE.6020105@giref.ulaval.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig96B870E179573568BF73D7BC"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 24 16:12:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tn9hG-0001RX-HA
	for gcvg-git-2@plane.gmane.org; Mon, 24 Dec 2012 16:12:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955Ab2LXPLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2012 10:11:48 -0500
Received: from plane.gmane.org ([80.91.229.3]:33943 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752597Ab2LXPLr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2012 10:11:47 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Tn9h7-0001IZ-3Z
	for git@vger.kernel.org; Mon, 24 Dec 2012 16:11:57 +0100
Received: from d67-193-232-12.home3.cgocable.net ([67.193.232.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 24 Dec 2012 16:11:57 +0100
Received: from brian by d67-193-232-12.home3.cgocable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 24 Dec 2012 16:11:57 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: d67-193-232-12.home3.cgocable.net
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <50D861EE.6020105@giref.ulaval.ca>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212111>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig96B870E179573568BF73D7BC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12-12-24 09:08 AM, Eric Chamberland wrote:
> Hi,

Hi,

> Doing a "git clone" always work fine, but when we "git pull" or "git gc=
"
> or "git fsck", often (1/5) the local repository get corrupted.

Have you tried adding a "-q" to the git command line to quiet down git's
"feedback" messages?

I discovered other oddities with using git on Lustre which I described
in this thread:

http://thread.gmane.org/gmane.comp.version-control.git/208886

I found that by simply disabling the feedback (which disables the
copious SIGALRM processing) I could alleviate the issue.

I wonder if your issues are more of the same.

I filed Lustre bug LU-2276 about it at:

http://jira.whamcloud.com/browse/LU-2276

Cheers,
b.



--------------enig96B870E179573568BF73D7BC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlDYcKAACgkQl3EQlGLyuXAweQCfUM7oFdaV1xYWQOZL6jThItuI
8ucAnj3X2v5vomMke8AQv1H916yokq8E
=+Pb8
-----END PGP SIGNATURE-----

--------------enig96B870E179573568BF73D7BC--
