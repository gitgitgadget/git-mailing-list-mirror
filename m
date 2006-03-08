From: Andreas Ericsson <ae@op5.se>
Subject: Re: Pulling tags from git.git
Date: Wed, 08 Mar 2006 11:13:08 +0100
Message-ID: <440EAE34.5020807@op5.se>
References: <4dd15d180603061044h3f70d48bk8006c15e605fdca1@mail.gmail.com>	<4dd15d180603061054k36d1a434se7377ded1b3240bb@mail.gmail.com>	<440D5285.3050401@op5.se> <7voe0ilf25.fsf@assigned-by-dhcp.cox.net> <440D7A7D.8070507@op5.se> <440D9AB0.4070305@gmail.com> <440DA82D.3060909@op5.se> <440E5E40.7090700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 08 11:13:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGvfU-0002iU-E8
	for gcvg-git@gmane.org; Wed, 08 Mar 2006 11:13:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWCHKNK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Mar 2006 05:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932553AbWCHKNK
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Mar 2006 05:13:10 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:63173 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932548AbWCHKNJ
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Mar 2006 05:13:09 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 8E4C66BD58; Wed,  8 Mar 2006 11:13:08 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: gitzilla@gmail.com
In-Reply-To: <440E5E40.7090700@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17367>

A Large Angry SCM wrote:
> 
> Why is a "pull" bothering with tags? A "fetch" yes, but not a pull.
> 

A pull is a fetch + merge. I said pull because what little I know of 
Linus' workflow is the the emails he gets from susbsystem maintainers 
are called "pull requests".

>>
>> Tags not meant to be distributed are unannotated, and unannotated tags 
>> are kept out of published repos which are always stored at a central 
>> server. Everybody synchronize to those central repos, so nobody pulls 
>> from each other. Perhaps this is how the kernel devs work too, but if 
>> it ever changes the update hook will no longer be able to safeguard 
>> from it and the, in my eyes, temporary tags will be distributed in a 
>> criss-crossing mesh so no-one will ever know where it came from or who 
>> created it or why. I.e. a Bad Thing.
> 
> 
> The distinction here is not annotated tags or temporary tags but _local_ 
> tags. _Your_ workflow conventions treat unannotated tags as local tags 
> but declaring that unannotated tags can not be pushed is imposing _your_ 
> conventions on other groups. Just as branch names, themselves, can be 
> meaningful, so can tag names.
> 

Yes, that's why I said it's better to discourage than to disallow. The 
default update-hook is disabled by default and there are comments 
aplenty to make it possible even for the most die-hard point-and-click 
monkey to be able to comment out the disallowing of unannotated tags.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
