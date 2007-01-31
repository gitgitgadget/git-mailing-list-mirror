From: "Mark Levedahl" <fastestspinner@hotmail.com>
Subject: Re: [PATCH] Make gitk work reasonably well on Cygwin.
Date: Wed, 31 Jan 2007 16:39:45 +0000
Message-ID: <BAY13-F4E31B150239BDBBE1AC18D0A50@phx.gbl>
References: <81b0412b0701310836q4222c82arcfda05d3594182af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Cc: git@vger.kernel.org
To: raa.lkml@gmail.com
X-From: git-owner@vger.kernel.org Wed Jan 31 17:41:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCIUz-0000EI-P8
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 17:39:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbXAaQju (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 11:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030256AbXAaQju
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 11:39:50 -0500
Received: from bay0-omc3-s4.bay0.hotmail.com ([65.54.246.204]:5024 "EHLO
	bay0-omc3-s4.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030255AbXAaQju (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Jan 2007 11:39:50 -0500
Received: from hotmail.com ([64.4.31.4]) by bay0-omc3-s4.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.2668);
	 Wed, 31 Jan 2007 08:39:49 -0800
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Wed, 31 Jan 2007 08:39:49 -0800
Received: from 12.109.151.100 by by13fd.bay13.hotmail.msn.com with HTTP;
	Wed, 31 Jan 2007 16:39:45 GMT
X-Originating-IP: [12.109.151.100]
X-Originating-Email: [fastestspinner@hotmail.com]
X-Sender: fastestspinner@hotmail.com
In-Reply-To: <81b0412b0701310836q4222c82arcfda05d3594182af@mail.gmail.com>
X-OriginalArrivalTime: 31 Jan 2007 16:39:49.0434 (UTC) FILETIME=[6C91B1A0:01C74556]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38274>

I will resend tonight when I get access to an account where I can control 
the mailer.


>From: "Alex Riesen" <raa.lkml@gmail.com>
>To: "Mike Nefari" <fastestspinner@hotmail.com>
>CC: git@vger.kernel.org
>Subject: Re: [PATCH] Make gitk work reasonably well on Cygwin.
>Date: Wed, 31 Jan 2007 17:36:16 +0100
>
>On 1/31/07, Mike Nefari <fastestspinner@hotmail.com> wrote:
>>The gitk gui layout was completely broken on Cygwin. If gitk was started
>>without previous geometry in ~/.gitk, the user could drag the window 
>>sashes
>>to get a useable layout. However, if ~/.gitk existed, this was not 
>>possible
>>at all.
>>
>>The fix was to rewrite makewindow, changing the toplevel containers and
>>the particular geometry information saved between sessions. Numerous bugs
>>in both the Cygwin and the Linux Tk versions make this a delicate
>>balancing act: the version here works in both but many subtle variants
>>are competely broken in one or the other environment.
>>
>
>The patch is broken very spectacularly. How have you made it?
>Copy-paste in the browsers window?

_________________________________________________________________
Get live scores and news about your team: Add the Live.com Football Page  
http://www.live.com/?addtemplate=football
