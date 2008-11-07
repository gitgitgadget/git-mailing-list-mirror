From: Mark Burton <markb@ordern.com>
Subject: Re: [RFC PATCH 0/4] deny push to current branch of non-bare repo
Date: Fri, 7 Nov 2008 22:39:26 +0000 (UTC)
Message-ID: <loom.20081107T222744-932@post.gmane.org>
References: <20081107220730.GA15942@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 23:40:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kya0e-0001Nt-N1
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 23:40:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbYKGWjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 17:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbYKGWjm
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 17:39:42 -0500
Received: from main.gmane.org ([80.91.229.2]:45890 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751651AbYKGWjl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 17:39:41 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KyZzN-0004w0-06
	for git@vger.kernel.org; Fri, 07 Nov 2008 22:39:37 +0000
Received: from host86-128-20-200.range86-128.btcentralplus.com ([86.128.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Nov 2008 22:39:36 +0000
Received: from markb by host86-128-20-200.range86-128.btcentralplus.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Nov 2008 22:39:36 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 86.128.20.200 (Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.0.3) Gecko/2008092510 Ubuntu/8.04 (hardy) Firefox/3.0.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100355>

Jeff King <peff <at> peff.net> writes:

> 
> The short of it is that it's dangerous, we see people confused by it
> (there was another one just yesterday), and it's a FAQ:
> 
>   http://git.or.cz/gitwiki/GitFaq#head-b96f48bc9c925074be9f95c0fce69bcece5f6e73
> 
> The FAQ even says "don't do this until you know what you are doing." So
> the safety valve is configurable, so that those who know what they are
> doing can switch it off.

When I first tried to use git I was bitten by exactly this problem. I know,
RTFM, but when everything is new, it's easy to undervalue the words of wisdom
when you don't understand the bigger picture and the rational behind the advice.

I now happily work with non-bare repositories on my main machine that I push to
from my satellite development machines but, of course, I don't push to the head
branches but, instead, to remote branches and then merge on the main machine.

I wouldn't have wasted as much time getting my head around this if git had
refused to accept the push to the current branch but, instead, issued a suitable
message telling me I probably didn't want to be doing that.

So, from my own experience, I would say this would be a good feature to add.

Cheers,

Mark
