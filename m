From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-pull and tag objects
Date: Thu, 15 Feb 2007 02:21:36 +0100
Organization: At home
Message-ID: <er0cfg$1m7$1@sea.gmane.org>
References: <1170933407.15431.38.camel@okra.transitives.com> <81b0412b0702090133qa4eb0c0v6a2d309fe9653a3f@mail.gmail.com> <7v4ppurka1.fsf@assigned-by-dhcp.cox.net> <20070210142322.GB25607@thunk.org> <Pine.LNX.4.64.0702100938540.8424@woody.linux-foundation.org> <7vy7n5gs0y.fsf@assigned-by-dhcp.cox.net> <20070212162745.GB2741@thunk.org> <7vr6su1szp.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702132230490.3604@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 15 02:25:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHVMy-0003U1-7d
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 02:25:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbXBOBZE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 20:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbXBOBZE
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 20:25:04 -0500
Received: from main.gmane.org ([80.91.229.2]:51844 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751478AbXBOBZB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 20:25:01 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HHVL7-0000n3-96
	for git@vger.kernel.org; Thu, 15 Feb 2007 02:23:13 +0100
Received: from host-81-190-26-5.torun.mm.pl ([81.190.26.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Feb 2007 02:23:13 +0100
Received: from jnareb by host-81-190-26-5.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Feb 2007 02:23:13 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-5.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39782>

Linus Torvalds wrote:

> One thing that _might_ be a good idea for tags (if people _really_ want to 
> actually update tags under the same name) is to have a "parent" pointer 
> for tag objects, the same way we have for commits. That way you could - if 
> you really wanted to - create a chain of tags, and show the history of 
> them.

Wouldn't it be better to just use reflog for given tag? That assuming of
course that we could protect tag reflog from pruning...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
