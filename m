From: david@lang.hm
Subject: Re: merge time
Date: Sun, 29 Jul 2007 21:17:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707292114120.6510@asgard.lang.hm>
References: <994493.95349.qm@web51001.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Matthew L Foster <mfoster167@yahoo.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 06:18:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFMiR-00030S-7Z
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 06:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbXG3ESk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 00:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751596AbXG3ESk
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 00:18:40 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:44646
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557AbXG3ESj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 00:18:39 -0400
Received: from asgard (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l6U4Ia3I007429;
	Sun, 29 Jul 2007 21:18:37 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <994493.95349.qm@web51001.mail.re2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54185>

On Sun, 29 Jul 2007, Matthew L Foster wrote:

> --- Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>> You misunderstand. It would do so both for the newly merged commits *and*
>> for the old commits. Because _you_ think the "new" commits got merged, but
>> it's logically exactly equivalent to saying that the *old* commits got
>> merged.
>>
>> So now *every* single commit would get the timestamp of the merge.
>>
>> See? It would be pointless.
>
> Ok maybe I am still confused. If a repository is in state A and a merge happens changing it to
> state B we can give the changes that got us to B the timestamp of the merge? Since the changes
> that got us from A to B were all merged locally at the same time they should be given the same
> timestamp, right? Please explain more about how changes/commits in state A would also be given the
> timestamp of the merge?
>
> When I say local time I also really mean local commit order as both should be interchangeable
> unless you widly misset/change your local clock. Git/gitweb could have an option to sort/display
> based on local commit order and maybe have check for if local time order is out of sync with local
> commit order.

one feature of git (and I think of truely distributed change management 
systems)

say you have tree A and I have tree B

if you clone your tree and merge from mine, and I clone my tree and merge 
from yours, the result of both merges _must_ be the same there will be 
trouble when we both try and merge with tree C later on.

another thing is that a given commit cannot be changed once it's created 
(if it was changed it wouldn't have the same sha1 value) so you can't just 
go around changeing dates on commits that took place elsewhere.

David Lang
