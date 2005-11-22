From: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Subject: Re: [PATCH] speedup allocation in pack-redundant.c
Date: Wed, 23 Nov 2005 00:14:53 +0100
Message-ID: <4383A66D.2030201@etek.chalmers.se>
References: <81b0412b0511220656l528436b1xea80ee18965e4dda@mail.gmail.com> <7vek58ct4b.fsf@assigned-by-dhcp.cox.net> <20051122230011.GA2916@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Nov 23 00:18:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EehLE-0002Ey-IJ
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 00:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030184AbVKVXOV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 18:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbVKVXOV
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 18:14:21 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:48564 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1030184AbVKVXOU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 18:14:20 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout2-sn1.fre.skanova.net (7.2.069.1)
        id 438346970001A7C1; Wed, 23 Nov 2005 00:14:18 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20051122230011.GA2916@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12584>

Alex Riesen wrote:
> Junio C Hamano, Tue, Nov 22, 2005 21:41:56 +0100:
>>I think making allocation/deallocation to the central place is a
>>good cleanup, but I am not sure about the free-nodes reusing.
>>Does this make difference in real life?
> 
> 
> It definitely does, though nor very much. I have no real numbers at
> hand (being home now), but I remember it was 1 min with against 3 min
> without the patch on cygwin+fat32, which is already bad enough all by
> itself. Very big repository with no redundant packs in it.
> 

Would you mind sharing the .idx files?
