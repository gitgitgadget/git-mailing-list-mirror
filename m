From: Eric Raible <raible@gmail.com>
Subject: Re: Print last time and committer a file was touched by for a whole repo
Date: Thu, 1 Jul 2010 19:45:56 +0000 (UTC)
Message-ID: <loom.20100701T214421-373@post.gmane.org>
References: <AANLkTikRElk07ZqK0TOM2WD31t-H5RVngvHNU9KM7e9D@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 01 21:46:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUPiA-0001zS-UT
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 21:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755329Ab0GATqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 15:46:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:57099 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754345Ab0GATqH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 15:46:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OUPi0-0001tK-8c
	for git@vger.kernel.org; Thu, 01 Jul 2010 21:46:04 +0200
Received: from mobile-166-187-086-018.mycingular.net ([mobile-166-187-086-018.mycingular.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 21:46:04 +0200
Received: from raible by mobile-166-187-086-018.mycingular.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 21:46:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 166.187.86.18 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/533.4 (KHTML, like Gecko) Chrome/5.0.375.70 Safari/533.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150064>

Tim Visher <tim.visher <at> gmail.com> writes:

> 
> Hi everyone,
> 
> I need to get a listing of the entire contents of my current repo (as
> in, I don't need deleted files or anything like that, just the current
> snapshot) with the time the file was committed and who committed it.
> 
> Thoughts on how to do that?

Loop over the output of 'git ls-files' doing
'git log -1 --pretty="%ae %aD"' on each of them?
