From: Andreas Ericsson <ae@op5.se>
Subject: Re: RFC: Subprojects
Date: Mon, 16 Jan 2006 11:16:35 +0100
Message-ID: <43CB7283.3090003@op5.se>
References: <43C52B1F.8020706@hogyros.de> <Pine.LNX.4.64.0601110928350.5073@g5.osdl.org> <7vacdzkww3.fsf@assigned-by-dhcp.cox.net> <200601161328.04985.lan@ac-sw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 11:16:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyRPr-0005gG-JK
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 11:16:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWAPKQi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 05:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWAPKQi
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 05:16:38 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:963 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S932317AbWAPKQi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jan 2006 05:16:38 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 1EA8D6BCBE; Mon, 16 Jan 2006 11:16:36 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Alexander Litvinov <lan@ac-sw.com>
In-Reply-To: <200601161328.04985.lan@ac-sw.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14736>

Alexander Litvinov wrote:
> On Saturday 14 January 2006 14:59, Junio C Hamano wrote:
> 
>>Now I'll think aloud about a completely different design.
>>
>>We could simply overlay the projects.  I think this is what
>>Johannes suggested earlier.
>>
>>You keep one branch for each "subproject", and make commits into
>>each branch (i.e. if you modified files for the upstream kernel,
>>the change is committed to the branch for linux-2.6 subproject),
>>but when checking things out, you do an equivalent of octopus
>>merge across subprojects.
> 
> If I cleary understand this idea it is NOT that I dreaming about. Almost all 
> our sub-projects are used in more than one project (imaging network layer 
> library). So variant with gitlink is that I willing.


Then it isn't so much a subproject as a separate project of its own. 
Otherwise glibc would be a subproject of pretty much everything and 
that's hardly a sane setup.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
