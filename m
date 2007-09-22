From: Michal Vitecek <fuf@mageo.cz>
Subject: Re: [PATCH] Use "" instead of "<unknown>" for placeholders
Date: Sat, 22 Sep 2007 10:53:41 +0200
Message-ID: <46F4D815.5050602@mageo.cz>
References: <20070921101420.GD22869@mageo.cz>	<Pine.LNX.4.64.0709211146090.28395@racer.site>	<20070921110646.GA9072@mageo.cz>	<Pine.LNX.4.64.0709211207070.28395@racer.site>	<20070921140500.GB9072@mageo.cz> <7vk5qjixqy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 22 10:53:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZ0kM-00079x-DO
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 10:53:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbXIVIxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2007 04:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbXIVIxt
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Sep 2007 04:53:49 -0400
Received: from interactive-1.com ([193.85.232.82]:53463 "EHLO
	interactive-1.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783AbXIVIxs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2007 04:53:48 -0400
Received: from interactive-1.com (localhost.localdomain [127.0.0.1])
	by interactive-1.com (Postfix) with ESMTP id A004F23B30F;
	Sat, 22 Sep 2007 10:53:43 +0200 (CEST)
Received: from [127.0.0.1] (unknown [217.11.253.238])
	by interactive-1.com (Postfix) with ESMTP id 824AC23B2BB;
	Sat, 22 Sep 2007 10:53:43 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vk5qjixqy.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58927>

Junio C Hamano wrote:
>>>>>> I made it because I want to use my own pretty format which currently 
>>>>>> only allows '%s' for subject and '%b' for body. But '%b' is 
>>>>>> substituted with <undefined> if the body is "missing" which I 
>>>>>> obviously don't like :)
>>>>> Then you should fix %b not to show "<undefined>".
>>>>  I'll do it if it is okay. Shall I do the same for the other
>>>>  placeholders as well?
>>> Yeah.  Don't know why I did it that way.
>>  Here comes the big patch :)
> 
> Now, this breaks t6006 which needs this patch.

Oops - I'm sorry about that. I ran the test suite (1.5.3.1) but it 
failed in 2 tests before the patch and in 2 tests after it so I 
considered it okay.

> Looking at this patch, I am not sure if your change is really a
> desirable one --- shouldn't it be removing the line itself, not
> just <unknown> token?

This sounds as the best solution. I'll look into it. Thanks for your time.

-- 
		fuf					(fuf@mageo.cz)
