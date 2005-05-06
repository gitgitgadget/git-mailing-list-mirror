From: Frank Sorenson <frank@tuxrocks.com>
Subject: How do I...
Date: Fri, 06 May 2005 03:49:39 -0600
Message-ID: <427B3DB3.4000507@tuxrocks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri May 06 11:43:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTzMr-0006Fm-5u
	for gcvg-git@gmane.org; Fri, 06 May 2005 11:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVEFJuF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 05:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVEFJuF
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 05:50:05 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:9993 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S261200AbVEFJtq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2005 05:49:46 -0400
Received: from [10.0.0.10] (byu-gw.customer.csolutions.net [216.190.206.130])
	(authenticated bits=0)
	by tuxrocks.com (8.13.1/8.13.1) with ESMTP id j469nh6h008461
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 6 May 2005 03:49:44 -0600
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Okay, I've got some "How can I?" questions.  I hope I'm not the only one
still working to "git it".

How can I git a list of commits that have modified a particular file?
For example, I'd like to do something like this:
# git-file-revs Makefile
f7eb55878f11575281add2a5726e483aed5e45bb
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
...

How can I output a list of the filename(s) modified by a particular
commit? (for example)
# git-commit-info files 6741f3a7f9922391cd02b3ca1329e669497dc22f
Makefile
file1
arch/file2

Can I use cg-log to output just the information about a particular
commit?  (I don't need all the commits, just the one I'm interested in).

After doing a cg-update, can I cg-log just the changes since the last
update?  Alternatively, how can I tell cg-log I'm caught up, and don't
need anything historical?

Can I do these with git/cogito, or will I need to start diving deeper
into the code?

Thanks,

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCez2zaI0dwg4A47wRAuNAAJ0QsBkwwHFbFQshRGSDCLv/pEaZXQCfeZj6
rqC9ZoVAYNeMwKqppbyXx9o=
=pJDl
-----END PGP SIGNATURE-----
