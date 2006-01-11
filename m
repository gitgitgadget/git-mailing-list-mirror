From: Andreas Ericsson <ae@op5.se>
Subject: Re: git binary size...
Date: Wed, 11 Jan 2006 21:00:25 +0100
Message-ID: <43C563D9.9000105@op5.se>
References: <Pine.LNX.4.64.0601111021450.5073@g5.osdl.org> <43C558FB.3030102@op5.se> <43C55EE4.9010103@zytor.com> <43C56278.6090105@op5.se> <43C562F7.1090000@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jan 11 21:01:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ewm8z-0002DU-Il
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 21:00:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbWAKUA1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 15:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbWAKUA1
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 15:00:27 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:20640 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932484AbWAKUA0
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 15:00:26 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 77D246BD03
	for <git@vger.kernel.org>; Wed, 11 Jan 2006 21:00:25 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <43C562F7.1090000@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14509>

H. Peter Anvin wrote:
> Andreas Ericsson wrote:
>>
>> strip:
>>     strip $(STRIP_OPTS) $(PROGRAMS)
>>
>> so Linus can set STRIP_OPTS=--strip-debug and everybody's happy.
>>
> 
> The proper way to do this is:
> 
> strip:
>     $(STRIP) $(STRIP_OPTS) $(PROGRAMS)
> 
> For "strip", this is frequently omitted, though.  Since "strip" is 
> architecture-dependent, though, this is necessary for cross-compilation.
> 

Damn! I almost made it through the entire day without learning anything, 
and now you come along and spoil it all.

Oh well, new game tomorrow. ;)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
