From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Handling renames.
Date: Thu, 14 Apr 2005 11:49:17 -0700
Message-ID: <425EBB2D.3060508@zytor.com>
References: <1113501260.27227.26.camel@hades.cambridge.redhat.com> <425EB4AE.4010700@zytor.com> <Pine.LNX.4.58.0504141145220.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org,
	James Bottomley <James.Bottomley@SteelEye.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 20:47:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM9MS-0001o4-AB
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 20:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbVDNSt6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 14:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbVDNSt6
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 14:49:58 -0400
Received: from terminus.zytor.com ([209.128.68.124]:42382 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261542AbVDNStb
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 14:49:31 -0400
Received: from [172.27.0.18] (c-67-169-23-106.hsd1.ca.comcast.net [67.169.23.106])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3EInHq7010382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 Apr 2005 11:49:18 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504141145220.7211@ppc970.osdl.org>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 14 Apr 2005, H. Peter Anvin wrote:
> 
>>Although Linus is correct in that an SCM doesn't *have* to handle this, 
>>it really feels like shooting for mediocracy to me.  We might as well 
>>design it right from the beginning.
> 
> No. git is not an SCM. it's a filesystem designed to _host_ an SCM, and 
> that _is_ doing it right from the beginning.
> 
> Keep the abstractions clean. Do _not_ get confused into thinking that git 
> is an SCM. If you think of it that way, you'll end up with crap you can't 
> think about.
> 
> And at a filesystem layer, "rename" already exists. It's moving an object 
> to a new name in a tree. git already does that very well, thank you very 
> much.
> 
> But a filesystem rename is _not_ the same thing as an SCM rename.  An SCM 
> rename is built on top of a filesystem rename, but it has its own issues 
> that may or may not make sense for the filesystem.
> 

I wasn't referring to git per se, I was referring to the hosted SCM.

	-hpa
