From: Andreas Ericsson <ae@op5.se>
Subject: Re: [ANNOUCNE] GIT 1.1.0
Date: Tue, 10 Jan 2006 01:22:34 +0100
Message-ID: <43C2FE4A.50203@op5.se>
References: <7v4q4eurgu.fsf@assigned-by-dhcp.cox.net>	<43C2CAED.8030304@cc.jyu.fi> <7vwth9f1nk.fsf@assigned-by-dhcp.cox.net> <43C2F7E2.4090909@cc.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 01:22:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ew7Ha-0002nl-RN
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 01:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWAJAWg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 19:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWAJAWg
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 19:22:36 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:2702 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S1750751AbWAJAWf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jan 2006 19:22:35 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id B64C46BCBE; Tue, 10 Jan 2006 01:22:34 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: lamikr@cc.jyu.fi
In-Reply-To: <43C2F7E2.4090909@cc.jyu.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14392>

lamikr wrote:
>>Ah, sorry, and thanks for catching this.  RPM building procedure
>>is somewhat tricky, and I failed to catch this bug.  Fixed in my
>>tree --- this calls for an early 1.1.1 release I guess.
>>
>>On the other hand, if you are building from the source, what
>>Andreas said applies, and in addition you need to fetch v1.1.0
>>tag before building; otherwise the versioning mechanism would not
>>notice you are building v1.1.0.
>> 
>>
> 
> I was not using git for fetching git sources,
> I have build from the git 1.1.0.tar.bz2.
> 
> Did you mean that things should work after 1.1.1 is released?


Not unless you build from the git-repo, no.

Snapshots will fail to set the "proper" version every time, because the 
GIT-VERSION-FILE: is a forced target and even if git-describe is present 
it will find neither tags nor HEAD.

I have no solution to this, apart from rewriting the Makefile on the fly 
whenever a release tarball is created.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
