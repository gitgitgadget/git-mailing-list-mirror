From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 1/2] git-svn: don't append extra newlines at the end of
 commit messages.
Date: Fri, 13 Jun 2008 09:23:01 +0200
Message-ID: <48522055.6060006@op5.se>
References: <1213312251-8081-1-git-send-email-apenwarr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 09:24:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K73di-0006tQ-G7
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 09:24:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753624AbYFMHXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 03:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753632AbYFMHXH
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 03:23:07 -0400
Received: from mail.op5.se ([193.201.96.20]:46277 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753562AbYFMHXG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 03:23:06 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 7825D1B80379;
	Fri, 13 Jun 2008 09:19:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.449
X-Spam-Level: 
X-Spam-Status: No, score=-3.449 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.950, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CaDcZJCpdIQX; Fri, 13 Jun 2008 09:19:39 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.27])
	by mail.op5.se (Postfix) with ESMTP id 8E12B1B80088;
	Fri, 13 Jun 2008 09:19:39 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <1213312251-8081-1-git-send-email-apenwarr@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84844>

Avery Pennarun wrote:
> In git, all commits end in exactly one newline character.  In svn, commits
> end in zero or more newlines.  Thus, when importing commits from svn into
> git, git-svn always appends two extra newlines to ensure that the
> git-svn-id: line is separated from the main commit message by at least one
> blank line.
> 
> Combined with the terminating newline that's always present in svn commits
> produced by git, you usually end up with two blank lines instead of one
> between the commit message and git-svn-id: line, which is undesirable.
> 
> Instead, let's remove all trailing whitespace from the git commit on the way
> through to svn.
> 

I'm not familiar with git-svn, and my perl is pretty weak as it is.
Are you proposing to remove extra whitespace from git commits when they are
sent back to svn via dcommit? If so, wouldn't it be better to always strip
extra newlines when importing from svn so they're never there in the first
place?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
