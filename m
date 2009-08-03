From: Michael Wild <themiwi@users.sourceforge.net>
Subject: conflict status
Date: Mon, 3 Aug 2009 17:14:00 +0200
Message-ID: <DDAD985F-C9CA-4159-B382-354D4B082C19@users.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 03 18:24:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MY0KU-0002VB-2D
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 18:24:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755431AbZHCQXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 12:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755427AbZHCQXf
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 12:23:35 -0400
Received: from mxout005.mail.hostpoint.ch ([217.26.49.184]:59351 "EHLO
	mxout005.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755419AbZHCQXe (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Aug 2009 12:23:34 -0400
X-Greylist: delayed 4174 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Aug 2009 12:23:34 EDT
Received: from [10.0.2.20] (helo=asmtp002.mail.hostpoint.ch)
	by mxout005.mail.hostpoint.ch with esmtp (Exim 4.69 (FreeBSD))
	(envelope-from <themiwi@users.sourceforge.net>)
	id 1MXzEe-0008UG-So
	for git@vger.kernel.org; Mon, 03 Aug 2009 17:14:00 +0200
Received: from [82.130.106.80] (helo=nynaeve.ifd.mavt.ethz.ch)
	by asmtp002.mail.hostpoint.ch with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69 (FreeBSD))
	(envelope-from <themiwi@users.sourceforge.net>)
	id 1MXzEe-000Cuu-NV
	for git@vger.kernel.org; Mon, 03 Aug 2009 17:14:00 +0200
X-Authenticated-Sender-Id: mi@miba.li
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124702>

Hi all

I'm merging two branches with a large number of conflicts.  
Fortunately, there are many modified/deleted conflicts (locally  
modified, remotely deleted), and I know that for those I want to pick  
the deleted version. However, I can't seem to motivate GIT into  
telling me for which of the conflicting files this is the case. I know  
that git-mergetool somehow extracts this information, but looking at  
the code, it seems to me that there must be an easier, user-level  
method of obtaining this information.

Generally speaking, I would like to know for each file with a conflict  
what it's status is, similar to what SVN does:
- locally modified/created/deleted/...
- remotely modified/created/deleted/...

Please excuse me if this is either trivial or has been answered many  
times before, but neither perusing the man-pages, nor asking google  
turned up anything remotely useful.

Thanks for the help

Michael
