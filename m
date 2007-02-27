From: Bill Lear <rael@zopyra.com>
Subject: Strange behavior of git remote with bogus input
Date: Tue, 27 Feb 2007 07:21:58 -0600
Message-ID: <17892.12406.691169.428572@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 27 14:22:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM2HW-0004oV-S1
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 14:22:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbXB0NWM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 08:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbXB0NWM
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 08:22:12 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60357 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751192AbXB0NWL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 08:22:11 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1RDMAc03957;
	Tue, 27 Feb 2007 07:22:10 -0600
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40730>

% ls
project foo
% cd project
% git remote add ../foo joe
% git remote

origin

I mis-typed the git remote and got the order wrong.  It did not give
an error and then it seemed to add a "ghost" remote.

My .git/config file has:

[remote "../foo"]
        url = joe
        fetch = +refs/heads/*:refs/remotes/../foo/*

Soo, probably kinda goofy.

Now, how do I fix this?  Just remove this entry from the .git/config
file?


Bill
