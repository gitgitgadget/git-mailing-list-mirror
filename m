From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Linus kernel tree corrupt?
Date: Sun, 10 Jul 2005 13:35:17 -0700
Message-ID: <42D18685.1000307@zytor.com>
References: <9e473391050708085756bd463e@mail.gmail.com> <12c511ca05070810065db87043@mail.gmail.com> <20050709114303.B2175@flint.arm.linux.org.uk> <20050709115530.GC26343@pasky.ji.cz> <42D01174.4050501@zytor.com> <20050710152309.GE24249@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Russell King <rmk@arm.linux.org.uk>,
	Tony Luck <tony.luck@gmail.com>,
	Jon Smirl <jonsmirl@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 10 22:40:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Driaj-0003fo-3k
	for gcvg-git@gmane.org; Sun, 10 Jul 2005 22:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbVGJUgr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 16:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVGJUgg
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 16:36:36 -0400
Received: from terminus.zytor.com ([209.128.68.124]:31379 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261919AbVGJUgC
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2005 16:36:02 -0400
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j6AKZHbb028642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 10 Jul 2005 13:35:18 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050710152309.GE24249@pasky.ji.cz>
X-Virus-Scanned: ClamAV version 0.86.1, clamav-milter version 0.86 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:
> 
> It _is_ unsafe for individual objects, and your packfile will be corrupt
> if you break it in the middle and not have --whole-file turned on, I
> assume. It would be ideal if we could make rsync allow resuming download
> of the file if interrupted, but not under the final name but in that
> hidden file it uses.
> 

I think if you just don't give it --partial you're fine (rsync always 
creates a second copy, --partial decides if a partial file should be 
thrown away or not.)

	-hpa
