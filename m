From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] (Updated) Exec git programs without using PATH.
Date: Wed, 11 Jan 2006 21:38:39 -0800
Message-ID: <43C5EB5F.6000402@zytor.com>
References: <1136849678.11717.514.camel@brick.watson.ibm.com>	<1136849810.11717.518.camel@brick.watson.ibm.com>	<7vwth8bxqd.fsf@assigned-by-dhcp.cox.net>	<1136900174.11717.537.camel@brick.watson.ibm.com>	<43C3CC4A.4030805@op5.se>	<1136910406.11717.579.camel@brick.watson.ibm.com>	<43C4075E.4070407@op5.se> <7vu0cb6f1n.fsf@assigned-by-dhcp.cox.net>	<1136924980.11717.603.camel@brick.watson.ibm.com>	<7vd5iz4mt7.fsf@assigned-by-dhcp.cox.net>	<1136945538.11717.643.camel@brick.watson.ibm.com>	<7v4q4bwavi.fsf@assigned-by-dhcp.cox.net>	<1136999157.11717.658.camel@brick.watson.ibm.com>	<7vek3esdw0.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0601111238550.5073@g5.osdl.org>	<1137014812.11717.669.camel@brick.watson.ibm.com> <7vk6d6qwmn.fsf@assigned-by-dhcp.cox.net> <43C59EC6.6070905@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 06:38:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwvAe-0002ST-L6
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 06:38:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWALFip (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 00:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbWALFip
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 00:38:45 -0500
Received: from terminus.zytor.com ([192.83.249.54]:38112 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964774AbWALFio
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 00:38:44 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k0C5cdc7018335
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 11 Jan 2006 21:38:40 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43C59EC6.6070905@op5.se>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.2 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14546>

Andreas Ericsson wrote:
> 
> Not being entirely knowledgeable on what spawn() actually does and how 
> its semantics differ from fork() and exec*() style API's (Google was 
> depressingly unhelpful and wikipedia dredged up froglings...), I've got 
> a decent "clone-lots-of-processes-and-multiplex-between-them" kind of 
> library lying around. Would it be of any use?
> 
>  From the prototypes I've seen on spawn it doesn't seem to be much more 
> than a fork() + execve(), either closing or dup2'ing all the 
> file-descriptors, so I don't understand why that couldn't be implemented 
> for git. Some pointers, anyone?
> 

RTFM(posix_spawn)...

	-hpa
