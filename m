From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: Re: documentation issues
Date: Thu, 1 Dec 2005 16:54:24 -0500
Message-ID: <20051201215424.GA13016@pe.Belkin>
References: <438F5D05.4080101@citi.umich.edu> <7v64q8fqm8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: cel@citi.umich.edu, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 22:56:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhwNp-0004gT-BI
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 22:54:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbVLAVy0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 16:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbVLAVy0
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 16:54:26 -0500
Received: from eastrmmtao03.cox.net ([68.230.240.36]:37089 "EHLO
	eastrmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932504AbVLAVy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2005 16:54:26 -0500
Received: from localhost ([24.250.31.7]) by eastrmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051201215301.QCAI29285.eastrmmtao03.cox.net@localhost>;
          Thu, 1 Dec 2005 16:53:01 -0500
Received: from chris by localhost with local (Exim 4.43)
	id 1EhwNk-0003OL-Jf; Thu, 01 Dec 2005 16:54:24 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64q8fqm8.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13078>

On Thu, Dec 01, 2005 at 01:34:55PM -0800, Junio C Hamano wrote:
> > also, git-diff-index supports a "-r" option, but that doesn't seem to be 
> > documented on this page.
> 
> What Chris Shoemaker said is right.
> 
> But we could do this instead if you want.  I am neutral myself.

I think it is more clear without this, since we imply elsewhere that
diff-* accepts the options in diff-options.txt.  Documenting "-r" in
the only place it applies (diff-tree) means we don't need exceptions
anywhere else.

Incidentally, I think it would make more sense if diff-tree defaulted
to recursive behavior and required a flag to produce non-recursive
behavior, but I realize that's impractical now, and only of minor
benefit.

-chris
