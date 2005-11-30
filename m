From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: More merge questions
Date: Wed, 30 Nov 2005 13:37:26 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0511301325580.25300@iabervon.org>
References: <20051130131045.28149.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Nov 30 19:57:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhWp9-0007nJ-CE
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 19:37:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbVK3Sg4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 13:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbVK3Sg4
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 13:36:56 -0500
Received: from iabervon.org ([66.92.72.58]:40456 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751504AbVK3Sgz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Nov 2005 13:36:55 -0500
Received: (qmail 30186 invoked by uid 1000); 30 Nov 2005 13:37:26 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Nov 2005 13:37:26 -0500
To: linux@horizon.com
In-Reply-To: <20051130131045.28149.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13012>

On Wed, 30 Nov 2005, linux@horizon.com wrote:

> Given that it all matches up so nicely, I'd like to honestly ask if
> case 3 of the conditions is correct.  I'd think that if I deleted
> a file form te index, and the file wasn't changed on the head I'm
> tracking, the right resolution is to keep it deleted.  Why override
> my deletion?

You're allowed to do the two-way merge with your index empty, and this 
means that you just hadn't read the ancestor, not that you want to remove 
everything. I'm not sure what this is useful for.

You're definitely allowed to do a three-way merge with your index empty, 
meaning that you don't have any local changes at all, which lets you do a 
merge in a temporary index that didn't exist before. (The two-way case is 
less interesting, because it's the same as just reading the new tree.)

	-Daniel
*This .sig left intentionally blank*
