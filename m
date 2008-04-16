From: Ralf Baechle <ralf@linux-mips.org>
Subject: Is there really a need for packed-refs to exist for rsync://?
Date: Wed, 16 Apr 2008 10:42:22 +0100
Message-ID: <20080416094222.GA23987@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Wed Apr 16 11:49:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jm4Gk-0008HC-5i
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 11:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756412AbYDPJst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 05:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755788AbYDPJst
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 05:48:49 -0400
Received: from oss.sgi.com ([192.48.170.157]:32977 "EHLO oss.sgi.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754605AbYDPJst (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 05:48:49 -0400
X-Greylist: delayed 384 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Apr 2008 05:48:49 EDT
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m3G9fgDs026686
	for <git@vger.kernel.org>; Wed, 16 Apr 2008 02:41:43 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m3G9gMdo024083
	for <git@vger.kernel.org>; Wed, 16 Apr 2008 10:42:22 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m3G9gMKi024082
	for git@vger.kernel.org; Wed, 16 Apr 2008 10:42:22 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79690>

Trying to clone a repository using its rsync:// URL I'm getting this
error message:

[...]
sent 150 bytes  received 363603747 bytes  80800866.00 bytes/sec
total size is 363559095  speedup is 1.00
rsync: link_stat "/scm/upstream-linus.git/packed-refs" (in pub) failed: No such file or directory (2)
rsync error: some files could not be transferred (code 23) at main.c(1385) [receiver=2.6.9]
fatal: Could not run rsync to get refs
$

The same repository can be cloned with no problem using its git:// and
http:// URLs so I guess the rsync:// method is broken here.  This is
using git 1.5.4.1.

Cheers,

  Ralf
