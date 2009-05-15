From: "David H. Lynch J.r" <ml@dlasys.net>
Subject: git svn rebase problem
Date: Fri, 15 May 2009 17:21:09 -0400
Message-ID: <4A0DDCC5.4010001@dlasys.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 15 23:28:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M54wh-0000QB-VY
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 23:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754036AbZEOV1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 17:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753818AbZEOV1v
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 17:27:51 -0400
Received: from outbound-mail-116.bluehost.com ([69.89.22.16]:46549 "HELO
	outbound-mail-116.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752416AbZEOV1u (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 May 2009 17:27:50 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 May 2009 17:27:50 EDT
Received: (qmail 27614 invoked by uid 0); 15 May 2009 21:21:12 -0000
Received: from unknown (HELO host200.hostmonster.com) (74.220.207.200)
  by outboundproxy3.bluehost.com with SMTP; 15 May 2009 21:21:12 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=dlasys.net;
	h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:Content-Type:Content-Transfer-Encoding:X-Identified-User;
	b=WELWRnDsv5U4jiB/FspcFnAHzgm2kjyJlPGJeASxChi+XFbGrbLbaMM3unpGqRcwiOQlP2WQka7GreuUbQMeZ/GZYo7Sveaf7Bb0EWemNmSWE0QBT7oLDk5iR1PY5IDO;
Received: from 72.25.32.200.dynamic.dejazzd.com ([72.25.32.200] helo=[206.223.20.150])
	by host200.hostmonster.com with esmtpa (Exim 4.69)
	(envelope-from <ml@dlasys.net>)
	id 1M54q8-00069S-94
	for git@vger.kernel.org; Fri, 15 May 2009 15:21:12 -0600
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
X-Identified-User: {2173:host200.hostmonster.com:dlasysne:dlasys.net} {sentby:smtp auth 72.25.32.200 authed with dhlii+dlasys.net}
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119300>

For some time I am using git svn to manage a local copy of a remote svn
repository.

The svn repository has no branches.

A few days ago I did an
git svn rebase

The rebase took a while and after it completed reported
fatal: bad object HEAD

git status reports
root@hp-dhlii:/usr/src/pico/git# git status
# Not currently on any branch.
fatal: bad object HEAD

and git fsck reports
root@hp-dhlii:/usr/src/pico/git# git fsck
dangling blob eb3afb4aa3aaf0003bac601a5db4fd76aafa2a87
dangling commit 5c496db25007c17c325f294bb8324097c9bc407d

How can I recover without downloading the entire repository again which
could take days?
