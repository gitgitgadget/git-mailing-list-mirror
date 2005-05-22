From: Frank Sorenson <frank@tuxrocks.com>
Subject: Re: cogito - how do I ???
Date: Sat, 21 May 2005 23:27:28 -0600
Message-ID: <42901840.5080002@tuxrocks.com>
References: <20050521214700.GA18676@mars.ravnborg.org> <2765.10.10.10.24.1116713164.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Sam Ravnborg <sam@ravnborg.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 07:27:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZiyn-0002Wd-R3
	for gcvg-git@gmane.org; Sun, 22 May 2005 07:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbVEVF1k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 01:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbVEVF1k
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 01:27:40 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:15888 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S261735AbVEVF1h (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 May 2005 01:27:37 -0400
Received: from [10.0.0.10] (byu-gw.customer.csolutions.net [216.190.206.130])
	(authenticated bits=0)
	by tuxrocks.com (8.13.1/8.13.1) with ESMTP id j4M5RTmC012098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 21 May 2005 23:27:30 -0600
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <2765.10.10.10.24.1116713164.squirrel@linux1>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Sean wrote:
> On Sat, May 21, 2005 5:47 pm, Sam Ravnborg said:
> 
>>Hi all.
>>
>>While trying to get up to speed on cogito/git I stumbled across
>>a few things that I at least did not find available in cogito.
>>
>>1) Something similar to "bk changes -R". I use this to see what has
>>happened upstream - to see if I really want to merge stuff.
> 
> 
> Not sure what bk did here, but you can do something like:
> 
> cg-pull origin
> cg-log -c -r origin
> 
> To see what is at the head of the unmerged objects you just pulled down,
> and if you want to merge then "cg-merge origin".  Although as far as I
> know there's no way to have the log stop automatically at the proper spot.

Here's what I use:

cg-log -c -f -r :origin

- -c = colorize the output
- -f = list files affected
- -r :origin = only display this range (equivalent to "-r HEAD:origin")

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCkBhAaI0dwg4A47wRAtrdAJ9Hy/H4BNurGd+Ukjtz+0+6sUDIkgCdHJIr
KnponX5ITXEDe/r+0dAOmqc=
=jaNR
-----END PGP SIGNATURE-----
