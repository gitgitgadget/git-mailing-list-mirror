From: David Roundy <droundy@abridgegame.org>
Subject: Re: The criss-cross merge case
Date: Thu, 28 Apr 2005 07:16:48 -0400
Message-ID: <20050428111647.GB9422@abridgegame.org>
References: <87d5sf7il2.fsf@rzstud4.rz.uni-karlsruhe.de> <Pine.LNX.4.21.0504272209390.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Apr 28 13:17:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR70J-00041D-P4
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 13:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbVD1LVx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 07:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbVD1LVx
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 07:21:53 -0400
Received: from user-10mt71s.cable.mindspring.com ([65.110.156.60]:32296 "EHLO
	localhost") by vger.kernel.org with ESMTP id S261562AbVD1LVv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 07:21:51 -0400
Received: from droundy by localhost with local (Exim 4.50)
	id 1DR70k-0002VZ-IE
	for git@vger.kernel.org; Thu, 28 Apr 2005 07:16:50 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0504272209390.30848-100000@iabervon.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 27, 2005 at 10:19:17PM -0400, Daniel Barkalow wrote:
> On Thu, 28 Apr 2005, Benedikt Schmidt wrote:
> > Ok, darcs doesn't handle block moves, so there is no need for an
> > algorithm that supports them (yet). Is there any free SCM that has
> > support for block moves at the moment? It seems like clearcase detects
> > them, but I don't know whqere it takes advantage of it.
> 
> I would think that darcs would be able to do neat things in its merger if
> it knew about block moves. Obviously, it only makes sense to add support
> for identifying them and using them at the same time.

Indeed, handling block moves would definitely be *very* nice.  An ancient
version of darcs actually did this (it's not in the current darcs history,
since it was so ancient and buggy), although it had a terrible diff
algorithm.  But I really didn't understand the theory back then, and when I
rewrote everything, I never added the block moves back in.  They complicate
conflict situations a bit, and once I found that darcs was actually
useable, I started focusing on other issues.  (Most recently efficiency
issues.)
-- 
David Roundy
http://www.darcs.net
