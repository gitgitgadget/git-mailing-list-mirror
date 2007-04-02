From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: avoid respewing similar error messages for missing paths
Date: Mon, 2 Apr 2007 11:46:53 -0700
Message-ID: <20070402184652.GA29646@hand.yhbt.net>
References: <m28xdkvsxx.fsf@ziti.fhcrc.org> <20070327190004.GD16591@localdomain> <m23b3qts11.fsf@ziti.fhcrc.org> <20070331005448.GA6948@muzzle> <m2lkhb6pbm.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Seth Falcon <sethfalcon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 02 20:47:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYRYQ-0004UD-0K
	for gcvg-git@gmane.org; Mon, 02 Apr 2007 20:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965679AbXDBSqy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Apr 2007 14:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965680AbXDBSqy
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Apr 2007 14:46:54 -0400
Received: from hand.yhbt.net ([66.150.188.102]:47770 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965679AbXDBSqy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2007 14:46:54 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 2BD4D7DC091; Mon,  2 Apr 2007 11:46:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m2lkhb6pbm.fsf@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43609>

Seth Falcon <sethfalcon@gmail.com> wrote:
> I have the impression that the initial fetch phase is taking longer
> than it used to.  This could easily be due to network and server load
> related issues, but I wonder if something in the parent following /
> path searching is different.  The first git svn fetch seems to do
> nothing for a very long time (except emit a few of the warnings) and
> then once it starts actually adding commits it goes quite fast.  This
> isn't really a problem as the initial fetch is a fairly rare
> operation, but I wondered if this made sense based on recent git-svn
> changes...

Does using --log-window-size=1000 speed things back up?

I decreased it to 100 to reduce memory usage (but exposed it as an
option).

-- 
Eric Wong
