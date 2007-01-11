From: Andreas Ericsson <ae@op5.se>
Subject: Re: [BUG] OSX ends with "install: git-init.1: No such file or directory"
Date: Thu, 11 Jan 2007 10:57:31 +0100
Message-ID: <45A60A0B.5000001@op5.se>
References: <8664bedsbc.fsf@blue.stonehenge.com> <7vmz4q5abe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Jan 11 10:57:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4wgl-0004PQ-0a
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 10:57:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965336AbXAKJ5e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 04:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965353AbXAKJ5e
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 04:57:34 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:51266 "EHLO
	smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965336AbXAKJ5d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 04:57:33 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id E5D5A6BCBE; Thu, 11 Jan 2007 10:57:31 +0100 (CET)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmz4q5abe.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36571>

Junio C Hamano wrote:
> merlyn@stonehenge.com (Randal L. Schwartz) writes:
> 
>> If I cd into Documentation, and try to make "git-init.1", I get this:
>>
>>     % make git-init.1
>>     asciidoc -b docbook -d manpage -f asciidoc.conf git-init.txt
>>     xmlto -m callouts.xsl man git-init.xml
>>     Note: meta date   : No date. Using generated date       git-init-db
>>     Note: meta source : No productname or alternative       git-init-db
>>     Note: meta source : No refmiscinfo@class=source         git-init-db
>>     Note: meta version: No productnumber or alternative     git-init-db
>>     Note: meta version: No refmiscinfo@class=version        git-init-db
>>     Warn: meta source : No valid fallback. Leaving empty    git-init-db
>>     Note: meta manual : No ancestor with title              git-init-db
>>     Note: meta manual : No refmiscinfo@class=manual         git-init-db
>>     Warn: meta manual : No valid fallback. Leaving empty    git-init-db
>>     Note: Writing git-init-db.1
>>     rm git-init.xml
>>
>> That's not good. Making git-init-db when it wants git-init.
> 
> Not good.  I am _very_ tempted to do this.
> 

Perhaps, but "git init-db" does a lot more than just initialise the 
object database (such as setting default config-variables, installing 
template hooks...). "git init" is actually a more sensible name now adays.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
