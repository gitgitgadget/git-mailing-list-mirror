From: Paul Gardiner <osronline@glidos.net>
Subject: How to find where a branch was taken from.
Date: Fri, 21 Mar 2008 09:05:39 +0000
Message-ID: <47E37A63.9070209@glidos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: osronline@glidos.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 21 10:06:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcdCm-0004sH-8D
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 10:06:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422AbYCUJFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 05:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752571AbYCUJFp
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 05:05:45 -0400
Received: from mk-outboundfilter-1.mail.uk.tiscali.com ([212.74.114.37]:57485
	"EHLO mk-outboundfilter-1.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752385AbYCUJFo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Mar 2008 05:05:44 -0400
X-Trace: 70778391/mk-outboundfilter-1.mail.uk.tiscali.com/PIPEX/$ACCEPTED/pipex-customers/81.86.57.226
X-SBRS: None
X-RemoteIP: 81.86.57.226
X-IP-MAIL-FROM: osronline@glidos.net
X-IP-BHB: Once
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvoAAK8W40dRVjni/2dsb2JhbAAIqhI
X-IP-Direction: IN
Received: from 81-86-57-226.dsl.pipex.com (HELO [10.0.0.24]) ([81.86.57.226])
  by smtp.pipex.tiscali.co.uk with ESMTP; 21 Mar 2008 09:05:41 +0000
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77730>

I need a command that will find the remote branch from which
the currently checked out branch was started. I don't know
git very well, and the only way I can think to do it so far
is to iterate over the remote branches and find the one
for which git-rev-list <branch>..HEAD gives the smallest
number of objects. I'm guessing there must be a better
way. Any ideas?

Cheers,
	Paul.
