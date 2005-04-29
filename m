From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Odd decision of git-pasky-0.7 to do a merge
Date: Fri, 29 Apr 2005 21:52:50 +0100
Message-ID: <20050429215250.E30010@flint.arm.linux.org.uk>
References: <20050429083615.A32271@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504291043060.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 22:55:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRcWB-000200-1S
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 22:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262929AbVD2Uzv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 16:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262976AbVD2UzM
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 16:55:12 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22792 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262929AbVD2Uw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 16:52:56 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DRcTj-0004ww-P8; Fri, 29 Apr 2005 21:52:52 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DRcTi-0002p3-U0; Fri, 29 Apr 2005 21:52:50 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0504291043060.18901@ppc970.osdl.org>; from torvalds@osdl.org on Fri, Apr 29, 2005 at 10:44:29AM -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 29, 2005 at 10:44:29AM -0700, Linus Torvalds wrote:
> On Fri, 29 Apr 2005, Russell King wrote:
> > Why it decided that a merge was necessary is beyond me.  Any ideas?
> > Did Linus forget to merge his tree properly?
> 
> It looks like it was unable to find the right common ancestor.
> 
> If you only had my stuff in it, the common ancestor _should_ have been the 
> parent (c60c390620e0abb60d4ae8c43583714bda27763f), which _should_ have 
> been your old top.
> 
> But maybe merge-base didn't work right?

Yup - pasky-0.7 came out with some weird commit-id, but cogito-0.8
got it right.  Now using cogito-0.8 here, so I'm no longer concerned
about this particular problem.

-- 
Russell King

