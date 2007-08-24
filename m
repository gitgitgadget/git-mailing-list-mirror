From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Tags of non-commits
Date: Fri, 24 Aug 2007 14:11:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0708241337560.5774@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 24 20:12:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOdda-0007F1-4G
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 20:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758786AbXHXSLk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 14:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764974AbXHXSLj
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 14:11:39 -0400
Received: from iabervon.org ([66.92.72.58]:3291 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762860AbXHXSLi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 14:11:38 -0400
Received: (qmail 27617 invoked by uid 1000); 24 Aug 2007 18:11:33 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Aug 2007 18:11:33 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56585>

There seems to be an inconsistency between the fetch and tag over whether 
lightweight tags of non-commits are allowed. Fetch doesn't like them, but 
tag creates them without any particular fuss. I think that fetch is right 
that, if you want to tag a blob, you should use a real tag object so that 
there's something that indicates (correctly) the type of the tagged 
object. Should git-tag perhaps automatically make a tag object if the 
tagged object isn't a commit, acting as if -a was given, except that an 
empty message is used instead of invoking an editor if -m is not given? (I 
can, of course, just use git-tag that way, but it seems generally 
unfriendly to by able to get "error:" out of a sequence of purely git 
commands, even if they're sort of odd and probably not what you really 
wanted to do.

	-Daniel
*This .sig left intentionally blank*
