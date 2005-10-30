From: Frank Sorenson <frank@tuxrocks.com>
Subject: [PATCH] gitk: Specify line hover font
Date: Sun, 30 Oct 2005 02:06:46 -0700
Message-ID: <43648D26.90006@tuxrocks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Oct 30 10:09:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EW9Av-0002ur-4q
	for gcvg-git@gmane.org; Sun, 30 Oct 2005 10:08:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbVJ3JIP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Oct 2005 04:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbVJ3JIP
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Oct 2005 04:08:15 -0500
Received: from www.tuxrocks.com ([64.62.190.123]:527 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S1750791AbVJ3JIO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Oct 2005 04:08:14 -0500
Received: from [10.0.0.10] (216-190-206-130.customer.csolutions.net [216.190.206.130])
	(authenticated bits=0)
	by tuxrocks.com (8.13.1/8.13.1) with ESMTP id j9U971oC017922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 30 Oct 2005 02:07:22 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10817>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hovering over a line in gitk displays the commit one-liner in a
box, but the text usually overflows the box.  The box size is
computed with a specified font, so this patch sets the text font
as well.

Signed-off-by: Frank Sorenson <frank@tuxrocks.com>

- --- a/gitk	2005-10-30 01:52:29.000000000 -0700
+++ b/gitk	2005-10-30 01:51:45.000000000 -0700
@@ -3143,7 +3143,7 @@
     set t [$canv create rectangle $x0 $y0 $x1 $y1 \
 	       -fill \#ffff80 -outline black -width 1 -tags hover]
     $canv raise $t
- -    set t [$canv create text $x $y -anchor nw -text $text -tags hover]
+    set t [$canv create text $x $y -anchor nw -text $text -tags hover -font $mainfont]
     $canv raise $t
 }
 

Frank
- -- 
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDZIz1aI0dwg4A47wRAjgLAKDFMGTgTPnGI9zBv48p1emAvLg6GgCeNwz3
OSrKWqnqGYpgMC89amkpUos=
=dD0G
-----END PGP SIGNATURE-----
