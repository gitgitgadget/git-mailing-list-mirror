From: Marcel Holtmann <marcel@holtmann.org>
Subject: Problem cloning the Linux history tree
Date: Thu, 03 Nov 2005 09:56:26 +0100
Message-ID: <1131008187.6634.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>
X-From: git-owner@vger.kernel.org Thu Nov 03 09:56:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXati-0003wZ-Le
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 09:56:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbVKCI4f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 03:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbVKCI4f
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 03:56:35 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:22926 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1751091AbVKCI4e
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 3 Nov 2005 03:56:34 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id jA38uSGB004996
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Thu, 3 Nov 2005 09:56:28 +0100
To: git@vger.kernel.org
X-Mailer: Evolution 2.4.1 
X-Virus-Scanned: ClamAV 0.85.1/1160/Wed Nov  2 17:26:43 2005 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11068>

Hi guys,

I have some problems cloning the Linux history tree from Thomas Gleixner
over the HTTP transport. The rsync transport seems to work.

# cg-clone http://www.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
defaulting to local storage area
09:53:02 URL:http://www.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/HEAD [41/41] -> "refs/heads/.origin-fetching" [1]
Getting alternates list
Getting pack list
error: The requested URL returned error: 404
error: Unable to find e7e173af42dbf37b1d946f9ee00219cb3b2bea6a under http://www.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/

Cannot obtain needed object e7e173af42dbf37b1d946f9ee00219cb3b2bea6a
while processing commit 0000000000000000000000000000000000000000.
cg-fetch: objects fetch failed
cg-clone: fetch failed

Regards

Marcel
