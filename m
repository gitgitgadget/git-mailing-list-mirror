From: Frank Sorenson <frank@tuxrocks.com>
Subject: Re: [PATCH] Fix git-fsck-cache segfault on invalid tag
Date: Fri, 20 May 2005 08:36:16 -0600
Message-ID: <428DF5E0.6030106@tuxrocks.com>
References: <428D8B19.4070605@tuxrocks.com> <20050520085047.GA27787@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri May 20 16:38:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZ8b8-0001xA-FV
	for gcvg-git@gmane.org; Fri, 20 May 2005 16:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVETOgb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 10:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbVETOgb
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 10:36:31 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:26378 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S261347AbVETOgZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 10:36:25 -0400
Received: from [10.0.0.10] (sorenson.dsl.csolutions.net [216.190.206.130])
	(authenticated bits=0)
	by tuxrocks.com (8.13.1/8.13.1) with ESMTP id j4KEaHBt030139
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 20 May 2005 08:36:19 -0600
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050520085047.GA27787@pasky.ji.cz>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Petr Baudis wrote:
> Dear diary, on Fri, May 20, 2005 at 09:00:41AM CEST, I got a letter
> where Frank Sorenson <frank@tuxrocks.com> told me that...
> 
>>git-fsck-cache will segfault if a tag contains a non-existent sha1.  This
>>patch fixes fsck-cache to report the invalid tag and not die.
> 
> 
> Oh. I've fixed this too but didn't even get to commit it yet. :-)

Okay.  At least we fixed the same bug.  It was a good exercise for me to
track it down anyway :)

> My error message is
> 
> 	error("%s: invalid sha1 pointer %.40s", path, hexname);
> 
> I'd prefer that (at least use the error() call). The .40 is there since
> it has a newline on its own.

Great.  Your message looks fine.  It looks like error() should work fine
as well.

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCjfXgaI0dwg4A47wRAikrAKCvPmZBQK34sdnnY61/meuewu2jzQCfT7Qf
TDSNgfp3WBJOTvWG5uhwX4s=
=CUF2
-----END PGP SIGNATURE-----
