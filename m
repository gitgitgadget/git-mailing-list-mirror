From: Andreas Ericsson <ae@op5.se>
Subject: Re: Problem using GIT CVS-server
Date: Wed, 03 May 2006 10:44:35 +0200
Message-ID: <44586D73.5060301@op5.se>
References: <445865A5.5030700@lumumba.uhasselt.be> <4458670A.4080205@op5.se> <4458691A.4010007@lumumba.uhasselt.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 10:44:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbCyS-0004pZ-9N
	for gcvg-git@gmane.org; Wed, 03 May 2006 10:44:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbWECIoh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 04:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965129AbWECIoh
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 04:44:37 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:6626 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S964977AbWECIoh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 04:44:37 -0400
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id BA4206BCF8; Wed,  3 May 2006 10:44:35 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Panagiotis Issaris <takis@lumumba.uhasselt.be>
In-Reply-To: <4458691A.4010007@lumumba.uhasselt.be>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19464>

Panagiotis Issaris wrote:
> Hi,
> 
> Andreas Ericsson wrote:
> 
>> [...]
>>
>> Drop -z3 from command-line. git-cvsserver has no compression support.
> 
> 
> Thanks!
> 
> Ahum, painful. That should have been obvious :), but I'm kinda programmed
> to use "-z3 -PAd" whenever I do a cvs update. I didn't even notice the 
> z3 in
> my own typing :->
> 
> 
> Without the z3, it gives the same error/warning as on checkout:
> takis@issaris:/tmp/a/b/project-master$ cvs update -PAd
> takis@localhost's password:
> closing dbh with active statement handles
> takis@issaris:/tmp/a/b/project-master$
> 

That error message comes from your client. I have no idea why, and now 
that I'm a git fanatic I'll stay blissfully ignorant of CVS' internal 
workings. Martyn and Martin (the dynamic duo that wrote the cvsserver 
thingie) might be able to tell you more.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
