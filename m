From: Andreas Ericsson <ae@op5.se>
Subject: Re: git cole give unexpected error message
Date: Wed, 14 Dec 2005 10:36:45 +0100
Message-ID: <439FE7AD.6080602@op5.se>
References: <20051213212820.GB5232@mars.ravnborg.org> <20051213222829.GE22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Dec 14 10:43:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmT49-0007ka-7V
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 10:36:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbVLNJgq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 04:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbVLNJgq
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 04:36:46 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:42155 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932250AbVLNJgq
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2005 04:36:46 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 508536BD08
	for <git@vger.kernel.org>; Wed, 14 Dec 2005 10:36:45 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <20051213222829.GE22159@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13624>

Petr Baudis wrote:
> Dear diary, on Tue, Dec 13, 2005 at 10:28:20PM CET, I got a letter
> where Sam Ravnborg <sam@ravnborg.org> said that...
> 
>>cogito being a nice porcelain gives the git errormessage but manage to
>>clean up when the clone fails.
>>So also cogito would benefit from a more descriptive errormessage.
> 
> 
> Well, git clone can fail for many reasons and I don't think the "no such
> repository" one is completely overwhelming, so hinting that by Cogito
> could be quite confusing (theme of the day: usability ;-)).
> 
> The real solution would be proper error reporting by the git daemon.
> 

But that would open up for an information disclosure. If someone's 
hacking on a patch, please make it configurable at least.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
