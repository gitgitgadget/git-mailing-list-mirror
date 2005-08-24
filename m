From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: [RFC] undo and redo
Date: Wed, 24 Aug 2005 14:47:36 -0600
Organization: Hewlett Packard
Message-ID: <20050824204736.GA13194@hpsvcnb.fc.hp.com>
References: <20050824172339.GA7083@hpsvcnb.fc.hp.com> <20050824181004.GA18790@hpsvcnb.fc.hp.com> <Pine.LNX.4.58.0508241148480.3317@g5.osdl.org> <20050824195615.GA693@hpsvcnb.fc.hp.com> <Pine.LNX.4.63.0508241634350.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Baldwin <cnb@fc.hp.com>, Linus Torvalds <torvalds@osdl.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 24 22:49:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E829s-00068Y-98
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 22:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbVHXUrh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Aug 2005 16:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbVHXUrh
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Aug 2005 16:47:37 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:43749 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S932180AbVHXUrh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Aug 2005 16:47:37 -0400
Received: from smtp1.fc.hp.com (smtp1.fc.hp.com [15.15.136.127])
	by atlrel6.hp.com (Postfix) with ESMTP id AB1023BB4;
	Wed, 24 Aug 2005 16:47:36 -0400 (EDT)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp1.fc.hp.com (Postfix) with ESMTP
	id 6C28237F80; Wed, 24 Aug 2005 20:47:36 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id 5B8D62CE9C; Wed, 24 Aug 2005 14:47:36 -0600 (MDT)
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0508241634350.23242@iabervon.org>
X-Origin: hpescnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7729>

This is interesting.  Can a ref be to a tree rather than a commit?  And
it still works?  I guess it would.  I hadn't thought about that.

Will prune preserve any tree mentioned in any file in refs?  How does
this work exactly?

Cheers,
Carl

On Wed, Aug 24, 2005 at 04:44:48PM -0400, Daniel Barkalow wrote:
> On Wed, 24 Aug 2005, Carl Baldwin wrote:
> 
> > This brings up a good point (indirectly).  "git prune" would destroy the
> > undo objects.  I had thought of this but decided to ignore it for the
> > time being.
> 
> If you made undo store the tree under refs somewhere, git prune would
> preserve it.
> 
> 	-Daniel
> *This .sig left intentionally blank*
> 

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        Systems VLSI Laboratory
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
