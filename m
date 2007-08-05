From: Larry Finger <larry.finger@lwfinger.net>
Subject: Re: Problem with bisect
Date: Sun, 05 Aug 2007 14:24:06 -0500
Message-ID: <46B623D6.7070809@lwfinger.net>
References: <46B5F48D.7020907@lwfinger.net> <20070805145234.554bf671.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Sun Aug 05 21:24:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHli1-0001Lb-UA
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 21:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756098AbXHETYK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 15:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754827AbXHETYJ
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 15:24:09 -0400
Received: from mtiwmhc13.worldnet.att.net ([204.127.131.117]:60468 "EHLO
	mtiwmhc13.worldnet.att.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750858AbXHETYI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 15:24:08 -0400
Received: from [192.168.1.104] (cpe-72-129-173-253.kc.res.rr.com[72.129.173.253])
          by worldnet.att.net (mtiwmhc13) with ESMTP
          id <20070805192407113008vaoje>; Sun, 5 Aug 2007 19:24:07 +0000
User-Agent: Thunderbird 1.5.0.12 (X11/20070509)
In-Reply-To: <20070805145234.554bf671.seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55058>

Sean wrote:
> On Sun, 05 Aug 2007 11:02:21 -0500
> Larry Finger <Larry.Finger@lwfinger.net> wrote:
> 
>> I'm helping someone find what looks like a regression in bcm43xx-mac80211 between v2.6.22 and 
>> v2.6.23-rc1. This driver is not in the mainstream kernel, but is found in John Linville's 
>> wireless-dev git tree. When we do the first bisection between the current state and v2.6.22, we 
>> obtain a kernel whose Makefile says it is v2.6.22; however, it's code is based on a state before 
>> bcm43xx-mac80211 was introduced into this tree. My memory isn't what it used to be, but I think this 
>> code was put into this tree during 2.6.19 or .20. When I used visualize to see the tree, the bottom 
>> is all the way to v2.6.16, which I think is the origin of the git process.
>>
>> Is this a git bug, or is it some flaw in this particular tree? We have worked around the problem by 
>> arbitrarily calling each bisection that does not have the bcm43xx-mac80211 code as "good". It has 
>> been a source of confusion for the guy I'm helping as it is his first bisection. Unfortunately, the 
>> bug doesn't show on my machine.
>>

The git repo is git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-dev.git.

The commands were:

git bisect start
git bisect bad
git bisect good v2.6.22

I'm using git version 1.4.4.2.g04509

Larry
