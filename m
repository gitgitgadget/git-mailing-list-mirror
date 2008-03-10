From: Peter Gordon <peter@pg-consultants.com>
Subject: Git workflow
Date: Mon, 10 Mar 2008 14:37:43 +0200
Message-ID: <1205152663.3470.12.camel@tigger>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 11 02:09:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYszv-0003qM-DW
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 02:09:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbYCKBJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 21:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbYCKBJD
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 21:09:03 -0400
Received: from ace.securenet-server.net ([63.247.93.10]:57662 "EHLO
	ace.securenet-server.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbYCKBJC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 21:09:02 -0400
X-Greylist: delayed 45075 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Mar 2008 21:09:02 EDT
Received: from [212.143.139.191] (helo=[10.10.0.22])
	by ace.securenet-server.net with esmtpa (Exim 4.68)
	(envelope-from <peter@pg-consultants.com>)
	id 1JYhGA-0002L9-U3
	for git@vger.kernel.org; Mon, 10 Mar 2008 07:37:43 -0500
X-Mailer: Evolution 2.10.3 (2.10.3-8.fc7) 
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ace.securenet-server.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - pg-consultants.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76779>

Hi.

There are a number of us working on a project. We each have a HEAD, and
work on branches, using git-checkout -b MyPatch. When we have finished
working on the branch, we move back to the HEAD, with 
git-checkout master, do a 
git-pull
and then git-cherry-pick sha1.....

I have two questions. 

1) Is this the normal way to work with git.

2) Also, we sometimes get a log of 
Merge branch 'master' of git://sgit/MyProject which has no commits. Why
does this happen?

Thanks,

Peter
