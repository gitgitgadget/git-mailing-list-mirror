From: Darrin Thompson <darrint@progeny.com>
Subject: Re: Merges without bases
Date: Thu, 25 Aug 2005 17:59:24 -0500
Message-ID: <1125010764.4110.35.camel@localhost.localdomain>
References: <1125004228.4110.20.camel@localhost.localdomain>
	 <7vvf1tps9v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 26 02:59:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8QhY-0007cb-Te
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 01:00:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbVHYW7a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Aug 2005 18:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbVHYW73
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Aug 2005 18:59:29 -0400
Received: from zealot.progeny.com ([216.37.46.162]:60555 "EHLO
	morimoto.progeny.com") by vger.kernel.org with ESMTP
	id S964964AbVHYW73 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2005 18:59:29 -0400
Received: from localhost.localdomain (morimoto.progeny.com [192.168.1.53])
	by morimoto.progeny.com (Postfix) with ESMTP
	id 9D768636AB; Thu, 25 Aug 2005 17:59:24 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvf1tps9v.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.2.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7776>

On Thu, 2005-08-25 at 15:26 -0700, Junio C Hamano wrote:
>         empty=`GIT_INDEX_FILE=.no-such-file git-write-tree`
>         git-read-tree -m -u $empty $head $foreign ||

ooooo. Tricky.

Thanks for the script. That's a bad, bad hack. :-)

> One thing that makes me reluctant to recommend this "merging
> unrelated projects" business is that I suspect that it makes
> things _much_ harder for the upstream project that is being
> merged, and should not be done without prior arrangement; Linus
> merged gitk after talking with paulus, so that was OK.
> 

What I'm going to do is actually an inversion of that. Publishing a
repository with the _intent_ of being merged into existing history, and
observing obvious naming conventions as the "prior arrangement".

I thought once I got the initial baseless merges done and committed that
I do fetch-octopus from that point on. But octopus was still complaining
about not finding a merge base. I'm going to verify that I didn't just
mess something up in the process.

If I can get octopus working as the tool for doing merges _after_ the
baseless merges then I can live with the current situation. 

--
Darrin
