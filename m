From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: No "pull" in git gui?
Date: Fri, 26 Sep 2008 07:49:55 -0700
Message-ID: <20080926144955.GB3669@spearce.org>
References: <588192970809260737i46ce0c30y191e29156bbf6396@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Steve Hoelzer <shoelzer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 16:52:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjEev-0003Nm-V3
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 16:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607AbYIZOt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 10:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752522AbYIZOt4
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 10:49:56 -0400
Received: from george.spearce.org ([209.20.77.23]:36546 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476AbYIZOt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 10:49:56 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id CB3123835F; Fri, 26 Sep 2008 14:49:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <588192970809260737i46ce0c30y191e29156bbf6396@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96862>

Steve Hoelzer <shoelzer@gmail.com> wrote:
> Why isn't there a pull command in git gui's remote menu?

I got lazy and didn't write support for it.  Before today nobody has
really asked me why it was missing so it seemed to be unimportant.

> Am I supposed to fetch and then merge?

Yes, that works.

> Is that preferred over pull for some reason?

I find it easier to teach new Git users "fetch + merge" rather
than pull.  It helps to reinforce the idea of having your own
local state that differs from the state on the upstream repository.
I consider pull to be more of a power-user feature.  But many in the
Git community disagree with me and find teaching pull is easier, with
fetch+merge being power user features.

So patches to add pull to git-gui would be accepted, but they won't
be getting written by me anytime soon.  I've got too much other
stuff going on to write a feature that isn't very interesting to me.

-- 
Shawn.
