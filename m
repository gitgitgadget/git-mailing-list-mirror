From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC 2/2] Automatically transform .git/{branches,remotes} into
 .git/config
Date: Mon, 28 Nov 2005 09:43:26 +0100
Message-ID: <438AC32E.5010100@op5.se>
References: <Pine.LNX.4.63.0511211455120.13775@wbgn013.biozentrum.uni-wuerzburg.de>	<20051127125945.GD22159@pasky.or.cz>	<Pine.LNX.4.63.0511280248020.12343@wbgn013.biozentrum.uni-wuerzburg.de> <7vfyph1ebq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Nov 28 09:45:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Egebk-0007Pp-Mw
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 09:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbVK1In3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 03:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbVK1In2
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 03:43:28 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:5288 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S1751253AbVK1In2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2005 03:43:28 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id E57D66BCBE
	for <git@vger.kernel.org>; Mon, 28 Nov 2005 09:43:26 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <7vfyph1ebq.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12860>

Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> 
>>I only realized that we -- in the good tradition of UNIX -- have many 
>>different formats for different configurations: Some configurations are in 
>>.gitignore, some are in .git/branches/, some in .git/remotes/, some in 
>>.git/config, and even some in environment variables!
> 
> 
> Can you live with something like this?
> 
>  - we will add new ones to config, now we have it;
> 

I'd still like to see git-repo-config and git-user-config. Otherwise 
we'll need to continue having user-based environment variables 
(GIT_COMMITTER_IDENT and friends).

> 
>  - we would revisit deprecating things outside config file
>    sometime later after 1.0 stabilizes, and that's when we will
>    talk about moving these things into config.
> 

GIT_DIR and GIT_OBJECT_DIR must remain environment variables (or command 
line arguments) more or less indefinitely. It doesn't make sense to keep 
them any other way.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
