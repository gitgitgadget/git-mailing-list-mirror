From: Andreas Ericsson <ae@op5.se>
Subject: Re: git add -i fails to heed user's exclude settings
Date: Thu, 08 Nov 2007 10:46:00 +0100
Message-ID: <4732DAD8.8000702@op5.se>
References: <buowsstmapt.fsf@dhapc248.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Nov 08 10:46:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq3xv-0007Ep-PG
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 10:46:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758622AbXKHJqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 04:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758577AbXKHJqG
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 04:46:06 -0500
Received: from mail.op5.se ([193.201.96.20]:37145 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758459AbXKHJqF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 04:46:05 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 304AC1F08709;
	Thu,  8 Nov 2007 10:45:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b733VdWVteoe; Thu,  8 Nov 2007 10:45:48 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 506DC1F08705;
	Thu,  8 Nov 2007 10:45:48 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <buowsstmapt.fsf@dhapc248.dev.necel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63982>

Miles Bader wrote:
> Inside git add -i, option 4 "add untracked", it doesn't seem to consider
> the user's personal ignore patterns, which is _really_ annoying.
> 
> E.g., I have:
> 
>    $ git config core.excludesfile
>    /home/miles/.gitignore
> 
>    $ cat /home/miles/.gitignore
>    [+,#]*
>    *~
> 
>    $ git status
>    # On branch master
>    nothing to commit (working directory clean)
> 
>    $ git add -i
>               staged     unstaged path
> 
>    *** Commands ***
>      1: status       2: update       3: revert       4: add untracked
>      5: patch        6: diff         7: quit         8: help
>    What now> 4
>      1: ,l
>      2: ,l.~1~
>      3: AUTHORS.~1~
>      4: Makefile.am.~1~
>      5: config.h.in~
>      6: configure.ac.~1~
>      ...tons of other random backup files etc...
> 
> This makes it very hard to find files that actually need to be added!
> 

Which git version are you using?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
