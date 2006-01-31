From: Eric Sandall <eric@sandall.us>
Subject: Re: [ANNOUNCE] GIT 1.1.5
Date: Tue, 31 Jan 2006 09:38:19 -0800 (PST)
Message-ID: <Pine.LNX.4.63.0601310937490.29839@cerberus>
References: <7virs5x8im.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 18:38:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3zRA-0008L4-Ce
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 18:37:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWAaRg6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 12:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWAaRg6
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 12:36:58 -0500
Received: from dslb138.fsr.net ([12.7.7.138]:54464 "EHLO sandall.us")
	by vger.kernel.org with ESMTP id S1751113AbWAaRg6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 12:36:58 -0500
Received: from cerberus ([192.168.0.254])
	by sandall.us with esmtp (Exim 4.50)
	id 1F3zSR-0000rf-Jb; Tue, 31 Jan 2006 09:38:23 -0800
X-X-Sender: sandalle@cerberus
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virs5x8im.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15325>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Fri, 27 Jan 2006, Junio C Hamano wrote:
> The latest maintenance release GIT 1.1.5 is available at the
> usual places:
>
> 	http://www.kernel.org/pub/software/scm/git/
>
> 	git-1.1.5.tar.{gz,bz2}			(tarball)
> 	RPMS/$arch/git-*-1.1.5-1.$arch.rpm	(RPM)
>
> Mark Wooding noticed that there is a bug in git-checkout-index
> to overflow its internal buffer, if you construct a blob that
> records an insanely long symbolic link in your index file and
> try to check it out.  This makes it dump core or worse.
>
> The fix for this problem is the only change from v1.1.4.  The
> master branch has been updated with the same fix (so has "pu").
>
>
> ---
>
> By the way, "dump core or worse" is a subtle way to say that
> this is a security fix.  To be victimized, you have to somehow
> first get such a bogus symbolic link in your index.  Merging
> with somebody of dubious trustworthiness is a way to do so;
> please practice safe merge ;-).

I've updated the Source Mage GNU/Linux package, thanks!

- -sandalle

- --
Eric Sandall                     |  Source Mage GNU/Linux Developer
eric@sandall.us                  |  http://www.sourcemage.org/
http://eric.sandall.us/          |  SysAdmin @ Inst. Shock Physics @ WSU
http://counter.li.org/  #196285  |  http://www.shock.wsu.edu/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFD36CPHXt9dKjv3WERAhpUAKCXdVE+RgUUEY2BGl2jf0Bicdo7lgCgu/PJ
yfRqXjYEzA8etWJBWQ+fK7E=
=4UVq
-----END PGP SIGNATURE-----
