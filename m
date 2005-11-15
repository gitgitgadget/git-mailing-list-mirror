From: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Subject: Re: fix git-pack-redundant crashing sometimes
Date: Tue, 15 Nov 2005 22:41:34 +0100
Message-ID: <437A560E.8020500@etek.chalmers.se>
References: <81b0412b0511150749g5672158v7b39c02ffdf13e08@mail.gmail.com> <20051115213442.GA4256@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Nov 15 22:43:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec8YD-0007iP-5I
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 22:41:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbVKOVlK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 16:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbVKOVlK
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 16:41:10 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:40069 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1751048AbVKOVlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 16:41:09 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout1-sn1.fre.skanova.net (7.2.060.1)
        id 4378F0CA0006548F; Tue, 15 Nov 2005 22:41:06 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
In-Reply-To: <20051115213442.GA4256@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11947>

Alex Riesen wrote:
> Alex Riesen, Tue, Nov 15, 2005 16:49:30 +0100:
> 
>>llist_sorted_difference_inplace didn't handle the match in the first
>>sha1 correctly and the lists went wild everywhere.
> 
> 
> This wasn't enough. It never (>5 min on 2.4GHz PIV) finishes on
> my local mirror of git, which has 22 packs by now.
> 

If the patch I just sent out doesn't fix the problem, and you don't
want to debug it yourself, could you please publish the .idx files
so I could have a look at them?
