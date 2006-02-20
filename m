From: Ryan Anderson <ryan@michonline.com>
Subject: Re: Prepend the history of one git tree to another
Date: Mon, 20 Feb 2006 05:57:55 -0500
Message-ID: <43F9A0B3.6020304@michonline.com>
References: <20060220090909.GT6558@cip.informatik.uni-erlangen.de> <43F99684.5070403@op5.se> <20060220104345.GG26454@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig887719BE3D56818A1A99E0F4"
Cc: Andreas Ericsson <ae@op5.se>, GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 20 11:58:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FB8kD-0007oM-Td
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 11:58:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbWBTK6O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 05:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbWBTK6O
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 05:58:14 -0500
Received: from mail.autoweb.net ([198.172.237.26]:14757 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S964883AbWBTK6N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2006 05:58:13 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1FB8k3-0007Kl-QK; Mon, 20 Feb 2006 05:58:11 -0500
Received: from [10.254.251.12] (helo=mythryan.michonline.com)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FB8ju-00081c-NG; Mon, 20 Feb 2006 05:57:58 -0500
Received: from localhost ([127.0.0.1])
	by mythryan.michonline.com with esmtp (Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FB8ju-0007Dy-AP; Mon, 20 Feb 2006 05:57:58 -0500
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20060220104345.GG26454@cip.informatik.uni-erlangen.de>
X-Enigmail-Version: 0.93.0.0
X-h4x0r5.com-MailScanner: Found to be clean
X-h4x0r5.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16478>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig887719BE3D56818A1A99E0F4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Thomas Glanzmann wrote:

>Hello Andreas,
>
>  
>
>>Something like this might do the trick, depending on how linear your 
>>ancestry graph is:
>>    
>>
>
>  
>
>>$ cd blastwave
>>$ first=$(git rev-list HEAD | tail -n 1)
>>$ git format-patch -k --stdout $first..HEAD > ../blw.mbox
>>$ cd ../blastwave.old
>>$ git am -k -3 ../blw.mbox
>>    
>>
>
>My graph is very linear. However. I have binaries checked into my tree.
>I am not sure if format-patch can handle this.
>  
>
I wrote a program called "graft-ripple", that takes a commit, and
rewrites the current branch's history to reflect as if it started at
that commit.

It doesn't ever actually work with diffs or anything, it just reads
commits and trees and recreates them.

It's in the list archives, but I appear to have deleted it when I was
cleaning up my archives.

http://www.gelato.unsw.edu.au/archives/git/0511/12965.html

Hope this helps!

-- 

Ryan Anderson
  sometimes Pug Majere


--------------enig887719BE3D56818A1A99E0F4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFD+aC2fhVDhkBuUKURAjWcAJ9he3f9e1Z1uSJDVIvddq/i9ocxgACgkR0t
10kOjfaf6EBJr/eQfQVPiXM=
=xfmi
-----END PGP SIGNATURE-----

--------------enig887719BE3D56818A1A99E0F4--
