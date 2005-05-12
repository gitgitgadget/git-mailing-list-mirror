From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Wed, 11 May 2005 18:09:39 -0700
Message-ID: <4282ACD3.50009@zytor.com>
References: <1115847510.22180.108.camel@tglx> <428291CD.7010701@zytor.com>	 <1115854733.22180.202.camel@tglx>	 <200505111941.04104.dtor_core@ameritech.net> <1115858670.22180.259.camel@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 03:02:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW25s-0001xw-P8
	for gcvg-git@gmane.org; Thu, 12 May 2005 03:02:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVELBKA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 21:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVELBKA
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 21:10:00 -0400
Received: from terminus.zytor.com ([209.128.68.124]:19387 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261286AbVELBJy
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 21:09:54 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j4C19jMR023850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 11 May 2005 18:09:45 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: tglx@linutronix.de
In-Reply-To: <1115858670.22180.259.camel@tglx>
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.0 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Thomas Gleixner wrote:
> On Wed, 2005-05-11 at 19:41 -0500, Dmitry Torokhov wrote:
> 
>>>Which is complety error prone due to rsync. Some of the repositories on
>>>kernel.org keep identical copies of .git/description already. Why should
>>>they preserve an unique .git/repoid ?
>>
>>I think that an unique repoid should be created automatically every time
>>you clone. It is ok for it to go away when you discard a tree, it will just
>>identify a line (set) of changes originating from some place.
> 
> 
> Yes, as long as you make sure that rsync does _NOT_ pollute/populate it
> 

You shouldn't be rsyncing the .git directory, only .git/objects anyway. 
   Some people seem to have merely copied Linus' entire tree, and that's 
what causing problems.

That one you can't win.

	-hpa

