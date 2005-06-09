From: Frank Sorenson <frank@tuxrocks.com>
Subject: Re: [PATCH] Fix cogito handling of timezones
Date: Thu, 09 Jun 2005 08:20:29 -0600
Message-ID: <42A8502D.4030508@tuxrocks.com>
References: <42A7BA17.5050707@tuxrocks.com> <20050609082949.GC29665@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 09 16:35:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgNpn-0007Rz-Nh
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 16:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbVFIOUm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 10:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262411AbVFIOUm
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 10:20:42 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:780 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S262410AbVFIOUe (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 10:20:34 -0400
Received: from [10.0.0.10] (sorenson.dsl.csolutions.net [216.190.206.130])
	(authenticated bits=0)
	by tuxrocks.com (8.13.1/8.13.1) with ESMTP id j59EKUML012106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 9 Jun 2005 08:20:31 -0600
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050609082949.GC29665@pasky.ji.cz>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Petr Baudis wrote:

> It looks ok, but shouldn't this be
> +		lsec=$(($sec + $dtz % 100 * 60 $sign $dtz / 100 * 3600))

Ah, yes, of course.  I see that Dan Holmsand has also sent a patch (3/6)
to fix this.  I haven't tested his very much, but it looks like a
cleaner and more comprehensive solution.  Sigh.

Frank
- -- 
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCqFAtaI0dwg4A47wRAlaEAJ0Ui38Yrwp7r0QUseI5/7n4kbnRaACfZBv0
M5TClhJuvD2y7fz/Fm9pNes=
=SOdU
-----END PGP SIGNATURE-----
