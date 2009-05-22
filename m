From: Eric Raible <raible@gmail.com>
Subject: Re: git merge remote branch says "Merge commit ..."?
Date: Fri, 22 May 2009 17:29:41 +0000 (UTC)
Message-ID: <loom.20090522T172429-73@post.gmane.org>
References: <2729632a0905211250v4e7537caybe9e703c14361b5f@mail.gmail.com> <20090522074927.GB1409@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 22 19:30:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7YZJ-0004wJ-BV
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 19:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756377AbZEVR34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 13:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755700AbZEVR3z
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 13:29:55 -0400
Received: from main.gmane.org ([80.91.229.2]:58194 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755342AbZEVR3z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 13:29:55 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M7YZA-00063U-IA
	for git@vger.kernel.org; Fri, 22 May 2009 17:29:57 +0000
Received: from mail.nextest.com ([12.96.234.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 May 2009 17:29:56 +0000
Received: from raible by mail.nextest.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 May 2009 17:29:56 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 12.96.234.114 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.19 (KHTML, like Gecko) Chrome/1.0.154.65 Safari/525.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119743>

Jeff King <peff <at> peff.net> writes:

> I think doing a "git merge origin/master" is perfectly normal for some
> workflows. For example:
> 
>   $ git fetch origin ;# grab it
>   $ gitk origin/master...master ;# check if it is good to merge
>   $ git merge origin/master ;# and merge it
> 
> The final step _could_ be a pull, but there is no point in repeating the
> fetch (which might be costly).

My understanding is that if the objects already exist
locally then this is not going to be costly at all.
The negotiation of what is needed is cheap, isn't it?

- Eric
