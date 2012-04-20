From: Mark Haney <markh@abemblem.com>
Subject: Re: Help with repo management.
Date: Fri, 20 Apr 2012 08:39:47 -0400
Message-ID: <4F915913.10908@abemblem.com>
References: <4F902294.10302@abemblem.com> <CAH5451nL+BiZPo-cWHwYC4GkA=pT3zgBXi_M-TB-qgDfmy7yow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 20 15:05:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLDWg-0003k6-5o
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 15:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947Ab2DTNFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 09:05:22 -0400
Received: from [50.55.33.242] ([50.55.33.242]:45936 "EHLO marius.homelinux"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751323Ab2DTNFV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 09:05:21 -0400
X-Greylist: delayed 1521 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Apr 2012 09:05:20 EDT
Received: from marius.homelinux (localhost.localdomain [127.0.0.1])
	by marius.homelinux (8.14.5/8.14.5) with ESMTP id q3KCdl7x002548
	for <git@vger.kernel.org>; Fri, 20 Apr 2012 08:39:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120329 Thunderbird/11.0.1
In-Reply-To: <CAH5451nL+BiZPo-cWHwYC4GkA=pT3zgBXi_M-TB-qgDfmy7yow@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195989>

On 04/19/2012 07:49 PM, Andrew Ardill wrote:

>
> First things first, don't think that just because a bare repository
> does not have a working copy that it doesn't have all the data. Having
> a local working copy and a bare repository on a server _is_ keeping
> two separate copies of your data handy, just one is not immediately
> accessible (you have to check it out first). This may be your
> understanding, but it was unclear so I thought I would clarify.
>
> In terms of pushing to a remote, it is best practice to NOT push to a
> repository that has a checked out working copy. The main reason for
> this is that it becomes much easier to lose data, which is bad.
>
> Instead, if you want to work on SERVER as well as some other machine,
> it is safer to checkout the bare repository to another repository on
> SERVER, pulling and pushing to the bare repository in the same fashion
> as you would from a remote machine.
>
> Some more explanation can be found at
> http://gitready.com/advanced/2009/02/01/push-to-only-bare-repositories.html
> for example.
>


Well, that's originally what I thought, that the bare repository carries 
all the data.  But (and I'm not sure how this came about), the more I 
was reading on using git the more it read like the bare repository ONLY 
housed the changes made.  For example, I have a technical document on 
how the structure of the database I'm designing.  If I edit the document 
and then push it to the bare repo, the ONLY thing in the bare repo is 
the delta of that document, not the delta AND the original document. 
Does that make sense?

In essence, it sounded to me like the bare repo required a copy of the 
original data in order for it to be used, since it only housed the 
deltas of the original, not the originals themselves.

In retrospect, it sounds a bit silly now, I suppose since it would be 
impossible to for someone new to pull a copy of the data down from the 
bare repo and have it be useful.  But, that's how I read the docs I had 
googled when first getting started with this project.

I hope that makes it a little easier to understand why I had the problem 
I was having.  Thanks a lot for the informative reply, and the patience 
to do so.


-- 

Mark Haney
Software Developer/Consultant
AB Emblem
markh@abemblem.com
Linux marius.homelinux 3.3.1-5.fc16.x86_64 GNU/Linux
