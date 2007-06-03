From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 3 Jun 2007 01:20:51 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706030114540.4046@racer.site>
References: <7v646wqrvm.fsf@assigned-by-dhcp.cox.net> <7vfy5wcnbg.fsf@assigned-by-dhcp.cox.net>
 <7vd50xz7lq.fsf@assigned-by-dhcp.cox.net> <7vodkb1adr.fsf@assigned-by-dhcp.cox.net>
 <7virac547s.fsf@assigned-by-dhcp.cox.net> <7v6466oygl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Jun 03 02:23:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Huds4-0000M0-6B
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 02:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754420AbXFCAWw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 20:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762774AbXFCAWw
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 20:22:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:52739 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754420AbXFCAWv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 20:22:51 -0400
Received: (qmail invoked by alias); 03 Jun 2007 00:22:49 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp057) with SMTP; 03 Jun 2007 02:22:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+FQEVZTHqFuF5Zje2hU7Q82l028+rN4qDTL00vh+
	tPK6kZR29AwPpv
X-X-Sender: gene099@racer.site
In-Reply-To: <7v6466oygl.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48963>

Hi,

On Sat, 2 Jun 2007, Junio C Hamano wrote:

> * lh/submodules (Sat Jun 2 03:27:42 2007 +0200) 2 commits
>  + Add basic test-script for git-submodule
>  + Add git-submodule command
> 
> I find this a 'master' material already.  Will merge soon.

I agree. Even if I had not time to review it closely, from a cursory look 
it is clean enough. I don't expect any regressions from that.

> * pb/am (Thu May 24 19:25:25 2007 -0700) 2 commits
>  + Remove git-applypatch
>  + git-applymbox: Remove command
> 
> Will push out to 'master' soon to see if anybody screams.

Ack.

> * jc/diff (Mon Dec 25 01:08:50 2006 -0800) 2 commits
>  - test-para: combined diff between HEAD, index and working tree.
>  - para-walk: walk n trees, index and working tree in parallel
> 
> Backburnered.

I actually like those two commits, and I always wanted to work on top of 
these, but my new boss keeps me away from Git :-(

Will review, and try to work some more on them in the next three weeks. 
Don't drop them!

As for the complicated source code: I cannot agree. If you have _any_ idea 
about what data structures are about, you will readily recognize what it 
is about. We _could_ be more explicit, but by a huge margin.

(IMHO too many people try to chime in without _any_ clue about the 
difference of hash tables and binary search, and no notion of Landau's 
symbol. We should not necessarily try to accomodate people who are _that_ 
unwilling to work up their theory.)

Ciao,
Dscho
