From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Yet another base64 patch
Date: Thu, 14 Apr 2005 09:58:58 -0700
Message-ID: <425EA152.4090506@zytor.com>
References: <425DEF64.60108@zytor.com> <20050414022413.GB18655@64m.dyndns.org> <425E0174.4080404@zytor.com> <20050414024228.GC18655@64m.dyndns.org> <425E0D62.9000401@zytor.com> <Pine.LNX.4.58.0504140038450.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christopher Li <git@chrisli.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 18:59:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM7fD-0008JR-DS
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 18:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVDNRA5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 13:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbVDNRA5
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 13:00:57 -0400
Received: from terminus.zytor.com ([209.128.68.124]:15242 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261548AbVDNQ7z
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 12:59:55 -0400
Received: from [172.27.3.248] (c-67-169-23-106.hsd1.ca.comcast.net [67.169.23.106])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3EGx0Qu008359
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 Apr 2005 09:59:11 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504140038450.7211@ppc970.osdl.org>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> I'll tell you why a flat object directory format simply isn't an option.
> 
> Hint: maximum directory size. It's limited by n_link, and it's almost
> universally a 16-bit number on Linux (and generally artifically limited to
> 32000 entries).
> 
> In other words, if you ever expect to have more than 32000 objects, a flat 
> space simply isn't possible.
> 

Eh?!  n_link limits the number of *subdirectories* a directory can 
contain, not the number of *entries*.

	-hpa

	
