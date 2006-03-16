From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Invoke git-repo-config directly.
Date: Thu, 16 Mar 2006 15:39:53 +0100
Message-ID: <441978B9.6090301@op5.se>
References: <20060314211022.GA12498@localhost.localdomain>	<Pine.LNX.4.64.0603141351470.3618@g5.osdl.org>	<20060314224027.GB14733@localhost.localdomain>	<Pine.LNX.4.64.0603141506130.3618@g5.osdl.org>	<7vek13ieap.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0603151450070.3618@g5.osdl.org>	<7vlkvbffhz.fsf@assigned-by-dhcp.cox.net>	<20060316075324.GA19650@pfit.vm.bytemark.co.uk>	<7v64mebxsu.fsf@assigned-by-dhcp.cox.net>	<slrne1inu0.fr9.mdw@metalzone.distorted.org.uk> <20060316162709.6f383f95.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 16 15:40:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJtdu-00018j-1V
	for gcvg-git@gmane.org; Thu, 16 Mar 2006 15:39:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWCPOjz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Mar 2006 09:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWCPOjz
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Mar 2006 09:39:55 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:26845 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751088AbWCPOjz
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Mar 2006 09:39:55 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id B87BC6BD21; Thu, 16 Mar 2006 15:39:53 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20060316162709.6f383f95.tihirvon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17637>

Timo Hirvonen wrote:
> On Thu, 16 Mar 2006 12:53:20 +0000 (UTC)
> Mark Wooding <mdw@distorted.org.uk> wrote:
> 
> 
>>By the way, am I the only person who /likes/ having all the git-*
>>programs on his path?  It makes shell completion work fairly well
>>without having to install strange completion scripts which get out of
>>date for one thing.
> 
> 
> I like git-* for the same reason.  But if git potty had aliases for long
> commands then git-* commands would become irrelevant.  Especially
> "git co" would be nice.  It even would be faster to type than
> git-ch<tab>c<tab>o<tab> ;)
> 

It would indeed, and it should also be fairly trivial. However, adding 
short-hands that are identical with cvs and svn but does a totally 
different thing (well, not really different, but cvs users will be 
surprised) is not necessarily a good thing.

It would be better, imo, to add ambiguity detection for commands that 
lacks an exact match. That way "git br" and "git branch" would be 
identical and the logic only needs doing once. I'm not terribly excited 
about it though, so...

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
