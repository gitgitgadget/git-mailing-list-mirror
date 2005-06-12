From: Zack Brown <zbrown@tumblerings.org>
Subject: Re: cogito and tags propagation
Date: Sun, 12 Jun 2005 10:49:05 -0700
Message-ID: <20050612174905.GA18751@tumblerings.org>
References: <9e4733910506120850f762078@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 12 19:46:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DhWXF-00052d-17
	for gcvg-git@gmane.org; Sun, 12 Jun 2005 19:46:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262662AbVFLRt1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Jun 2005 13:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262663AbVFLRt1
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jun 2005 13:49:27 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:34231 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S262662AbVFLRtV
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2005 13:49:21 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.50)
	id 1DhWa1-0005K1-4r; Sun, 12 Jun 2005 10:49:05 -0700
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910506120850f762078@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 12, 2005 at 11:50:08AM -0400, Jon Smirl wrote:
> If I add a tag to tree A,  then go to tree B which depends on A and do
> cg update. It says the branch is already fully merged. It's not
> counting the addition of a tag as something that marks the tree dirty.

My impression is that tags are local to a given repo, i.e. they are not included
by default in the publically accessible data. The repo owner has to somehow
'tell' people about the tags, in order for them to be able to get them.

Apparently this is useful because it allows smaller groups to work together with
their own 'local' tags, without polluting the main tree.

Be well,
Zack

> 
> -- 
> Jon Smirl
> jonsmirl@gmail.com
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Zack Brown
