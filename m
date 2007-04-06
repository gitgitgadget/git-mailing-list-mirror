From: David Lang <david.lang@digitalinsight.com>
Subject: Re: git-index-pack really does suck..
Date: Fri, 6 Apr 2007 14:56:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0704061455380.24050@qynat.qvtvafvgr.pbz>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org> 
 <Pine.LNX.4.64.0704031413200.6730@woody.linux-foundation.org> 
 <alpine.LFD.0.98.0704031836350.28181@xanadu.home> 
 <Pine.LNX.4.63.0704031532390.21680@qynat.qvtvafvgr.pbz>
 <81b0412b0704040251j34b0bc5eh1518eadcfa2ed299@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Chris Lee <clee@kde.org>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 07 01:55:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZwtt-0003pX-KR
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 00:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933127AbXDFW1T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 18:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933114AbXDFW1S
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 18:27:18 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:51274 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S933127AbXDFW1R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 18:27:17 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Fri, 6 Apr 2007 15:27:17 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Fri, 06 Apr 2007 15:25:59 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <81b0412b0704040251j34b0bc5eh1518eadcfa2ed299@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43935>

On Wed, 4 Apr 2007, Alex Riesen wrote:

> On 4/4/07, David Lang <david.lang@digitalinsight.com> wrote:
>> 
>> > The keeping of fetched packs broke that presumption of trust towards
>> > local objects and it opened a real path for potential future attacks.
>> > Those attacks are still fairly theoretical of course.  But for how
>> > _long_?  Do we want GIT to be considered backdoor prone in a couple
>> > years from now just because we were obsessed by a 7% CPU overhead?
>> >
>> > I think we have much more to gain by playing it safe and being more
>> > secure and paranoid than trying to squeeze some CPU cycles out of an
>> > operation that is likely to ever be bounded by network speed for most
>> > people.
>> 
>> this is why -paranoid should be left on for network pulls, but having it on 
>> for
>> the local uses means that the cost isn't hidden in the network limits isn't
>> good.
>
> You never know what pull is networked (or should I say: remote enough
> to cause a collision).

so leave it on for all pulls, but for other commands don't turn it on.

remember that the command that linus ran into at the start of the thread wasn't 
a pull.

David Lang
