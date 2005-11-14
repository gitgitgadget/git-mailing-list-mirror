From: Andreas Ericsson <ae@op5.se>
Subject: Re: Simple questions on GIT usage.
Date: Mon, 14 Nov 2005 17:08:39 +0100
Message-ID: <4378B687.3060701@op5.se>
References: <cda58cb80511140746w2f691fb8y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 14 17:12:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ebgsu-0007G5-4Q
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 17:08:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbVKNQIl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 11:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbVKNQIl
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 11:08:41 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:1987 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S1751171AbVKNQIk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Nov 2005 11:08:40 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 9326D6BCBE
	for <git@vger.kernel.org>; Mon, 14 Nov 2005 17:08:39 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
In-Reply-To: <cda58cb80511140746w2f691fb8y@mail.gmail.com>
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11806>

Franck wrote:
> Hi,
> 
> I'd like to know how to delete an entire branch and all it's related
> objects. Is the following correct to accomplish that ?
> 

man git-branch

It will tell you about its -d and -D options.

> 
> And a second question is: how to get the tree ID of the working
> repository ?


I get a feeling there's a higher-level question behind this one, like 
"How can I get a diff between an updated (but not committed) index and 
the files in the working directory?"

When you have a problem it's usually better to just tell people what 
sort of end-result you're hoping to achieve and what steps you've taken 
to accomplish it so far. Asking for details about something that might 
be wrong thinking from the start won't help you but will still require 
much of our time to answer. I.e. nobody gains anything but the work 
still has to be done.

Incidentally, the answer to the quoted question above is (usually)
	git diff-index -p HEAD

Otherwise;
man git (and look in the "IDENTIFIER TERMINOLOGY". I wish I had).

and

for i in /usr/bin/git-*tree*; do man ${i##*/}; done

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
