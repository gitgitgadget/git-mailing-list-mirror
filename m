From: Sergio <sergio.callegari@gmail.com>
Subject: Re: RFC: git sync
Date: Wed, 10 Feb 2010 16:39:14 +0000 (UTC)
Message-ID: <loom.20100210T173300-230@post.gmane.org>
References: <20100210032720.GA5205@cthulhu> <m3wryl8lkp.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 10 17:39:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfFbM-0003SD-LY
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 17:39:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754315Ab0BJQjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 11:39:39 -0500
Received: from lo.gmane.org ([80.91.229.12]:55228 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753977Ab0BJQjj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 11:39:39 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NfFbF-0003O3-8l
	for git@vger.kernel.org; Wed, 10 Feb 2010 17:39:37 +0100
Received: from mars-fw.arces.unibo.it ([137.204.143.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Feb 2010 17:39:37 +0100
Received: from sergio.callegari by mars-fw.arces.unibo.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Feb 2010 17:39:37 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 137.204.143.2 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100106 Ubuntu/9.10 (karmic) Firefox/3.5.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139516>

> Why not use the recpie from GitFaq:
> "How would I use "git push" to sync out of a host that I cannot pull from?"
>
http://git.wiki.kernel.org/index.php/GitFaq#How_would_I_use_.22git_push.22_to_sync_out_of_a_host_that_I_cannot_pull_from.3F
> 

Hi, to follow that recipe with more than one satellite, all sharing the same
config, it would be just great to be able to put $hostname in .git-config, e.g.

[remote "mothership"]
   url = <url>
   push = master:refs/remotes/$hostname/master

Would there be any potential problem with that?
