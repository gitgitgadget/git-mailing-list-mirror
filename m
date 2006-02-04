From: Brian Smith <linuxfood@linuxfood.net>
Subject: Re: Tracking and committing back to Subversion?
Date: Sat, 4 Feb 2006 07:27:25 -0800
Message-ID: <200602040727.30965.linuxfood@linuxfood.net>
References: <1138834301.21899.40.camel@wilber.wgtn.cat-it.co.nz>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2208403.hoMt6AXcmj";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 16:27:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5PKA-0006z5-UI
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 16:27:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161001AbWBDP1d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 10:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161002AbWBDP1d
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 10:27:33 -0500
Received: from [67.124.82.122] ([67.124.82.122]:37961 "EHLO linuxfood.net")
	by vger.kernel.org with ESMTP id S1161001AbWBDP1c (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Feb 2006 10:27:32 -0500
Received: (qmail 6626 invoked from network); 4 Feb 2006 07:27:31 -0800
Received: from unknown (HELO borealis.linuxfood.net) (192.168.1.2)
  by 192.168.1.6 with AES256-SHA encrypted SMTP; 4 Feb 2006 07:27:31 -0800
To: sam@vilain.net
User-Agent: KMail/1.9
In-Reply-To: <1138834301.21899.40.camel@wilber.wgtn.cat-it.co.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15596>

--nextPart2208403.hoMt6AXcmj
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Well..

On Wednesday 01 February 2006 14:51, Sam Vilain wrote:
> Hi all,
>
> Has anyone done any work on bidirectional access to SVN repositories?
> ie, tracking and committing.
>

I'm working on something that does just that, I haven't gotten to the=20
bidirectional part just yet. (The only reason I didn't use git-svnimport is=
=20
that it has a /terrible/ time importing from the KDE svn repo. )

>      <prop-dir> is a directory object, with one file in this example;
>      called svn:ignore.  The contents of this file would be something
>      like the .gitignore;
>
>           Makefile
>           Makefile.old
>           blib
>           ...etc...

My take on the properties, though I like your thoughts on how to handle at=
=20
least svn:ignore, is to basically just let svn deal with them. I will make =
a=20
couple tools that will modify them, for interface reasons, but they'll just=
=20
be wrappers around the svn commands themselves.

At the moment, the tools are written as bash shell scripts with an interfac=
e=20
I'm trying to keep as intuitive as cogito (even though I use the core-git=20
tools now.)

--nextPart2208403.hoMt6AXcmj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD5MfiMdIamnZHMKsRAuyrAKCgGzqFGvzX97RSr7TVju5xIXf1MwCfZCR/
CFPrbtCQn3uI3mP+ZSGuHXg=
=c3gb
-----END PGP SIGNATURE-----

--nextPart2208403.hoMt6AXcmj--
