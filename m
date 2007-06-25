From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH 2/2] Check for IO errors after running a command
Date: Mon, 25 Jun 2007 15:42:04 +0200
Organization: eudaptics software gmbh
Message-ID: <467FC62C.87F83541@eudaptics.com>
References: <87abuq1z6f.fsf@rho.meyering.net> <7vzm2pwws8.fsf@assigned-by-dhcp.cox.net>
	 <alpine.LFD.0.98.0706240951440.3593@woody.linux-foundation.org>
	 <alpine.LFD.0.98.0706241010480.3593@woody.linux-foundation.org>
	 <7vy7i8xtap.fsf@assigned-by-dhcp.pobox.com> <Pine.LNX.4.64.0706251413530.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 25 15:43:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2orB-0005uv-7y
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 15:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755519AbXFYNnu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 09:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755474AbXFYNnu
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 09:43:50 -0400
Received: from main.gmane.org ([80.91.229.2]:38036 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754930AbXFYNnt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 09:43:49 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I2oqN-0005cM-6j
	for git@vger.kernel.org; Mon, 25 Jun 2007 15:43:03 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Jun 2007 15:43:03 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Jun 2007 15:43:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50893>

Johannes Schindelin wrote:
> One thing we might consider, however: when rebasing, the current branch
> gets updated at each step. Some might consider this a bug, and prefer
> rebase to work on a detached HEAD, and only update the branch at the end,
> so that <branchname>@{1} refers to the state _before_ rebase.

YESSSS!

Finding the commit before the rebase in the reflog is a nightmare.

-- Hannes
