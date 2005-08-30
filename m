From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Bisection visualization hint..
Date: Tue, 30 Aug 2005 14:03:37 -0400
Message-ID: <43149F79.4020809@gmail.com>
References: <Pine.LNX.4.58.0508301026450.4293@g5.osdl.org> <7vhdd7joz6.fsf@assigned-by-dhcp.cox.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 30 20:09:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EAASV-0007L5-Ar
	for gcvg-git@gmane.org; Tue, 30 Aug 2005 20:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbVH3SDl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Aug 2005 14:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbVH3SDk
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Aug 2005 14:03:40 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:43758 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932245AbVH3SDk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Aug 2005 14:03:40 -0400
Received: by wproxy.gmail.com with SMTP id i2so1096202wra
        for <git@vger.kernel.org>; Tue, 30 Aug 2005 11:03:39 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=W9dGQUwUETiBeImraLoLZ04qKYdOl8OCJRQ2K7qg4kyuJFJX8wJgTtw7klHo2Uo0i9NJj320tz7LLtiKVxCEbw3dFIx56VxXnsx7KQuKtD3VlGsa0w8vEXu0uvRvb4ehoI79P39zyZv0JO5Rxhso5wR7pDoBHLV6l48OdiFb8Ow=
Received: by 10.54.130.13 with SMTP id c13mr42920wrd;
        Tue, 30 Aug 2005 11:03:39 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.89.97.97])
        by mx.gmail.com with ESMTP id 13sm11487272wrl.2005.08.30.11.03.38;
        Tue, 30 Aug 2005 11:03:39 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhdd7joz6.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7958>

Junio C Hamano wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
>>I'm testing bisection to find a bug that causes my G5 to no longer boot, 
>>and during the process have found this command line very nice:
>>
>>	gitk bisect/bad --not $(cd .git/refs ; ls bisect/good-*)
>>
>>it basically shows the state of bisection with the known bad commit as the 
>>top, and cutting off all the good commits - so what you see are the 
>>potential buggy commits.
> 
>>But it's not the nicest of command lines and depends on knowing how
>>bisection works, so maybe we could make
>>
>>	git bisect visualize
>>
>>do this for us?
> 
> Will do.
> 
> Another thing that might make sense is roll it also into gitk, a
> new command from "File" menu to cause it to re-read not just ref
> values but the rev-list itself out of that particular rev-list
> command (and add any other common patterns as we discover them).

Unless gitk will always be part of git, this is better off as a gitk 
feature or gitk helper script. IE. it belongs in the gitk namespace, not 
the git namespace.

That said, a wrapper for "git show-branch" (git show-bisect?) would be 
nice also.
