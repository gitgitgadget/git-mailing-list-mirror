From: Andreas Ericsson <ae@op5.se>
Subject: Re: merging initial part of a branch?
Date: Thu, 12 Jan 2006 01:59:32 +0100
Message-ID: <43C5A9F4.1040604@op5.se>
References: <20060111230451.GH8618@fieldses.org>	<7vek3epbs9.fsf@assigned-by-dhcp.cox.net> <43C59FB6.20803@op5.se> <7vu0cai98f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Thu Jan 12 01:59:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwqoV-0000gE-IK
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 01:59:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbWALA7e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 19:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbWALA7e
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 19:59:34 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:36770 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S964878AbWALA7d
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 19:59:33 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id AF06B6BD03; Thu, 12 Jan 2006 01:59:32 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0cai98f.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14540>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
> 
>>Junio C Hamano wrote:
>>
>>
>>>I haven't tried this for some time, but I presume
>>>	$ git pull linus tag v2.6.15
>>>would do what you want.
>>
>>If it doesn't you might be able to do
>>
>>$ git format-patch -m -k v2.6.14..v2.6.15 --stdout > mega-mbox-patch
>>$ git checkout our-own-branch
>>$ git am -3 -k mega-mbox-patch
>>
>>That'll take some time though, so be sure to have a six-pack or two handy.
> 
> 
> I do not think that should be done.  You will create an
> alternate history that way, not the true v2.6.15 history.
> 

I took their request to mean that they already have patches of their own 
in that, so they'll never have v2.6.15 vanilla history anyway.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
