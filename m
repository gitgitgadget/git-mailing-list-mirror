From: david@lang.hm
Subject: Re: Untracked working tree files
Date: Wed, 15 Oct 2008 12:09:25 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0810151208100.7808@asgard.lang.hm>
References: <20081015115654.fb34438f.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Oct 15 21:10:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqBks-0000vM-Bm
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 21:09:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755182AbYJOTIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 15:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755149AbYJOTIp
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 15:08:45 -0400
Received: from mail.lang.hm ([64.81.33.126]:45769 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754129AbYJOTIp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 15:08:45 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m9FJ8elv001308;
	Wed, 15 Oct 2008 12:08:40 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20081015115654.fb34438f.akpm@linux-foundation.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98297>

On Wed, 15 Oct 2008, Andrew Morton wrote:

> Date: Wed, 15 Oct 2008 11:56:54 -0700
> From: Andrew Morton <akpm@linux-foundation.org>
> To: git@vger.kernel.org
> Subject: Untracked working tree files
> 
> I often get this (running git 1.5.6.rc0 presently):
>
> y:/usr/src/git26> git-checkout linux-next
> error: Untracked working tree file 'arch/x86/kernel/apic.c' would be overwritten by merge.
>
> which screws things up.  I fix it by removing the offending file, which
> gets irritating because git bails out after the first such instance, so
> I need to rerun git-checkout once per file (there are sometimes tens of them).

what I do when I run into this is "git reset --hard HEAD" which makes all 
files in the working directory match HEAD, and then I can do the other 
checkout.

David Lang

> Should this be happening?  I don't know what causes it, really.  All
> I've been doing in that directory is running `git-checkout' against
> various maintainers' trees.  95% of the time this works OK but
> eventually git seems to get all confused and the above happens.
>
> Is there some way in which I can work around this with a single command
> rather than having to run git-checkout once per offending file?  I
> suppose a good old `rm -rf *' would do it...
>
> Thanks.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
