From: Frank Sorenson <frank@tuxrocks.com>
Subject: [PATCH] Commify numbers in cg-pull
Date: Wed, 06 Jul 2005 01:04:25 -0600
Message-ID: <42CB8279.10603@tuxrocks.com>
References: <42CB81A2.7080405@tuxrocks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jul 06 09:10:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dq42t-0008Pi-65
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 09:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262159AbVGFHI1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 03:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbVGFHH7
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 03:07:59 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:52240 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S262159AbVGFHEa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2005 03:04:30 -0400
Received: from [10.0.0.10] (216-190-206-130.customer.csolutions.net [216.190.206.130])
	(authenticated bits=0)
	by tuxrocks.com (8.13.1/8.13.1) with ESMTP id j6674PNf021027
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 6 Jul 2005 01:04:26 -0600
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
In-Reply-To: <42CB81A2.7080405@tuxrocks.com>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here is a patch to commify the number and size of objects pulled
in cg-pull.  Depends on the previous "Add commify function" patch.

Signed-off-by: Frank Sorenson <frank@tuxrocks.com>

Commify number and size of objects pulled in pull_progress

- ---
commit 03fb604eb8c24851096cca14bed19f4eacc79686
tree 191e8aa3a034e302aa660a9a5b5c0c64e2e88ac9
parent de4fd646c8307777137b9a4c1b5735f9573167f6
author Frank Sorenson <frank@tuxrocks.com> Wed, 06 Jul 2005 00:47:56 -0600
committer Frank Sorenson <frank@tuxrocks.com> Wed, 06 Jul 2005 00:47:56 -0600

 cg-pull |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/cg-pull b/cg-pull
- --- a/cg-pull
+++ b/cg-pull
@@ -82,7 +82,7 @@ pull_progress() {
 		size=$(($size + $(stat -c '%s' "$object" 2>/dev/null)))
 		objects=$(($objects + 1));
 
- -		echo -ne "progress: $objects objects, $size bytes$percentage\r"
+		echo -ne "progress: $(commify $objects) objects, $(commify $size) bytes$percentage\r"
 	done;
 	[ "$last_objects" != "$objects" ] && echo
 }


Frank
- -- 
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCy4J4aI0dwg4A47wRAihxAKCOAioNWvYBDPkOvk/hYUgfUuMdewCgm1ea
4IGx09Ew6tytbOAyPrUxHZU=
=YM7f
-----END PGP SIGNATURE-----
