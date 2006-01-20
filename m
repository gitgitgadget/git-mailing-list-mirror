From: Ryan Anderson <ryan@michonline.com>
Subject: Re: /etc in git?
Date: Fri, 20 Jan 2006 08:50:26 -0500
Message-ID: <43D0EAA2.8090308@michonline.com>
References: <b476569a0601181943y6a14e703k1b521a7edb9e2e2@mail.gmail.com>	<7vlkxckf7o.fsf@assigned-by-dhcp.cox.net>	<b476569a0601182040w581b72b7xbb99845da4085646@mail.gmail.com>	<7v64ogkdtu.fsf@assigned-by-dhcp.cox.net>	<43CF3061.2030504@michonline.com> <7vvewgirlt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6C486DE5C420B58E3D5226DC"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 20 14:50:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ezwf5-0007do-EW
	for gcvg-git@gmane.org; Fri, 20 Jan 2006 14:50:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWATNul (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jan 2006 08:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbWATNul
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jan 2006 08:50:41 -0500
Received: from mail.autoweb.net ([198.172.237.26]:42196 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1750972AbWATNuk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2006 08:50:40 -0500
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1Ezwez-0007Gx-QF; Fri, 20 Jan 2006 08:50:39 -0500
Received: from [10.254.251.12] (helo=mythryan.michonline.com)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1Ezwet-0000WN-HK; Fri, 20 Jan 2006 08:50:37 -0500
Received: from localhost ([127.0.0.1])
	by mythryan with esmtp (Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1Ezwes-0008Br-F4; Fri, 20 Jan 2006 08:50:30 -0500
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvewgirlt.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14961>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6C486DE5C420B58E3D5226DC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Junio C Hamano wrote:

>Ryan Anderson <ryan@michonline.com> writes:
>  
>
>>Junio C Hamano wrote:
>>    
>>
>>>You are much better off to keep /usr/src/rootstuff/.git (and
>>>working tree files are /usr/src/rootstuff/etc/hosts and
>>>friends), have a build procedure (read: Makefile) there, and
>>>version control that source directory.  I usually have 'install'
>>>and 'diff' target in that Makefile, so that I can do this:
>>>... 
>>>      
>>>
>>If you're doing this, especially if you're doing this on multiple
>>machines, creating a package is probably a worthwhile thing to
>>contemplate as well.
>>    
>>
>
>In my workplace environment, the equivalent of the above
>/usr/src/rootstuff is accessible throughout the networked
>machines (mostly NFS mounted); for things that needs per-host
>customization, we do not have /usr/src/rootstuff/etc/hosts but
>keep /usr/src/rootstuff/etc/hosts.in as the source, and Makefile
>customizes that into a form suitable for installation for each
>machine.  Especially useful is vfstab.in --- a single source
>builds fstab for local mounting and nfs exports, while other
>machines have mountpoints and project symlinks pointing into
>location automounted from that machine with disk, generated
>automatically.  This does not match typical "package" use.
>  
>
To provide an off-topic, but perhaps useful, counter-example, where I
work, I've made a package that does something similar.

I use a Makefile to generate a few template files, such as
/etc/resolv.conf, /etc/apt/preferences, /etc/sudoers, /etc/ntp.conf
It Pre-Depends on, ntp, sudo, (etc).

A postinstallation script does a little bit of tweaking of these files
based upon the answers to one or two questions asked during installation.

It's simply another way of looking at the problem.

-- 

Ryan Anderson
  sometimes Pug Majere


--------------enig6C486DE5C420B58E3D5226DC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFD0OqlfhVDhkBuUKURAtazAJ4qkh7tcOmncHZ+OYLFVK08B7uMCwCcDLJX
S6PjAF4xS+cZoDzcwJLubPw=
=dVXp
-----END PGP SIGNATURE-----

--------------enig6C486DE5C420B58E3D5226DC--
