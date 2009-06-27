From: Unknown <borg@uu3.net>
Subject: [PATCH] git status -q (similar to subversion)
Date: Sat, 27 Jun 2009 22:57:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0906272248570.11453@cube>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811584-1792811730-1246136233=:11453"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 27 23:25:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKfOm-0006Ed-Pu
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 23:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792AbZF0VZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2009 17:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbZF0VZA
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 17:25:00 -0400
Received: from borg.uu3.net ([87.99.63.19]:48211 "EHLO borg.uu3.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750840AbZF0VY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2009 17:24:59 -0400
X-Greylist: delayed 1666 seconds by postgrey-1.27 at vger.kernel.org; Sat, 27 Jun 2009 17:24:59 EDT
Received: from localhost (localhost [127.0.0.1])
	by borg.uu3.net (Postfix) with ESMTP id E4391633A9
	for <git@vger.kernel.org>; Sat, 27 Jun 2009 22:57:13 +0200 (CEST)
X-X-Sender: borg@cube
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122384>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811584-1792811730-1246136233=:11453
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Here is a tiny patch adding -q option to git status.
It means -uno (Show no untracked files).

Not sure where to add that in documentation.
Maybe in git-commit man just below -u:
-q (for git-status only, equals to -uno).
Or something like this?

Regards,
Borg
---1463811584-1792811730-1246136233=:11453
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=git-status.patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0906272257130.11453@cube>
Content-Description: 
Content-Disposition: attachment; filename=git-status.patch

ZGlmZiAtLWdpdCBhL2J1aWx0aW4tY29tbWl0LmMgYi9idWlsdGluLWNvbW1p
dC5jDQppbmRleCA0MWUyMjJkLi5lNGUwMDc0IDEwMDY0NA0KLS0tIGEvYnVp
bHRpbi1jb21taXQuYw0KKysrIGIvYnVpbHRpbi1jb21taXQuYw0KQEAgLTgy
Niw2ICs4MjYsOCBAQCBpbnQgY21kX3N0YXR1cyhpbnQgYXJnYywgY29uc3Qg
Y2hhciAqKmFyZ3YsIGNvbnN0IGNoYXIgKnByZWZpeCkNCiAJCWRpZmZfdXNl
X2NvbG9yX2RlZmF1bHQgPSBnaXRfdXNlX2NvbG9yX2RlZmF1bHQ7DQogDQog
CWFyZ2MgPSBwYXJzZV9hbmRfdmFsaWRhdGVfb3B0aW9ucyhhcmdjLCBhcmd2
LCBidWlsdGluX3N0YXR1c191c2FnZSwgcHJlZml4KTsNCisJaWYocXVpZXQp
DQorCQlzaG93X3VudHJhY2tlZF9maWxlcyA9IFNIT1dfTk9fVU5UUkFDS0VE
X0ZJTEVTOw0KIA0KIAlpbmRleF9maWxlID0gcHJlcGFyZV9pbmRleChhcmdj
LCBhcmd2LCBwcmVmaXgpOw0KIA0K

---1463811584-1792811730-1246136233=:11453--
