From: Eric Raible <raible@gmail.com>
Subject: Re: Reverting an uncommitted revert
Date: Wed, 20 May 2009 16:55:25 +0000 (UTC)
Message-ID: <loom.20090520T165201-657@post.gmane.org>
References: <4A136C40.6020808@workspacewhiz.com> <alpine.LFD.2.00.0905192300070.3906@xanadu.home> <20090520032139.GB10212@coredump.intra.peff.net> <alpine.LFD.2.00.0905192328310.3906@xanadu.home> <025225A0-FACC-4A29-A747-40201A7FBA19@wincent.com> <alpine.LFD.2.00.0905200853010.3906@xanadu.home> <20090520141709.GO30527@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 20 18:55:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6p59-0006nl-8s
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 18:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897AbZETQzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 12:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753825AbZETQzn
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 12:55:43 -0400
Received: from main.gmane.org ([80.91.229.2]:37203 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753035AbZETQzn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 12:55:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M6p4w-0006g4-Qf
	for git@vger.kernel.org; Wed, 20 May 2009 16:55:43 +0000
Received: from adsl-67-119-194-173.dsl.pltn13.pacbell.net ([67.119.194.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 May 2009 16:55:42 +0000
Received: from raible by adsl-67-119-194-173.dsl.pltn13.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 May 2009 16:55:42 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 67.119.194.173 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.19 (KHTML, like Gecko) Chrome/1.0.154.65 Safari/525.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119620>

Shawn O. Pearce <spearce <at> spearce.org> writes:

> You did say "uncommitted entry causes reflog append", so in Peff's
> original example of "git add a; vi a; git add a", we should be
> creating a reflog entry for that first added state, which is clearly
> not a disagreement.
> 
> FWIW, I think this is a great idea, but lack the time to code it
> myself, otherwise I probably would start hacking on it right now.
> 

I for one am very happy to hear to say this.

Git is generally quite safe, but still, there are holes for the unwary.
I've fallen into those holes (embarrassingly, more than once), and so
any movement towards filling them is quite welcome.
