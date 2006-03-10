From: Paul Mackerras <paulus@samba.org>
Subject: Re: git-rev-list feature request
Date: Fri, 10 Mar 2006 15:50:59 +1100
Message-ID: <17425.1459.786864.172060@cargo.ozlabs.ibm.com>
References: <17424.53563.622642.738307@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0603091950360.18022@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 10 05:51:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHZau-0002UJ-Fg
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 05:51:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWCJEvO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 23:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWCJEvN
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 23:51:13 -0500
Received: from ozlabs.org ([203.10.76.45]:57221 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751375AbWCJEvN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Mar 2006 23:51:13 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 40B79679E9; Fri, 10 Mar 2006 15:51:12 +1100 (EST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603091950360.18022@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17449>

Linus Torvalds writes:

> Yeah. I _think_ what you want is
> 
>  - phase 1: generate the current graph that we already do for
> 
> 	git-rev-list --all ^cmit
> 
>  - phase 2: start at "cmit", and mark everything that refers to it as 
>    "show me" (including "cmit" itself, which was originally marked 
>    uninteresting)

I'm not sure if that's what I want.  Is that how "git-rev-list -- foo" 
works?

What I want is basically just what "git-rev-list -- foo" does, but
with some extra flexibility in choosing what commits are interesting -
that is, to be able to say that a commit is interesting if it affects
some file, has a reference under .git/refs, or if it is one of a set
of specified commits.

Paul.
