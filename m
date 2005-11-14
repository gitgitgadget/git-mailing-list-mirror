From: Andreas Ericsson <ae@op5.se>
Subject: Re: ./configure script prototype
Date: Mon, 14 Nov 2005 20:03:13 +0100
Message-ID: <4378DF71.3060103@op5.se>
References: <43788078.4040403@op5.se> <437880AC.3040101@op5.se> <20051114132956.GT30496@pasky.or.cz> <20051114181958.GD20749@ca-server1.us.oracle.com> <Pine.LNX.4.64.0511141027380.3263@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Nov 14 20:05:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ebjbq-0006CV-BF
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 20:03:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbVKNTDP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 14:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbVKNTDP
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 14:03:15 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:3012 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S1751242AbVKNTDP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Nov 2005 14:03:15 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id E0D336BD01
	for <git@vger.kernel.org>; Mon, 14 Nov 2005 20:03:13 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0511141027380.3263@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11839>

Linus Torvalds wrote:
> 
> On Mon, 14 Nov 2005, Joel Becker wrote:
> 
> 
>>On Mon, Nov 14, 2005 at 02:29:56PM +0100, Petr Baudis wrote:
>>
>>>Dear diary, on Mon, Nov 14, 2005 at 01:18:52PM CET, I got a letter
>>>where Andreas Ericsson <ae@op5.se> said that...
>>>
>>>>		--prefix=*)
>>>>			prefix=${1##*=}
>>
>>	${i# and ${i% are POSIX, iirc.
> 
> 
> They may be in POSIX, but they sure as h*ll aren't portable.
> 

A bit funny really. I've already said I'll change them to some sed 
thing, so the last 16 emails on this thread have been purely academic. I 
guess more people than me are bored by mondays.

> If you want to do a "configure" script (and I'm not sure it's worth it), 

Perhaps not. I was under the impression that Junio was for it to 
simplify the possible move of binaries to GIT_EXEC_PATH.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
