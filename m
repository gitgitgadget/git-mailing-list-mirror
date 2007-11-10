From: Sven Herzberg <sven@imendio.com>
Subject: Re: git submodules and diffing
Date: Sat, 10 Nov 2007 01:46:00 +0100
Message-ID: <C3A79C8B-2953-4A9F-B0BE-78CEA375393B@imendio.com>
References: <4D079E0B-D6FB-4FBA-B449-2EFBFD5A5DE4@imendio.com> <1194649057-19676-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 01:46:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqeU7-0007YX-Sd
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 01:46:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540AbXKJApt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 19:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752737AbXKJApt
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 19:45:49 -0500
Received: from holken.mikan.net ([88.131.94.251]:37834 "EHLO holken.mikan.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752345AbXKJAps (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 19:45:48 -0500
Received: from localhost (localhost [127.0.0.1])
	by holken.mikan.net (Postfix) with ESMTP id 7EB961458F;
	Sat, 10 Nov 2007 01:45:46 +0100 (CET)
Received: from holken.mikan.net ([127.0.0.1])
	by localhost (holken.mikan.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 17976-03; Sat, 10 Nov 2007 01:45:43 +0100 (CET)
Received: from [192.168.2.108] (p548FC53A.dip.t-dialin.net [84.143.197.58])
	by holken.mikan.net (Postfix) with ESMTP id 3BE8912C08;
	Sat, 10 Nov 2007 01:45:42 +0100 (CET)
In-Reply-To: <1194649057-19676-1-git-send-email-jnareb@gmail.com>
X-Mailer: Apple Mail (2.752.3)
X-Virus-Scanned: Debian amavisd-new at holken.mikan.net
X-Spam-Status: No, score=-97.613 tagged_above=-999 required=4
	tests=[AWL=0.299, RCVD_IN_SORBS_DUL=2.088, USER_IN_WHITELIST=-100]
X-Spam-Score: -97.613
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64288>

Hey Jakub,

Am 09.11.2007 um 23:57 schrieb Jakub Narebski:

> Sven Herzberg wrote:
>
>> When I started working with git submodules, I realized that git-diff
>> only lists the revision ids of a submodule if it has changed. I have
>> created a repository which includes a diff command for git-submodule,
>> so you can use it like "gut submodule diff <modules...>"
>>
>> I pushed my git tree at git://git.imendio.com/sven/git.git

>   http://git.imendio.com/?p=sven/git.git
>
>> Feel free to look into the changes and request improvements or merge
>> it into your tree.
>
> Although having "git submodule diff" is quite nice, I'd rather have
> "git diff --recurse-submodules" (or something like that) if I want to
> get diff of submodules.

I think it's pretty nice if git-submodule is the only command that  
knows about submodules.

> From browsing commitdiff
>   http://git.imendio.com/?p=sven/ 
> git.git;a=commitdiff;h=7fa1d4911d1ac2590ab1eccd84a7f235aca7878e
> I'd like to mention that instead of
>
>   (unset GIT_DIR && cd "$path" && git diff $flag "$sha1..HEAD")
>
> you can simply use
>
>   git --git-dir="$path" diff $flag "$sha1..HEAD"

It wasn't exactly that simple (I has to add `pwd` and "/.git") but  
thats for the hint. See the updated version in my repository.

>> PS: Please CC me, I'm not on this list
>
> You can always read list using NNTP / news / Usenet interface at
>   nntp://news.gmane.org/gmane.comp.version-control.git
> or one of the mailing list archives, see
>   http://git.or.cz/gitwiki/GitCommunity

I know, but being CCed is a simple task and makes it even easier for  
me to contribute in irregular intervals.

Thank you,
   Sven
