From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Git tree for old kernels from before the current tree
Date: Sun, 22 Jul 2007 16:49:48 -0400
Message-ID: <9e4733910707221349s462aa11bj714956f7cdc72aac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 22 22:50:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICiNL-0007CD-5E
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 22:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764994AbXGVUtw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 16:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764985AbXGVUtv
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 16:49:51 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:1432 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764951AbXGVUtt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 16:49:49 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1751277wah
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 13:49:49 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Y4UvZNBJYqD4NWEPbEA1Wvn2sILS6mm95AQHx7GcTUOABsQDV9i9LstAkMKAkWLqP00Be/AY27bfvXYJfqZ9uL0Nv84GVgZ6LXbQyRL6wqj4gDr9HJLT9wKa+rMx7UIPfMJ9JobaNK/SgVloTvADhTiLy51gWidHjiKGfEYAO7M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=BAnlkVY3JLOLNWc7difoRVEfAmyoLP30noIePU1GK2SuqV+9b/WK+bIFVQTtWA1soDt0dc1eLMCePgKbe/5am/QYWZCyC0PekoVKBxeyLtAjmRDk4C/SLaW4FUoBARLDt/HDi5vf57qrMke216+HHNEZm0P9hXf6nowxei4GWss=
Received: by 10.114.88.1 with SMTP id l1mr2354690wab.1185137388803;
        Sun, 22 Jul 2007 13:49:48 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Sun, 22 Jul 2007 13:49:48 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53317>

Continuing on with kernel archeology for embedded systems, any
interest in making a git tree with all of the kernel versions from the
beginning up to the start of the current git tree? No history in the
tree, just a simple way to quickly fetch and select a copy of all the
various old releases. I know they are all available ftp, git tree
would organize them all in one place and let you fetch them all at
once.

If this is small enough you could add it to the current kernel tree.
Git's super diffing performance might make this fairly small.

My dream system lets me checkout an ancient version, apply the diff
from the vendor (or expand a tarball), use git status to see what
files changed, and git diff to get detailed changes (all minus CVS
keyword expansion noise). Major bonus points if it can detect detect a
subsystem that has been backported.

-- 
Jon Smirl
jonsmirl@gmail.com
