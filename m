From: Andreas Ericsson <ae@op5.se>
Subject: Re: Does git belong in root's $PATH?
Date: Sun, 08 Jan 2006 01:37:41 +0100
Message-ID: <43C05ED5.1090603@op5.se>
References: <Pine.LNX.4.64.0601070838470.6317@x2.ybpnyarg> <43C0025A.9080406@op5.se> <43C02725.2020702@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: walt <wa1ter@myrealbox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 08 01:37:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvOZ8-0007Yd-6k
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 01:37:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161101AbWAHAho (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 19:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161102AbWAHAho
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 19:37:44 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:26754 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1161101AbWAHAhn
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 7 Jan 2006 19:37:43 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 2E2DD6BCBE; Sun,  8 Jan 2006 01:37:42 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43C02725.2020702@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14293>

H. Peter Anvin wrote:
> Andreas Ericsson wrote:
> 
>>
>> Not including /usr/local/{bin,sbin} in root's path is considered wise, 
>> since, historically, that's where users would install their own 
>> versions of programs that the system doesn't provide. This use has 
>> largely been obsoleted by $HOME/bin as the default for user-specific 
>> programs, mainly because of disks getting larger and cheaper.
>>
> 
> Hmmm... I think that was /usr/bin (hence the eventual migration of the 
> meaning of /usr from what was originally the equivalent of /home.)
> 


I've been told that it's '/usr' simply because that's where user 
interface tools that have nothing to do with boot-strapping resides. A 
point emphasized by the fact that /bin, /sbin and /lib must not reside 
on network-mounted media, while /usr may.

It seems so logical I never bothered to look in to find out for myself 
though, so I may well be wrong, or at least younger. ;)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
