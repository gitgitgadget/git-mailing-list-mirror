From: Eric Raible <raible@gmail.com>
Subject: Re: Problem with large files on different OSes
Date: Thu, 28 May 2009 04:21:11 +0000 (UTC)
Message-ID: <loom.20090528T041831-21@post.gmane.org>
References: <submission.1M9Gk0-0000N8-MQ@mail.cs.st-andrews.ac.uk> <m3y6siboij.fsf@localhost.localdomain> <alpine.LFD.2.01.0905270922250.3435@localhost.localdomain> <alpine.LFD.2.01.0905270942580.3435@localhost.localdomain> <alpine.LFD.2.00.0905271312220.3906@xanadu.home> <20090527215314.GA10362@coredump.intra.peff.net> <alpine.LFD.2.01.0905271457310.3435@localhost.localdomain> <f95910c20905271609u63d04965oa38b8af34d7704c1@mail.gmail.com> <alpine.LFD.2.01.0905271825520.3435@localhost.localdomain> <alpine.LFD.2.00.0905272312370.3906@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 28 06:22:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9X8n-0003By-2M
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 06:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbZE1EVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 00:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbZE1EVW
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 00:21:22 -0400
Received: from main.gmane.org ([80.91.229.2]:35801 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750833AbZE1EVW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 00:21:22 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M9X7J-0005us-S4
	for git@vger.kernel.org; Thu, 28 May 2009 04:21:22 +0000
Received: from adsl-67-119-194-173.dsl.pltn13.pacbell.net ([67.119.194.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 May 2009 04:21:21 +0000
Received: from raible by adsl-67-119-194-173.dsl.pltn13.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 May 2009 04:21:21 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 67.119.194.173 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.19 (KHTML, like Gecko) Chrome/1.0.154.65 Safari/525.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120144>

Nicolas Pitre <nico <at> cam.org> writes:

> On Wed, 27 May 2009, Linus Torvalds wrote:
> 
> > +pack.packDeltaLimit::
> > +	The default maximum size of objects that we try to delta.
> 
> The option name feels a bit wrong here, like if it meant the max number 
> of deltas in a pack.  Nothing better comes to my mind at the moment 
> though.

pack.maxDeltaSize sounds weird when said aloud.
How about pack.deltaMaxSize?

- Eric
