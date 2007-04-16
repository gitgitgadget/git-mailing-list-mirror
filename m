From: Alan Larkin <nobrow@eircom.net>
Subject: Re: fatal: Out of memory, malloc failed
Date: Mon, 16 Apr 2007 09:02:56 +0100
Message-ID: <46232DB0.3010303@eircom.net>
References: <461FBD02.6050105@eircom.net> <Pine.LNX.4.64.0704131143130.28042@woody.linux-foundation.org> <462277CD.5020609@eircom.net> <20070415214050.GA4417@steel.home> <462329D8.4020302@eircom.net> <Pine.LNX.4.64.0704160853050.7680@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 16 10:03:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdMB1-000354-6d
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 10:03:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbXDPIC6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 04:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbXDPICz
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 04:02:55 -0400
Received: from mail05.svc.cra.dublin.eircom.net ([159.134.118.21]:8247 "HELO
	mail05.svc.cra.dublin.eircom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S964959AbXDPICq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2007 04:02:46 -0400
Received: (qmail 41549 messnum 3332698 invoked from network[86.42.230.88/unknown]); 16 Apr 2007 08:02:45 -0000
Received: from unknown (HELO ?192.168.1.6?) (86.42.230.88)
  by mail05.svc.cra.dublin.eircom.net (qp 41549) with SMTP; 16 Apr 2007 08:02:45 -0000
User-Agent: Thunderbird 1.5.0.10 (X11/20070330)
In-Reply-To: <Pine.LNX.4.64.0704160853050.7680@beast.quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44616>

Julian Phillips wrote:
> On Mon, 16 Apr 2007, Alan Larkin wrote:
> 
>> Alex Riesen wrote:
>>> Alan Larkin, Sun, Apr 15, 2007 21:06:53 +0200:
>>>>>> Its not a huge push Im trying to do here (<about 150Mb) but
>>>>>> always malloc fails!
>>>>> Any huge objects?
>>>>>
>>>> There were a couple of big files. I removed a 72Mb one (making 47Mb
>>>> the biggest one left in the project) and made the push and it
>>>> worked. I later pulled the project down to a different machine,
>>>> added the 72Mb file back in, and pushed to the server and it worked.
>>>> So apparently it's a platform specific problem. If anybody's
>>>> particularly interested I could replicate it under gdb and pass on
>>>> any info, but if not I wont ... job's done, Im happy.
>>>
>>> 72Mb is nothing. Is it Windows/cygwin, by any chance? (I see the
>>> problem there sometimes. Tried debugging it, got into some ugly
>>> cygwin-windows interactions, threw up, did the same you did and tried
>>> to forget it all).
>>>
>>> -
>>> To unsubscribe from this list: send the line "unsubscribe git" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>
>> Thats what I thought, but malloc continued to fail until the 72Mb file
>> was removed.
>>
>> No, my server is running Debian. I had the push problem when logged in
>> on that. It worked when I
>> pushed it from a Gentoo box.
> 
> a problem with ulimit -m on the server?
> 

Unlimited ...
