From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-fetch per-repository speed issues
Date: Tue, 04 Jul 2006 08:44:48 +0200
Organization: At home
Message-ID: <e8d2nu$k44$2@sea.gmane.org>
References: <1151949764.4723.51.camel@neko.keithp.com> <Pine.LNX.4.64.0607031603290.12404@g5.osdl.org> <20060704002138.GB5716@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Jul 04 08:45:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fxeek-0004D2-Uj
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 08:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbWGDGpI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 02:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWGDGpH
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 02:45:07 -0400
Received: from main.gmane.org ([80.91.229.2]:29097 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750929AbWGDGpG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 02:45:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Fxeeb-0004B4-ST
	for git@vger.kernel.org; Tue, 04 Jul 2006 08:45:01 +0200
Received: from host-81-190-27-124.torun.mm.pl ([81.190.27.124])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Jul 2006 08:45:01 +0200
Received: from jnareb by host-81-190-27-124.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Jul 2006 08:45:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-124.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23260>

Jeff King wrote:

> On Mon, Jul 03, 2006 at 04:14:10PM -0700, Linus Torvalds wrote:
> 
>> Well, you could use multiple branches in the same repository, even if
they 
>> are totally unrealated. That would allow you to fetch them all in one go.
> 
> One annoying thing about this is that you may want to have several of
> the branches checked out at a time (i.e., you want the actual directory
> structure of libXrandr/, Xorg/, etc). You could pull everything down
> into one repo and point small pseudo-repos at it with alternates, but I
> would think that would become a mess with pushes. You can do some magic
> with read-tree --prefix, but again, I'm not sure how you'd make commits
> on the correct branch.  Is there an easier way to do this?

Write proper subprojects support for git, or pester someone to write it
(finally). See Subpro.txt in todo branch.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
