From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: git performance
Date: Fri, 24 Oct 2008 07:24:12 +0900
Message-ID: <20081024072412.6117@nanako3.lavabit.com>
References: <alpine.LNX.1.00.0810231346520.19665@iabervon.org> <000801c93483$2fdad340$8f9079c0$@com> <20081022203624.GA4585@coredump.intra.peff.net> <000901c93490$e0c40ed0$a24c2c70$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Edward Ned Harvey <git@nedharvey.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Oct 24 00:26:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kt8dA-0003Cz-Vs
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 00:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544AbYJWWY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 18:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752204AbYJWWY7
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 18:24:59 -0400
Received: from karen.lavabit.com ([72.249.41.33]:37085 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752008AbYJWWY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 18:24:58 -0400
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id 8A6ABC8950;
	Thu, 23 Oct 2008 17:24:57 -0500 (CDT)
Received: from 1823.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id EP2QQ8PHEOBB; Thu, 23 Oct 2008 17:24:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=SDw4zdBjTJZqT2PW5/ln6bDQwtTG06Xv6EK+yHBRz+WMucqcOYzAh0a0w+vT5pTDf0XzewLQcfxYCP60FvNU8Vc95CSU+knaEX3Vnjgn4Iu3gxo6rbR2TnHYx7b4CLJkxOo6FXKv1aR9vTKyAzFEi3SjWl0GK8QW7oNBT47FAO0=;
  h=From:To:Cc:Date:Subject:In-reply-to:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-reply-to: <alpine.LNX.1.00.0810231346520.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98990>

Quoting Daniel Barkalow <barkalow@iabervon.org>:

> On Wed, 22 Oct 2008, Edward Ned Harvey wrote:
>
>> Out of curiosity, what are they talking about, when they say "git is 
>> fast?"  Just the fact that it's all local disk, or is there more to it 
>> than that?  I could see - git would probably outperform perforce for 
>> versioning of large files (let's say iso files) to benefit from 
>> sustained local disk IO, while perforce would probably outperform 
>> anything I can think of, operating on thousands of tiny files, because 
>> it will never walk the tree. 
>
> It shouldn't be too hard to make git work like perforce with respect to 
> walking the tree. git keeps an index of the stat() info it saw when it 
> last looked at files, and only looks at the contents of files whose stat() 
> info has changed. In order to have it work like perforce, it would just 
> need to have a flag in the stat() info index for "don't even bother", 

Are you describing the "assume unchanged bit"?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
