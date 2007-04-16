From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: fatal: Out of memory, malloc failed
Date: Mon, 16 Apr 2007 08:54:04 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704160853050.7680@beast.quantumfyre.co.uk>
References: <461FBD02.6050105@eircom.net> <Pine.LNX.4.64.0704131143130.28042@woody.linux-foundation.org>
 <462277CD.5020609@eircom.net> <20070415214050.GA4417@steel.home>
 <462329D8.4020302@eircom.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Alan Larkin <nobrow@eircom.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 09:54:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdM2O-0007zg-7d
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 09:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbXDPHyJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 03:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbXDPHyJ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 03:54:09 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:58786 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932478AbXDPHyH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2007 03:54:07 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 21239C62A1
	for <git@vger.kernel.org>; Mon, 16 Apr 2007 08:54:06 +0100 (BST)
Received: (qmail 11431 invoked by uid 103); 16 Apr 2007 08:53:27 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3087. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.041306 secs); 16 Apr 2007 07:53:27 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 16 Apr 2007 08:53:27 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <462329D8.4020302@eircom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44610>

On Mon, 16 Apr 2007, Alan Larkin wrote:

> Alex Riesen wrote:
>> Alan Larkin, Sun, Apr 15, 2007 21:06:53 +0200:
>>>>> Its not a huge push Im trying to do here (<about 150Mb) but
>>>>> always malloc fails!
>>>> Any huge objects?
>>>>
>>> There were a couple of big files. I removed a 72Mb one (making 47Mb
>>> the biggest one left in the project) and made the push and it
>>> worked. I later pulled the project down to a different machine,
>>> added the 72Mb file back in, and pushed to the server and it worked.
>>> So apparently it's a platform specific problem. If anybody's
>>> particularly interested I could replicate it under gdb and pass on
>>> any info, but if not I wont ... job's done, Im happy.
>>
>> 72Mb is nothing. Is it Windows/cygwin, by any chance? (I see the
>> problem there sometimes. Tried debugging it, got into some ugly
>> cygwin-windows interactions, threw up, did the same you did and tried
>> to forget it all).
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>
> Thats what I thought, but malloc continued to fail until the 72Mb file was removed.
>
> No, my server is running Debian. I had the push problem when logged in on that. It worked when I
> pushed it from a Gentoo box.

a problem with ulimit -m on the server?

-- 
Julian

  ---
No skis take rocks like rental skis!
