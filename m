From: Matthias-Christian Ott <matthias.christian@tiscali.de>
Subject: Re: [PATCH GIT 0.6] make use of register variables & size_t
Date: Mon, 25 Apr 2005 20:15:22 +0200
Message-ID: <426D33BA.8040604@tiscali.de>
References: <426CD1F1.2010101@tiscali.de> <Pine.LNX.4.58.0504250751330.18901@ppc970.osdl.org> <426D21FE.3040401@tiscali.de> <Pine.LNX.4.58.0504251021280.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 20:13:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ84Q-0005uw-8q
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 20:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262716AbVDYSRK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 14:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262713AbVDYSPo
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 14:15:44 -0400
Received: from relay1.tiscali.de ([62.26.116.129]:4493 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S262702AbVDYSPg
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 14:15:36 -0400
Received: from [169.254.101.1] (213.54.101.65) by webmail.tiscali.de (7.0.036.1) (authenticated as matthias.christian@tiscali.de)
        id 426359FA00041903; Mon, 25 Apr 2005 20:15:31 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050406)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504251021280.18901@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 25 Apr 2005, Matthias-Christian Ott wrote:
> 
>>"register" and "auto" variables aren't relicts of the 60's,  they're a 
>>part of the ISO-C 99 standard, I'm following, "man".
> 
> 
> They _are_ relicts of the 60's. It's just that the C standard hasn't ever 
> had the reason to remove them.
> 
> 
>>And if you think "register" variables are outdated, please remove the 
>>CONFIG_REGPARM option from the Kernel source.
> 
> 
> That does something totally different. And doesn't use "register" at all.
> 
> Pass the toke, you've been hogging the drugs for way too long.
> 
> 		Linus
> 
But this makes, like "register",  direct use of processor registers (it stores int arguments in eax, ebx, etc.).

Matthias-Christian Ott
