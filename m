From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [PATCH] display shortlog after git-commit
Date: Sun, 15 Apr 2007 23:34:57 +0300
Message-ID: <20070415203457.GE15208@mellanox.co.il>
References: <20070404070135.GF31984@mellanox.co.il>
	<7v4pnh4dip.fsf@assigned-by-dhcp.cox.net>
	<20070415200939.GC15208@mellanox.co.il>
	<200704152126.44480.andyparkins@gmail.com>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 15 22:35:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdBR5-00086t-0C
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 22:34:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759AbXDOUe4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 16:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753761AbXDOUe4
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 16:34:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:63073 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753747AbXDOUez (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 16:34:55 -0400
Received: by ug-out-1314.google.com with SMTP id 44so956030uga
        for <git@vger.kernel.org>; Sun, 15 Apr 2007 13:34:54 -0700 (PDT)
Received: by 10.67.93.6 with SMTP id v6mr3778101ugl.1176669294000;
        Sun, 15 Apr 2007 13:34:54 -0700 (PDT)
Received: from ?127.0.0.1? ( [89.138.119.177])
        by mx.google.com with ESMTP id o1sm5769267uge.2007.04.15.13.34.52;
        Sun, 15 Apr 2007 13:34:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200704152126.44480.andyparkins@gmail.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44516>

> Quoting Andy Parkins <andyparkins@gmail.com>:
> Subject: Re: [PATCH] display shortlog after git-commit
> 
> On Sunday 2007, April 15, Michael S. Tsirkin wrote:
> 
> > And I wander why does it tell me the new commit hash -
> > wouldn't displaying the subject make more sense?
> > Something like
> >
> > 	Created commit "Make foobar faster by caching more barbar in foo"
> > 	1 files changed, 1 insertions(+), 0 deletions(-)
> 
> If you do a series of "git commit --amend"s, you would get an identical 
> message each time.  Also, I've often found it convenient when doing 
> resets, amends, patch splits and movements between branches to be able 
> to cut and paste the commit hash still on the terminal into lines like
> 
>  git commit --amend -c $HASH
> 
> I wouldn't object to having the subject as well, but please don't lose 
> the hash - it's very useful.

Yes, I see how that would be useful with amends.

-- 
MST
