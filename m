From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git binary size...
Date: Thu, 12 Jan 2006 11:16:27 -0800
Message-ID: <43C6AB0B.4030408@zytor.com>
References: <Pine.LNX.4.64.0601111021450.5073@g5.osdl.org>  <43C558FB.3030102@op5.se>  <Pine.LNX.4.64.0601111134560.5073@g5.osdl.org> <2cd57c900601120215pdb5da27l@mail.gmail.com> <43C65E70.7090702@op5.se> <Pine.LNX.4.64.0601121013030.3535@g5.osdl.org> <Pine.LNX.4.64.0601121033020.3535@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 12 20:17:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ex7wQ-0002sU-JR
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 20:16:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161196AbWALTQz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 14:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161195AbWALTQx
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 14:16:53 -0500
Received: from terminus.zytor.com ([192.83.249.54]:25538 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1161194AbWALTQw
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 14:16:52 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k0CJGW7C006000
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 12 Jan 2006 11:16:32 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601121033020.3535@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 
	autolearn=unavailable version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14581>

Linus Torvalds wrote:
> 
>>Repeat after me: "autoconf is crap".
> 
> .. which is not to say that some _other_ autoconf-like thing might not be 
> good.
> 
> The problem I have with autoconf is that it adds absolutely horrendous 
> #ifdef's etc all over the place, and the resulting makefile (and the 
> config file itself) is just completely unreadable.
> 
> The reason autoconf sucks *ss is that it doesn't try to abstract out any 
> of the differences between systems, it tries to basically "fix up" the 
> differences.
> 
> A real abstraction library would be a lot more preferable than autoconf. 
> It's kind of the way the git stuff works (ie using things like 
> "gitstrcasestr()" and "gitfakemmap()"), but for many of the same reasons 
> that autoconf never did a good job, git itself doesn't do a good job (it 
> uses "#if" hackery to then do things like "#define mmap gitfakemmap").
> 
> But I think the git kind of hackish #ifdef thing is better than the 
> _insitutionalized_ horrible autoconf hackery.
> 

You can use autoconf in this way, though.  See my previous post on the 
matter.

	-hpa
