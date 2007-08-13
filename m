From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: [PATCH] gitk - dont warn when deleting synonym for current head
Date: Sun, 12 Aug 2007 21:10:38 -0400
Message-ID: <46BFAF8E.1000508@verizon.net>
References: <1186952583887-git-send-email-mdl123@verizon.net>
 <18111.39773.231609.306547@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Aug 13 03:10:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKOSM-0006qQ-Bm
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 03:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933554AbXHMBKk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 21:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764427AbXHMBKk
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 21:10:40 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:52830 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762461AbXHMBKj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 21:10:39 -0400
Received: from [192.168.100.117] ([71.246.233.117])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JMO00AX8TXRSEJF@vms046.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 12 Aug 2007 20:10:39 -0500 (CDT)
In-reply-to: <18111.39773.231609.306547@cargo.ozlabs.ibm.com>
User-Agent: Thunderbird 1.5.0.12 (Windows/20070509)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55738>

Paul Mackerras wrote:
> Mark Levedahl writes:
>
>   
> Do you mean that HEAD was a direct ref to the same commit as the
> branch you were deleting, or that HEAD pointed to the branch you were
> deleting?  I.e. what was in .git/HEAD, a commit ID or a branch name?
>
> If the latter, then I think gitk was correct to warn, since you'll end
> up with .git/HEAD pointing to a non-existent branch, won't you?
>   
current checked out branch = master
HEAD contains ref: refs/heads/master
foo points to the same commit as master
I attempted to delete foo.

Note: the context menu does not allow deleting the currently checked out 
branch, so the referenced check is irrelevant to that.

Mark
