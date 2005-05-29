From: Jochen Roemling <jochen@roemling.net>
Subject: Re: change of git-diff-tree and symlinks
Date: Sun, 29 May 2005 18:06:38 +0200
Message-ID: <4299E88E.7090306@roemling.net>
References: <20050525111711.GA27492@vrfy.org> <4299CED5.5070508@roemling.net> <20050529150656.GA27127@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Sebastian Kuzminsky <seb@highlab.com>
X-From: git-owner@vger.kernel.org Sun May 29 18:05:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcQHJ-0005nx-TJ
	for gcvg-git@gmane.org; Sun, 29 May 2005 18:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVE2QGz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 12:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbVE2QGz
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 12:06:55 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:59898 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261346AbVE2QGl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 12:06:41 -0400
Received: from p54AAFF39.dip.t-dialin.net [84.170.255.57] (helo=[10.3.24.50])
	by mrelayeu.kundenserver.de with ESMTP (Nemesis),
	id 0ML29c-1DcQJB3PjD-0004pS; Sun, 29 May 2005 18:06:37 +0200
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20050529150656.GA27127@vrfy.org>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:35bace2e8eeec41a1b9500b782c09cc4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[resending in plain-text]

Kay Sievers wrote:

>The kernel.org servers use Cogito which needs a new release. So the
>version on kernel.org is always a working version with the current
>release of Cogito as long as we don't get a git-core to provide the
>binaries.
>  
>
Ah yes, I remember the discussion about that.
Sebastian, could you include a matching gitweb.cgi into your 
Debian-Package?

And what about something like:

if (-e '/etc/gitweb.conf') { requite '/etc/gitweb.conf'; }

after the variable settings? The included file would then set 
$projectroot and friends to the local values so that I don't have to 
patch gitweb everytime I upgrade it. Since perl has no plain "include" 
and the require doesn't really work for me (it seems to include the 
file, but the variables stay the same), I leave it up to you (I would 
have been so proud to provide you a patch, but obviously my perl 
knowledge is worse than I thought).

>My latest version is here:
>  ftp://ehlo.org/gitweb.cgi
>  
>
Thanks for pointing that out. I had the impression, on ehlo.org is only 
a installed version, not a downloadable one.

>>And as a last side note it would be helpfull if you could include a 
>>release number in the gitweb footer as you did in the very beginning so 
>>that we know if something changed and there is new stuff to explore...
>>    
>>
>
>It is in the html-source, right at the top.
>  
>
Good hiding-place....

Jochen
