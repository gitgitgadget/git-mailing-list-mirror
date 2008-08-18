From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: BUG simple "revert" fails
Date: Mon, 18 Aug 2008 11:14:55 +0200
Message-ID: <g8beig$218$1@ger.gmane.org>
References: <48A76115.9060909@purple-people.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 11:16:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KV0qT-0004x1-Nw
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 11:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbYHRJPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 05:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751537AbYHRJPJ
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 05:15:09 -0400
Received: from main.gmane.org ([80.91.229.2]:60460 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751049AbYHRJPI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 05:15:08 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KV0pL-0004me-Qp
	for git@vger.kernel.org; Mon, 18 Aug 2008 09:15:03 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 18 Aug 2008 09:15:03 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 18 Aug 2008 09:15:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <48A76115.9060909@purple-people.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92691>

Anthony Booker venit, vidit, dixit 17.08.2008 01:21:
> Attached is a tarball with a couple of repositories.  eg-sub is a 
> submodule in eg.  In eg there's a commit, 
> cd626e6baaa0888c6090e1f040f9f0ba8bfef218, which inappropriately changed 
> a file in eg-sub.  It's a newby mistake with git and submodules.
> 
> The problem is that the problem can't be reverted.  It fails with 
> unknown object It is a submodule.
> 
> To reproduce, unpack the tarball, cd to eg and:
> git revert cd626e6baaa0888c6090e1f040f9f0ba8bfef218
> 
> Thanks for your time.

There's no tarball attached, at least not when reading your post via gmane.

If the repo hasn't been published yet you probably want to rewrite
history rather than introducing a revert commit.

Revering is a bit complicated because the commit to be reverted
contains: subproject commit (unregistering from sub in super) plus add
commit (in super).

Michael
