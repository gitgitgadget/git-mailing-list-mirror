From: Paul Mackerras <paulus@samba.org>
Subject: Re: new gitk feature
Date: Fri, 28 Apr 2006 09:52:22 +1000
Message-ID: <17489.22838.502099.575465@cargo.ozlabs.ibm.com>
References: <17487.21137.344427.173131@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0604260802050.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 28 02:02:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZGRV-0008TK-C9
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 02:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbWD1ACO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 20:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbWD1ACO
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 20:02:14 -0400
Received: from ozlabs.org ([203.10.76.45]:1932 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751772AbWD1ACN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Apr 2006 20:02:13 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 8FD6B67A3D; Fri, 28 Apr 2006 10:02:07 +1000 (EST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604260802050.3701@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19255>

Linus Torvalds writes:

> Any possibility of something light that? I'd _love_ to be able to see the 
> whole tree, but with things that touch certain files or things that are 
> newer highlighted.

That should be quite doable.  How about I show the commits that are in
the highlight view in bold?  That won't conflict with the existing
yellow background for commits that match the find criteria.

> (Btw, the "revision information" is also cool things like "--unpacked". I 
> actually use "gitk --unpacked" every once in a while, just because it's 
> such a cool way to say "show me everything I've added since I packed the 
> repo last).

OK, I didn't know about --unpacked. :)  I plan to add stuff to the
view definition window to allow you to select commits to
include/exclude by reachability from given commits (by head/tag/ID)
and when I do I can add a way to say --unpacked too.

Paul.
