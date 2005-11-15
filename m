From: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Subject: Re: fix git-pack-redundant crashing sometimes
Date: Tue, 15 Nov 2005 22:38:56 +0100
Message-ID: <437A5570.70509@etek.chalmers.se>
References: <81b0412b0511150749g5672158v7b39c02ffdf13e08@mail.gmail.com> <20051115180848.561a6da5.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Timo Hirvonen <tihirvon@gmail.com>, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Nov 15 22:40:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec8Vb-0006h3-Tu
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 22:38:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbVKOVi3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 16:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbVKOVi3
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 16:38:29 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:42135 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1750834AbVKOVi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 16:38:29 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout1-sn2.hy.skanova.net (7.2.060.1)
        id 4378E9530006D236; Tue, 15 Nov 2005 22:38:28 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <20051115180848.561a6da5.tihirvon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11946>

Timo Hirvonen wrote:
> On Tue, 15 Nov 2005 16:49:30 +0100
> Alex Riesen <raa.lkml@gmail.com> wrote:
> 
> 
>>llist_sorted_difference_inplace didn't handle the match in the first
>>sha1 correctly and the lists went wild everywhere.
>>
>>---
>>
>>I noticed it on a very big repository (more than 100k files), trying
>>to prune it.
>>The code could profit from double-linked lists greatly, IMHO.
> 
> 
> I use list.h from Linux when I need double-linked lists.  It is very
> easy to use, efficient and fast.
> 
Well, well. Live and learn I suppose. I have never heard of it before.

How portable is it to #include <linux/list.h>? (non-rethorical)

Would there be a performance benefit from doubly-linked list or would
it just simplify parts of the code? My first implementation used d-lists,
but I dropped the ->prev when I realised it was never used.
