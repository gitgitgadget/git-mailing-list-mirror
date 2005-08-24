From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] undo and redo
Date: Wed, 24 Aug 2005 17:04:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508241651420.23242@iabervon.org>
References: <20050824172339.GA7083@hpsvcnb.fc.hp.com> <20050824181004.GA18790@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.58.0508241148480.3317@g5.osdl.org> <20050824195615.GA693@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.63.0508241634350.23242@iabervon.org> <20050824204736.GA13194@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 24 23:03:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E82NM-0003Nh-4G
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 23:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbVHXVBS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Aug 2005 17:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbVHXVBS
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Aug 2005 17:01:18 -0400
Received: from iabervon.org ([66.92.72.58]:63249 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932212AbVHXVBS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Aug 2005 17:01:18 -0400
Received: (qmail 23930 invoked by uid 1000); 24 Aug 2005 17:04:51 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Aug 2005 17:04:51 -0400
To: Carl Baldwin <cnb@fc.hp.com>
In-Reply-To: <20050824204736.GA13194@hpsvcnb.fc.hp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7730>

On Wed, 24 Aug 2005, Carl Baldwin wrote:

> This is interesting.  Can a ref be to a tree rather than a commit?  And
> it still works?  I guess it would.  I hadn't thought about that.

Generally, each subdirectory of refs/ has refs to objects of the same
type, and heads/ is commits, but other directories are other things. tags/
is all tag objects, and you could have undo/ be trees.

> Will prune preserve any tree mentioned in any file in refs?  How does
> this work exactly?

It keeps any object reachable from an object that there's a ref to in
refs.

	-Daniel
*This .sig left intentionally blank*
