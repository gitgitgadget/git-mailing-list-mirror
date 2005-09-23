From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 'bad file' error updating from Linus
Date: Fri, 23 Sep 2005 12:43:07 -0700
Message-ID: <43345ACB.1080201@zytor.com>
References: <dgu56t$d2p$1@sea.gmane.org> <509c8057050922054272b823fe@mail.gmail.com> <dgv8jv$amv$1@sea.gmane.org> <Pine.LNX.4.58.0509221630200.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: walt <wa1ter@myrealbox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 21:44:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EItSX-0005kn-09
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 21:43:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbVIWTna (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 15:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbVIWTna
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 15:43:30 -0400
Received: from terminus.zytor.com ([209.128.68.124]:208 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750951AbVIWTn3
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 15:43:29 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j8NJh9E8025604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 23 Sep 2005 12:43:10 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509221630200.2553@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9195>

Linus Torvalds wrote:
> 
> Nope, it's not.
> 
> It just depends on which IP address you happen to get when you look at 
> www.kernel.org.
> 
> www.kernel.org resolves to two addresses:
> 
> 	Name:   zeus-pub.kernel.org
> 	Address: 204.152.191.5
> 	Name:   zeus-pub.kernel.org
> 	Address: 204.152.191.37
> 
> and the .5 address is working, but the .37 address has the broken mirror.
> 
> I thought hpa took it out of service while it was re-syncing, but 
> apparently not. 
> 

Well, it had resynched, but the time and date stamp on the 
refs/heads/master file were correct - just the data wrong - so rsync 
didn't flag the file.  I forced rsync --checksum and it's correct now.

	-hpa
