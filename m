From: Andreas Ericsson <ae@op5.se>
Subject: Re: Pulling tags from git.git
Date: Tue, 07 Mar 2006 10:29:41 +0100
Message-ID: <440D5285.3050401@op5.se>
References: <4dd15d180603061044h3f70d48bk8006c15e605fdca1@mail.gmail.com> <4dd15d180603061054k36d1a434se7377ded1b3240bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 07 10:30:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGYVv-00084Q-Br
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 10:29:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109AbWCGJ3n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 04:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752125AbWCGJ3n
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 04:29:43 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:38838 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1752109AbWCGJ3m
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Mar 2006 04:29:42 -0500
Received: from [192.168.1.20] (unknown [192.168.1.20])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id CF4666BD01; Tue,  7 Mar 2006 10:29:41 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: David Ho <davidkwho@gmail.com>
In-Reply-To: <4dd15d180603061054k36d1a434se7377ded1b3240bb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17327>

David Ho wrote:
> Okay sorry, git fetch --tags did the trick.
> 
> Just out of curiosity, should git pull --tags behave similarly since
> the difference is git pull does a merge after a fetch?
> 

With the git or git+ssh protocol, tags will be autofollowed when you do 
a pull (only signed tags, I think). The auto-following is done by 
detecting tags that are fetched, so when you did a pull using rsync the 
tags weren't auto-followed but you got all the commits. Next, when you 
changed protocol to git:// you already had all the commit objects, so 
there was nothing to auto-detect tags on. Since you're using git:// now 
it should work as advertised in the future though.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
