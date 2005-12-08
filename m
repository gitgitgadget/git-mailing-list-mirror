From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: as promised, docs: git for the confused
Date: Thu, 08 Dec 2005 14:02:05 -0800
Message-ID: <4398AD5D.7010101@zytor.com>
References: <20051208063409.31967.qmail@science.horizon.com> <7vk6efb6ib.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux@horizon.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 08 23:04:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkTqp-0004Bu-C6
	for gcvg-git@gmane.org; Thu, 08 Dec 2005 23:02:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbVLHWCw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 17:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbVLHWCw
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 17:02:52 -0500
Received: from terminus.zytor.com ([192.83.249.54]:6794 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751226AbVLHWCw
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 8 Dec 2005 17:02:52 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jB8M2A8e001689
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 8 Dec 2005 14:02:10 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6efb6ib.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13379>

Junio C Hamano wrote:
> linux@horizon.com writes:
> 
> 
>>* Terminology - heads, branches, refs, and revisions
>>
>>(This is a supplement to what's already in "man git".)
>>
>>The most common object needed by git primitives is a tree.  Since a
>>commit points to a tree and a tag points to a commit, both of these are
>>acceptable "tree-ish" objects and can be used interchangeably.  Likewise,
>>a tag is "commit-ish" and can be used where a commit is required.
> 
> 
> I am unsure if we want to further confuse readers by saying
> this, but technically, "Likewise, a tag which is commit-ish can
> be used in place of commit".  Not all tags are necessarily
> commit-ish.  v2.6.11 tag is tree-ish but not commit-ish for
> example.  Typically, however, a tag is commit-ish.
> 

Saying they can be used interchangably is just plain wrong, however. 
It's not a bijective relation.

Something like:

 >> The most common object needed by git primitives is a tree.  Since a
 >> commit points and tags uniquely identify a tree, a commit or tag can
 >> be used anywhere a tree is expected.

 >> Likewise, most tags point to commits and can be used anywhere a
 >> commit is expected.

... might be better, and avoids the colloquialisms.

	-hpa
