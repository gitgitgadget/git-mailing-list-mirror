From: Andreas Ericsson <ae@op5.se>
Subject: Re: [ANNOUNCE] GIT 1.2.1
Date: Sat, 18 Feb 2006 11:39:41 +0100
Message-ID: <43F6F96D.9090209@op5.se>
References: <7vzmkrizuw.fsf@assigned-by-dhcp.cox.net> <20060218043113.GA8976@blinkenlights.visv.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 18 11:39:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAPVC-0000CL-DI
	for gcvg-git@gmane.org; Sat, 18 Feb 2006 11:39:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWBRKjn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Feb 2006 05:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWBRKjn
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Feb 2006 05:39:43 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:43183 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751171AbWBRKjm
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2006 05:39:42 -0500
Received: from [192.168.1.20] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id B8E896BD04; Sat, 18 Feb 2006 11:39:41 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Michael Fischer <michael@visv.net>
In-Reply-To: <20060218043113.GA8976@blinkenlights.visv.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16406>

Michael Fischer wrote:
> *sigh*
> 
> I got confused about git pull origin and git pull master.
> 
> Tutorial seems to tell me I should have said git pull origin
> and left well enough alone. 
> 
> Now I get:
> 
> fatal: you need to resolve your current index first
> 
> How do I do that?
> 

If you just want to clean the index so you can pull from origin again, 
you should be able to just do

	$ git reset --hard origin

If you've got local changes that has caused conflicts in the index you 
need to fix that up first and commit them.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
