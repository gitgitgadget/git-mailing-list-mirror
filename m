From: Andreas Ericsson <ae@op5.se>
Subject: Re: [ANNOUNCE] GIT 0.99.9g
Date: Thu, 10 Nov 2005 21:30:58 +0100
Message-ID: <4373AE02.9050909@op5.se>
References: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net> <20051110185423.GA7212@blackbean.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Nov 10 21:32:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaJ4g-0001DV-Gd
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 21:31:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbVKJUbD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 15:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbVKJUbC
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 15:31:02 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:60576 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932070AbVKJUbA
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 15:31:00 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 2741D6BCFF
	for <git@vger.kernel.org>; Thu, 10 Nov 2005 21:30:59 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <20051110185423.GA7212@blackbean.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11520>

Jim Radford wrote:
> On Thu, Nov 10, 2005 at 12:14:29AM -0800, Junio C Hamano wrote:
> 
>>   I think archimport part needs to be split out just like its
>>   svn/cvs cousins,
> 
> 
> I don't agree.  The chance of running git-archimport and not having
> arch installed is significantly less likely than the chance of not
> noticing that the git-archimport program exists because it was moved
> into a separate package that you didn't know you needed to install in
> the first place.
> 

How is this different for when svnimport and cvsimport was moved out? I 
don't think anyone expected people to run those commands by accident 
without noticing that they fail without the svn || cvs installed underneath.

> The main reason I see for splitting cvs and email import out is the
> non-standard dependencies, cvsps and perl(Email::Valid).


Define "non-standard". String::ShellQuote isn't installed by default on 
Fedora Core 3 but is required by git-archimport.


>  While for
> svn import it's to keep from requiring subversion-perl of everone who
> installs git-core.  This dependency is added automatically, so you
> cannot easily just ignore it like you can in the arch/tla case.
> 

It's fairly simple to provide a custom find-requires script.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
