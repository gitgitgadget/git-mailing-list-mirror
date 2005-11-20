From: Andreas Ericsson <ae@op5.se>
Subject: Re: still unclear on setting up a repository
Date: Sun, 20 Nov 2005 02:07:44 +0100
Message-ID: <437FCC60.3090100@op5.se>
References: <86br0g883v.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 20 02:08:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EddgO-0005oR-IE
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 02:07:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbVKTBHq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 20:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbVKTBHq
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 20:07:46 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:50152 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750937AbVKTBHp
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2005 20:07:45 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 67BA26BD00; Sun, 20 Nov 2005 02:07:44 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <86br0g883v.fsf@blue.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12358>

Randal L. Schwartz wrote:
> And then, another "go-boom" problem:
> 
>     % cg-fetch
>     Hard links don't work - using copy
>     Fetching head...
>     cp: illegal option -- d


I think this was resolved some weeks ago. Perhaps you could try the 
latest cogito from git://git.kernel.org/pub/scm/cogito/cogito.git ?

> 
> Any chance you could make this more POSIX-like?  I know you have a big
> warning in README.osx, but are you *really* needing all those weird
> GNU-isms?  Maybe you could fall back to using rsync to copy exactly
> what you need?
> 

There aren't that many. This particular one was a typo, iirc.

As for rsync; From the output you posted above, you were setting up both 
the repositories on your local machine. Using rsync for those cases 
would be pretty stupid.

On a side-note, could you please turn off your spamvertising auto-reply? 
It sends me some info about your perl-expertise and contact-numbers 
every now and then. It's getting a bit annoying.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
