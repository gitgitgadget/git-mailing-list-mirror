From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 1/5] Library code for user-relative paths, take three.
Date: Fri, 18 Nov 2005 11:08:40 +0100
Message-ID: <437DA828.6020207@op5.se>
References: <20051117193714.2B8995BF93@nox.op5.se> <7v8xvmsu9o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 11:10:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ed3Ap-0007Aw-8S
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 11:08:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030608AbVKRKIm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 05:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030609AbVKRKIm
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 05:08:42 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:10973 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1030608AbVKRKIl
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 05:08:41 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 8AF5E6BD14; Fri, 18 Nov 2005 11:08:40 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xvmsu9o.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12218>

Junio C Hamano wrote:
> 
>>+	/* This is perfectly safe, and people tend to think of the directory
>>+	 * where they ran git-init-db as their repository, so humour them. */
>>+	(void)chdir(".git");
> 
> 
> It might be safe, but I think it changes the behaviour of
> upload-pack with strict case.  My gut reaction is we would want
> "if (!strict)" in front.  Thoughts?
> 

As it says in the comment; People tend to think of the directory where 
they ran "git init-db" as their repository, so humour them. It's nice 
for sharing files between devs in the office, and it *is* safe. Do as 
you please though. It's the generality of the

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
