From: Andreas Ericsson <ae@op5.se>
Subject: Re: Pulling tags from git.git
Date: Tue, 07 Mar 2006 13:20:13 +0100
Message-ID: <440D7A7D.8070507@op5.se>
References: <4dd15d180603061044h3f70d48bk8006c15e605fdca1@mail.gmail.com>	<4dd15d180603061054k36d1a434se7377ded1b3240bb@mail.gmail.com>	<440D5285.3050401@op5.se> <7voe0ilf25.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 07 13:20:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGbAs-0004ha-VC
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 13:20:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752493AbWCGMUT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 07:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752501AbWCGMUT
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 07:20:19 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:1465 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S1752493AbWCGMUS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Mar 2006 07:20:18 -0500
Received: from [192.168.1.20] (unknown [192.168.1.20])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id DDB836BD01; Tue,  7 Mar 2006 13:20:14 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voe0ilf25.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17333>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
> 
>>With the git or git+ssh protocol, tags will be autofollowed
>>when you do a pull (only signed tags, I think).  The
>>auto-following is done by detecting tags that are fetched,
> 
> 
> Ah, you are correct.  We do not follow lightweight tags; I am
> not sure if we should.
> 

I'm fairly sure we shouldn't. The default update-hook prevents them (if 
enabled), and I can't for the life of me think of why anyone would want 
to distribute such tags.

OTOH, preventing unannotated tags from being pushed seems like a better 
way than to not have the ability to auto-follow those same tags. After 
all, it's better to discourage than to disallow.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
