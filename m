From: Alan Larkin <nobrow@eircom.net>
Subject: Re: fatal: Out of memory, malloc failed
Date: Mon, 16 Apr 2007 09:11:24 +0100
Message-ID: <46232FAC.4080506@eircom.net>
References: <461FBD02.6050105@eircom.net>	 <Pine.LNX.4.64.0704131143130.28042@woody.linux-foundation.org>	 <462277CD.5020609@eircom.net> <20070415214050.GA4417@steel.home>	 <462329D8.4020302@eircom.net> <81b0412b0704160100y35d0f86csd2196fb2864a7037@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Apr 16 10:11:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdMJ7-0006WJ-By
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 10:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbXDPILP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 04:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbXDPILP
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 04:11:15 -0400
Received: from mail01.svc.cra.dublin.eircom.net ([159.134.118.17]:15993 "HELO
	mail01.svc.cra.dublin.eircom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S964793AbXDPILO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2007 04:11:14 -0400
Received: (qmail 35656 messnum 7065532 invoked from network[86.42.230.88/unknown]); 16 Apr 2007 08:11:12 -0000
Received: from unknown (HELO ?192.168.1.6?) (86.42.230.88)
  by mail01.svc.cra.dublin.eircom.net (qp 35656) with SMTP; 16 Apr 2007 08:11:12 -0000
User-Agent: Thunderbird 1.5.0.10 (X11/20070330)
In-Reply-To: <81b0412b0704160100y35d0f86csd2196fb2864a7037@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44618>

Alex Riesen wrote:
> On 4/16/07, Alan Larkin <nobrow@eircom.net> wrote:
>> > 72Mb is nothing. Is it Windows/cygwin, by any chance? (I see the
>> > problem there sometimes. Tried debugging it, got into some ugly
>> > cygwin-windows interactions, threw up, did the same you did and tried
>> > to forget it all).
>>
>> Thats what I thought, but malloc continued to fail until the 72Mb file
>> was removed.
>>
>> No, my server is running Debian. I had the push problem when logged in
>> on that.
>> It worked when I pushed it from a Gentoo box.
> 
> Ok, now _that_ is interesting... Any limits on that server?
> What git version?  There were some memory leaks fixed recently...
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

Ah, perhaps youre on to something there. The version Im running on the server is 1.4.4.4 (from apt
package manager), but on my own machine (from whence the push was successful) its 1.5.0.5. Still,
youd expect the problem to have effected more people if its a leak or something in the older version.
