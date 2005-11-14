From: Andreas Ericsson <ae@op5.se>
Subject: Re: ./configure script prototype
Date: Mon, 14 Nov 2005 17:11:58 +0100
Message-ID: <4378B74E.2060208@op5.se>
References: <43788078.4040403@op5.se> <437880AC.3040101@op5.se> <20051114132956.GT30496@pasky.or.cz> <43789FED.7060401@op5.se> <20051114155119.GA23912@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 14 17:15:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ebgw8-0000Yt-36
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 17:12:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbVKNQMA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 11:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbVKNQMA
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 11:12:00 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:6083 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S1751175AbVKNQL7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Nov 2005 11:11:59 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id BE00B6BCBE; Mon, 14 Nov 2005 17:11:58 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Chris Wedgwood <cw@f00f.org>
In-Reply-To: <20051114155119.GA23912@taniwha.stupidest.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11807>

Chris Wedgwood wrote:
> On Mon, Nov 14, 2005 at 03:32:13PM +0100, Andreas Ericsson wrote:
> 
> 
>>Dunno. I only know bash-scripting, really. I'll replace them with
>>some sed thing instead.
> 
> 
> For some people /bin/sh != /bin/bash so you probably want "!/bin/bash"
> instead.

Ach no. The configure script really needs to be portable. POSIX (or SUS 
or some such) define a minimum syntax that any shell must support when 
invoked as /bin/sh.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
