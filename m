From: Andy Whitcroft <apw@shadowen.org>
Subject: bare repositories: packing and fetching
Date: Fri, 15 Sep 2006 19:04:39 +0100
Message-ID: <450AEB37.3090909@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Sep 15 20:05:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOI3x-0001Jm-5t
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 20:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbWIOSFK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 14:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWIOSFJ
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 14:05:09 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:29199 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751304AbWIOSFI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Sep 2006 14:05:08 -0400
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1GOI3N-0003ma-LD
	for git@vger.kernel.org; Fri, 15 Sep 2006 19:04:41 +0100
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
To: Git Mailing List <git@vger.kernel.org>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27094>

I was trying to make a bare repo to stage linus' main tree.  As this was
only to be a local tree for others to pull from I thought that I could
clone his tree 'bare' and then fetch into that on a regular basis.  That
does not appear to be the case?  Both git fetch and git repack say 'not
a git repository .git' and bail.

Is this expected behaviour.  Do I have to have all the checked out files?

-apw
