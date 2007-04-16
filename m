From: Alan Larkin <nobrow@eircom.net>
Subject: Re: fatal: Out of memory, malloc failed
Date: Mon, 16 Apr 2007 08:46:32 +0100
Message-ID: <462329D8.4020302@eircom.net>
References: <461FBD02.6050105@eircom.net> <Pine.LNX.4.64.0704131143130.28042@woody.linux-foundation.org> <462277CD.5020609@eircom.net> <20070415214050.GA4417@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 16 09:46:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdLuu-0004wL-3s
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 09:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbXDPHqX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 03:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbXDPHqX
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 03:46:23 -0400
Received: from mail16.svc.cra.dublin.eircom.net ([159.134.118.215]:24730 "HELO
	mail16.svc.cra.dublin.eircom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932382AbXDPHqX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2007 03:46:23 -0400
Received: (qmail 30629 messnum 3618224 invoked from network[86.42.230.88/unknown]); 16 Apr 2007 07:46:20 -0000
Received: from unknown (HELO ?192.168.1.6?) (86.42.230.88)
  by mail16.svc.cra.dublin.eircom.net (qp 30629) with SMTP; 16 Apr 2007 07:46:20 -0000
User-Agent: Thunderbird 1.5.0.10 (X11/20070330)
In-Reply-To: <20070415214050.GA4417@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44605>

Alex Riesen wrote:
> Alan Larkin, Sun, Apr 15, 2007 21:06:53 +0200:
>>>> Its not a huge push Im trying to do here (<about 150Mb) but
>>>> always malloc fails!
>>> Any huge objects?
>>>
>> There were a couple of big files. I removed a 72Mb one (making 47Mb
>> the biggest one left in the project) and made the push and it
>> worked. I later pulled the project down to a different machine,
>> added the 72Mb file back in, and pushed to the server and it worked.
>> So apparently it's a platform specific problem. If anybody's
>> particularly interested I could replicate it under gdb and pass on
>> any info, but if not I wont ... job's done, Im happy.
> 
> 72Mb is nothing. Is it Windows/cygwin, by any chance? (I see the
> problem there sometimes. Tried debugging it, got into some ugly
> cygwin-windows interactions, threw up, did the same you did and tried
> to forget it all).
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

Thats what I thought, but malloc continued to fail until the 72Mb file was removed.

No, my server is running Debian. I had the push problem when logged in on that. It worked when I
pushed it from a Gentoo box.
