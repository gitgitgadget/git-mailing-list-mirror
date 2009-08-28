From: david@lang.hm
Subject: Re: Using git to track my PhD thesis, couple of questions
Date: Fri, 28 Aug 2009 14:42:24 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.0908281442050.28411@asgard.lang.hm>
References: <4A979690.1050601@gnu.org> <20090827203402.GC7168@kisimul> <vpqk50pasek.fsf@bauges.imag.fr> <20090827203402.GC7168@kisimul> <9b18b3110908271521w764684cfg3b009f6960ee5dc4@mail.gmail.com> <20090827203402.GC7168@kisimul> <7v1vmxq6nw.fsf@alter.siamese.dyndns.org>
 <20090827203402.GC7168@kisimul> <fabb9a1e0908271341o3a558eedq85541e68875ab77f@mail.gmail.com> <20090827203402.GC7168@kisimul> <20090828133708.GA11146@kisimul> <vpqpragt5bo.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: seanh <seanh.nospam@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Aug 28 23:43:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh9Dc-0003Yy-M5
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 23:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012AbZH1Vmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 17:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbZH1Vmh
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 17:42:37 -0400
Received: from mail.lang.hm ([64.81.33.126]:35997 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751562AbZH1Vmg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 17:42:36 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n7SLgOpN003117;
	Fri, 28 Aug 2009 14:42:25 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <vpqpragt5bo.fsf@bauges.imag.fr>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127353>

On Fri, 28 Aug 2009, Matthieu Moy wrote:

> seanh <seanh.nospam@gmail.com> writes:
>
>> In response to Matthieu and Paolo, I'm not sure I understand the git
>> internals involved in the discussion around merge --squash, I had a
>> feeling this would produce a 'merge' that git in some sense would 'not
>> know about',
>
> Yes, that's it. Git does a merge, and immediately forgets it was a
> merge. The consequence is when you merge again later, Git will not be
> able to use the merge information to be clever about merging. Somehow,
> Git will be as bad as SVN for merging if you don't know what you're
> doing ;-).

I thought that was what rere did?

David Lang
