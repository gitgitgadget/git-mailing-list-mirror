From: Frank Sorenson <frank@tuxrocks.com>
Subject: Re: [doc]playing with git, and netdev/libata-dev trees
Date: Thu, 26 May 2005 02:19:22 -0600
Message-ID: <4295868A.5070509@tuxrocks.com>
References: <42955DF7.4000805@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: jgarzik@pobox.com
X-From: git-owner@vger.kernel.org Thu May 26 10:23:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbDc9-0002O5-54
	for gcvg-git@gmane.org; Thu, 26 May 2005 10:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVEZIWX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 04:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVEZIWX
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 04:22:23 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:24334 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S261270AbVEZIT3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 May 2005 04:19:29 -0400
Received: from [10.0.0.10] (sorenson.dsl.csolutions.net [216.190.206.130])
	(authenticated bits=0)
	by tuxrocks.com (8.13.1/8.13.1) with ESMTP id j4Q8JNG3007854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 26 May 2005 02:19:25 -0600
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <42955DF7.4000805@pobox.com>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jeff Garzik wrote:
> Hopefully, this email can quick-start some people on git.

I think the quick-start is great.  Definitely needed to get people
up-to-speed with git.

> 1) installing git
> 
> git requires bootstrapping, since you must have git installed in order
> to check out git.git (git repo), and linux-2.6.git (kernel repo).  I
> have put together a bootstrap tarball of today's git repository.
> 
> Download tarball from:
> http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-20050526.tar.bz2

A tarball of git will work, but it's a big bootstrap, and will need
periodic updating.

I'm curious whether we couldn't make a git-bootstrap that contained a
significantly stripped-down version that did nothing other than
bootstrap git.  A single program/file (perl script perhaps?) that...

mkdir git
cd git
rsync -rl rsync://rsync.kernel.org/pub/scm/git/git.git/ .git
echo rsync://rsync.kernel.org/pub/scm/git/git.git > .git/branches/origin
beginning with .git/HEAD, start extracting files

...and nothing more.  Then, we could tell people to just download
git-bootstrap and run it to create an up-to-date git repo.

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFClYaKaI0dwg4A47wRAp1MAKCcGK8vTWtw1gnTCjFbMFpbZkSO8QCff5RE
NC8Z7RVHFP4qcbKRMSJ2rzg=
=fXsr
-----END PGP SIGNATURE-----
