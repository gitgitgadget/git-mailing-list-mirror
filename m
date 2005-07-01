From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Tags
Date: Fri, 01 Jul 2005 11:37:55 -0700
Message-ID: <42C58D83.9060107@zytor.com>
References: <Pine.LNX.4.21.0506301403300.30848-100000@iabervon.org> <Pine.LNX.4.58.0506301302410.14331@ppc970.osdl.org> <42C454B2.6090307@zytor.com> <Pine.LNX.4.58.0506301344070.14331@ppc970.osdl.org> <42C462CD.9010909@zytor.com> <Pine.LNX.4.58.0506301432500.14331@ppc970.osdl.org> <42C46B86.8070006@zytor.com> <m13bqyk4uh.fsf_-_@ebiederm.dsl.xmission.com> <20050701180944.GA14375@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 01 20:34:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoQKk-0005ML-Kr
	for gcvg-git@gmane.org; Fri, 01 Jul 2005 20:33:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbVGASlS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jul 2005 14:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263431AbVGASlS
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jul 2005 14:41:18 -0400
Received: from terminus.zytor.com ([209.128.68.124]:5564 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S263429AbVGASk5
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Jul 2005 14:40:57 -0400
Received: from [10.4.1.32] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j61Ic0L6025331
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 1 Jul 2005 11:38:00 -0700
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050701180944.GA14375@pasky.ji.cz>
X-Virus-Scanned: ClamAV version 0.85.1, clamav-milter version 0.85 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.7 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:
> Dear diary, on Fri, Jul 01, 2005 at 03:56:06PM CEST, I got a letter
> where "Eric W. Biederman" <ebiederm@xmission.com> told me that...
> 
>>"H. Peter Anvin" <hpa@zytor.com> writes:
>>
>>
>>>In the end, it might be that the right thing to do for git on kernel.org is to
>>>have a single, unified object store which isn't accessible by anything other
>>>than git-specific protocols.  There would have to be some way of dealing with,
>>>for example, conflicting tags that apply to different repositories, though.
>>
>>As far as I can tell public distributed tags are not that hard and if
>>you are going to be synching them it is probably worth working on.
>>
>>The basic idea is that instead of having one global tag of
>>'linux-2.6.13-rc1' you have a global tag of
>>'torvalds@osdl.org/linux-2.6.13-rc1'.
>>
>>The important part is that the tag namespace is made hierarchical
>>with at least 2 levels.  Where the top level is a globally
>>unique tag owner id and the bottom level is the actual tag.  This
>>prevents collisions when merging trees because two peoples
>>tags are never in the same namespace, as least when
>>people are not actively hostile :)
> 
> 
> I don't know, I don't consider this very appealing myself. I'd rather
> prefer the private tags to be per-repository rather than per-user, since
> those ugly "merged-here", "broken" etc. tags aren't very useful on
> larger scope than of a repository. OTOH, what tags would be per-user,
> not per-repository and not global?
> 

He's talking about global tags, just using a "globally unique" 
namespace.  Which of course only works right if only genuinely can't 
create tags outside your assigned namespace.

	-hpa
