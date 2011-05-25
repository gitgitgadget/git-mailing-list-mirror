From: =?utf-8?b?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: t7810.94 (git-grep -E -F -G) never passed
Date: Wed, 25 May 2011 21:22:30 +0000 (UTC)
Message-ID: <loom.20110525T231844-341@post.gmane.org>
References: <BE19630B-8E48-4CA8-B956-A4DC767BFFDD@gernhardtsoftware.com> <4DDCD845.1030800@drmicha.warpmail.net> <1AEF57D5-49E0-4F37-BE8D-DEBD25965D83@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 23:22:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPLXa-0006oV-91
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 23:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755282Ab1EYVWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 17:22:49 -0400
Received: from lo.gmane.org ([80.91.229.12]:59755 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752717Ab1EYVWs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 17:22:48 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QPLXN-0006iz-P3
	for git@vger.kernel.org; Wed, 25 May 2011 23:22:42 +0200
Received: from 85-177-78-94.net.stream.pl ([94.78.177.85])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 May 2011 23:22:41 +0200
Received: from michal.kiedrowicz by 85-177-78-94.net.stream.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 May 2011 23:22:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 94.78.177.85 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110511 Gentoo Firefox/3.6.17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174465>

Brian Gernhardt <brian <at> gernhardtsoftware.com> writes:

> 
> Some would be right.  I tend to find that the BSD (and BSD-like) libraries on
OS X are more strict and have less
> features than the GNU equivalents.  (The fact that OS X's libreadline is
actually the only mostly
> compatible libedit drives me batty sometimes.)
> 
> This does leave us with the question of what to do with the test.  Perhaps a
pattern like "a*+b" to match
> "aa+b"?  Plain + should always match just + in a BRE, even if \+ is special,
and the * makes sure that it is a
> regex instead of plain string matching.
> 
> ~~ Brian
> 
> 

You're right about \+ in BRE. I guess I missed that because glibc's
implementation isn't strict BRE. I'll post a patch that fixes this problem.
Thanks for catching this up!
