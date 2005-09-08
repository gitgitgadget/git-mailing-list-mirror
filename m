From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: Multi-ancestor read-tree notes
Date: Thu, 8 Sep 2005 22:37:56 +0200
Message-ID: <20050908203756.GB26088@c165.ib.student.liu.se>
References: <Pine.LNX.4.63.0509050049030.23242@iabervon.org> <1126199765.3984.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 08 22:39:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDTA0-0007Ef-9N
	for gcvg-git@gmane.org; Thu, 08 Sep 2005 22:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbVIHUh6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Sep 2005 16:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbVIHUh6
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Sep 2005 16:37:58 -0400
Received: from [85.8.31.11] ([85.8.31.11]:64226 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S965002AbVIHUh5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Sep 2005 16:37:57 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 45B064100; Thu,  8 Sep 2005 22:42:43 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EDT9g-0007So-00; Thu, 08 Sep 2005 22:37:56 +0200
To: Darrin Thompson <darrint@progeny.com>
Content-Disposition: inline
In-Reply-To: <1126199765.3984.1.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8215>

On Thu, Sep 08, 2005 at 12:16:05PM -0500, Darrin Thompson wrote:
> On Mon, 2005-09-05 at 01:41 -0400, Daniel Barkalow wrote:
> > I've got a version of read-tree which accepts multiple ancestors and does 
> > a merge using information from all of them.
> 
> Do the multiple ancestors have to share a common parent? More to the
> point, is this read-tree any more friendly to baseless merges?
> 

Is a baseless merge a merge with two branches that do not have a
common ancestor? That is, if we want to merge the branches A and B and
git-merge-base --all A B do not return any commits, is that a baseless
merge?

If that is the case then my merge code handles baseless merges
fine. Or, it is _supposed_ to handle them, I have done some basic
tests but it hasn't been tested thoroughly yet.

I don't know how the new read-tree code handles those cases.

- Fredrik
