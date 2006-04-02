From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn and svn sw --relocate
Date: Sun, 2 Apr 2006 15:21:00 -0700
Message-ID: <20060402222100.GA17888@localdomain>
References: <4430123E.5090605@iaglans.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 03 00:21:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQAwU-0002WI-Jk
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 00:21:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbWDBWVE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 18:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWDBWVD
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 18:21:03 -0400
Received: from hand.yhbt.net ([66.150.188.102]:39393 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932425AbWDBWVB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Apr 2006 18:21:01 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 821D42DC033;
	Sun,  2 Apr 2006 15:21:00 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun,  2 Apr 2006 15:21:00 -0700
To: Nicolas Vilz 'niv' <niv@iaglans.de>
Content-Disposition: inline
In-Reply-To: <4430123E.5090605@iaglans.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18293>

Nicolas Vilz 'niv' <niv@iaglans.de> wrote:
> ok, guys... next question:
> 
> i have now my repository locally and i want to get it remotely on a
> server, in order to have a few collaborators...
> 
> the steps on the svn-side are clear. But what do i have todo on the
> git-svn-side of this life?
> 
> does a simple "svn sw --relocate" do the job in the git-svn meta-dir?

Yes, you'll need to do that in .git/git-svn/tree and also update
.git/git-svn/info/url by hand.

-- 
Eric Wong
